From: Per Cederqvist <cederp@opera.com>
Subject: Re: [PATCH 10/10] submodule deinit: complain when given a file
 instead of a submodule
Date: Mon, 2 May 2016 10:26:02 +0200
Message-ID: <CAP=KgsStNm7eUWRfzDPje8mAQ2hFCMJ6MpCeF_OgPvir244vgQ@mail.gmail.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
	<1461976845-18228-11-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 02 10:26:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax9BX-0004Qc-74
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 10:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbcEBI0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 04:26:15 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33573 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbcEBI0D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 04:26:03 -0400
Received: by mail-qk0-f176.google.com with SMTP id n63so70646497qkf.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=hOVwpXNDhBLpsJ3LF20bqAINfMG3nzFmU0MhXKxT+rM=;
        b=IYIuvpHyX3t9/XmkJk8s52NO9cnZhTwWdgQAt5x/COzsqT1x9IszetFDuM+kzSihqT
         x/o1OBkQVRu8p3R/HwM9gmWYoFr1ei3CyP0R66Vj/vKISXc5l4JMMd86YcQf/ZG1xamz
         8sDHMBvW8vs2ez5KZNzFYqBrt3NUcFxQzA2W+9wD5Hzdn1eI1Ry6Aa3jliSl1TiRw88b
         Pq8GgFRSpcRithkH1wyz3ydPhXaymoXRLEre50auSoSZr3jXKMn8LZW2WsgglMa1lBp0
         GsPfkDHf+FJ7xUqcplO2rFHugCKfLHQS3T7FLDkpgjSCsF+f13sJViZ4WEKfiiCLbTSr
         DpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hOVwpXNDhBLpsJ3LF20bqAINfMG3nzFmU0MhXKxT+rM=;
        b=kZsGHE5LZBlofzCuDx5vkvE2k2ZVSchu4qFfX2MORuZNrulI5v5jzQbZiNZu3IktSE
         QejxfQh8px4qtk8oGOVuHHzSseq2PIBBDfvwkvwc+KBYumKd45EuuajXP1vuRFiNJCcp
         FemShY+I6s5UeAigPOLAlCB4yrnq7I6cZmT9Y5swQ5wBdShia7JN5jdEwoVpahLTvTZY
         QEBe1UdIRIyrRw4JHL0rQm7+Sqe0dcfozwZAhmqtQU5QDl32uA5plXrdwIUBSg4f32mI
         u1WsY2vVUoUIkpG2UHhdScK2OjO+gLkZGZeqJYONgwlhgWaC7A8bxhf0WiUgNx5Qv7mz
         uEHg==
X-Gm-Message-State: AOPr4FXniVgYfX7/GC5egP7EzDx4TKIMscZNyEMAG06+446ubUW5V09SoPxoWN7TAyk43cTIQb3tE6txJf9y2SZx
X-Received: by 10.233.232.16 with SMTP id a16mr2425027qkg.25.1462177562453;
 Mon, 02 May 2016 01:26:02 -0700 (PDT)
Received: by 10.55.184.70 with HTTP; Mon, 2 May 2016 01:26:02 -0700 (PDT)
In-Reply-To: <1461976845-18228-11-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293230>

After this change, what is the simplest way to programmatically
deinit any submodule that may exist, without failing if there are
none?

"git commit" by default refuses to make an empty commit, but
it has the --allow-empty option.

"git rm -r ." by default fails if there are no files in the repository,
but it has the --ignore-unmatch option.

It makes sense that "git submodule deinit ." should fail if there
are no submodules, but please add support for --ignore-unmatch
at the same time.

    /ceder


On Sat, Apr 30, 2016 at 2:40 AM, Stefan Beller <sbeller@google.com> wrote:
> This also improves performance for listing submodules, because
> S_ISGITLINK is both faster as match_pathspec as well as expected to
> be true in fewer cases, so putting it first in the condition will speed
> up the loop to compute all submodules.
>
> As this partially reverts 84ba959bbdf0 (submodule: fix regression for
> deinit without submodules, 2016-03-22), this also disallows the use
> of `git submodule deinit .` to deinit all submodules, when no
> submodules are present. `deinit .` continues to work on repositories,
> which have at least one submodule.
>
> CC: Per Cederqvist <cederp@opera.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>
>> Patch 10 is a controversial thing I'd assume as it breaks existing users.
>> We should take it for the next major release (i.e. 3.0)
>> I just want to put it out here now.
>
>  builtin/submodule--helper.c |  6 +++---
>  t/t7400-submodule-basic.sh  | 15 ++++++++++++++-
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 7f0941d..e41de3e 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -242,9 +242,9 @@ static int module_list_compute(int argc, const char **argv,
>         for (i = 0; i < active_nr; i++) {
>                 const struct cache_entry *ce = active_cache[i];
>
> -               if (!match_pathspec(pathspec, ce->name, ce_namelen(ce),
> -                                   0, ps_matched, 1) ||
> -                   !S_ISGITLINK(ce->ce_mode))
> +               if (!S_ISGITLINK(ce->ce_mode) ||
> +                   !match_pathspec(pathspec, ce->name, ce_namelen(ce),
> +                                   0, ps_matched, 1))
>                         continue;
>
>                 ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 53644da..361e6f6 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -915,7 +915,20 @@ test_expect_success 'submodule deinit works on repository without submodules' '
>                 >file &&
>                 git add file &&
>                 git commit -m "repo should not be empty" &&
> -               git submodule deinit .
> +               git submodule deinit
> +       )
> +'
> +
> +test_expect_success 'submodule deinit refuses to deinit a file' '
> +       test_when_finished "rm -rf newdirectory" &&
> +       mkdir newdirectory &&
> +       (
> +               cd newdirectory &&
> +               git init &&
> +               >file &&
> +               git add file &&
> +               git commit -m "repo should not be empty" &&
> +               test_must_fail git submodule deinit file
>         )
>  '
>
> --
> 2.8.0.32.g71f8beb.dirty
>
