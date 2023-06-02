Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BCBC7EE23
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 00:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjFBAGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 20:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjFBAGU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 20:06:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66250133
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 17:06:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-568bc5db50dso62081507b3.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 17:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685664377; x=1688256377;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DnxuA25sIVr+Z6gig3ANj59B9sUjUeaGueeFhjNqO1w=;
        b=ixaUshYmTSnSIBg62hR7n1V0J986qwAXVotljBfVxbavZy8tIJzztwMDAOBADyNW2z
         h61dP2znVBalXDKud/2hZRvHHpJ86loD+Xzx2GBwfLqpfWNPb1V+rYFfjqst3sqadMkM
         rKl5qIOOL10uAiOqbvLLO0xh1Nuc9lDbfk58kSx7H9zRXTmpY1uA6PBLUzOp7ejdH4HO
         DWZRyRNpSfx3iXKhE912v31WW7YbotJIaiL9c4hGBXIDG5xXqn9GOfcD/UPsdKkzZece
         IEFBZYSx540jpLYRSzBaBpUiRbkFHoKXyMv1Oc5BQSz1nx0pyvAXz7YXI1ZKq++065lg
         Yfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685664377; x=1688256377;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnxuA25sIVr+Z6gig3ANj59B9sUjUeaGueeFhjNqO1w=;
        b=CcgrYNAcRullrWa6yanqkvYl9GUmMnOAfsGkINwmTMVTGKi+OATG0fy01oIiLwiZvY
         XHam2fTKe1xDLIbvWtYUFdX9u/S24X/pwx2T5evGDhiPBmi69bFnFnjG8m/gmSfDI+oH
         YVW/+WbL4OzvBpDMzTszNvLiwAi8jn+0V68vycuuwN5mExCBv2pxKagkW0oOejGfgREM
         iBQ/iyJFWGgbIUIOnuNYruA3ymEecteCxWIoMkUEH++yqjomtte7V69Kiv8qk30NpCt/
         whiTJd1NiN91CtaKgP80VGBWSFUzPb/qMqDrrbQjYl/oQcVxubkqmxBtZRjDCRH4GT40
         9vww==
X-Gm-Message-State: AC+VfDx7pdelYtOlohlEX8rAlKYqZvkwi+OfJQ+OKdL9Wlldy2rg8rRT
        ea11XZb8ZAUmNsuxXp0pWt8vFDaTPtPDLkJmV7KK
X-Google-Smtp-Source: ACHHUZ6ZaZcs+tlzPPmIIAzzkXa2Hnh4LN6XyKghqDv0yx7SvKQYSL6QeLiz/y8s23zWIFV5Xi03yz1VhEryFzvVBbPQ
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:9bd:7d22:5bbe:5b1c])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:3006:b0:565:8b2e:b324 with
 SMTP id ey6-20020a05690c300600b005658b2eb324mr2477492ywb.3.1685664377723;
 Thu, 01 Jun 2023 17:06:17 -0700 (PDT)
Date:   Thu,  1 Jun 2023 17:06:15 -0700
In-Reply-To: <7d9b9eefc7860959dbb6ed86d8c3d165a978a0b5.1685472134.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602000615.434180-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 13/14] config: add kvi.path, use it to evaluate includes
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Glen Choo <chooglen@google.com>
> 
> Include directives are evaluated using the path of the config file. To
> reduce the dependence on "config_reader.source", add a new
> "key_value_info.path" member and use that instead of
> "config_source.path".

Maybe add:

  This allows us to remove a "struct config_reader *" field from "struct
  config_include_data", which will subsequently allow us to remove "struct
  config_reader" entirely.
   
The code change looks good.
