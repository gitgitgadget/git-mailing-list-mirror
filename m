Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38523C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 17:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbjDYRrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 13:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjDYRrb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 13:47:31 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4023EAD0F
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 10:47:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b51fd2972so4851599b3a.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682444850; x=1685036850;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x23DFGaNUWjiGjQHcEMFUlrRtapeyW/f/bAIg8jJB7Q=;
        b=bw8djH/siXyP08gDfzewCbcdP1mowGyciSXppYAtAv+GYFGiw147u+aUBvFCApa8JW
         UOW1ef00YGPjrWxJBQOEQ1IAEpVZnGUiiFmh21QJX3Y/CQSTFam3Xl87fXAXC+1khge2
         X4ug44+FSPO5NFxhRFsGkwIAZAJTpuaA+Wn44PT4ImJV54dad1qoJj9t1yRYq2x/js7B
         vGa2QZGtIz54CkWx+2elc7C376c5F9In+1ZFoURHkMz1LuGyi5q4taBCD+1k1FjAck0j
         N0WN6/klXal21Yhqqg/YysZngCA4vHRbC801OsQqF/U/YlFVif4+nBo69N54/gro5oGl
         ql9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682444850; x=1685036850;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x23DFGaNUWjiGjQHcEMFUlrRtapeyW/f/bAIg8jJB7Q=;
        b=JlArZ9HlojwMGNeWoCwTb6EqE7HgJkTX4sbqVftHAgA/f0MZx3JwFRyiaudfteP893
         kn2guK5bjS77vnxDu1c7ndoprH0P2irTjEkh3GI6PdqR9h7tpjbm2CEN3UDcN5FH2clA
         Oo6xe0gMCE+lE56T7dVeczIPMlRWay0mxF7935IedkoVxwU6kvY/zkjkgxyWWGDmACuu
         FxmPXWA0Ho6oQpLCYnLIBuazs9yGwagsWdOyysw70Ux9c4Zi4p93t7GRqR17jNXydLTi
         +Wa14paXk1WsWZmeU1Y0J8vZjlIvv7aq8h6vF3kkhb6W9w6/EmyyHPHeLJD+rlQY4Wh8
         hbNQ==
X-Gm-Message-State: AAQBX9dYOP/8Ewe5cNoTEsExDgnJjzt1bVacspYpTubPhm3biFqWSNUa
        sTbQo+Mao6GMYa6/YYLviu4=
X-Google-Smtp-Source: AKy350am/LN+Is6Kat4gH/CW/VoUeeO1EF9sjOwRNi0VBSy+/R33quML6NqUaB1yjJMxB4WdrJIf/Q==
X-Received: by 2002:a05:6a00:9a1:b0:63b:3e:cbee with SMTP id u33-20020a056a0009a100b0063b003ecbeemr26286563pfg.32.1682444849678;
        Tue, 25 Apr 2023 10:47:29 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id i69-20020a628748000000b00640e12b6464sm2656205pfe.178.2023.04.25.10.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 10:47:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 5/6] notes.c: append separator instead of insert by pos
References: <cover.1682429602.git.dyroneteng@gmail.com>
        <ef40e0efc34ce6b6ee5b9b67bdde3dae02652cec.1682429602.git.dyroneteng@gmail.com>
Date:   Tue, 25 Apr 2023 10:47:29 -0700
In-Reply-To: <ef40e0efc34ce6b6ee5b9b67bdde3dae02652cec.1682429602.git.dyroneteng@gmail.com>
        (Teng Long's message of "Tue, 25 Apr 2023 21:34:40 +0800")
Message-ID: <xmqqa5yv26ry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> This commit rename "insert_separator" to "append_separator" and also

"This commit rename" -> "Rename".

> remove the "postion" argument, this serves two purpose:
>
> The first is that when specifying more than one "-m" ( like "-F", etc)
> to "git notes add" or "git notes append", the order of them matters,
> which means we need to append the each separator and message in turn,
> so we don't have to make the caller specify the position, the "append"
> operation is enough and clear.

OK.

> The second is that when we execute the "git notes append" subcommand
> , we need to combine the "prev_note" and "current_note" to get the

Funny placement of comma?

> +static void append_separator(struct strbuf *message)
>  {
>  	if (!separator)
> -		strbuf_insertstr(message, pos, "\n");
> +		strbuf_insertstr(message, message->len, "\n");
>  	else if (separator[strlen(separator) - 1] == '\n')
> -		strbuf_insertstr(message, pos, separator);
> +		strbuf_insertstr(message, message->len, separator);
>  	else
> -		strbuf_insertf(message, pos, "%s%s", separator, "\n");
> +		strbuf_insertf(message, message->len, "%s%s", separator, "\n");
>  }

Is it still needed to use strbuf_insert*() variants when the only
thing being done is to append at the end?  Use of strbuf_add*()
would let you drop message->len from the arguments.
