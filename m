From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] branch: fix shortening of non-remote symrefs
Date: Tue, 5 Apr 2016 11:51:14 +0530
Message-ID: <CAOLa=ZTYc1+1ekC0q+c2sZ9==Wzw_=84V3bodhh0+pBnFAfjWg@mail.gmail.com>
References: <570085DE.9000002@orcon.net.nz> <20160403041426.GA22211@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Sainty <psainty@orcon.net.nz>,
	Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 05 08:21:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anKN4-0003hm-Ie
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 08:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067AbcDEGVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 02:21:46 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33902 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbcDEGVo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 02:21:44 -0400
Received: by mail-qg0-f42.google.com with SMTP id c6so3010820qga.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 23:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k+CE8KfJ701reVt3+D+y8u3t0i+eCsRoUMC1jBbCRT8=;
        b=X2AUWPFKvRvvFRU/jKaHrOzZ1eompzXqMnBnqFaIDmCX72VlLfWNN0mdNhzwyp+h+z
         OQ+kWxufIg06N7t4oqn1ZeRzsJmb5apB5rGcz5Sjj58Q0m6qsOxsm1NeJzxRx6uOzOs4
         klYgOo4tkLwKqmXaeEiNAoHFIxVdt0aOzy01qh99SBaCmuJqqPVCogjOukd0k7HHjZTA
         2q2FDxtlmSCVF+3hTUvwNZuHfI1gqn4xtP99CCY3uhuD+vsk965H/x0smoORO9zeTqGl
         qpSu1d3JfgMdS9unaO4V8SaGKAesoaMI69mz2KrUlXBap9M2vDhjzsnj1l1Ui3gwOeCw
         ltbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k+CE8KfJ701reVt3+D+y8u3t0i+eCsRoUMC1jBbCRT8=;
        b=IuqpMRjkBtJvmmfzTvCcMoEGHmUeEnvD2b8gu7IJdOOC3qs5UwTAMIkVKVerZr5Nk+
         9H8W2VFltP2VsLmmLgZ+btiY/2wPlAIHQlUf+ElVWE4+AbzRqCQnqwEDZz3ScjYQdn3i
         zUaFtLhJz3UAcnUdogLCfzT3DVkSk0evfktwwI+hAN6wNVQ4UHmCW/ojDh3Vh9TPzmEm
         gSQOi8bu7ASI7e5rSKc2DFxydLwgeoA1foBwrBw+vRzwM/kbzFjhjeE4hrTiUtqn/muY
         ST/RPqB1LfRhJN+nm3BU2s3uz1NTAOJQYVYcjSxdh16p14K9+YZaIGtSaQ+jbJhcHO1C
         eEoQ==
X-Gm-Message-State: AD7BkJLnZYayTkZI+SB+ze9Fhp3f/oHt9+4MM7OHxyJ7xXTUhDyQFcbl+70VY6KQI2aR1Mqngk8zkJSRPNBQgw==
X-Received: by 10.140.232.15 with SMTP id d15mr18804893qhc.87.1459837303670;
 Mon, 04 Apr 2016 23:21:43 -0700 (PDT)
Received: by 10.140.92.238 with HTTP; Mon, 4 Apr 2016 23:21:14 -0700 (PDT)
In-Reply-To: <20160403041426.GA22211@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290761>

Hello,

On Sun, Apr 3, 2016 at 9:44 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 03, 2016 at 02:54:22PM +1200, Phil Sainty wrote:
>
>> Given the following symbolic reference:
>>
>> $ git symbolic-ref refs/heads/m refs/heads/master
>>
>>
>> Correct in 2.6.6:
>>
>> $ PATH=~/git/git-2.6.6:$PATH git branch
>>   m -> master
>> * master
>>
>>
>> Wrong in 2.7.0:
>>
>> $ PATH=~/git/git-2.7.0:$PATH git branch
>>   m -> m
>> * master

Thanks for reporting this.

>
> Thanks for an easy test case. Though we don't officially support
> arbitrary symrefs in the ref namespace, they do mostly work. And
> certainly the current output is nonsense, and it worked before. This
> bisects to aedcb7d (branch.c: use 'ref-filter' APIs, 2015-09-23).
>
> The fix is below. Karthik, I didn't look at all how this interacts with
> your work to convert branch to ref-filter for printing. I imagine it
> drops this code completely, but we should make sure that ref-filter gets
> this case right. I almost didn't prepare this patch at all, but I
> suspect we may want it for "maint", while the full conversion would wait
> for "master".
>

It's dropped in my latest series. I should be able to replicate what you've done
here onto ref-filter.c. Since I'm re-rolling my patches, I'll add this
one along too.

> -- >8 --
> Subject: branch: fix shortening of non-remote symrefs
>
> Commit aedcb7d (branch.c: use 'ref-filter' APIs, 2015-09-23)
> adjusted the symref-printing code to look like this:
>
>     if (item->symref) {
>             skip_prefix(item->symref, "refs/remotes/", &desc);
>             strbuf_addf(&out, " -> %s", desc);
>     }
>
> This has three bugs in it:
>
>   1. It always skips past "refs/remotes/", instead of
>      skipping past the prefix associated with the branch we
>      are showing (so commonly we see "refs/remotes/" for the
>      refs/remotes/origin/HEAD symref, but the previous code
>      would skip "refs/heads/" when showing a symref it found
>      in refs/heads/.
>
>   2. If skip_prefix() does not match, it leaves "desc"
>      untouched, and we show whatever happened to be in it
>      (which is the refname from a call to skip_prefix()
>      earlier in the function).
>
>   3. If we do match with skip_prefix(), we stomp on the
>      "desc" variable, which is later passed to
>      add_verbose_info(). We probably want to retain the
>      original refname there (though it likely doesn't matter
>      in practice, since after all, one points to the other).
>
> The fix to match the original code is fairly easy: record
> the prefix to strip based on item->kind, and use it here.
> However, since we already have a local variable named "prefix",
> let's give the two prefixes verbose names so we don't
> confuse them.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The test makes sure we restored the v2.6.x behavior, namely that
> cross-prefix symrefs will not be shortened at all. It might be nice to
> show:
>
>   ref-to-remote -> remotes/origin/branch-one
>
> or something, but that should be separate from the fix (and I don't
> overly care either way, so I probably won't work on it).
>
>  builtin/branch.c         | 19 ++++++++++++-------
>  t/t3203-branch-output.sh | 12 ++++++++++++
>  2 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 7b45b6b..f6c23bf 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -393,22 +393,25 @@ static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
>         int current = 0;
>         int color;
>         struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
> -       const char *prefix = "";
> +       const char *prefix_to_show = "";
> +       const char *prefix_to_skip = NULL;
>         const char *desc = item->refname;
>         char *to_free = NULL;
>
>         switch (item->kind) {
>         case FILTER_REFS_BRANCHES:
> -               skip_prefix(desc, "refs/heads/", &desc);
> +               prefix_to_skip = "refs/heads/";
> +               skip_prefix(desc, prefix_to_skip, &desc);
>                 if (!filter->detached && !strcmp(desc, head))
>                         current = 1;
>                 else
>                         color = BRANCH_COLOR_LOCAL;
>                 break;
>         case FILTER_REFS_REMOTES:
> -               skip_prefix(desc, "refs/remotes/", &desc);
> +               prefix_to_skip = "refs/remotes/";
> +               skip_prefix(desc, prefix_to_skip, &desc);
>                 color = BRANCH_COLOR_REMOTE;
> -               prefix = remote_prefix;
> +               prefix_to_show = remote_prefix;
>                 break;
>         case FILTER_REFS_DETACHED_HEAD:
>                 desc = to_free = get_head_description();
> @@ -425,7 +428,7 @@ static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
>                 color = BRANCH_COLOR_CURRENT;
>         }
>
> -       strbuf_addf(&name, "%s%s", prefix, desc);
> +       strbuf_addf(&name, "%s%s", prefix_to_show, desc);
>         if (filter->verbose) {
>                 int utf8_compensation = strlen(name.buf) - utf8_strwidth(name.buf);
>                 strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
> @@ -436,8 +439,10 @@ static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
>                             name.buf, branch_get_color(BRANCH_COLOR_RESET));
>
>         if (item->symref) {
> -               skip_prefix(item->symref, "refs/remotes/", &desc);
> -               strbuf_addf(&out, " -> %s", desc);
> +               const char *symref = item->symref;
> +               if (prefix_to_skip)
> +                       skip_prefix(symref, prefix_to_skip, &symref);
> +               strbuf_addf(&out, " -> %s", symref);
>         }
>         else if (filter->verbose)
>                 /* " f7c0c00 [ahead 58, behind 197] vcs-svn: drop obj_pool.h" */
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index 4261403..c6a3ccb 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -184,4 +184,16 @@ test_expect_success 'ambiguous branch/tag not marked' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'local-branch symrefs shortened properly' '
> +       git symbolic-ref refs/heads/ref-to-branch refs/heads/branch-one &&
> +       git symbolic-ref refs/heads/ref-to-remote refs/remotes/origin/branch-one &&
> +       cat >expect <<-\EOF &&
> +         ref-to-branch -> branch-one
> +         ref-to-remote -> refs/remotes/origin/branch-one
> +       EOF
> +       git branch >actual.raw &&
> +       grep ref-to <actual.raw >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.8.0.429.gaaf8de0
>

This seems to fix the bug very easily and effectively. Thanks for the patch :)

-- 
Regards,
Karthik Nayak
