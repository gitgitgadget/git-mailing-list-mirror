Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22D1C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 16:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjDYQ3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjDYQ3B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 12:29:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269223C0A
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 09:29:01 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a50cb65c92so48280805ad.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682440140; x=1685032140;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZWARPzDTaIaCd4dLseacV5/xLxy8NmMgpRtgZExmgE=;
        b=HtJEMPPvcZez7+uYpg6jpRzwD6AstVi0uq5EpOZreN1+8dKtv1tKHcRA5x1JUsEZgi
         IJZCJZx/kkw2bo5InwcBTXkFyP1hLx2VBeQj/BpaCZ3hTgD0NFYySdN1MMfKxuTYKQpz
         bqi3w/9owqGrbPeFvxu6RTfku4kPgGs0NSo2+mw3X7w8+vuVVLZ/63ojWD3T7Y0LIZgU
         0mgz0GQpyXOvEIdq8mnAJeCIDp61x9Ivgm6SU1dBmpe3e6U93APtGFjWrDI+tS5LPGGX
         TfC7Skqv02kEQ64268EsaloQeziQEXQMs+sixs+x7j6Ax5Vk0rW+sXOZ3eL0R5sq4v4Z
         AgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682440140; x=1685032140;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bZWARPzDTaIaCd4dLseacV5/xLxy8NmMgpRtgZExmgE=;
        b=II+Z3t9Va4gWY9mWpC868ui8LM5CXLyfRtXIwjtn1fmfPb3wR+6ApLvXIw97yNHNXQ
         XFNRRhRpwSwZAL4V12eCFNUH/IwZsykBDA6expeqnjzgvDNNioxa0SJBRd6gJvUkBW7D
         RdWF2v3CTy8rCXzvvnKWhcxMxCsPGDbb8GVAhLQ0wgc26kbUnL48n/XRtmawIMDTmg9l
         1hF0fURFM5w83vkS4H2a8E4B+D2rGL25t9AOvl2J8qnJjIAKpzsZ59mvYeafk8Xtm6du
         aVw6M7QE8W3BXCsBZH80D4wsWiBYlVyrbHgY6HgzU6exN9b9r9NFrBq+RIzJWEgQb/ww
         F3dQ==
X-Gm-Message-State: AAQBX9fQ+YvtAHB0GQxDcLAeT9DEoCgQT/dk7Iuvr+/0XNqguj/FKzH8
        QpTGqTZLBTDiexueFprwLjQ=
X-Google-Smtp-Source: AKy350ZJzvYP4xGzCEca0WEwE85Xz5NbXC8Zk5/6biTQgiX3rLLCAU99rPVBb853B9bjigsByrcySQ==
X-Received: by 2002:a17:902:dac7:b0:1a9:5c78:8fdf with SMTP id q7-20020a170902dac700b001a95c788fdfmr15435823plx.36.1682440140509;
        Tue, 25 Apr 2023 09:29:00 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902988200b0019a7d58e595sm8439447plp.143.2023.04.25.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:29:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Maxim Cournoyer <maxim.cournoyer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] send-email: add --header-cmd option
References: <20230423122744.4865-1-maxim.cournoyer@gmail.com>
        <20230423122744.4865-3-maxim.cournoyer@gmail.com>
        <xmqqh6t57x0y.fsf@gitster.g> <87y1mgortc.fsf@gmail.com>
Date:   Tue, 25 Apr 2023 09:29:00 -0700
In-Reply-To: <87y1mgortc.fsf@gmail.com> (Maxim Cournoyer's message of "Tue, 25
        Apr 2023 12:22:07 -0400")
Message-ID: <xmqqcz3s3oz7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maxim Cournoyer <maxim.cournoyer@gmail.com> writes:

> I'm not too familiar with the email format; but I presume an empty line
> would signal the end of a message?  That'd be bad yes, but I think it
> cannot currently happen given the 'last if $line =~ /^$/;' guard at in
> execute_cmd around line 2023; it'd means headers following an empty line
> would be discarded though.  The expected use case is indeed for a user's
> script to produce RFC 2822 style headers to messages.

Yes, silently discarding the end-user input is what I meant by a
disaster.

> The former (a true default with no way to turn it off other than
> redefining it), which I believe is the same behavior as for --cc-cmd or
> --to-cmd.  There are no '--no-cc-cmd' or '--no-to-cmd' options, although
> their result can be filtered via the '--no-cc' and '--no-to' options.

Yup.

> Looking in the source, options supporting '--no-' always appear to be
> boolean toggles (on/off) though, so I'm not sure how a '--no-header-cmd'
> that take a value can currently be implemented.  Perhaps it could be
> added later if there is a need?

Perhaps we can do without a configuration variable first, and
perhaps the variable could be added later if there is a need and a
proper way to turn it off per invocation basis.

> I've extracted such postprocessing into fold_headers and applied
> execute_cmd to it in new invoke_header_cmd subroutine.

Sounds like a good approach (without looking the actual patch).

Thanks.
