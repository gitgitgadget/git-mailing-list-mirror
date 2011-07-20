From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] gitignore: add top level patch ignore rule
Date: Wed, 20 Jul 2011 10:09:19 +0200
Message-ID: <4E268D2F.50201@drmicha.warpmail.net>
References: <1311113877.2643.2.camel@vitaliy-Vostro-1400>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: vitalivanov@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 20 10:09:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjRqT-0002Qy-C4
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 10:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab1GTIJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 04:09:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57406 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751317Ab1GTIJW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 04:09:22 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BAF8220EF4;
	Wed, 20 Jul 2011 04:09:21 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Wed, 20 Jul 2011 04:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ndXr3EahKP7PBgcI8NP4k/
	3ydyY=; b=VQSoPORX4AKcNyUduNgK6zACFH7TexIEt8Lqv6tPDhpYiL9HK0G94W
	URY1bM5Ia1uiGFvHf6s04z/zHTKCoiPg3rZKDJV5R0Xn6DXSo5ip3KwNQ1iUWAps
	6CGTVEagKMYHawDsufEDkltD2DGvV10VblOIPQyEMIu7kz/gs6hmw=
X-Sasl-enc: 1oK5WnQAp1kfoS1Dq9QTri4Qn/CE9VVaNgHQOg5SzIaU 1311149361
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 20F2E40955C;
	Wed, 20 Jul 2011 04:09:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <1311113877.2643.2.camel@vitaliy-Vostro-1400>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177526>

Vitaliy Ivanov venit, vidit, dixit 20.07.2011 00:17:
> Add top level ignore rule for patches created by format-patch command.

Please don't.

The tracked ignore file is for ignoring products and artefacts of our
build process. format-patch is not part of this process, and the
existence of *.patch files depends on your workflow. But what is much
worse: In

git status
git format-patch rev-spec
git send-email *.patch

it is very easy to send out the wrong patches (along with the right
ones), because your patch hides them from status. Also, I can't clean
them up with "git clean -f" any more. I would have to use "git clean -f
-x" which would clean the build products also (and force a rebuild).

So, your patch makes a format-patch based workflow much worse. What
problem does it try to solve?

> On the way, reorganize ignore rules and add comments.

How and why do you reorganize?

> 
> Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>
> ---
>  .gitignore |   43 ++++++++++++++++++++++++++++++-------------
>  1 files changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 8572c8c..47afe77 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -1,3 +1,15 @@
> +#
> +# NOTE! Don't add files that are generated in specific
> +# subdirectories here. Add them in the ".gitignore" file
> +# in that subdirectory instead.
> +#
> +# NOTE! Please use 'git ls-files -i --exclude-standard'
> +# command after changing this file, to see if there are
> +# any tracked files which get ignored after the change.
> +
> +#
> +# Top-level files
> +#
>  /GIT-BUILD-OPTIONS
>  /GIT-CFLAGS
>  /GIT-LDFLAGS
> @@ -187,21 +199,10 @@
>  /test-svn-fe
>  /test-treap
>  /common-cmds.h
> -*.tar.gz
> -*.dsc
> -*.deb
>  /git.spec
> -*.exe
> -*.[aos]
> -*.py[co]
> -.depend/
> -*.gcda
> -*.gcno
> -*.gcov
>  /coverage-untested-functions
>  /cover_db/
>  /cover_db_html/
> -*+
>  /config.mak
>  /autom4te.cache
>  /config.cache
> @@ -213,6 +214,24 @@
>  /tags
>  /TAGS
>  /cscope*
> +/Debug/
> +/Release/
> +/*.patch
> +
> +#
> +# Normal rules
> +#
> +*.tar.gz
> +*.dsc
> +*.deb
> +*.exe
> +*.[aos]
> +*.py[co]
> +.depend/
> +*.gcda
> +*.gcno
> +*.gcov
> +*+
>  *.obj
>  *.lib
>  *.sln
> @@ -222,5 +241,3 @@
>  *.user
>  *.idb
>  *.pdb
> -/Debug/
> -/Release/
