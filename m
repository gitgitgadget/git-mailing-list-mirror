Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4513AC4338F
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 21:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2559D61042
	for <git@archiver.kernel.org>; Sat,  7 Aug 2021 21:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhHGVf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Aug 2021 17:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhHGVfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Aug 2021 17:35:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FBFC0613CF
        for <git@vger.kernel.org>; Sat,  7 Aug 2021 14:35:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k11-20020a17090a62cbb02901786a5edc9aso4410348pjs.5
        for <git@vger.kernel.org>; Sat, 07 Aug 2021 14:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u9yJgGIs9zB6IZFqJ0ELbuZPIGcWhDEaYknElAlERN0=;
        b=aqi8qy8lS9NwFOA05K8Mgwh3sQn0KE6Ysj6zZuAbD+waGhlFjcdicr/KeZHAw4snZ5
         Y10QmAAnsmcJz064YA9aDNapF8+GQw10wltIqnWrfEJFezUcvnFScZoWiJdJzu2bgFzN
         xrAdsCsTBSODAmelx8x3gmFSmKQAK9PSUdPz8RxZt5VGwtA21BvziXlCwCdhDfx7svjq
         QiF9aJu9v2hU7Jwp2l81us3RCs3fdRneBe1zVfQ17DE5cbn88Aj9FjRzBneUuGoAEEW7
         tPMBPhRK3faEmEhxpV+EXsbPdwOLRP7dmPna+Sj0fqoxyktxZ8M0ebVy5srWBpvlGmpZ
         NZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9yJgGIs9zB6IZFqJ0ELbuZPIGcWhDEaYknElAlERN0=;
        b=EbNHogaECdxH9XAupKPWm4KvUtN/T4PZftJgoR3UxjtsaalBAe02qg/YUo/iz7vD9q
         pMu6kOp+ZKy98mPH3T14RdhinQ6lSgUsmy9e0l7kfNao6baMYWkMIgZJ3wC90gK4om0X
         rHgZrSEr+Oab3h6KjR0R4L7E4yV0AAnXMbBxZDoC9GWwwayNRkZ3tmhq63DyV2MkBCR9
         4H8rPNVIuvqGA8f4DXGO8bfXEC5OsFeEpiPh9fKD/E66pWwhVpY37VMfFE1KXuCt1Ykg
         hgI0OeyezDqmem/XcCQGHtAnI7ZrzWDuGbAXAVgonmFhVSKQKQbUg4+1SNSb09M8KBHr
         zdEA==
X-Gm-Message-State: AOAM533ye3NGUimprNpL7uYdommAP7Mw5qY0ELM7BaanIhm6fFGE8ddn
        WjqqFm8XKaWh6Kzo2mHqZv2HdfRKoZNIcsGv7FM=
X-Google-Smtp-Source: ABdhPJxgHVgaqMFTwojRXU8A/dO1Zx/w+LC3ce9QEYTJ+GDJTqWDp6GG5nIRI2BGbTBYsOPwMBWVRQ1/TvEyehV/Jz8=
X-Received: by 2002:a65:67c6:: with SMTP id b6mr171308pgs.332.1628372106990;
 Sat, 07 Aug 2021 14:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210807202752.1278672-1-noah.pendleton@gmail.com> <xmqqr1f5hszw.fsf@gitster.g>
In-Reply-To: <xmqqr1f5hszw.fsf@gitster.g>
From:   Noah Pendleton <noah.pendleton@gmail.com>
Date:   Sat, 7 Aug 2021 17:34:56 -0400
Message-ID: <CADm0i3-ToKo1gNTXXLHH6i2d4qpz771VeRjDsfJjgbgMfhx6rA@mail.gmail.com>
Subject: Re: [PATCH 0/1] blame: Skip missing ignore-revs file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the quick response!

Very good point about no longer catching misconfiguration. For
detecting provenance of a setting, I think we'd need to tag the config
options with it when they're loaded, possibly in 'struct
config_set_element' or similar. What do you think about instead
emitting a warning message on stderr in the case of misconfiguration,
but still continuing? Eg:

diff --git a/builtin/blame.c b/builtin/blame.c
index e5b45eddf4..6ee8f29313 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -835,7 +835,9 @@ static void build_ignorelist(struct blame_scoreboard *sb,
  for_each_string_list_item(i, ignore_revs_file_list) {
  if (!strcmp(i->string, ""))
  oidset_clear(&sb->ignore_list);
- else if (file_exists(i->string))
+ else if (!file_exists(i->string))
+ warning(_("skipping ignore-revs-file %s"), i->string);
+ else
  oidset_parse_file_carefully(&sb->ignore_list, i->string,
     peel_to_commit_oid, sb);
  }

On Sat, Aug 7, 2021, 16:58 Junio C Hamano <gitster@pobox.com> wrote:
>
> Noah Pendleton <noah.pendleton@gmail.com> writes:
>
> > Setting a global `blame.ignoreRevsFile` can be convenient, since I
> > usually use `.git-blame-ignore-revs` in repos. If the file is missing,
> > though, `git blame` exits with failure. This patch changes it to skip
> > over non-existent ignore-rev files instead of erroring.
>
> That cuts both ways, though.  Failing upon missing configuration
> file is a way to catch misconfiguration that is hard to diagnose.
>
> I wonder if we can easily learn where the configuration variable
> came from in the codepath that diagnoses it as a misconfiguration.
>
> If it came from a per-repo configuration and names a non-existent
> file, it clearly is a misconfiguration that we want to flag as an
> error.  Even if it came from a per-user configuration, if it was
> specified in a conditionally included file, it is likely to be a
> misconfiguration.  If it came from a per-user configuration that
> applies without any condition, it can be a good convenience feature
> to silently (or with a warning) ignore missing file.
