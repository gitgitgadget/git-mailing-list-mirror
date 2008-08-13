From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit TOY PATCH] tg-graft: forge tip--base--<deps...> history for a subcommand
Date: Wed, 13 Aug 2008 09:10:40 +0200
Message-ID: <36ca99e90808130010w226a8947y1e1c59e5f5d57989@mail.gmail.com>
References: <1218575416-16711-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>
To: "Thomas Rast" <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 13 09:11:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTAWG-0006KT-8C
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 09:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbYHMHKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 03:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbYHMHKl
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 03:10:41 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:16339 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbYHMHKl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 03:10:41 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1124733yxm.1
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 00:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=URf4GqYNS3dc3cVyvT25zd/tdoWnKvNc/kqXIkwh0xg=;
        b=fQCZIwfie/jEOS7wRCTXmhJt8yDJ2Lah1Xmqfl512R09gcHsqhcKwUHUTSI46YHRMG
         nCczsAefHPTpHy5EGFlnc1n232rUKcEm5DBqen3b+mpLjCPByHgNmWNPd0WRQMbBgY3W
         3GnWe1gc5tMwPUZ0bX3mjGXvHYGvSQZ1175Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=A7rM2hjGubZrLqohymd+1AeAPIage3MUM1O2rEWDMK28upyCz7USD8SOUFAKuhEeNY
         LugwzXR0h29GK4dadQE5SNzFF0YUE3lT9EUNhaDI5o9R8H0UtBGqFWOIM4d6oFQijcwF
         cG7xjkxeX1lnHhC10iHwVpXhdtEvEU36uuKQI=
Received: by 10.151.51.18 with SMTP id d18mr15922079ybk.96.1218611440192;
        Wed, 13 Aug 2008 00:10:40 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Wed, 13 Aug 2008 00:10:40 -0700 (PDT)
In-Reply-To: <1218575416-16711-1-git-send-email-trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92185>

On Tue, Aug 12, 2008 at 23:10, Thomas Rast <trast@student.ethz.ch> wrote:
> Adds a command 'tg graft <command>' that evaluates <command> with a
> special GIT_GRAFT_FILE: the parent of each patch head is its patch
> base, and the parents of the patch base are the dependencies of the
> patch.
>
> Try, for example, 'tg graft "gitk --all"'.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> Mainly sending this so someone can turn it into a useful feature, and
> maybe build a few subcommands on top of it (that might call gitk or
> 'git log --graph', for example).
>
> The one big issue with the resulting history is that the commit
> messages at the tip aren't very interesting and may even be completely
> irrelevant (for a base merge).  I don't see a good solution for that.
>
>  Makefile    |    2 +-
>  tg-graft.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 1 deletions(-)
>  create mode 100755 tg-graft.sh
>
> diff --git a/Makefile b/Makefile
> index 6eade1e..57745c0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -6,7 +6,7 @@ sharedir = $(PREFIX)/share/topgit
>  hooksdir = $(cmddir)/hooks
>
>
> -commands_in = tg-create.sh tg-delete.sh tg-export.sh tg-info.sh tg-patch.sh tg-summary.sh tg-update.sh
> +commands_in = tg-create.sh tg-delete.sh tg-export.sh tg-info.sh tg-patch.sh tg-summary.sh tg-update.sh tg-graft.sh
Petr, maybe we should use a wildcard here, to prevent merge conflicts
while adding new commands.

I will send a patch.

>  hooks_in = hooks/pre-commit.sh
>
>  commands_out = $(patsubst %.sh,%,$(commands_in))
> diff --git a/tg-graft.sh b/tg-graft.sh
> new file mode 100755
> index 0000000..b6d0458
> --- /dev/null
> +++ b/tg-graft.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +# TopGit - A different patch queue manager
> +# (c) Petr Baudis <pasky@suse.cz>  2008
> +# GPLv2
> +
> +if [ -z "$1" -o -n "$2" ]; then
> +       echo "Usage: tg graft <command>" >&2
> +       exit 1
> +fi
> +
> +mkdir -p "$git_dir"/info
This shouldn't be needed, the info dir is created by git init.
