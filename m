Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E41D1F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 15:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933755AbcIVPgD (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 11:36:03 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34044 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933448AbcIVPgC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 11:36:02 -0400
Received: by mail-io0-f172.google.com with SMTP id q92so89737604ioi.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NJrc20ELVGemIlXlOwDWPSMpHOs5Aez4bTZ3wgBrtb0=;
        b=OqkIhxqtKYgNOVH52HT/rgKvUt9dmGgCPGIP0Sb63nTzWS6K7KHksbtXM4Txl1RgEl
         cyCeiYPD2HwrbXH4Fj5U47/6HwU57TxQF8KHkKMk/OumJFqRoRJ0hINhVoZtSZMcds05
         VSLUyb07AiTY7XO/JjoJlkBXyl3ZzV87wDs1WU1c427x7/HOmhUyZ+0W6s9PfrG1D6Sq
         8RAgLtjSQUcOMYdzEcIMjMo0Yjftfd9CFemDxMPY9LUi2p/1n5g02X4DjIr13zw/hjlJ
         Rv0dljInbK5tdcKD+syxt6PVeuTTwyITUeq5sEohSdLsooO6RH/XfhN0k/v5vx0gpATV
         +t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NJrc20ELVGemIlXlOwDWPSMpHOs5Aez4bTZ3wgBrtb0=;
        b=Zzqep4hWJFICMKnOv0GGNge2j6Pd6Zm38CRCoQon0XEiIKO7N/9+SGT/EORBdr19eX
         Wx3FeZ7F5z445KrbiDTvNJPxyRYnmaZDklga0t5gc8LIGH84kQjDsWZm/rmp7WVP2haU
         iRgNI+FJSf9v/HzoXu+7vH2djCCKCRiyatH674qV2AAwra3pRyw2dXC+LflFhbOLNZI4
         0W5Wz1n6iwnMZRCFApfzOvZSRmMF7CKXTCJWR9UWw3ubQcaxiBS/TxaZJJoYzOqhpftW
         DyxfLR+o8sf6a6p2qB0G0VIdEhjdHQxmMYSitFCVhbAsU106CnmgrHT2EVpVTSahnXvs
         31Hw==
X-Gm-Message-State: AA6/9Rk4/7hn77gUYXaj+VRNnRZKKVIst048aMxd8AR9gKAg8UzAWgLJSD4CTxEg5bKqT+FP0Br2jdLf5mm0o0sZ
X-Received: by 10.107.180.11 with SMTP id d11mr3979509iof.203.1474558561602;
 Thu, 22 Sep 2016 08:36:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Thu, 22 Sep 2016 08:36:01 -0700 (PDT)
In-Reply-To: <20160922052446.iwr62hpa2meal7uj@sigill.intra.peff.net>
References: <20160922052446.iwr62hpa2meal7uj@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Sep 2016 08:36:01 -0700
Message-ID: <CAGZ79kbTi+5oo325v+v8GB7isKRfqys6WRGUARHiMvieDz+png@mail.gmail.com>
Subject: Re: [PATCH] clone: pass --progress decision to recursive submodules
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 10:24 PM, Jeff King <peff@peff.net> wrote:
> When cloning with "--recursive", we'd generally expect
> submodules to show progress reports if the main clone did,
> too.
>
> In older versions of git, this mostly worked out of the
> box. Since we show progress by default when stderr is a tty,
> and since the child clones inherit the parent stderr, then
> both processes would come to the same decision by default.
> If the parent clone was asked for "--quiet", we passed down
> "--quiet" to the child. However, if stderr was not a tty and
> the user specified "--progress", we did not propagate this
> to the child.
>
> That's a minor bug, but things got much worse when we
> switched recently to submodule--helper's update_clone
> command. With that change, the stderr of the child clones
> are always connected to a pipe, and we never output
> progress at all.

Right, that is an issue.

>
> Signed-off-by: Jeff King <peff@peff.net>

Acked and thanked by Stefan ;)

>
> I imagine there are other code paths that want similar treatment, but I
> didn't look into them. I'd assume "fetch" is one. I'm not sure if we do
> parallel checkouts, but that's another potential.

Looking for run_processes_parallel in the code,
it seems to only be used in fetch_populated_submodules
and the submodule helper.

>
>         update_head(our_head_points_at, remote_head, reflog_msg.buf);
>
> +       /*
> +        * We want to show progress for recursive submodule clones iff
> +        * we did so for the main clone. But only the transport knows
> +        * the final decision for this flag, so we need to rescue the value
> +        * before we free the transport.
> +        */
> +       submodule_progress = transport->progress;
> +

Good point! I was aware of this bug (but I did not consider it to be impactful
or as you put it "much worse"), but I anticipated we would need some refactoring
of the transport code, e.g. have the decision via isatty(2) as a
separate outside
function that we consult before we even setup the transport and then
pass it down
to the submodules as well. This seems to solve this bug elegantly.

>         transport_unlock_pack(transport);
>         transport_disconnect(transport);
>
> @@ -1108,7 +1120,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>         }
>
>         junk_mode = JUNK_LEAVE_REPO;
> -       err = checkout();
> +       err = checkout(submodule_progress);
>
>         strbuf_release(&reflog_msg);
>         strbuf_release(&branch_top);
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 7b8ddfe..d2f9d7d 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -443,7 +443,8 @@ static int module_name(int argc, const char **argv, const char *prefix)
>  }
>
>  static int clone_submodule(const char *path, const char *gitdir, const char *url,
> -                          const char *depth, struct string_list *reference, int quiet)
> +                          const char *depth, struct string_list *reference,
> +                          int quiet, int progress)

I am not sure if having both quiet and progress is maintainable well,
but it get's the job done here, specifically if we consider this patch a bug
fix that we'd want to merge down to maint.
