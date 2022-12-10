Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D782BC4332F
	for <git@archiver.kernel.org>; Sat, 10 Dec 2022 00:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLJAQp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 19:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLJAQo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 19:16:44 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643F996542
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 16:16:43 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w23so6517758ply.12
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 16:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jEqOJc+CrmgFfzFIVJtrC0BfiuEgY61hfeYhynaTohU=;
        b=Q/fa2gwDEtjJMT8+rqPJPh1xF1rPUZiepmVz5CFYiw/V4Q11lg5w1bIZQLXHuvQq+e
         EGZYPHZGqS/BmDWedpDD59lW+VC/QnzJatdU8zcukAPBHCXdNbGjFRtKkrNNwvY700bW
         h+mN0UnZTzsg+QbAuPneZlDxFAkeZuMg1wn25AWYH2nbwsUuWTcyMGAQnTx8c9vyXKKL
         jMnLzT9KuHD9CCg9L9duK1Vj8rQPp/U5KgOH7SUiVvwBTs4WWFca5g2TcphCNAy1t14o
         sYkAqrEaAnL4upsXndvuKSJ7B3oQSyYdXU7DAh1OtmMPVhJGsT0lA26PQOc2bDPbssQj
         BlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jEqOJc+CrmgFfzFIVJtrC0BfiuEgY61hfeYhynaTohU=;
        b=cspSNMQgkDOPMHxhicWkJCURdeLo6rd0x9jpI7lqg3KV0+LK3bpVzdgdcqS1Md7JE8
         eqYkFAkOoDrXgpY00wUMIYNViaz3Tbk5SnXE5hXVrPU+SPckwzFngOPAH44tnMpFCRlN
         /qWOzDBesrylPYxmYGnTVq4H4LWWHoO3e4YAfBrmajHfzARJG83WOV/rME4c6RKztJTt
         vJnxHImpTrL0SflnSPfUT7iK4I5ZXtDg0sYOTQEJZzcz4+C/OhOnoBNqX37YUA24GfEs
         510K2k+6D7h6lP4FFJthy6twZFmYmZSmReHYCDs7h/X8WRxUFjNDTTvRJXef6eFDXeQD
         /yKQ==
X-Gm-Message-State: ANoB5pl6mAfMsDfxAbVwL9RWeTwTmm9o17bP1iaOCs9t6TkMSFv8j37K
        GWvuiIkva53elHXpPUbZilk=
X-Google-Smtp-Source: AA0mqf6AQzlFXgX99zSKb0VV8gMi++1gr1Vv9F5A54TupyZJQt+9Y9gsLopy05if97VDO5myikbzAA==
X-Received: by 2002:a17:902:ce04:b0:189:323d:df17 with SMTP id k4-20020a170902ce0400b00189323ddf17mr8770040plg.67.1670631402747;
        Fri, 09 Dec 2022 16:16:42 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902bd8900b0018941395c40sm1818963pls.285.2022.12.09.16.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 16:16:42 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com
Subject: Re: [PATCH v4 3/4] object-file: emit corruption errors when detected
References: <cover.1669839849.git.jonathantanmy@google.com>
        <cover.1670622176.git.jonathantanmy@google.com>
        <07d28db92c2c61358755b3d501bc5bd35a760de1.1670622176.git.jonathantanmy@google.com>
Date:   Sat, 10 Dec 2022 09:16:42 +0900
In-Reply-To: <07d28db92c2c61358755b3d501bc5bd35a760de1.1670622176.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 9 Dec 2022 13:44:24 -0800")
Message-ID: <xmqqv8mkxgd1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +	fd = open_loose_object(r, oid, &path);
> +	if (fd < 0) {
> +		if (errno != ENOENT)
> +			error_errno(_("unable to open loose object %s"), path);
> +		return -1;
> +	}

I know there was a discussion in the previous round, but is this use
of path truly safe?  Currently it may happen to be as long as there
is at least one element on the odb list, but when thinking things
through with future-proofing point of view, I do not think assuming
that path is always computable is a healthy thing to do in the
longer term.

Our "struct object_id" may be extended in the future and allow us to
express "invalid" object name, in which case the error return we get
may not even be about "loose object file not openable" but "there
will never be a loose object file for such an invalid object name",
in which case there won't be any path returned from the function.

Other than that, the series looks quite clearly written.  Nicely
done.

Thanks.
