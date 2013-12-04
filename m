From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH jk/remove-deprecated] stop installing git-tar-tree link
Date: Wed, 04 Dec 2013 11:23:31 +0100
Message-ID: <529F02A3.2030704@drmicha.warpmail.net>
References: <cover.1384098226.git.john@keeping.me.uk> <d29327f6eb6e999ef31c3130ad2bab712a5d280b.1384098226.git.john@keeping.me.uk> <20131202233710.GB29959@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Dec 04 11:23:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo9c0-0006Mu-Pp
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 11:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab3LDKXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 05:23:17 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55551 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755225Ab3LDKXQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 05:23:16 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E561F21608;
	Wed,  4 Dec 2013 05:23:14 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 04 Dec 2013 05:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=A0j8nZzS8/pbmqlX63GhdT
	D1Fw0=; b=WBiP9WrjRMTyFAplzt6jcXJnhY3nzEOHVjraaPSE3abxW4qMBT6igO
	pkb8XIgUx2SNG2CYQltRDHSJlJmuN+vgeU3PLEgMfwT8iCGocJXkCoscEmEBOEzk
	rNs+rVAaq064Io50mGSqnRHXGWVpVQ1j8DQgW0okPX3NT6CDipf7k=
X-Sasl-enc: Pbi4x3TjOBo2NsLCov9Qem7pvls7AZ4o4uWvpSPZ4DKV 1386152594
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 38768C00E88;
	Wed,  4 Dec 2013 05:23:14 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131202233710.GB29959@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238769>

Jonathan Nieder venit, vidit, dixit 03.12.2013 00:37:
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

... "which still resides in builtin/tar-tree.c"

Had me scratch my head quite a bit as is ;)

> Rename the get-tar-commit-id source file to builtin/get-tar-commit-id.c
> to reflect its purpose and fix 'make install'.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi,
> 
> John Keeping wrote:
> 
>>  builtin/tar-tree.c                     | 62 -------------------------
> 
> Here's a quick fixup on top.  Thoughts?
> 
> Thanks,
> Jonathan
> 
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
> 
