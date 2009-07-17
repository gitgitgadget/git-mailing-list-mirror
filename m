From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v6] mailinfo: allow e-mail files as input
Date: Fri, 17 Jul 2009 19:06:01 +0900
Message-ID: <20090717190601.6117@nanako3.lavabit.com>
References: <7v8wip9jjw.fsf@alter.siamese.dyndns.org>
    <f006bbb9c754c80c133798ff70db5b5291dae060.1247766192.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Jul 17 12:06:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRkL1-0001mQ-UP
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 12:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934360AbZGQKGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 06:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934354AbZGQKGk
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 06:06:40 -0400
Received: from karen.lavabit.com ([72.249.41.33]:58731 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934314AbZGQKGj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 06:06:39 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id ED73511B875;
	Fri, 17 Jul 2009 05:06:38 -0500 (CDT)
Received: from 3939.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id WOB0LNBBXVWP; Fri, 17 Jul 2009 05:06:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=fiAr/ELL220JUGmpyaMLhAWXKi4jE2bdxZYfggV6t2xDfAm8u6EiItaY6Cy7fPe6ClujwQlPbCFfHc0BGpryvbDJz5PvVovTCyPU9tPPeLm55TtnrMpRxWeaZg9U4SHZ/c67agUqm78JhWH5KJvOLHRygqVkSsWUIB8uCzv2UXI=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <f006bbb9c754c80c133798ff70db5b5291dae060.1247766192.git.nicolas.s.dev@gmx.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123458>

Quoting Nicolas Sebrecht <nicolas.s.dev@gmx.fr>:

> We traditionally allowed a mbox file or a directory name of a maildir to be
> given to "git am".  Even though an individual file in a maildir (or more
> generally, a piece of RFC2822 e-mail) is not a mbox file, it contains enough
> information to create a commit out of it, so there is no reason to reject one.
> It allows to run 'git am' with an email list argument, something like:
>
>  $ git am dir/*
>  $ git am email1 email2
>
> This builds on top of a5a6755 (git-am foreign patch support: introduce
> patch_format, 2009-05-27) that introduced mailbox format detection.  The
> codepath to deal with a mbox requires it to begin with "From " line and
> also allows it to begin with "From: ", but a random piece of e-mail can
> and often do begin with any valid RFC2822 header lines.
>
> Instead of checking the first line, we extract all the lines up to the
> first empty line, and make sure they look like e-mail headers.
>
> Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
> ---

Could you summarize the changes since v5 here?  Is the change the same as Junio's patch (if so shouldn't you credit him in the commit log message)? 

>  Documentation/git-am.txt |    6 ++--
>  git-am.sh                |   14 ++++++++++++
>  t/t4150-am.sh            |   54 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 32e689b..2a930a7 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  	 [--ignore-date]
>  	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
>  	 [--reject] [-q | --quiet]
> -	 [<mbox> | <Maildir>...]
> +	 [<mbox> | <Maildir>... | <email>... ]
>  'git am' (--skip | --resolved | --abort)
>  
>  DESCRIPTION
> @@ -25,8 +25,8 @@ current branch.
>  
>  OPTIONS
>  -------
> -<mbox>|<Maildir>...::
> -	The list of mailbox files to read patches from. If you do not
> +<mbox>|<Maildir>...|<email>...::
> +	The list of mailbox files or email to read patches from. If you do not
>  	supply this argument, the command reads from the standard input.
>  	If you supply directories, they will be treated as Maildirs.
>  

I wasn't following the discussion closely, and at first I didn't understand this change to the documentation, because it doesn't say how <mbox> and <email> are different. I'm afraid many readers of the documentation don't understand it either.

Why does this description have ... in it? If I'm reading it correctly, the code in check_patch_format function checks only the first file.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
