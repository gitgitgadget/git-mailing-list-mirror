Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D132BC76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 23:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjDKXKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 19:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDKXKi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 19:10:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F5A1FD2
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 16:10:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h24so9577803plr.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 16:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681254635; x=1683846635;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pzo+r9G/0SMhxeQQuUHXPPu1R4iqzT/+LICe8SkoW1w=;
        b=oaT2jMf4SkPlJIMhsIZiEOybASJUGF1FCMzo9D0NQfzVN2Kd6BUxpMfQszzTaZXmc6
         IcujUB75QdsBvP+AMuqTfLmlS0kx+xEmOPbL+SZCHP4QbeI46dZ/DcxkFsQ6G3/58SJV
         ZTNjUNGj55UGqtVCd/LSOYe1AxseiC8MtZEtkLebWhspfQrlEmlW/TJeFZkUAU0sFaoG
         PV2x/Yl38fZyT1Vio5gH+IbKtYPG3cI0aSONvwiZdQydCCnVWp8Jricegod2fYXmQ5bV
         qNwZXFeZPRoqsCEHcJmo6lmsGSvorrQUn0nQWvEDE/sDOfZjre6Ka9C7b4o0fLddFzMY
         HtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681254635; x=1683846635;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pzo+r9G/0SMhxeQQuUHXPPu1R4iqzT/+LICe8SkoW1w=;
        b=OXbTS6CiZUiZy0oI1Nvolze21p/a4Vj12AyPocMxK0idAA2E8ySP7iNPzsldV9LUyc
         3OEgsP6qc8fatGTWCu02ZQhMcwgGCtJGXavu9GmyL1EyFmDHdv2AUnvDZGO6XT+QXiAH
         yNUJAkt6LNdhD6ZqRKy1CcjZymBDi+GAyCzN+/nK9NoyU2HgEHjPPJbGKiuOzme3eAnV
         5Phvbxk4yKateqC9qtutIQMEqoxd2sRlPZz30gVqz7INhWMW2tJy1P4KzmmpKYqQfZMi
         xnhPptNrDXL09j5PajZKqanSx2BdZ+GNExY14k1iLRNO07bZgQ3Nicco6DpexRNbKS6w
         GNpQ==
X-Gm-Message-State: AAQBX9c7xX3m4PPp31fSsDpQAksWmrYhr484KPMktNzbWsNIT3QMU1Uw
        dM6i2p+9UYcVIYbZc2+k+1M=
X-Google-Smtp-Source: AKy350ZeX7HPyOwrpRpYBfKD6so+yxsCUM8pCSw6VrArxsBOA/hlQXPc9OegSX1frcs2nCkM4axf1w==
X-Received: by 2002:a17:90b:38ce:b0:246:8f9b:d274 with SMTP id nn14-20020a17090b38ce00b002468f9bd274mr5936013pjb.21.1681254635050;
        Tue, 11 Apr 2023 16:10:35 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id bg8-20020a17090b0d8800b00246a770310esm132621pjb.11.2023.04.11.16.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 16:10:33 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert Boyd III via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Robert Boyd III <git@robertboyd.dev>
Subject: Re: [PATCH] git-commit: fix cut_line behavior with CRLF
References: <pull.1513.git.1681253732794.gitgitgadget@gmail.com>
Date:   Tue, 11 Apr 2023 16:10:33 -0700
In-Reply-To: <pull.1513.git.1681253732794.gitgitgadget@gmail.com> (Robert Boyd
        III via GitGitGadget's message of "Tue, 11 Apr 2023 22:55:32 +0000")
Message-ID: <xmqq35569frq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert Boyd III via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Robert Boyd III <git@robertboyd.dev>
>
> On Windows with certain editor (mis)configurations, the cut_line that is
> used when commit.verbose is turned on doesn't work correctly because
> COMMIT_EDITMSG is rewritten with Windows line endings. This used to
> happen on old versions of VSCode, but I can't seem to reproduce it
> anymore without explicitly setting the line-endings to Windows. Even so,
> I think it would be sensible to fix this for good, even in the face of
> bad editor behavior.
>
> This patch moves the \n ending out of the detection string constant, so
> that regardless of the line endings, the cut_line is detected correctly.

The problem description does make sense.

Removing the hardcoded LF from the constant is a good idea, because
we would want to allow CRLF after the cut_line[] constant on Windows
while we usually expect LF there.  The code that inserts cut_line[]
into the output wants to have the LF at the end of the input string,
and your patch correctly compensates for the loss of LF, so that is
good, too.

But wt_status_locate_end() should be taught about our expectation
that cut_line[] we seek is supposed to be followed by either LF or
CRLF.  Otherwise we would mistake any random line that begins with
the cut_line[] constant, followed by arbitrary garbage that is not
end of line.

Thanks.

>  wt-status.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 3162241a570..85904362fe5 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -24,7 +24,7 @@
>  #define UF_DELAY_WARNING_IN_MS (2 * 1000)
>  
>  static const char cut_line[] =
> -"------------------------ >8 ------------------------\n";
> +"------------------------ >8 ------------------------";
>  
>  static char default_wt_status_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
> @@ -1090,7 +1090,7 @@ void wt_status_append_cut_line(struct strbuf *buf)
>  {
>  	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
>  
> -	strbuf_commented_addf(buf, "%s", cut_line);
> +	strbuf_commented_addf(buf, "%s\n", cut_line);
>  	strbuf_add_commented_lines(buf, explanation, strlen(explanation));
>  }
>  
>
> base-commit: 73876f4861cd3d187a4682290ab75c9dccadbc56
