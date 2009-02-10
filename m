From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 22:21:16 +0100
Message-ID: <4ac8254d0902101321w1b6171cfkf7a6253181324acd@mail.gmail.com>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com>
	 <20090210110330.GB12089@coredump.intra.peff.net>
	 <7vwsbynv0o.fsf@gitster.siamese.dyndns.org>
	 <20090210181052.GA19634@coredump.intra.peff.net>
	 <20090210191118.GA26651@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 10 22:23:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX046-0001za-Q6
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 22:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287AbZBJVVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 16:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755277AbZBJVVT
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 16:21:19 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:36086 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755271AbZBJVVT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 16:21:19 -0500
Received: by bwz5 with SMTP id 5so80021bwz.13
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 13:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JQK/COvOnAMSioGp6gCP1nF8Uefii1eynSik7UFnMY8=;
        b=sa11R/VB5U4z4x7kyi+NYywOJ+MNk/wZswRYhIJM3j81hBom4r36Zwv4I0JYUsPAZN
         v6hesSp1R9KuZLrqM8FzW/nCUUnDuQL4Jw/iBGn49RhUKFRFmOIRC8iEAebhmI4lzAN6
         OIwYzTzmNULX4S/+w5vMr0u9oGVuiuKsTTyfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tEIEEk+AWNbXviSGS8PN7THraSsRcTKrnvXf4VCIzelUz7Ccy7xMNFy4WLEXdWe0LA
         zD2QCK4PcCupLmSl5sXVgwE6r9QbI6HOjyMOT/hLy7YFiHIXTZbKeyOCs1r7H1fmFuZm
         MuG/E0IJSDC8kFBZQD2tTzgAwepKH1U77Nfeo=
Received: by 10.223.115.193 with SMTP id j1mr438696faq.98.1234300876291; Tue, 
	10 Feb 2009 13:21:16 -0800 (PST)
In-Reply-To: <20090210191118.GA26651@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109313>

On Tue, Feb 10, 2009 at 8:11 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 10, 2009 at 01:10:52PM -0500, Jeff King wrote:
>
>>   - I don't think the "mini" status is really related to this. The novel
>>     thing here is collating the outputs into a single sorted list. But
>>     the "mini" output is not about that at all:
>>
>>       1. It doesn't care about full output, so it should be able to exit
>>          early from the diff, avoid rename detection, etc, so that it is
>>          as quick as possible.
>>
>>       2. It doesn't collate the output at all. It is about three
>>          separate symbols for the three separate lists.
>
> OK, I realize this is not exactly what the proposed --mini does. But
> here is more along the lines of what I was thinking.
>
> Warm cache, it runs in .042s on my git repo, about half of which is the
> untracked files check. It takes about .49s on the kernel repo. The
> read_directory() bit is not optimized at all, and could probably benefit
> from an early return (OTOH, the worst case is still going to need to
> look at every path).
>
> I am not particularly interested in a fancy prompt myself, but maybe
> this will help somebody else.

I tried this and it did not run faster than my experiment.
I had to add a missing opening curly brace in
have_untracked() before it compiled.

As we haven't found a fast way yet I can live without it.

> The patch relies on the index_differs_from() patch that Stephan
> posted earlier today.
>
> ---
>  .gitignore           |    1 +
>  Makefile             |    1 +
>  builtin-ministatus.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  builtin.h            |    1 +
>  git.c                |    1 +
>  5 files changed, 56 insertions(+), 0 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index 055eb54..de2249b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -81,6 +81,7 @@ git-mergetool
>  git-mktag
>  git-mktree
>  git-name-rev
> +git-ministatus
>  git-mv
>  git-notes
>  git-pack-redundant
> diff --git a/Makefile b/Makefile
> index a0ca137..9145c7b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -559,6 +559,7 @@ BUILTIN_OBJS += builtin-merge-base.o
>  BUILTIN_OBJS += builtin-merge-file.o
>  BUILTIN_OBJS += builtin-merge-ours.o
>  BUILTIN_OBJS += builtin-merge-recursive.o
> +BUILTIN_OBJS += builtin-ministatus.o
>  BUILTIN_OBJS += builtin-mv.o
>  BUILTIN_OBJS += builtin-name-rev.o
>  BUILTIN_OBJS += builtin-pack-objects.o
> diff --git a/builtin-ministatus.c b/builtin-ministatus.c
> new file mode 100644
> index 0000000..c9f8e7f
> --- /dev/null
> +++ b/builtin-ministatus.c
> @@ -0,0 +1,52 @@
> +#include "cache.h"
> +#include "diff.h"
> +#include "commit.h"
> +#include "revision.h"
> +#include "dir.h"
> +
> +static int worktree_is_dirty(void)
> +{
> +       struct rev_info rev;
> +       init_revisions(&rev, "");
> +       setup_revisions(0, NULL, &rev, NULL);
> +       DIFF_OPT_SET(&rev.diffopt, QUIET);
> +       DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
> +       run_diff_files(&rev, 0);
> +       return DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
> +}
> +
> +static int have_untracked(void)
> +{
> +       struct dir_struct dir;
> +       int i;
> +
> +       memset(&dir, 0, sizeof dir);
> +       setup_standard_excludes(&dir);
> +
> +       read_directory(&dir, ".", "", 0, NULL);
> +       /* XXX we are probably leaking memory from dir */
> +       for (i = 0; i < dir.nr; i++)
> +               struct dir_entry *ent = dir.entries[i];
> +               if (cache_name_is_other(ent->name, ent->len))
> +                       return 1;
> +       }
> +       return 0;
> +}
> +
> +int cmd_ministatus(int argc, const char **argv, const char *prefix)
> +{
> +       if (argc != 1)
> +               die("Sorry, I don't understand any command line options.");
> +
> +       read_cache();
> +       refresh_cache(REFRESH_QUIET);
> +
> +       if (index_differs_from("HEAD", 0))
> +               putchar('+');
> +       if (worktree_is_dirty())
> +               putchar('*');
> +       if (have_untracked())
> +               putchar('?');
> +
> +       return 0;
> +}
> diff --git a/builtin.h b/builtin.h
> index f054fc7..03e6a88 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -71,6 +71,7 @@ extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
>  extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
>  extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
>  extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
> +extern int cmd_ministatus(int argc, const char **argv, const char *prefix);
>  extern int cmd_mv(int argc, const char **argv, const char *prefix);
>  extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
>  extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
> diff --git a/git.c b/git.c
> index 4c0fa44..8bf7e78 100644
> --- a/git.c
> +++ b/git.c
> @@ -323,6 +323,7 @@ static void handle_internal_command(int argc, const char **argv)
>                { "merge-ours", cmd_merge_ours, RUN_SETUP },
>                { "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
>                { "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },
> +               { "ministatus", cmd_ministatus, RUN_SETUP | NEED_WORK_TREE },
>                { "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
>                { "name-rev", cmd_name_rev, RUN_SETUP },
>                { "pack-objects", cmd_pack_objects, RUN_SETUP },
>
