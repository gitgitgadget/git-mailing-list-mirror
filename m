From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/7] add new command git equal-tree-marker
Date: Mon, 30 Nov 2009 16:36:28 +0100
Message-ID: <4B13E67C.4050005@drmicha.warpmail.net>
References: <cover.1259524136.git.brlink@debian.org> <9e6833ef7188f41d6ea46ddcf92929af284b4adb.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bernhard R. Link" <brlink@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 30 16:37:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF8K3-0004iY-9W
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 16:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbZK3Phf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 10:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753093AbZK3Phe
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 10:37:34 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:44122 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753061AbZK3Phd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 10:37:33 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C92F5C51A7;
	Mon, 30 Nov 2009 10:37:39 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 30 Nov 2009 10:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=zriURAWA6NLh3NGze3FibG22w2c=; b=ZIHqocHq5c9zIh4sVmXVMQGEsznvdUDgLQJM/WtCw57405uFB6p4ugusMIn3yaluTRdgl2KZVV4FYiNBsixArjg76CzTI2gI0NSIZsz4HCGwRZ7l4IXBQhcfptjDajWU3Wtnvd/KIdGlXCXXGIzKJRy8QvjItVfy2QWACRoEdms=
X-Sasl-enc: cHKLWZQilSwMI4qJBZJoslC9f9w9gratay+8QFiyM2s7 1259595459
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4031B1A6A8;
	Mon, 30 Nov 2009 10:37:39 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091127 Lightning/1.0b1pre Shredder/3.0.1pre
In-Reply-To: <9e6833ef7188f41d6ea46ddcf92929af284b4adb.1259524136.git.brlink@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134114>

Bernhard R. Link venit, vidit, dixit 30.11.2009 15:43:
> This adds a new commit denoting tha current branch has the same
> tree as another branch, thus allowing fast-forward from the named
> commits to this one.
> 
> TODO: manpage, rewrite as builtin once the semantics are accepted?
> ---
>  .gitignore               |    1 +
>  Makefile                 |    1 +
>  git-equal-tree-marker.sh |   50 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+), 0 deletions(-)
>  create mode 100644 git-equal-tree-marker.sh
> 
> diff --git a/.gitignore b/.gitignore
> index ac02a58..248d146 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -39,6 +39,7 @@
>  /git-difftool
>  /git-difftool--helper
>  /git-describe
> +/git-equal-tree-marker
>  /git-fast-export
>  /git-fast-import
>  /git-fetch
> diff --git a/Makefile b/Makefile
> index 4dba10e..913d4c4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -336,6 +336,7 @@ TEST_PROGRAMS =
>  SCRIPT_SH += git-am.sh
>  SCRIPT_SH += git-bisect.sh
>  SCRIPT_SH += git-difftool--helper.sh
> +SCRIPT_SH += git-equal-tree-marker.sh
>  SCRIPT_SH += git-filter-branch.sh
>  SCRIPT_SH += git-lost-found.sh
>  SCRIPT_SH += git-merge-octopus.sh
> diff --git a/git-equal-tree-marker.sh b/git-equal-tree-marker.sh
> new file mode 100644
> index 0000000..403cc56
> --- /dev/null
> +++ b/git-equal-tree-marker.sh
> @@ -0,0 +1,50 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2009 Bernhard R. Link
> +#
> +# Create a new commit making HEAD parent of the arguments,
> +# which must be commits with the same tree.
> +
> +set -e
> +
> +USAGE='<head>...'
> +LONG_USAGE='Make current HEAD parent of the given heads (which need to have the same tree).'
> +SUBDIRECTORY_OK=Yes
> +OPTIONS_SPEC=
> +. git-sh-setup
> +cd_to_toplevel
> +
> +# is there really no function for this?
> +tree_of_commit() {
> +	git cat-file commit "$1" | grep '^tree ' | head -n 1 | sed -e 's/^tree //'
> +}

You mean there should be something really simple, such as:

git rev-parse "$1"^{tree}

Michael
