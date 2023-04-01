Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C49C761A6
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 01:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjDAB7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 21:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjDAB6s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 21:58:48 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08772624C
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 18:57:25 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-17ab3a48158so25078900fac.1
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 18:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680314196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGzE/kbtDFlaaBO/DmBGOYj6Ldr8ZfoBY9rJNB5mfbs=;
        b=Fs6kwoOeL1BVG+mPrbph/OU0ldy2HGMSzPTKsC4lPrSaoIAXanQCmNckyJy7NMVr21
         +1ZoJRz9n2Ppx+nUkOlW/kt2JC6aP0MoPdUu/ILf1Q3nJpiuMMWcpzPtlhf/laLuJfWc
         2ijSqidVMyluJVh4F6ZzxaGYEozIjwdhqMXHkZHVR3HpgjQrklyoHLJJHXf0JX7we/Oa
         jbkNivtmRceI+biBdwoHZqRYmJTiNQmbqikf/1F13XWLsHlqaO4TYmw//6xSNsD/Rp9b
         o6yQrQwKhAMMyplBk8VRPOCWS3reDlJaoRUm6wDeBGGaeH1BpaY74Gu0s/L4+KIdWk46
         CKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680314196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGzE/kbtDFlaaBO/DmBGOYj6Ldr8ZfoBY9rJNB5mfbs=;
        b=uCPieknZK+Nk1T7I1q51+qUyipMujMBiNe44IWrFldr/Z1hume6wnZ8qdqcmuC2GaQ
         XNZp2v4PY3BjD9GNAsQB2gO7gLyOD31eUUM56J3cJgDFMNNVx2qlQtfP0vksSW28NHOD
         nDluI5r0E1ZFkLCdWmTKDm/b39RDmAFBmTYGT0nqAl70SWp4oIiJds3SFmnpPgtn1LRG
         voL1L8qz1Fdo0/WubECuonWUPqXEkYnutto6FSjHMm8DfZjxlR0WBIf4jA3/DNakFJQ+
         Gj8neKB1T0IvJSRkURsZghJGD4StTzTTjyL1gOWqKBTNLl/ppnEEF1OsrGRuooDkjq1V
         OqCQ==
X-Gm-Message-State: AO0yUKX7mAGSdqjAs1gJqrr0nbMUlHHR7IN1oLY3wpBotfxPcqhsCss5
        nDT5/s7nYF6ODs4vOFUn6Z2MaJcg2Vc=
X-Google-Smtp-Source: AK7set/VFZneOLlOb8kOvTh6jY++Wvi7L9mG2VPn3cSjQUTd9XrS/OCocaEdccXBqlSE/BwOmVntVw==
X-Received: by 2002:a05:6871:442:b0:17a:ccda:5c04 with SMTP id e2-20020a056871044200b0017accda5c04mr18424802oag.14.1680314196356;
        Fri, 31 Mar 2023 18:56:36 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id az2-20020a05687c230200b0017af6149e61sm1520039oac.21.2023.03.31.18.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 18:56:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] test: fix build for zsh
Date:   Fri, 31 Mar 2023 19:56:31 -0600
Message-Id: <20230401015632.103581-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230401015632.103581-1-felipe.contreras@gmail.com>
References: <20230401015632.103581-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

zsh has the ability to emulate Bourne shell, which is closer to what our
testing suite expect.

Using the POSIX_ARGZERO option makes $0 behave as POSIX seems to define:
show the name of the command launched, as opposed to the zsh default:
the path of the script.

This enables many tests, but not all.

We can run the tests with `zsh --emulate sh` which has more more
compatibility, but doing `emulate sh` inside the script allows us to
just use `zsh`, although it's not as compatible.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/test-lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 62136caee5..d5a9168484 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -15,6 +15,11 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see http://www.gnu.org/licenses/ .
 
+if test -n "${ZSH_VERSION-}"
+then
+	emulate sh -o POSIX_ARGZERO
+fi
+
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 if test -z "$TEST_DIRECTORY"
-- 
2.40.0

