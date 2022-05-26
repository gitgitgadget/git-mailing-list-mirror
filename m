Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9477C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 14:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243924AbiEZOuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 10:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbiEZOul (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 10:50:41 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41CC5DD1B
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:40 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j6so1851368pfe.13
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2aaJzHcmlhNRZeWbNf+3yAibcMiyJl+cx3tG1hawCWo=;
        b=DdZR5iVofHQFvgQFjlvrJ3AFfKm03/LZPAVFQ5qzoF7L6lE6jlJY2KmQNAKaRVRE9r
         RP0AcN+gLgK55FLTl+vJRVDF8AauvOvnl72YNFZIv35RbAMr4HbdlTaV7jNED4Fqzmw/
         48DoxHEGvhRt7GF5yOpAt8NFKujRQFj8f6UY8i9ap2dj7zGvs2FiTMpvuRR1rr/Sllpi
         tPaSPP7C8cZZMQ7RQoREWL9VBnQZPMwxG4k16jp6msawIt5jdH1EOQDzAJ52Am0o9UPG
         jgAPrIkT4ndPWD2V0LM+jcEFJnrS9JOaDWNRXhcMpGB0AvirP8ce/Iz1xaVaYWc6K+nL
         /pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2aaJzHcmlhNRZeWbNf+3yAibcMiyJl+cx3tG1hawCWo=;
        b=JcNPK2F5rf5ouTPy8Hk0jbXKGd+Eyouxvbv9YzrSDGHCwQP9yQOkn25KEOMVbkAJLv
         8aF6iIfIzFtJ+C1NaQ+2Ih9G5F5aMV7rR5jbRaNy7u7S+rThUSs5WXjtjzmyiuqKZXSC
         Gc5I5SDGrAMAAgZ80ipmMmoYncnglv9T59E4oi05rqE9DfFw5CZA7Ex35UQIoR2Z37cI
         nCECRumjLVSSfJhqb41uFzEYTpcnW4ap9z2kwGMWnMsY/kONySHhVhx3iGRBu3KfpwT8
         ZG9JPDJk390dOv6tPKQQ2hf7nVCc4ypeEGiokX4KeM9vrY69SIuHNVjHwzWvDtuVTgHZ
         rvQw==
X-Gm-Message-State: AOAM533mlW/VWdDhhSwqApV2i4NjGk7yAi7a31mvQt8tVQCY6Tek2r8n
        9xgfUAGrWTiI23g6pJJOTtk=
X-Google-Smtp-Source: ABdhPJycyxMq10CKN5oeo5mP4iCaO9Q2QnI6SeJC+VCNwNALOGzHnW9Wljvb3974a2V3l7i+60X07w==
X-Received: by 2002:a63:2365:0:b0:3db:8691:4fb9 with SMTP id u37-20020a632365000000b003db86914fb9mr32799898pgm.261.1653576640200;
        Thu, 26 May 2022 07:50:40 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i16-20020a056a00005000b00518382bceaesm1597480pfk.57.2022.05.26.07.50.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2022 07:50:39 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 01/10] Makefile: sort source files before feeding to xgettext
Date:   Thu, 26 May 2022 22:50:26 +0800
Message-Id: <20220526145035.18958-2-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523152128.26380-1-worldhello.net@gmail.com>
References: <20220523152128.26380-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

We will feed xgettext with more C source files and in different order
in subsequent commit. To generate a stable "po/git.pot" regardless of
the number and order of input source files, we sort the c, perl, and
shell source files in groups before feeding them to xgettext.

Ævar suggested that we should not pass the option "--sort-by-file" to
xgettext to sort the translatable strings, as it will mix the three
groups of source files (c, perl and shell) in the file "po/git.pot",
and change the order of translatable strings in the same line of a file.

With this update, the newly generated "po/git.pot" will have the same
entries while in a different order.

With the help of a custom diff driver as shown below,

    git config --global diff.gettext-fmt.textconv \
        "msgcat --no-location --sort-by-file"

and appending a new entry "*.pot diff=gettext-fmt" to git attributes,
we can see that there are no substantial changes in "po/git.pot".

We won't checkin the newly generated "po/git.pot", because we will
remove it from tree in a later commit.

Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index f8bccfab5e..7ca95cdb82 100644
--- a/Makefile
+++ b/Makefile
@@ -2713,10 +2713,9 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
-LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
-LOCALIZED_SH = $(SCRIPT_SH)
-LOCALIZED_SH += git-sh-setup.sh
-LOCALIZED_PERL = $(SCRIPT_PERL)
+LOCALIZED_C = $(sort $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H))
+LOCALIZED_SH = $(sort $(SCRIPT_SH) git-sh-setup.sh)
+LOCALIZED_PERL = $(sort $(SCRIPT_PERL))
 
 ifdef XGETTEXT_INCLUDE_TESTS
 LOCALIZED_C += t/t0200/test.c
-- 
2.36.0.1.g15c4090757

