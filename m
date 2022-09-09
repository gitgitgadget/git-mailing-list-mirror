Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC23ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 16:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiIIQsl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 12:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiIIQsC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 12:48:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E78146D2A
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 09:47:44 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id iw17so2371525plb.0
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=D/RrncthgjcANTf9Cvi5eSwRFS/pzAmVMyYpx8KD11E=;
        b=BZ+ITmD6ZCUd3a6QGmbpkhnefq6BIePyVQU7//ZSrse58dvAW+9UkN6tjxwqBlk45P
         5qCBaZjBZ/RXRK8AF1WrPequ6RETg8tC3HM+KS5dS99JFBk+FDoROmchc6kb9p3tWeoE
         XYJhMT6uAOtaPymIliEjeahnZnYl8TsG82OgxDF3ScmjUuOIfqocVPFhwRHVSSMe0vB8
         jgDppcPKTCT1Hr7mTbzoyk/JvQij+MS9l+Vemo47WLsQIAXdLNC7hfZ5SXHilBtHAIu2
         jpLfxiTYaVmDaNBp/WAZ/gCGV6N3kZeBVmyZtLEVWzvYJ0Mexu+hDFX3llgHvHPrncz4
         PFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=D/RrncthgjcANTf9Cvi5eSwRFS/pzAmVMyYpx8KD11E=;
        b=nXOaxiOll/d7k52y4CHA7WgiNNw5i323rbo0RTwTRkGGbd48IxchZQEfdd8jvFlXR7
         Xib0LaZF+YWfqTbSEOw5GpnJyUJehX+exRol7/MGEEI8Z2jnsYslWtXcQ1gMJlVoAeAb
         VkOM+FoBfcndECPgugCuqiuVPEhNjXVJYpCYGlpniLkFAOReg/s97gmHzG+YvVdsvLOD
         RoipPOorxktbR8prJXlVUSUg5e9FM0XcB/smnoV2GFr3fgtMga9so420vBIMRkCllPPh
         Cds1qmhxkY7J+g782ol1LKsskXu1FGjvdeB88C585riIcsUrOtsYTt0kXr7KQt3TDUmN
         NE0A==
X-Gm-Message-State: ACgBeo1X4VVPRv2a9qd2rKAU5o7Ff2VHfmZW2cNIv8yTVX5dLUL/Jyzl
        s1BWJtnv3KVh/RLU9mZSYME=
X-Google-Smtp-Source: AA6agR6BzsUUP+K7EsZge+EnUJ0Y8blNo/fA5Ntl7PCb7Z+SIjOeoj2HUQzuk5li3QshfnQZdMqJhA==
X-Received: by 2002:a17:903:11d0:b0:171:2cbc:3d06 with SMTP id q16-20020a17090311d000b001712cbc3d06mr13815825plh.142.1662742064258;
        Fri, 09 Sep 2022 09:47:44 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n4-20020aa79844000000b0053abb15b3d9sm829364pfq.19.2022.09.09.09.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 09:47:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, l.s.r@web.de
Subject: Re: [PATCH v2 2/2] format-patch: warn if commit msg contains a
 patch delimiter
References: <cover.1662559356.git.matheus.bernardino@usp.br>
        <a2c4514aa03657f3b1d822efe3dd630713287ee6.1662559356.git.matheus.bernardino@usp.br>
        <4d750ff2-9df5-504f-9972-59b082000db0@gmail.com>
        <xmqqa67buj4m.fsf@gitster.g>
        <CAHd-oW4Z-UbFWy=fj=L-CqiG9QP0x3ZLRg0icgK5Xgu=THd4Lw@mail.gmail.com>
Date:   Fri, 09 Sep 2022 09:47:43 -0700
In-Reply-To: <CAHd-oW4Z-UbFWy=fj=L-CqiG9QP0x3ZLRg0icgK5Xgu=THd4Lw@mail.gmail.com>
        (Matheus Tavares's message of "Thu, 8 Sep 2022 22:08:19 -0300")
Message-ID: <xmqqwnaclck0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> Makes sense. Perhaps under a config option? The difficult part would
> be for the scissors; just indenting it with whitespaces wouldn't
> suffice, right?

It may be difficult not because of any mechanical reasons, but
because we cannot guess WHY the author wrote it there in the log in
the first place.  It could be that the author writes explanatory
text that is not to become part of the permanent history at the
beginning, place scissors, and follow that with log for posterity,
EXPECTING that all of them is output by format-patch and transmit to
the receiving end without modified.

Another thing is a three-dash marker line in the log message.  I
myself did use them to leave a note for myself (which should be left
outside the official history when it is sent to the list and then
applied), and I would have been upset if it was stripped or the tool
even warned against it---I knew what I was doing after all.

Compared to these two, an unindented "diff " and its output in the
log has no reason to be pre-recoded in the commit message and make
the rest of the message a part of the patch, so I am perfectly fine
if we unconditionally "escaped" them.  But I personally think
scissors and three-dash lines should be left intact.
