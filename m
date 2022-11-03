Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7065AC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 08:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiKCImM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiKCImL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 04:42:11 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F49BF68
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 01:42:10 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 128so1096238pga.1
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 01:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st4qIb4/ZVkV89mwNK7TL/QDdQWtczWDkVrTIaOHPd4=;
        b=F3KAbmJQAIO0adlda7nEukVldAHF++12bRt3p4F8EZHqfmo3pF4udYlI23CKF17ybJ
         SikneGpoEI51M7BrNibMj81H7EuEm9G4vBErvTlClzoswJBfFYwd5zZnAhw4Yy9QJjOw
         XLeHc1PNnkTke/WDY0uYwy976rv6Ln6ckfzXzeTORf8gRyQg5brT3rKATvJu59g9gjKZ
         11Ux8TU6ff8gdQRwdInU7galqcvWt4jfUUowRLwB3xLhZvn94AdTB/By+TshJVD+jewh
         vkZ3DJmU+j8WDXfezM5fQTr7q8gRfw3hvXftI7KXockBu+bqo0s9J0yad04/IP6rrt5w
         oSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st4qIb4/ZVkV89mwNK7TL/QDdQWtczWDkVrTIaOHPd4=;
        b=ye5l5fLBm27LH/siFQNAaSuVIzOGUF4bxZR70qxGdnXqifR119Wr/oto9nR8KCxC0G
         9Ai7lMCrCA3AiM1P0G20VdXBz4yK5CWQVnbULfcwZLfOsCWiwKrRjfQT0cZFWYorPuTR
         DCF6Fa3HbBgLiDRsOuQsrvyfP2U2XrODz8AOliBjw/4U9gEDSJnUduQKnkpDY5lCMqSZ
         I61lvCs5rxeHoCY4lnlrOtt/Ml5qWGYLhcaE/YZwb3IASSjjbdvOYlC4+i1WOA7owXz8
         aToWbUR9YIwELi6cU8SYRyd8wTh8EF876I7NYw/sarcv8r8GxhCU2BZfy/uxZuGpMbwv
         e/3w==
X-Gm-Message-State: ACrzQf2cgLNMN0GB6MD9HLqPiqfrhzk+dCG/eQIVeEqbJEWxfcWpRTGS
        jooFqL8EV2UOYXQsHYECDPk=
X-Google-Smtp-Source: AMsMyM4itmW0iHnkM4FI2JkDNavt1HxNeggV547ks7xQiy8sKuu833JyS3UlXokn+YfPt1gKHfNZKQ==
X-Received: by 2002:a63:ff55:0:b0:438:fa5d:af36 with SMTP id s21-20020a63ff55000000b00438fa5daf36mr25205935pgk.533.1667464930224;
        Thu, 03 Nov 2022 01:42:10 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.50])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709026b4900b001868981a18esm74248plt.6.2022.11.03.01.42.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Nov 2022 01:42:09 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 0/1] pack-bitmap.c: avoid exposing absolute paths
Date:   Thu,  3 Nov 2022 16:42:02 +0800
Message-Id: <20221103084202.36131-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.383.g374bfe65850
In-Reply-To: <Y2MXgVZx6rqGkMzM@nand.local>
References: <Y2MXgVZx6rqGkMzM@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This is based on a somewhat out-of-date version of the pack-bitmap.c
> code which has changed quite a bit since Abhradeep Chakraborty worked on
> it over the summer.
>
> Resolving the merge conflicts during am wasn't too hard, and my rerere
> cache should save me from having to do it again. But if you don't mind
> rebasing on the tip of 'master' before sending the next round, that
> would be appreciated.

Sorry for that, I will do rebase on 'master' before sending v3.

Thanks.
