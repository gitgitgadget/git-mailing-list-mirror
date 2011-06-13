From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH v2] revert: Implement --abort processing
Date: Mon, 13 Jun 2011 20:25:03 +0530
Message-ID: <BANLkTim2SOAp3=g_zie-oi2=A9X7NVd5qw@mail.gmail.com>
References: <1307774186-14207-1-git-send-email-artagnon@gmail.com>
 <20110611112213.GA25268@elie> <BANLkTi=T0wCg1bKzmtQEQ-J-5ogqRZaqRg@mail.gmail.com>
 <20110612122145.GA20495@elie> <BANLkTi=gYSJgG-Yu-+-5wPetpb0-AW=X+g@mail.gmail.com>
 <20110612221217.GA2789@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 16:55:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW8Y7-0003ix-P2
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 16:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab1FMOz0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2011 10:55:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56874 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215Ab1FMOzY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2011 10:55:24 -0400
Received: by wwa36 with SMTP id 36so4910726wwa.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=bMWiJhBIIHcwq0xoY6qG78SppNEt9i3uHulgI8GleeI=;
        b=ZwUY5tHzRzXzfOfs6X2P1Y2ZS1Kcwuu6+XI9aP5htS+LqCKripfGZrCT3qTzNO4o2v
         IDVsvk1SF56bh247q4C03jAwNJ655TTXJdLTO4uVeJL89yHWAXNbQqRevHMFdD1H1tq9
         j8qONKb/clDW078U4fg9ayn8+HrpyADrVMtHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mJclQMyK1HvVUp5ENHs8a32IejhV5T6ycWvojLXR+alCgxbnjOtyvGYRAerBzm0CbD
         GGatm6LrA/ggZKxhjnNn6ibzg8ntkNi8ZAhkiS/NZ1VIiTPNPwiBRiLRiDbhO8zbB99D
         vt6fm/4rf7bAJeX6QOTHtpTCchlH1Xqd6Dmho=
Received: by 10.216.145.206 with SMTP id p56mr2669611wej.80.1307976923138;
 Mon, 13 Jun 2011 07:55:23 -0700 (PDT)
Received: by 10.216.1.20 with HTTP; Mon, 13 Jun 2011 07:55:03 -0700 (PDT)
In-Reply-To: <20110612221217.GA2789@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175710>

Hi again,

Jonathan Nieder writes:
> I don't think that should stop you from thinking about how new
> facilities help or interfere with work at all. =C2=A0You use magit, r=
ight?
> It automates all kinds of things. =C2=A0And while each person is goin=
g to
> use tools in different ways, that hasn't kept people from getting
> things done in the past.

I use Magit only for staging, unstaging, committing, amending, and
reverting portions.

> If you are thinking "I would never use 'git cherry-pick --abort' --- =
I
> would just look in the reflog for a commit to 'reset --hard' to", the=
n
> you are *done*. =C2=A0Just document it, make sure the reflog has usef=
ul
> content to help out, and wait until someone complains and adds a
> shortcut they like.

Ah, thanks for the helpful advice. I'll stay away from deciding
end-user interfaces altogether, and just write in the infrastructure
for sequencing commits with a minimalistic UI. People can add more
later :)

> As a side note, I'm curious about
> why you end up needing to remove the CHERRY_PICK_HEAD. =C2=A0Is "git =
commit
> -c interesting-patch" misbehaving somehow? =C2=A0(It should ignore th=
e
> CHERRY_PICK_HEAD entirely.)

Sorry, I should have been clearer.  I remove the CHERRY_PICK_HEAD to
avoid hitting "commit", "commit --amend" by mistake.  With "git commit
-c", it displays a pleasant message:

# It looks like you may be committing a cherry-pick.
# If this is not correct, please remove the file
#	.git/CHERRY_PICK_HEAD
# and try again.

-- Ram
