From: Johan Herland <johan@herland.net>
Subject: Possible regression in master? (submodules without a "master" branch)
Date: Thu, 27 Mar 2014 15:21:49 +0100
Message-ID: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 27 15:22:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTBBw-00067j-IU
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 15:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756855AbaC0OV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 10:21:57 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:60322 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbaC0OVz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 10:21:55 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1WTBBp-000KCW-Fo
	for git@vger.kernel.org; Thu, 27 Mar 2014 15:21:53 +0100
Received: by mail-pa0-f51.google.com with SMTP id kq14so3550444pab.38
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 07:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=s9mhPuenSTE1xCEMKvs5bLSAOgp+MrChNTVRfQKlrRI=;
        b=LMGQLoV0SesU4wKgAAl2HTbXRUJ6RpMbOyUX7uh+Ne+YmnFR1cEFXHQnCTvq+65yCK
         TvYEP+S9epYIvu7c/zWXzsIDhihRXpv1QbT3fApzfMusUjQ8yyXoTITpv88+hMutNXNI
         hPIKNal4y67NgkoiUkPpFvEpFBqMQxDv60yOrJ0j5XXHK1hNn1YhuTtShRwc2XNmg9OP
         dz1Dh2Rc9pN59EpW7IJSywn9Fs4cc34N5OS/wk3izPcjYiXZciJwV6UBXWtiXs3mpYxQ
         WEaCjzFJSZvAk7Lbu+VrON/Efv++HEDLifctDUMMbRKePG42pXJEwqaXt9ZricDEL58D
         2XVg==
X-Received: by 10.66.20.10 with SMTP id j10mr2113247pae.11.1395930109820; Thu,
 27 Mar 2014 07:21:49 -0700 (PDT)
Received: by 10.70.48.232 with HTTP; Thu, 27 Mar 2014 07:21:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245283>

Hi,

I just found a failure to checkout a project with submodules where
there is no explicit submodule branch configuration, and the
submodules happen to not have a "master" branch:

  git clone git://gitorious.org/qt/qt5.git qt5
  cd qt5
  git submodule init qtbase
  git submodule update

In current master, the last command fails with the following output:

  Cloning into 'qtbase'...
  remote: Counting objects: 267400, done.
  remote: Compressing objects: 100% (61070/61070), done.
  remote: Total 267400 (delta 210431), reused 258876 (delta 202642)
  Receiving objects: 100% (267400/267400), 136.23 MiB | 6.73 MiB/s, done.
  Resolving deltas: 100% (210431/210431), done.
  Checking connectivity... done.
  error: pathspec 'origin/master' did not match any file(s) known to git.
  Unable to setup cloned submodule 'qtbase'

Bisection points to 23d25e48f5ead73c9ce233986f90791abec9f1e8 (W.
Trevor King: submodule: explicit local branch creation in
module_clone). Looking at the patch, it seems to introduce an implicit
assumption on the submodule origin having a "master" branch. Is this
an intended change in behaviour?

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
