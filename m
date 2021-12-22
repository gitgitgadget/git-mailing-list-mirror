Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0168C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 07:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbhLVH62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 02:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhLVH61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 02:58:27 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EABC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 23:58:27 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id g2so1425427pgo.9
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 23:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNZpJWgkHzCKV7yM6s6Oa41RvrewlNPLsPsb6Zs53ww=;
        b=Kc9WlkJvUdMpQld3plY1LlH65BrrOXbfxTZI/GdItOYPN5SLrT1YcfWE+zmpapnEXr
         UrOzU+VDCaMtP62OegFJAnYZ/4b3a7ElXEHMiJoRcyjQGB23SHDL6qX7q68TfsL2kboP
         54NsQX+OMbGkdzyJpgCdV+wvqBfkNx2rBGgO8uRyBWHKHLinAemdcga3LxYtPmWvxDnJ
         /A1K+UZmFW2POfoOiSI7rLUbIBBLHmDzTkLTeNmA87MXVg+n44TzPE9oa1jIndEffQds
         v0KmRhTZWwR2nTtXiLQW2jmgXbUzSfw0ZfyrrO7yV6ia/rfv4W8xEncab6fwXhEY/lNg
         Rc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DNZpJWgkHzCKV7yM6s6Oa41RvrewlNPLsPsb6Zs53ww=;
        b=Jvvct/u4WaNq5g+9lKkZnPioWWa6t9bCIbgg1Umo8rrc3QGrM5oGzBNtPxw5NVbpjs
         54MyORWQEyYx53Uvn+wO35wbG3nlwkjOAbhebkIlv1lY7KL2uc5i0XmMVKTw0fdVUHVF
         hyH2b4EiGB4x1r4ysDERXMdECee4uzLYbTbE/BSwVSb6Eh9eadnnxJDG7Aqq92+9GAar
         unjjJnt1NYxXwQ6lAfPUPttG6zETaWrefOPLMycefJ304UEGiVlZLqB2GODsUpzL/aLi
         iSx71igi1yxoKpUD9nB91EFrUe9QWUrw3tu0s6X5RBVmexXDMwvm+BwMbN2OpgGY5s6N
         XJ3w==
X-Gm-Message-State: AOAM532RsFc799PxMXX6jMreDpECX3C3EaTvcQS+URE9zeXnGYQsnC03
        HspZYwEa3O3T8DXtnl9y2q6RsXoTspk=
X-Google-Smtp-Source: ABdhPJwDi0rW7BsVhheX4f76JyZmXf32ASE8tszpqZxnRBibqQhapN4ObArRVUoQ7oGDMlCxGrjvUQ==
X-Received: by 2002:a65:460e:: with SMTP id v14mr1826407pgq.70.1640159906866;
        Tue, 21 Dec 2021 23:58:26 -0800 (PST)
Received: from ubuntu.mate (subs03-180-214-233-76.three.co.id. [180.214.233.76])
        by smtp.gmail.com with ESMTPSA id s25sm1464420pfg.208.2021.12.21.23.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 23:58:26 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v4] fetch-pack: parameterize message containing 'ready' keyword
Date:   Wed, 22 Dec 2021 14:58:06 +0700
Message-Id: <20211222075805.19027-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The protocol keyword 'ready' isn't meant for translation. Pass it as
parameter instead of spell it in die() message (and potentially confuse
translators).

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v3 [1]:
   - Comment style fix (suggested by Junio)

 [1]: https://lore.kernel.org/git/xmqqwnl0gkks.fsf@gitster.g/T/#u

 fetch-pack.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 34987a2c30..51385cb3c9 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1415,9 +1415,17 @@ static int process_ack(struct fetch_negotiator *negotiator,
 	 * otherwise.
 	 */
 	if (*received_ready && reader->status != PACKET_READ_DELIM)
-		die(_("expected packfile to be sent after 'ready'"));
+		/*
+		 * TRANSLATORS: The parameter will be 'ready', a protocol
+		 * keyword.
+		 */
+		die(_("expected packfile to be sent after '%s'"), "ready");
 	if (!*received_ready && reader->status != PACKET_READ_FLUSH)
-		die(_("expected no other sections to be sent after no 'ready'"));
+		/*
+		 * TRANSLATORS: The parameter will be 'ready', a protocol
+		 * keyword.
+		 */
+		die(_("expected no other sections to be sent after '%s'"), "ready");
 
 	return 0;
 }

base-commit: 69a9c10c95e28df457e33b3c7400b16caf2e2962
-- 
An old man doll... just what I always wanted! - Clara

