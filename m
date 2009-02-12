From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Teach rebase to rebase even if upstream is up to date 
	with -f
Date: Thu, 12 Feb 2009 22:57:17 +0100
Message-ID: <bd6139dc0902121357l1eea7b8xe890513b756e97c2@mail.gmail.com>
References: <1234468061-29923-1-git-send-email-srabbelier@gmail.com>
	 <7vbpt7jq4c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>,
	"Shawn O. Pear, Sverre Rabbelier <srabbelier@gmail.com>"@b-sasl-quonix.sasl.smtp.pobox.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:58:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXja4-0003I0-B2
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbZBLV5U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Feb 2009 16:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbZBLV5U
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:57:20 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:28636 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbZBLV5T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2009 16:57:19 -0500
Received: by fg-out-1718.google.com with SMTP id 16so307451fgg.17
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 13:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=cfwHeBRRxkmDbTcG3cY3JOgocZzZ7Z+HJDWT25y4SV8=;
        b=ubt8ArPlmMN0H+rtpf/Wx362pngW9y9n9KUX7uAMAYJM91wAa4NTdUD/ROQCOZlaLA
         RywfaKMFiIP97J+v/WCe44o7LvpN5vg/G4LjCHjvJSTGmR/A7MDzs1LfMGG+wxSf9+Jz
         73Im6Frj5eLe7Mg93BebDnLqf7OCQ2Y8fVOOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=idGJ2qb8pF2jkvhs+QNDK6WnhVVYHc0h+pLSz904MacAZ26FWXXKJ9TGElu9if2RPd
         WQV99kVExk6IDF2Z2MQzkvkzuasX1ZTkEC//uEpbSRkCW1q1/0qrfWnJB9QU5qDqdtml
         m2jWyJs5tdg7KFyI4FGVQVszykuj2m7GqS5Uo=
Received: by 10.86.3.4 with SMTP id 4mr111790fgc.41.1234475837705; Thu, 12 Feb 
	2009 13:57:17 -0800 (PST)
In-Reply-To: <7vbpt7jq4c.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: 0cc685d319550c52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109669>

On Thu, Feb 12, 2009 at 22:34, Junio C Hamano <gitster@pobox.com> wrote=
:
> For that, I would prefer to see:
> =A0(1)=A0 =A0git format-patch --stdout origin >my.mbox
> =A0(2)=A0 =A0git fetch origin
> =A0(3)=A0 =A0git checkout origin =A0 =A0 =A0 =A0 =A0 =A0 ;# yes, deta=
ch
> =A0(4)=A0 =A0git am --whitespace=3Dfix my.mbox
> =A0(5)=A0 =A0make test
> =A0(6)  =A0git format-patch -o to-send-out origin
> =A0(7)=A0 =A0git send-email ..options.. to-send-out

If I understand things correctly 'git rebase -f --whitespace=3Dfix
origin' does only 1 and 4, yes? In my workflow I do 2 and 5 as 'git
pull --rebase' before I push anything, and since I push rather then
send-email, I never use 6 and 7. That leaves 3, which I guess is
specific to your workflow? I am guessing you detach to make it easier
to easily test many different topic branches.

> It fixes whitespace breakages, but more importantly, the procedure ma=
kes
> sure that what you will be sending out will apply cleanly to the orig=
in
> that may have progressed since you last looked at it.

Mhhh, would 'git fetch && git rebase -f whitespace=3Dfix orgin' do the
same? Do you see any other problems with the patch?

--=20
Cheers,

Sverre Rabbelier
