Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04891209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 15:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbdFFPNB (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 11:13:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36855 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdFFPNA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 11:13:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id k15so35391843wmh.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXdl6/vbIzrvuDVDlRYV9JOtZUC2TY70rSRAWuDhK84=;
        b=os5hm3/pLDtBukDySc26DrlrDXEJnW/aYlm42drMWJeaVrL08r0EAe+B5/a0QSBY5e
         y2CBmFdNrC8skzVVBLCC973VJu1vxRhTQ7KEuALiOhd3I0FGiKFbfnwflrEuhhHICNxq
         34KfmVad9/BR5F7iYnRDxgRtUGJpNFxS2ltv4g301xiSxHQwrFQrfN1ZT9DxzSoGQ/BD
         L2+qusEA6IqXABVtnfkV3duhunRpD+fkQn4yWicY82peE4fDRntHoH3s5yy0Uj6YXTEn
         3j/RN+fN4IpTIcEvssIylHenkZypIVuLlbo6fil4JkGDUi+OKsgFu6hwFyPPrVJE/wha
         o4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QXdl6/vbIzrvuDVDlRYV9JOtZUC2TY70rSRAWuDhK84=;
        b=WHF5OC+LnvhKHmjxprGV9i9iXa+vUfsXxbfV3F5WJg4vQ854lALC7qWzyYjEgdrXCV
         u1oVo/GT1vyb1S3cmPQc44Ms//uNuSYPYNZXXjXpECj8TRIGw9mbLvM4V4Nl7nWM3o5b
         5OMmSLZbeEpllFUN+poK/x65Jf4MeJ/R8aV9x3n4oQ7UgE0ZuDS6Tw50/a5afJ/0OZS4
         M+JE+Vg1M4tzj6q5DK8oUt0PTFBCVRbeB31LC9E1jCdCKEbJ3RKQA9XATDjlg3WemO/z
         AEfbsX40PW+LI1fWKy89aklnOyBQ0nn4wJFErZvH6R5z8y57K0muYauPBDksY80d0pUS
         Jc9A==
X-Gm-Message-State: AODbwcDxubkTQbK0M8rvysf4sDC7oN7y/VY5XqtOnU/OllEYZ0LZx6Xi
        aJ8Egv+urNjZwfBF7D0=
X-Received: by 10.80.144.132 with SMTP id c4mr20056390eda.139.1496761973887;
        Tue, 06 Jun 2017 08:12:53 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id d37sm2250632edb.54.2017.06.06.08.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2017 08:12:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Michael Kebe <michael.kebe@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] sha1collisiondetection: automatically enable when submodule is populated
Date:   Tue,  6 Jun 2017 15:12:31 +0000
Message-Id: <20170606151231.25172-4-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.506.g27d5fe0cd
In-Reply-To: <20170606151231.25172-1-avarab@gmail.com>
References: <20170606124323.GD25777@dinwoodie.org>
 <20170606151231.25172-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

If a user wants to experiment with the version of collision
detecting sha1 from the submodule, the user needed to not just
populate the submodule but also needed to turn the knob.

A Makefile trick is easy enough to do so, so let's do this.  When
somebody with a copy of the submodule populated wants not to use it,
that can be done by overriding it in config.mak or from the command
line.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index adeff26d57..eeccbff1cd 100644
--- a/Makefile
+++ b/Makefile
@@ -993,6 +993,10 @@ EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
 
+ifeq ($(wildcard sha1collisiondetection/lib/sha1.h),sha1collisiondetection/lib/sha1.h)
+DC_SHA1_SUBMODULE = auto
+endif
+
 include config.mak.uname
 -include config.mak.autogen
 -include config.mak
-- 
2.13.0.506.g27d5fe0cd

