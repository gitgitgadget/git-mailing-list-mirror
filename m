Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC550C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 16:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjDYQ0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbjDYQ0v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 12:26:51 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C1B2685
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 09:26:51 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-74dd7f52f18so1692217385a.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682440010; x=1685032010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YI9Z4pzZRkLFu/prKwx1UDCqvmXBO0e2PZ8BnmfPVc=;
        b=o6Hk54eX6evpz2oZdv4nmKjWfLDI+qvBmhjazokF1jtOBAhhdk1rj9EfArEvsiWoAv
         nbJRXm5dYp+zYUwR1DSQ0pr+NekoxhAAKy948toxmR+81H0oJCyz+N26BbubrxNE1mFw
         qD+GHxpjFQW9R1UWZZ5Y5o/3pq99NYioyNxaobtSGGlaZ9j/zDyYYDzkQFhY8ltxZOX6
         PQQAMUU2TAW6Ixkc5uLWpr6Io7DZm0YVuyOgnOjwf2Lkr/6OXUnb9tp6LFlJ1mENFIpd
         rtswaOX6MmvdqUUDCyh7SQKUOYeWHpI3bGBeNFQdBqeoUf0ZVw0aPjFlAoOi2abrUeZy
         Bi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682440010; x=1685032010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YI9Z4pzZRkLFu/prKwx1UDCqvmXBO0e2PZ8BnmfPVc=;
        b=O35OXuWo8HYX3TG7c6GLI7cllVjJsCxmwz28JaUadydx3StsPV6E03wo1L536wMsxH
         4/dQjdk0Lw9lum3jXQLJFCbUX2BJVUflbugLOE+ItKLJQNWBhFiZ/XFaKKp/IP2QtZOR
         jtSmaEg9L5rJLRIUoq2u19sSTaKz4fhCP9l+EachAbRizKLnL5U1RjCXbM60Bx5V0lk4
         Gu7IuHtV7fTK0cZq+PwxbSxbTETjQfQsIMVzGG3obQD5gKmUmdOToW8fv6s9t9f1zs3d
         eBuralOE86CA8t49Uv/V2P52wfeVdAqEJ4x05gutj7ifWCd5eEBn2UWVvMyyZPdm57YF
         P2PA==
X-Gm-Message-State: AAQBX9dt+W5gBvrjqhJDw8kgamFHqgxcSbwQKT7Xd1Kl9v4hAOFFhdO+
        SU9+hENqg9pCzySC7vlZb7xbAqHWSM4=
X-Google-Smtp-Source: AKy350bzAVPKuFW7gHFqBzXLyNKtn+i4A+w2Tck1g29tYDs1+eb4Tio0J7MHz+uxxFwX/iSMJmoYrg==
X-Received: by 2002:a05:622a:214:b0:3ef:6e44:48f7 with SMTP id b20-20020a05622a021400b003ef6e4448f7mr17969623qtx.12.1682440009896;
        Tue, 25 Apr 2023 09:26:49 -0700 (PDT)
Received: from localhost.localdomain ([2607:fad8:4:3::1003])
        by smtp.gmail.com with ESMTPSA id m13-20020ac807cd000000b003ef311b39d7sm4535544qth.96.2023.04.25.09.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:26:49 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Maxim Cournoyer <maxim.cournoyer@gmail.com>
Subject: [PATCH v2 0/2] send-email: add --header-cmd option
Date:   Tue, 25 Apr 2023 12:26:29 -0400
Message-Id: <20230425162631.13684-1-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <xmqqh6t57x0y.fsf@gitster.g>
References: <xmqqh6t57x0y.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This v2 addresses most of the review comments from Junio (thanks!).
It clarifies the documentation text and postprocesses the headers,
adding support for multiline headers.

Thanks,

Maxim Cournoyer (2):
  send-email: extract execute_cmd from recipients_cmd
  send-email: add --header-cmd option

 Documentation/config/sendemail.txt |  1 +
 Documentation/git-send-email.txt   |  8 ++++
 git-send-email.perl                | 74 +++++++++++++++++++++++-------
 t/t9001-send-email.sh              | 21 ++++++++-
 4 files changed, 85 insertions(+), 19 deletions(-)

Diff-intervalle contre v1 :
1:  216b40c1b8 = 1:  216b40c1b8 send-email: extract execute_cmd from recipients_cmd
2:  332d8ac4fe = 2:  332d8ac4fe send-email: add --header-cmd option

base-commit: 7580f92ffa970b9484ac214f7b53cec5e26ca4bc
-- 
2.39.2

