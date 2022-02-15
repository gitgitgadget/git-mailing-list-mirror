Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C91C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbiBOWDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:03:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiBOWDy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:03:54 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2571EEC0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:03:43 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id y15-20020a17090a390f00b001b9fde42fd4so3392589pjb.0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=+FEltCWMEqCIwyAqm6wZOmnhB5i5isbEoUOy4fJil2Y=;
        b=QJsZRZfihTMPLHEow2OixjDxzOUmFiyNFDSRemkeusAMqUVZ9o7rDod6PKsEH0jc3l
         xbRlsQhRMV4IHsVZGvuCCnAlXmbjeZy4nkErU+YaTgIG5c2eDhM2coaxMmkcITuzvcus
         1sm7/6559b0cQ18raiDi8j9/CSEbit7rK31AJsI2T5378xTgTLW7smkOcblAngZGGof5
         3Qo4SqGoWN0NPfH6ykp38b7US3kyLElyRdn/rjKN/JuiBuhCAdDYolJAnmZh5EEx1yIg
         zjBkcBwjn8704WgcVPwsHpnoZtRHVGi7SUhmqdzYSLuyrHFJKs3LbcvnsEM2CxwJiGp5
         o5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=+FEltCWMEqCIwyAqm6wZOmnhB5i5isbEoUOy4fJil2Y=;
        b=EG4VyLlDoJ+1+IIQT1ZtNiyQm8kDq2fyihncdcM4M0CxqHvkBTcZrL57n4a/gpIE4i
         Ty5fGBgE0XOq5QTHPCCzOoUzAv+gqtNtaFeDymj2aTCnNJrjwRBjAz+44U4vg2hy07JS
         CoCh5PgPh0TE9vy/KlDpq4Ue+6oUb0oGUu+DIZmHJcuSgFpXMtu3pnJAtFDlI5ehRpBb
         YV4Cg+m3npWGFHlbaDNLu7vDR4r4fVLsiDdN1krxM/9tAjxfOGfpytgDemCsW7FfcXLd
         NjqviQ1c98tYf9MnXrBlVlC+ZTejdQNlm2HqQYYHqKV7WJKBxIG1AuoRpBbMlkTSHifg
         zv2A==
X-Gm-Message-State: AOAM531CvQMVc/XbubbpPF3/pzwu8E3czkv0+L2eYZR50JwpT66JaFWk
        Zvj26EexijCJ9kXDk5UtAEfLu/hc0BnFeEpCWvLQ
X-Google-Smtp-Source: ABdhPJy81wCeCrFpSZZKb4v/CQXewJbIWeR+MJS2WeFmcYHHplcfQmwPSfY/ZKU2fCGq2XS+MtJTIgm/5afjN4Djw6XG
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:17c3:b0:1b8:cda0:bc08 with
 SMTP id me3-20020a17090b17c300b001b8cda0bc08mr6802665pjb.72.1644962623361;
 Tue, 15 Feb 2022 14:03:43 -0800 (PST)
Date:   Tue, 15 Feb 2022 14:03:41 -0800
In-Reply-To: <20220215172318.73533-9-chooglen@google.com>
Message-Id: <20220215220341.1634185-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: [PATCH v2 8/9] submodule: read shallows when finding changed submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> @@ -901,6 +902,9 @@ static void collect_changed_submodules(struct repository *r,
>  
>  	save_warning = warn_on_object_refname_ambiguity;
>  	warn_on_object_refname_ambiguity = 0;
> +	/* make sure shallows are read */
> +	is_repository_shallow(the_repository);

This is presumably to initialize the data structures that some later
code reads without first calling is_repository_shallow(). Do we know
which part of the later code this is? If yes, it would be better to fix
it there.
