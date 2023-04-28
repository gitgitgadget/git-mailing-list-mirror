Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03611C77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 20:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346683AbjD1UoO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 16:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345728AbjD1UoM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 16:44:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38191FF2
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 13:44:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b62d2f729so372500b3a.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682714651; x=1685306651;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q79QINdjZCCYGIei7fS1arJPfBN/cNGsue9Yiff6C3A=;
        b=FQpp8r2+GXhXR5t35KDhRjOcmP7STHq3dskLpcFMEna3FHcvukoHfUSu0DVYUE6wIy
         mdkKPZG2MeCUwSS2XyCv4gXiMXaMVg8N9Gnb0Y+6aCE8HLk5xj4+auoj+5yZmdQsf7L/
         PiPQMUC2f8GMR8pw43Z0sTRtYCCLh25XGeqCcNqSwp9DjKqGJjnkAi6jehwNnmvqXvn8
         UvBj+EbP1cYXCiMx25MXiXVx+T2Aas8JgGIjm0EXNDUdUIe0wn+s9H4sLRBBkYQ2Q97+
         bAizFM07AToEUuE0h55+Uhhwog21uVAUKPS8BjQ1505Q0qOxgkH6zHUAdsh9mrz86QKt
         Pg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682714651; x=1685306651;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q79QINdjZCCYGIei7fS1arJPfBN/cNGsue9Yiff6C3A=;
        b=MZf/wKDLA9olCGsAVG3AS8KyPM7WnaSZ8oJ/NUHwapbeGawaJ65AlYiycFeN5nuYT+
         R8xSt4A8/BRCNDIK3BaM7thxNYjlyF4dJPMuShEUquK6+eWEgtosva5euxuranQzpKfW
         yUiITK35nHNddPZKAKCBPUBBHI065XQW813GL4gouGTYz6ahq9W/M6wuzXG+60o1Ygyo
         AsHuaL2o6KJbsN2t203aTedX3L6X1bYyvKFdMt3iv0iJorKAdYfoprPgqTfhIOnx/VE9
         FjMSkk6JFpm/3+EtsCjKcoKO4CjneQ+wUOIzmkWOWiYTkDs8fMiY2txHkQyTSknDcJF4
         qudA==
X-Gm-Message-State: AC+VfDyzISFyK+2LI5rb6RH7KFg0Myf72+p/0krtFwRLzO9RtlSK14eM
        k9Vezl5gcN+LRKN7M+RhN0cienJKmo4=
X-Google-Smtp-Source: ACHHUZ7c6g0xVzlZRwyrf/S4tWVGU61oKZGTzz+hsKjOxw1d/wL5SttNcka1gBQxFStt551S1nT/mg==
X-Received: by 2002:a05:6a20:2590:b0:f4:ac2d:8e95 with SMTP id k16-20020a056a20259000b000f4ac2d8e95mr8654010pzd.9.1682714651216;
        Fri, 28 Apr 2023 13:44:11 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id o64-20020a62cd43000000b0063d642dcd12sm16082875pfg.16.2023.04.28.13.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 13:44:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce
 '--separator=<paragraph-break>' option
References: <cover.1682671758.git.dyroneteng@gmail.com>
        <ed930ef4f795f30792bc14d9c1939484e4976db8.1682671758.git.dyroneteng@gmail.com>
Date:   Fri, 28 Apr 2023 13:44:10 -0700
In-Reply-To: <ed930ef4f795f30792bc14d9c1939484e4976db8.1682671758.git.dyroneteng@gmail.com>
        (Teng Long's message of "Fri, 28 Apr 2023 17:23:32 +0800")
Message-ID: <xmqqsfcjbuud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> +static char *separator = "\n";

The only two ways this pointer gains a non-NULL value are with this
initialization and parsing the command line "--separator=<value>"
option with OPT_STRING().  Neither of them allocate new storage but
points an existing string that we do not "own" (and cannot free)
with the pointer.  So it probably is safer to make it a pointer to a
const string, i.e.

	static const char *separator = "\n";

> @@ -213,65 +229,96 @@ static void write_note_data(struct note_data *d, struct object_id *oid)
>  	}
>  }
>  
> +static void insert_separator(struct strbuf *message, size_t pos)
> +{
> +	if (separator[strlen(separator) - 1] == '\n')
> +		strbuf_addstr(message, separator);
> +	else
> +		strbuf_insertf(message, pos, "%s%s", separator, "\n");
> +}
> +
> +static void concat_messages(struct note_data *d)
> +{
> +	struct strbuf msg = STRBUF_INIT;
> +
> +	size_t i;
> +	for (i = 0; i < d->msg_nr ; i++) {

Wrong placement of the blank line that separates the declaration and
the first statement.

