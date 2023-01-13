Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C58C677F1
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 18:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjAMS2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjAMS1k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 13:27:40 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7CDDE99
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 10:24:24 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9so24233595pll.9
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 10:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpQemxoMn97NC+V0P+Bn2mlba02RGegmHyT1pcmg2i8=;
        b=IgQ0AkWOGgaqB8dRIvCBn6GDyLWskNAf/TzA0x5cEtMZPNAOee/TqpVOw5PeIClKXD
         9ddOG5nHHsgwm9+R3b3we8L3fzq/vVGwXBg1gnxeWT+7RdFeXwi0BWHNGJJiNxi1DVDx
         84Xvvcg8a4r7aqpzw+MFj+Qkh8CEzCPIQj60xf+f+Ovms4M76yJUwgf+hhU502NW94x+
         RD9onNebZxB5bEFQwKcv33eS07gF0NpMbcD5iAGNSsK1yJcsW2guiLqjYClvuSJ8C7v9
         mEscirbd8lLeNoav1PcCZL9wQgv1VmYtM9dqYUVFWfq8pPeaU1sXPXipFgdiqr38Yfdf
         7TTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GpQemxoMn97NC+V0P+Bn2mlba02RGegmHyT1pcmg2i8=;
        b=GUZHfEX3KMmjRtCwa2fRk6Zymzkjjyi+HusPnWMbpbBpYqZ9lTmX3YufcSaCD5gRZG
         /RXhvcekBUJrIQIIRVp+fkUoEN5Baclxp6rrMtVv0I/FXqawIfX3SNV/NbqYpxkVCrUo
         xzgNoJ7OQV6n+BBHecFv539fyotoDaBeG8x2waIy3zoOwCWUBdz9Zl8NjbkMAoL95Xn/
         04PB/2x9m1yhI7sxcNrbgr8K83Ve7US8VR8yYIcpxhVQtDz/nvfQQ43jLHSDdglq0g0F
         D5nnVMoX45sQ15NB6x9EgHNM7KoUTUvXIdkyzKfsBj/75v/fvg5ZfNW2Lz/8z4Y0ddrV
         JB6A==
X-Gm-Message-State: AFqh2komdvRMjrgiZEuZwCzvGyM23jlweOe4Vo+tycTq4VwA7l9nFRj4
        2yKrUtX//wI0PRIvTe2Y+U8=
X-Google-Smtp-Source: AMrXdXtd+AIKHGtlt5m5KuyfF9K2qu5qydSStuAa0DQ/bv/X6hOTBtexDB7Jwu/88GuoupflNUwOyw==
X-Received: by 2002:a17:902:a609:b0:191:d98:7d7e with SMTP id u9-20020a170902a60900b001910d987d7emr75687575plq.22.1673634263441;
        Fri, 13 Jan 2023 10:24:23 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902ccc100b00192a8d795f3sm14443761ple.192.2023.01.13.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:24:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH v2] merge: break out of all_strategy loop when strategy
 is found
References: <pull.1429.git.git.1673203153257.gitgitgadget@gmail.com>
        <pull.1429.v2.git.git.1673285669004.gitgitgadget@gmail.com>
Date:   Fri, 13 Jan 2023 10:24:22 -0800
In-Reply-To: <pull.1429.v2.git.git.1673285669004.gitgitgadget@gmail.com> (Rose
        via GitGitGadget's message of "Mon, 09 Jan 2023 17:34:28 +0000")
Message-ID: <xmqqbkn247jd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rose via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Seija Kijin <doremylover123@gmail.com>
>
> strncmp does not modify any of the memory.

It may be a correct statement, but so what?  It does not seem to
have relevance to this change.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 0f093f2a4f2..74de2ebd2b3 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -188,7 +188,7 @@ static struct strategy *get_strategy(const char *name)
>  		for (i = 0; i < main_cmds.cnt; i++) {
>  			int j, found = 0;
>  			struct cmdname *ent = main_cmds.names[i];
> -			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
> +			for (j = 0; !found && j < ARRAY_SIZE(all_strategy); j++)
>  				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
>  						&& !all_strategy[j].name[ent->len])
>  					found = 1;

I am not sure if this micro-optimization is worth it.  

If this loop is so costly that it needs optimization, a better thing
to do would be to rethink the way it filters main_cmds.names[] array
with all_strategy[].  The latter is a fairly small, and more
importantly, a constant set of known strategies, so there should be
a more efficient way than O(n*m) nested loop.

The code churn has already costed us too much, mostly reviewer and
maintainer time, for the value of the change itself.  I'll queue the
patch as-is, because this change is not making anything worse
per-se, but primarily because I do not want the topic to take any
more of our resources.

Thanks.
