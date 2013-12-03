From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH jk/remove-deprecated] stop installing git-tar-tree link
Date: Tue, 3 Dec 2013 20:19:44 +0000
Message-ID: <20131203201944.GC3163@serenity.lan>
References: <cover.1384098226.git.john@keeping.me.uk>
 <d29327f6eb6e999ef31c3130ad2bab712a5d280b.1384098226.git.john@keeping.me.uk>
 <20131202233710.GB29959@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 21:20:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnwRp-0004KZ-6N
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 21:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028Ab3LCUTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 15:19:53 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:42151 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867Ab3LCUTw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 15:19:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 2D744866005;
	Tue,  3 Dec 2013 20:19:52 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zn5fLgpMBgrt; Tue,  3 Dec 2013 20:19:51 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id ECA87CDA57D;
	Tue,  3 Dec 2013 20:19:46 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20131202233710.GB29959@google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238732>

On Mon, Dec 02, 2013 at 03:37:10PM -0800, Jonathan Nieder wrote:
> When the built-in "git tar-tree" command (a thin wrapper around "git
> archive") was removed in 925ceccf (tar-tree: remove deprecated
> command, 2013-11-10), the build continued to install a non-functioning
> git-tar-tree command in gitexecdir by mistake:
> 
> 	$ PATH=$(git --exec-path):$PATH
> 	$ git-tar-tree -h
> 	fatal: cannot handle tar-tree internally
> 
> The list of links in gitexecdir is populated from BUILTIN_OBJS, which
> includes builtin/tar-tree.o to implement "git get-tar-commit-id".
> Rename the get-tar-commit-id source file to builtin/get-tar-commit-id.c
> to reflect its purpose and fix 'make install'.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi,
> 
> John Keeping wrote:
> 
> >  builtin/tar-tree.c                     | 62 -------------------------
> 
> Here's a quick fixup on top.  Thoughts?

This is the obvious tidy-up on top of my series.  I avoided doing it
because I thought it would just add unnecessary noise, but I had not
realised that the names of the built-in object files was important, so
it's not just noise but a part of doing the job properly.

>  Makefile                                    | 3 +--
>  builtin/{tar-tree.c => get-tar-commit-id.c} | 0
>  2 files changed, 1 insertion(+), 2 deletions(-)
>  rename builtin/{tar-tree.c => get-tar-commit-id.c} (100%)
> 
> diff --git a/Makefile b/Makefile
> index 504931f..37beb73 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -586,7 +586,6 @@ BUILT_INS += git-cherry$X
>  BUILT_INS += git-cherry-pick$X
>  BUILT_INS += git-format-patch$X
>  BUILT_INS += git-fsck-objects$X
> -BUILT_INS += git-get-tar-commit-id$X
>  BUILT_INS += git-init$X
>  BUILT_INS += git-merge-subtree$X
>  BUILT_INS += git-show$X
> @@ -929,6 +928,7 @@ BUILTIN_OBJS += builtin/fmt-merge-msg.o
>  BUILTIN_OBJS += builtin/for-each-ref.o
>  BUILTIN_OBJS += builtin/fsck.o
>  BUILTIN_OBJS += builtin/gc.o
> +BUILTIN_OBJS += builtin/get-tar-commit-id.o
>  BUILTIN_OBJS += builtin/grep.o
>  BUILTIN_OBJS += builtin/hash-object.o
>  BUILTIN_OBJS += builtin/help.o
> @@ -980,7 +980,6 @@ BUILTIN_OBJS += builtin/show-ref.o
>  BUILTIN_OBJS += builtin/stripspace.o
>  BUILTIN_OBJS += builtin/symbolic-ref.o
>  BUILTIN_OBJS += builtin/tag.o
> -BUILTIN_OBJS += builtin/tar-tree.o
>  BUILTIN_OBJS += builtin/unpack-file.o
>  BUILTIN_OBJS += builtin/unpack-objects.o
>  BUILTIN_OBJS += builtin/update-index.o
> diff --git a/builtin/tar-tree.c b/builtin/get-tar-commit-id.c
> similarity index 100%
> rename from builtin/tar-tree.c
> rename to builtin/get-tar-commit-id.c
> -- 
> 1.8.4.1
