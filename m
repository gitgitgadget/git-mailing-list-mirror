Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EABC6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 20:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjCQUY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCQUYy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 16:24:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCA82E81D
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 13:24:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id ch1-20020a0569020b0100b00b3cc5b4fa9dso6336939ybb.12
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 13:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679084692;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KCkLJGXUGL7VYw5Srs8CHBqZhe+DhP/Kf+Zw1DCgG5o=;
        b=LHGObHpjFE37MWmnsGBAkjulvBBVwfcvT4D386kvE2doAmFFWxv6swxJtvPS3g3DKo
         VId3L42+hzDC8hNRz2FOvgu3yh1BAbnJoe5nJP78zQkFUUkS77wpd734V48td+6a69H3
         k/yX0fI711hAdyJP6rZdeUDqTu+UERRhS7GBw26xZIafx6NHEQ8y0sJJ645IRbQgc+UG
         GhUFpdP7u+ts2z5UcPPFhlVYgJjA3bbFf72UlYBL2o0So6WPrwzbGcUbnrsbiraavDlY
         wMtxBHwsCTAclXl+GMMW+BWQcB5ohzzTGHjWUMe9JPuTYYEuyonRMsWjRQQnDqFgJESR
         TiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679084692;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCkLJGXUGL7VYw5Srs8CHBqZhe+DhP/Kf+Zw1DCgG5o=;
        b=YteIkdDcVcvECUQyp+IVnGSfzDIFkw61mAFHEofBGbbimAtUaH517KCSf/uz+WE+9F
         DpPVArDTZQ6BQ0YRqiPEUpgSkl9jR/0jbWD2lA8NDARBb/ux6uGyUNDGIdqSJr2/7vom
         veaAWhXSi8ZgP1+orp5mUCAOTIvt2bu1by7TpuZIc508HccmPBdqksQ+lXReBV5bVq4y
         vNcEOkOcyYPxtcip8Aj3fOexq50UUt50e6T+bqSbxg+Qi45Q1oIyXQTsQbBf/TQqRzQw
         SAIiSHHKUMO181TT0TpP2G0rjcfFZAUAVDchHwDmy9mYvemznhcBUgAmWvBGnLkB/M8/
         eCWQ==
X-Gm-Message-State: AO0yUKU77QFbfFFbnV2tvtT1WjmjlUel+9GbUTqt9nieBdwWSEEcNwqf
        2Nl8WIILMtr1LzP5wQafWGqPHacsKgIWg7vYNXnK
X-Google-Smtp-Source: AK7set/o5J4J2WWwPxomC8kpS3FTXStLPY1f5p+/dhA6tSeWHG7Rwu61tpRbtdvlQFV5O/IWj7vGhxe/C0y5FJWCtoPL
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:97a1:d5da:aaf2:92eb])
 (user=jonathantanmy job=sendgmr) by 2002:a81:ae0d:0:b0:541:6941:5aa8 with
 SMTP id m13-20020a81ae0d000000b0054169415aa8mr5062920ywh.7.1679084692323;
 Fri, 17 Mar 2023 13:24:52 -0700 (PDT)
Date:   Fri, 17 Mar 2023 13:24:49 -0700
In-Reply-To: <cover.1678878623.git.ps@pks.im>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230317202449.1083635-1-jonathantanmy@google.com>
Subject: Re: [PATCH 0/8] fetch: refactor code that prints reference updates
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:
>     1. We want to take control of the reference updates so that we can
>        atomically update all or a subset of references that git-fetch
>        would have updated.
> 
>     2. We want to be able to quarantine objects in a fetch so that we
>        can e.g. perform consistency checks for them before they land in
>        the main repository.

If you want to do this, something that might be possible is to change
the RHS of the refspecs to put the refs in a namespace of your choice
(e.g. ...:refs/<UUID>/...) and then you can look at what's generated and
process them as you wish.

>     - There should be as few global state as possible. This is to reduce
>       confusion and having to repeat the same incantations in multiple
>       different locations.

Makes sense.

>     - The logic should be as self-contained as possible. This is so that
>       it can easily be changed in a subsequent patch series.

Also makes sense, but I think that some of your patches might be
contrary to this goal (more details below).

I've read all the patches, but will just summarize my thoughts here.

> Patrick Steinhardt (8):
>   fetch: rename `display` buffer to avoid name conflict

One other way, as others have discussed, is to just name the new
variable display_state. (I would prefer that, at the very least so
that in case someone else has a patch that contains the identifier
"display", problems would be more easily noticed. This is very unlikely
to happen but I think it's a good general direction for the Git project
to follow.)

>   fetch: move reference width calculation into `display_state`
>   fetch: move output format into `display_state`
>   fetch: pass the full local reference name to `format_display`

All these are good changes that I would be happy to see merged.

>   fetch: deduplicate handling of per-reference format

I'm not so sure that this is the correct abstraction. I think that this
and the last patch might be counterproductive to your stated goal of
having one more mode of printing the refs, in fact, since when we have
that new mode, the format would be different but the printing would
remain (so we should split the format and printing).

>   fetch: deduplicate logic to print remote URL

Makes sense, although I would need to consider only storing the
raw URL in the struct display_state and processing it when it needs
to be emitted (haven't checked if this is feasible, though).

>   fetch: fix inconsistent summary width for pruned and updated refs

This changes the behavior in that the summary width, even when printing
the summary of pruned refs, is computed based only on the updated refs.
The summary width might need to remain out of the struct display_state
for now.

>   fetch: centralize printing of reference updates

Same as "fetch: deduplicate handling of per-reference format".
