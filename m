Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02808C77B75
	for <git@archiver.kernel.org>; Sun,  7 May 2023 06:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjEGGnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 02:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEGGnl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 02:43:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9418B1702
        for <git@vger.kernel.org>; Sat,  6 May 2023 23:43:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643aad3bc41so2142158b3a.0
        for <git@vger.kernel.org>; Sat, 06 May 2023 23:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683441820; x=1686033820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeG66GJmql8/AMjzChMixfY8cC6k9D02ILf2X7rH0pk=;
        b=cvFPHTMvxDp/XUk9FOTprgTJE+QZA+wcu+Ls9NljGbJcsUhuinK9L2VOs+8AaPnh4l
         F1LMvBhErtae6cjBb78GX2s3n2BBTtyTQQGLaShHqQF5M3hkqCfPnUoR99eJT7WbppOg
         LfADD/Fix9E/DAbLAEolug1AiG2/pbYn1sWeNhq3Wpt7awCQgv7z8C4Q3LyUDGYVPzuo
         kUHA1/mgXTxZvA9arQ6jqV+1kT+xYssPMLSZGvrenVX8xN6Ohwxv622x+GdJJYPLZvgS
         o5z3bWdBDVu55G4fwxxn+qJ/M3EA6B/jhrfdZvURDQlY22BaduMJkrPlyxsQAgAJO/OP
         b9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683441820; x=1686033820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeG66GJmql8/AMjzChMixfY8cC6k9D02ILf2X7rH0pk=;
        b=WkJ0r0+lD70FhSKmhBOGZ7jFw41W4fbp5MlEx8k+8JHOx/woIetKafc3D8QTIr24J7
         CB3K9nJWGThj6RGqEL80//zYNxI0M0J9/fjE31A+BnbwanUXuSUHfSAcXzmMzybY15A7
         qql+VG5zNqSWf2ioR45uex0taBDFbgnbxn0in7ciqOk34XzzGxwgIW2M5GqrM25oiPwm
         /mLosNhHOzTQRWbGNAQw2huUoVoTI98PIEFBxD0NB2u3NFkrHJnuGrMeoAIJU78sXc8c
         25UUM+qmmBfanyii1SPt8aljCNhm+HVkQ5KOcy/GYxMwjGg40zALiLIZlRDuSftGOZtx
         WKBw==
X-Gm-Message-State: AC+VfDzt2tiW2DqOZQTtnAuGWdj2CGzPjkAieAw9RbKrveLGsxboYKlW
        PwHQqg/FxpaXvK8HZE905W4=
X-Google-Smtp-Source: ACHHUZ4jFC3djVPkdD4HIDBlOGGcZ0KUhj9A8dS5UDK+9aa3OTtTdKIe3DmeAbDH697pzbcqu81pNA==
X-Received: by 2002:a05:6a00:849:b0:643:980:65b with SMTP id q9-20020a056a00084900b006430980065bmr8691595pfk.2.1683441819956;
        Sat, 06 May 2023 23:43:39 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.57])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78281000000b0063f9de332f8sm3970777pfm.167.2023.05.06.23.43.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2023 23:43:39 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     adlternative@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        git@vger.kernel.org, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 1/1] push: introduce '--branches' option
Date:   Sun,  7 May 2023 14:43:29 +0800
Message-ID: <20230507064329.2158-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.335.g9857273b
In-Reply-To: <xmqqedntrvg5.fsf@gitster.g>
References: <xmqqedntrvg5.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>By the way, you may want to check and correct your patch sending
>procedure.  Somebody in your toolchain is adding "--cc=" to the
>first recipient address or something silly like that.

My fault, thank you for mentioning that.

Thanks.
