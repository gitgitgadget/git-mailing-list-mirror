Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493E2C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDAItF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjDAIr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:47:56 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0973A2031D
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:16 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id x8-20020a9d3788000000b0069f922cd5ceso13144388otb.12
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNtSxVFKcFSDbmdmdXhd5KktbMiysATgKQlv/7eNp+k=;
        b=OXyIVinKPgbVxh74RMTfvCmYl3XbYXzWOc283P6iQ6dTgHPJZEinOggX9DzUVUqkDo
         kvHMEI3M26WfJzL84FY7k27RwUZALV5hMKp0RlTFWAZvZZFb9ed8HkI0f8ljMDD6mYg+
         8ezpKOB/p4PQEGoEw/i8U+mB75+wMBEeLoXl3bS65FbDLTLhkTrANyzzDy6T9dfVi2mj
         X5RwAK94wvf8MEpXhnzmPIC5MY35ylLzf/HXpsVOsJd6Mn33f5bSzAOyHuL5wqIge3NU
         XAxYPrj5wBWL5PjrzmckS3IujXtKE6ap9afRM/VBcUTk4W38kQrwG5TqSgZM+F7pYLn0
         L/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNtSxVFKcFSDbmdmdXhd5KktbMiysATgKQlv/7eNp+k=;
        b=O4pL5GGcbn7FAW4NytpsxOv/TM28bDchRmyMvvxRaSSyhx8/h4AcoXdLqY3QcWwzVK
         1FnnzZ2SZrKWNEbvgrdjEMVu+z1kFfL36njla48wtJCRUQ4i3Cm2vaNDa//y0jC+z4Mm
         3zLKMeleiUnZ/DCwYpNixTtD/Dodu36guqNt/4UHE42LavJZAP7aqEcYNVnYaiwmUBxO
         WNDgb2rmOhA+p2oZo9L9S79wDi6NrfsBUfHh5fAV+We+JlXeOT3XHR1D8ZVm58NvCTTo
         utIxuWpNgnZ4gSlxD4YVChLLY+NxHZAAKXmhnrX62ljUJHaMsXNKLLQFGBqXBzaM+wd/
         9B0Q==
X-Gm-Message-State: AAQBX9fa7fcFRk4TCgHAfEg+TeZ96YlQkw44A2HTB8w5rMPfp79nm9eK
        dgRSSNYWnW8GzKjPOg0oGvIpWHuWrQ0=
X-Google-Smtp-Source: AKy350Zrf+AzQmW0Ol2UZQ/VpTYohzKZ+ZcgwG/dKQgPxOftivWnc/lngIJCTGhaHy4ZbH68OiofGQ==
X-Received: by 2002:a9d:4d84:0:b0:6a1:1ed4:bc50 with SMTP id u4-20020a9d4d84000000b006a11ed4bc50mr12996088otk.20.1680338835536;
        Sat, 01 Apr 2023 01:47:15 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r4-20020a056830134400b00697be532609sm1029933otq.73.2023.04.01.01.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:15 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 35/49] completion: bash: improve __gitcomp description
Date:   Sat,  1 Apr 2023 02:46:12 -0600
Message-Id: <20230401084626.304356-36-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It does a lot more than what is stated now.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2974604e99..6633b866fb 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -330,8 +330,7 @@ __gitcompadd ()
 	done
 }
 
-# Generates completion reply, appending a space to possible completion words,
-# if necessary.
+# Creates completion replies, reorganizing options and adding suffixes as needed.
 # It accepts 1 to 4 arguments:
 # 1: List of possible completion words.
 # 2: A prefix to be added to each possible completion word (optional).
-- 
2.33.0

