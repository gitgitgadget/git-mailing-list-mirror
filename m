Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5E3C77B75
	for <git@archiver.kernel.org>; Sat,  6 May 2023 09:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjEFJMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 05:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjEFJMP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 05:12:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876EA12C
        for <git@vger.kernel.org>; Sat,  6 May 2023 02:12:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24de3a8bfcfso2550523a91.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 02:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683364333; x=1685956333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mVKBurhO9y8iDktg4VnXKcoOPm71GTkqQrP9mTWW10=;
        b=CLQt+CLX/rcUA6nu3b2Fh4Cu20omKJYPfFKNDYPARJjFuF5pE7blk+70clx5PmJjsq
         3/I0cMOiRsH5LNIAXD99hdOWn7wrm3QwADBbBVDi+xde7txihxZQVHKLUe6WJAGLqkN7
         sDDkkn2p/pWjq28zp513sFQo0q7P5HH0REtfcVWnLLENZM6OyjQ7LAJRI2/FtVQGCQlk
         vIxniPWeS0nt3Muj+vEN4ffQX/ZV4yT1x3qMWInuNvZx07+PFSrLQ73TUQZfgfIvnH+/
         lEgbiDwC2z9PEoi3NYM4wee1GHV+pNj3w0hX3zRn+6tYpCDGU0+BwnfUx6ihQ8Oi3w86
         ZS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683364333; x=1685956333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mVKBurhO9y8iDktg4VnXKcoOPm71GTkqQrP9mTWW10=;
        b=T42ypR+ixelJ3YkMrpobXHCcal7PNgeOrzc5VSoXndJ7wxhsws71tC/uc9/kVrst5Y
         I4pbz0hzGeC1Unon8DRZNXaMbKiUP2L4YeG7TL/xeVaezfmiQt1gEXhRYyXsDjjDYbeN
         zENmPPk0zpoAQoj007ARxoUOEteGXi6Auj/M1ggv4DoSDhf01BTbmMoWpsd9dkJownoE
         A+2Dq5uiyB6Pc+5yL+2I4G6XMWokxLElohNpmq5rddZCm1Es2T0TePvo7CT7evvoKukM
         brjjzyjYqO/Xz50BlDvZlYsZKG5dV7+2LhY54DzrEBhu0RSr7/WVQDAciEQ63shshp7M
         OtRA==
X-Gm-Message-State: AC+VfDwVs1mm5wKt5z/9C3lQf34bLQ5ak1YnRrXxECEPRaPV6qCVWAC+
        /PuguPYaEqQzbzgdHQM6wjI=
X-Google-Smtp-Source: ACHHUZ5QGWEiHa7m6Q0EbcpXI0Mwunk54RarFmPqhaQ0YaHkrkNMUwT/Y05IRmsGVxf08uIGNLoz0g==
X-Received: by 2002:a17:90a:c10:b0:24b:2ef6:64d5 with SMTP id 16-20020a17090a0c1000b0024b2ef664d5mr4110470pjs.47.1683364332840;
        Sat, 06 May 2023 02:12:12 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.60])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902a9c700b001ab05aaaf8fsm3126994plr.104.2023.05.06.02.12.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 May 2023 02:12:11 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce '--separator=<paragraph-break>' option
Date:   Sat,  6 May 2023 17:12:04 +0800
Message-ID: <20230506091205.57746-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.1.446.gf331623a.dirty
In-Reply-To: <xmqqsfcjbuud.fsf@gitster.g>
References: <xmqqsfcjbuud.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +static char *separator = "\n";
>
>The only two ways this pointer gains a non-NULL value are with this
>initialization and parsing the command line "--separator=<value>"
>option with OPT_STRING().  Neither of them allocate new storage but
>points an existing string that we do not "own" (and cannot free)
>with the pointer.  So it probably is safer to make it a pointer to a
>const string, i.e.
>
>	static const char *separator = "\n";
>
>> @@ -213,65 +229,96 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
>>  	}
>>  }
>>  
>> +static void insert_separator(struct strbuf *message, size_t pos)
>> +{
>> +	if (separator[strlen(separator) - 1] == '\n')
>> +		strbuf_addstr(message, separator);
>> +	else
>> +		strbuf_insertf(message, pos, "%s%s", separator, "\n");
>> +}
>> +
>> +static void concat_messages(struct note_data *d)
>> +{
>> +	struct strbuf msg = STRBUF_INIT;
>> +
>> +	size_t i;
>> +	for (i = 0; i < d->msg_nr ; i++) {
>
>Wrong placement of the blank line that separates the declaration and
>the first statement.

Thanks for your advice and detailed explanation. I have noticed
in "what's cooking in git" that this patchset is being planed to
merge into 'next', so I display the diff here for the convenience
of applying, or please let me know if a new patch is required.

diff --git a/builtin/notes.c b/builtin/notes.c
index 8905298b..6eede305 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -28,7 +28,7 @@
 #include "worktree.h"
 #include "write-or-die.h"
 
-static const char *separator = "\n";
+static char *separator = "\n";
 static const char * const git_notes_usage[] = {
        N_("git notes [--ref <notes-ref>] [list [<object>]]"),
        N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [--separator=<paragraph-break>] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
@@ -248,8 +248,8 @@ static void append_separator(struct strbuf *message)
 static void concat_messages(struct note_data *d)
 {
        struct strbuf msg = STRBUF_INIT;
-       size_t i;
 
+       size_t i;
        for (i = 0; i < d->msg_nr ; i++) {
                if (d->buf.len)
                        append_separator(&d->buf);
