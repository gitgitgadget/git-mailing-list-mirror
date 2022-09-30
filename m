Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9B8C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 21:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiI3VuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbiI3VuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 17:50:09 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247A037F99
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 14:50:04 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r126-20020a632b84000000b004393806c06eso3516949pgr.4
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 14:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a3gsMTzBPwLbvG9qhU06yAnAf3mNr1bnRDFKzIAXR5M=;
        b=FFybL3jSXiLIjf1yAZec5qpsCWeGOkJMwyJo3f9CPRkmnhjax8FQ9aSMmAzJuIF7ti
         VGV+aWC1H6jcRh7qrC7hnuIsddCJmqpGtaUqmcKHX9BNa54O3FCFXw2tAVj001g2SKdH
         EltwRVCR+EWC19DYeucjGwOupJl6YvmOi/UzcTdv7m5o6rrS15IwPiKDZJWd6MDeN5Tt
         1E5NWNDct8yWUUcvOxYYW3UQTOh/Bb1unU9XYCqUpokTUeqx2IJjW5z4KYJd+M9f7AEL
         lX/qJLD5QiUdeaES2QHRkdj9Bna79SlnCzKN+PgNDFbZTql4kTIsyh7NID90iAlSEjye
         Mv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3gsMTzBPwLbvG9qhU06yAnAf3mNr1bnRDFKzIAXR5M=;
        b=vaoCnCkm7LTWd31S8EOq9pYGS6XahGnQFCl/tWDyHgQxH68u/dZPezzGi7yAJ4PdPH
         W0/N+mGTGh/Gn7Ujlu4U/M/CRow8AkNV1XFoAhZb5F90AvT7gFtCTFuqdv5CH9ewvv7n
         RxIJWDTlrLpfRVgAlOC4A1VcoOqf491+UVH1RpPhk7LOPmdWiq9m1uVPmrgehvWOzhCO
         ERUYNEsgUw69NjRsfMozp2+FYF1HbyZJswwXiA9ANSjqda83K2AUN1oGHqIDeu2IEsIM
         mwhg1gbEJ8KFsLXB7XbI4omCqeCKA5wPEiY7YYx/E5pZ/mcFrBzqUN/ByGD4T+AMnbKu
         hWYQ==
X-Gm-Message-State: ACrzQf0OrVaTP3SdXbw3kQ39yLutdrAIVpwN/oFNM3tW+axVzKLAEoqb
        m5M2HHVLI1lkd4kvUw6JcprQvllg5nrB8/rb1WMY
X-Google-Smtp-Source: AMsMyM4L7RhV8MFd0WmTMwl/IYVCsb7dbuc3SNknOpcR2xUiNTwwCfdOo6Tg2IfBWiuGfzuNSB8g5ichrcC9FyGL2TfO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8215:b0:178:6946:a282 with
 SMTP id x21-20020a170902821500b001786946a282mr10985967pln.162.1664574603693;
 Fri, 30 Sep 2022 14:50:03 -0700 (PDT)
Date:   Fri, 30 Sep 2022 14:50:00 -0700
In-Reply-To: <xmqqczbendil.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20220930215000.2079107-1-jonathantanmy@google.com>
Subject: Re: [PATCH 0/2] Fail early when partial clone prefetch fails
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> No changes to t/ directory?

Hmm...any test you would like to see in particular? Here, we just fail
with a specific error message when any sort of fetching from the
promisor remote due to a lookup of a missing object.
