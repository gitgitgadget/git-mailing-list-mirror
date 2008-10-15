From: "Stefan Karpinski" <stefan.karpinski@gmail.com>
Subject: Re: builtin conversion between tabs and spaces
Date: Wed, 15 Oct 2008 13:55:13 -0700
Message-ID: <d4bc1a2a0810151355q283d7a4y7bf35a3423cf1d46@mail.gmail.com>
References: <d4bc1a2a0810141839r547a770j3a8e56312afa6a53@mail.gmail.com>
	 <d4bc1a2a0810141842q1e50c85au7d813f2e5e37a84c@mail.gmail.com>
	 <d4bc1a2a0810141844x76223e76xf04e07ece834fc61@mail.gmail.com>
	 <48F58D1C.2040208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:56:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqDPw-00025h-OJ
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 22:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbYJOUzQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2008 16:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbYJOUzQ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 16:55:16 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:48230 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbYJOUzO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 16:55:14 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1626428wah.21
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 13:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tIOfc7a4fQ0TBSacZa6lNNpmRRclNLPYSLc80+lIylE=;
        b=A0AC+npTdMc6+qG9y2BhLq87cCf6KZls2rMHjTB1GaXAd23cMgl63u5JLhOHMdO/3x
         GjSG0Umetk3Ol/TA8VOy0BkX9PCHKOFlun9Qqjr4QgHe5XAF9qpBQ0hd9m84j2WdF3wZ
         Sjod9E0CjHrZ7b1rc2x8gcM2LicmZxMFMm+hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dpkO7AwI1+1J722PGWofl5Gbkml9rmmsKEM7AI8raCgAhgc/buW+n18h6tmpg2FEEu
         j6P8gATQaf/KUCclhQnbHRiqPrelCliowXnFCRzHkjXOd7I6e2b1YpP7ENtFbrYfTInK
         aLFIyeCdRLnmwKaUqDhCLdizpIl3CJhnXbC0I=
Received: by 10.114.170.1 with SMTP id s1mr1457400wae.127.1224104113850;
        Wed, 15 Oct 2008 13:55:13 -0700 (PDT)
Received: by 10.114.158.12 with HTTP; Wed, 15 Oct 2008 13:55:13 -0700 (PDT)
In-Reply-To: <48F58D1C.2040208@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98326>

>> This led me to wonder if it wouldn't make sense to have this
>> conversion ability built into git.
>
> This wouldn't help your case a lot. It is still at the discretion of =
each
> individual repository owner to enable the conversion. (You didn't mea=
n to
> make this conversion mandatory, did you?)

This would all be completely discretionary, of course. I just thought
that the issue was complicated enough and the problem of mixed spaces
and tabs in source code ubiquitous enough that it might be worth
"solving" correctly in git itself.

> BTW, you don't need to change git code to achieve this. It's sufficie=
nt to
> install a suitable "clean" filter:
>
> echo "*.c filter=3Dc-code" > .git/info/attributes
> git config filter.c-code.clean tabs2spaces
>
> where tabs2spaces is your utility that does the conversion.

That was the first thing I did=97in ruby first, then in C. The ruby
version is *way* too slow to use on any number of files=97and the
typical use case is that most of your files are source code and so
will have this applied to them. On the other hand, the ruby script (or
perl or whatever) is portable, so I can send it to my Windows-based
developers and have them use it too.

But the speed issue is pretty crucial, so I rewrote the thing as an
external C program, which is obviously much faster. But it's still
noticably slower than native git checkout though. Worse still, now the
filter script isn't portable, so I have to cross-compile it and give
every developer the version that works on their platform and make sure
that they have their path setup correctly, etc.

Having the conversion built into git would
  1) have native git checkout speed (I've tried it and it's not
noticable slower than normal git checkouts);
  2) be naturally portable to anywhere git works.

Now, if I thought this was a thing that would only benefit me, I would
never bring it up. However, it seems like something that a lot of
projects might want to use to ensure standard spacing in their source
files. Moreover, since developers feel strongly about using tabs or
spaces, it would be beneficial for individuals too. I think there's
enough complex issues that solving it once-and-for-all might be worth
a shot.
