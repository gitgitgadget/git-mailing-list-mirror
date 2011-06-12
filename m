From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v2] revert: Implement --abort processing
Date: Sun, 12 Jun 2011 17:12:17 -0500
Message-ID: <20110612221217.GA2789@elie>
References: <1307774186-14207-1-git-send-email-artagnon@gmail.com>
 <20110611112213.GA25268@elie>
 <BANLkTi=T0wCg1bKzmtQEQ-J-5ogqRZaqRg@mail.gmail.com>
 <20110612122145.GA20495@elie>
 <BANLkTi=gYSJgG-Yu-+-5wPetpb0-AW=X+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 00:12:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVstU-0002ct-Ir
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 00:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353Ab1FLWM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 18:12:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36371 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972Ab1FLWM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 18:12:27 -0400
Received: by iyb14 with SMTP id 14so3416480iyb.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 15:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=EO5+3oBV3Y672zGx4LrbxXoDssnrEYJhPyqiByqq9ws=;
        b=VSrgsB63sbAa2lONjsOVZlN11421WG4oEFoUhnTeojHdtJKBvyZAgH/++oEW5lD3i1
         imbnGJYs5VPegennoAsVJU13pEuI2H04vrV0YnhAtaNbIQDsoVYxa+ymvUkSD6qj3ml1
         3zV4JlyyVgWiUcPCcXS7Xi1cXo1gtwugLW6qg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MqBW99daFucjD8Of+4h2losaMM6WNx8wU4RnCd3OaeBFSb3A2JFyoVFh1HpxWCSKtx
         ugopgsb5Xg8fr6Adx6C6dav0cgAN8ZPFixPeis7bLO0VCEFNxZOwfkuXSNI6LScihdAd
         I0IJyEx5Onh05ZgqWVWa9R6mJu0Xgg7gC/nD8=
Received: by 10.42.213.137 with SMTP id gw9mr6009783icb.158.1307916746408;
        Sun, 12 Jun 2011 15:12:26 -0700 (PDT)
Received: from elie (adsl-69-209-71-178.dsl.chcgil.sbcglobal.net [69.209.71.178])
        by mx.google.com with ESMTPS id fw9sm2480359ibb.64.2011.06.12.15.12.24
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 15:12:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=gYSJgG-Yu-+-5wPetpb0-AW=X+g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175671>

Ramkumar Ramachandra wrote:

> Frankly, I'm still trying to understand how other people work -- I
> don't use the porcelain much, and I dislike anything but the most
> minimalistic automation.  I didn't even like the change to cherry-pick
> where you can simply "git commit" after resolving a conflict; I still
> prefer and use the more explicit "git commit -c" after removing the
> CHERRY_PICK_HEAD.  Also, I *always* use rebase with --onto

I don't think that should stop you from thinking about how new
facilities help or interfere with work at all.  You use magit, right?
It automates all kinds of things.  And while each person is going to
use tools in different ways, that hasn't kept people from getting
things done in the past.

If you are thinking "I would never use 'git cherry-pick --abort' --- I
would just look in the reflog for a commit to 'reset --hard' to", then
you are *done*.  Just document it, make sure the reflog has useful
content to help out, and wait until someone complains and adds a
shortcut they like.

Addendum:  Personally I was happy about "git commit" that implicitly
takes the commit message from CHERRY_PICK_HEAD because it adds a

	Conflicts:

		Makefile

that I can use as a template for a message about the nature of the
conflict and how I fixed it up.  As a side note, I'm curious about
why you end up needing to remove the CHERRY_PICK_HEAD.  Is "git commit
-c interesting-patch" misbehaving somehow?  (It should ignore the
CHERRY_PICK_HEAD entirely.)
