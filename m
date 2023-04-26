Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB85C77B7C
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjDZTkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 15:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjDZTkR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 15:40:17 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B744170E
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 12:40:16 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-63b41df6c5aso5085813b3a.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682538016; x=1685130016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bHuGQP+RwuEzDNCHpSSNk366KBtFJ6TYF6u23RdK/I4=;
        b=A5gQwKVvJj2DwEAMbbSaMiui16VqXbKqxKnsy3fllfubxj9fZ9OYhfgsCXNi103HZl
         JM2H3gT5Ww5zpMvnIgd6f9JzkmnbbmiIVde+ALPoY3LhRPZtTUoECgVFF/xrypKLkoKK
         pNwSTfnbR9NkMxNOujDswudPmDSidTAPmpAMHazewhKzKq2JaKsRYQ3xBbwTMU8fRtNn
         DL1u7lQeXT8aCqCLkfSUwJ7JgZfn2NVwhIVI3DP3DRwdjnl5BZ6rYDp8uA6/MwR9eU9Q
         AOTmFJYhkxKBl1XLal6WLM0mKbt5v6hNwboYPhRZohPu7FpCyOBNfOuEDN/EpEhnz0BK
         9zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682538016; x=1685130016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHuGQP+RwuEzDNCHpSSNk366KBtFJ6TYF6u23RdK/I4=;
        b=A4JExDK47JlFrMPzfDfLyq6hmD0xFGO9URCfOnGDocyLAuz/PNl42fSK6J05wUMXoe
         tYQ+YCpqhxY7ZVtRk3YBwokZxmfItEoyPlkpFU/WF4Jyqk4h+g6YnnRQFW+t2dcHB6F4
         KhT8IR8T7qtIbrbO6xH6Nbg4Scn5QSqvbYcx8gUqmR+xuoxL1XU1uGPCDBeEFsUjZB5K
         bzKVri9R6JRfHLUm8mFUKCM8NdkV12cbMgxMgo8I2zPLT+MH4tdbQ79/LKic02V5uw9C
         gV773pGq17Md4rHv68G6odBSZFuv14wUjb6+tpRhNU6jhtzXP11ohg/YwsVUMsbqrzyP
         ZwdQ==
X-Gm-Message-State: AAQBX9fNHKqbAvEbY+3auXZkHUVk+QlN2Fju6FgU71U57DHcdzzPC5RA
        rtNxiP2loAcMuojl3VsnDMX6JnOFf+q+7A==
X-Google-Smtp-Source: AKy350aVplMCf5pFTUiqkklfdNhrZYugEdHt+vKE55NV4QNw1oe19Cpy4e3M59uaP2lkab65UrK6xWQwIgNR9w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:aa7:8890:0:b0:625:5949:6dc0 with SMTP id
 z16-20020aa78890000000b0062559496dc0mr8937179pfe.4.1682538015847; Wed, 26 Apr
 2023 12:40:15 -0700 (PDT)
Date:   Wed, 26 Apr 2023 12:40:13 -0700
In-Reply-To: <3b2cad066a3b3446fc335d6944a62bf79b0779bb.1681906949.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <3b2cad066a3b3446fc335d6944a62bf79b0779bb.1681906949.git.ps@pks.im>
Message-ID: <kl6l1qk6o2jm.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 7/8] fetch: introduce new `--output-format` option
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> @@ -2101,6 +2116,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
>  		OPT_BOOL(0, "dry-run", &dry_run,
>  			 N_("dry run")),
> +		OPT_CALLBACK(0, "output-format", &display_format, N_("format"), N_("output format"),
> +			     opt_parse_output_format),
>  		OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
>  			 N_("write fetched references to the FETCH_HEAD file")),
>  		OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),

This change is good enough for fetching from a single remote, but if we
want to support "--all", we'd also need to propagate the CLI flag to the
child "fetch" processes. (The config option wouldn't have this bug
because the child processes would parse config and get the correct
value.)
