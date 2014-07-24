From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/5] checkout --to: no auto-detach if the ref is already
 checked out
Date: Thu, 24 Jul 2014 16:58:31 +0700
Message-ID: <CACsJy8DwPM68j-=LDDbq1H_bT1gD=aLQ8x6C1qiwF79=ai14dg@mail.gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
 <1406115795-24082-4-git-send-email-pclouds@gmail.com> <53CFBD2A.9030803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jul 24 11:59:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAFo7-00033s-O1
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 11:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933038AbaGXJ7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2014 05:59:21 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:32985 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934703AbaGXJ7D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2014 05:59:03 -0400
Received: by mail-qa0-f47.google.com with SMTP id i13so2675540qae.34
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 02:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Rp4csmMIG1adIp/mRcPAqygeBsIpYkhjbCquFQwabpE=;
        b=UtDbzdFTIjxfCaRNmD+4l4YuzSJxZUBmzIsFlVUybCKAbA6gG+3/DxWiSwRiCCTh1t
         TOKjsqK/hhjUMVowLT5SD1dJW2e+GAvBiftqMBBck/ia6ZT04ktfdgL5lZrFedLoMc6Q
         mNO6G442l6PdTTkTfzIk3jbjkeqtjsGNgCbMC6hkU9fucAaNwmz2bgtHpahMrd/fjVZg
         EN+94+C0etRvryFza/hgd8a86r2E2cO1jY3oj1BIk8vX3zUqF2zhIzEmOFmIQthjwkV/
         fF1KNpTy0T3jYN51itT35TzUS48cwYy4fYcX26RQJMTG2lZzwz7wo4585tH27l5wowI/
         cHUg==
X-Received: by 10.140.24.140 with SMTP id 12mr12469662qgr.11.1406195941935;
 Thu, 24 Jul 2014 02:59:01 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Thu, 24 Jul 2014 02:58:31 -0700 (PDT)
In-Reply-To: <53CFBD2A.9030803@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254151>

On Wed, Jul 23, 2014 at 8:48 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 23.07.2=
014 13:43:
>> +     if (advice_checkout_to)
>> +             die(_("%s is already checked out at %s.\n"
>> +                   "Either use --detach or -b together with --to "
>> +                   "or switch branch in the the other checkout."),
>
> "or switch to a different branch in the other checkout". But maybe we
> can be even more helpful, like:
>
> "%s is already checked out at %s.\n"
> "Either checkout the detached head of branch %s using\n"
> "    git checkout --detach --to %s %s\n"
> "or checkout a new branch based off %s using\n"
> "    git checkout --to %s -b %s newbranch %s\n"
> "or switch to a different branch in the other checkout."
>
> if we can figure out the appropriate arguments at this point in the c=
ode.

We would not be able to construct the exact command that the user has
entered, so perhaps

  git checkout --detach <more options> %s
  git checkout -b <new branch> <more options> %s

?

Note that this does not only occur when --to is given. If you have two
checkouts associated to the same repo, "git checkout foo" on one
checkout when "foo" is held by another checkout would cause the same
error. I'll need to think of a better name than advice.checkoutTo.
--=20
Duy
