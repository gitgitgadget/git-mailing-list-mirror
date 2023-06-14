Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2A5EB64D7
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 01:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbjFNBCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 21:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFNBCg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 21:02:36 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6C91BE3
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 18:02:35 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b3db8f3d94so14655345ad.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 18:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686704555; x=1689296555;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBpIU82VQS3w3z1jrs6xUgHn3XZVQC72HWVd/YdFYUE=;
        b=o21ei/o9uwpIH72NcJX4u0yCezxEvlhuSlH9lMOW/bEHVr1Gqn8qLkaV/AoNIhE73a
         5r8Me26EjoaTvEXpBHmf2O9td1OZY8CN6pSkN1kDDb/iO/YMFo4qzOHQEseiGqTt3eRM
         izBFFUsVaW4Scd636ciNIu7kFn21QZdqR2qzaOr0NtSCoGQioVVxVw1JsupIoJBFFnhm
         dYukVE410s3alrPZ4BVeeUOITWU6ZHnwmI6i2omrhfdrM0RTTHXVKx32hNgQvsbEzzHB
         G/01xu+vu1ADGQnxEaw0G0zE9fcwygKeEym20ayGO+tKtcTU9x2uF0EMXQY29YgHscN7
         +qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686704555; x=1689296555;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BBpIU82VQS3w3z1jrs6xUgHn3XZVQC72HWVd/YdFYUE=;
        b=lNLnDN+E6VobOdtz9VoW2A7JO8b+394AvbFkv+s6pAOAqOZIG7Jkqklh/cTTb/lVIv
         K3+9wlwG0Z2RiyELkdxZRQhVeUm9BR0KsFYwmT3NVp4/rP1iwfc8yt9nI8i2/9IA98IU
         Hi/cqgeZAW600DbalP+o8wicWHGxejlzzHruHV0Z5mXxsX4i/sg+r9HkrlJPdPph5Qv8
         27Gq2Ic3S1z24w1c/JiobF4bTyOWSbyeCbVwz0lotMPY308vBZicH4KqQRAb8S4IeEbX
         ocJraXfPdPuagxeGCMsKTpLYKoISr8sABchfd67xkwEi2kVqPA/Xa5g/IwYbEfVYQ48N
         nKWg==
X-Gm-Message-State: AC+VfDxtQxUlITsXtXI9rTnAEEgqy0UCoF+NQfOGkA8vDuMx8OAQKqLm
        Fo44VrRUPHUbIvdgP5wv76I=
X-Google-Smtp-Source: ACHHUZ4QxqjKCcwre2Xhxk59ptxaWV4xONZZ8t9IuizJUzP8mqSG4ZzjUVUycz207JNCefoiQOixQg==
X-Received: by 2002:a17:902:d4c7:b0:1ad:7bc5:b9ea with SMTP id o7-20020a170902d4c700b001ad7bc5b9eamr11803119plg.60.1686704554689;
        Tue, 13 Jun 2023 18:02:34 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id be7-20020a170902aa0700b001b1920cffd5sm10762525plb.267.2023.06.13.18.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 18:02:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce
 '--separator=<paragraph-break>' option
References: <cover.1682671758.git.dyroneteng@gmail.com>
        <ed930ef4f795f30792bc14d9c1939484e4976db8.1682671758.git.dyroneteng@gmail.com>
Date:   Tue, 13 Jun 2023 18:02:33 -0700
In-Reply-To: <ed930ef4f795f30792bc14d9c1939484e4976db8.1682671758.git.dyroneteng@gmail.com>
        (Teng Long's message of "Fri, 28 Apr 2023 17:23:32 +0800")
Message-ID: <xmqqh6ra26vq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This step seems to break CI asan/ubsan job

https://github.com/git/git/actions/runs/5260417146/jobs/9507299904#step:4:1826

Perhaps something like this is in order?

 builtin/notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/builtin/notes.c w/builtin/notes.c
index 6eede30597..785b1922ad 100644
--- c/builtin/notes.c
+++ w/builtin/notes.c
@@ -239,7 +239,7 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
 
 static void append_separator(struct strbuf *message)
 {
-	if (separator[strlen(separator) - 1] == '\n')
+	if (*separator && separator[strlen(separator) - 1] == '\n')
 		strbuf_addstr(message, separator);
 	else
 		strbuf_addf(message, "%s%s", separator, "\n");
