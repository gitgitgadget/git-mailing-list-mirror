Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8F4C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 21:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjDUVVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 17:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjDUVVx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 17:21:53 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36242110
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 14:21:51 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a920d4842bso21368965ad.2
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 14:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682112111; x=1684704111;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FU3CZjb29x+KAyUCp1GjUNIFG98SvwZnZANCUPKJDag=;
        b=qiXka2/66tWEdWW3VrjA0sWqyDOCZK9rRFRGF/BzofZZ3fuEtBzUN62MUnVQeBbIiO
         n3SHuKKhRFaI6qdv/1X2H31qGp2PvOLD7EUjt6r4d3ATEe1dgLEIWaEmB8uVAvY0nUV9
         XgehLLu5W9+Cf08WwTp30zE1JtQgOLET/fhdlJCVLCjx8T+gq0Y9/JpzBQleVoMtRdAW
         fqjb1amT7HLq+TMLc+MBwipxhD6bxglzejk/c5/ibmM+aIy6+KTWoFXt83W67Elu+fCc
         nMIbGtHJmqz5z4dgeDreZiCHlLZKvoxBji6njR32dbuXDZwzNAvnlHKlNuMUD8mcHVlk
         W/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682112111; x=1684704111;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FU3CZjb29x+KAyUCp1GjUNIFG98SvwZnZANCUPKJDag=;
        b=Y/zR+hTusqGlHyzbv02jEsK/ep1VMpVSSffOoEhyyRMb9CJbATGYuowOmsk4WSoH3d
         a+ibkpSK5Rcekoby13vLDfzh3ru76xdgm5ZZzr67/sDIEh51jpFfPraqY8Qb3PAto7Dh
         RP0Zv1xQ3m5rqWRJDPPbTp9O8Ju4SnhxzdN8XPM1ICmnWM8S/+JN2UVE1JEmYsVAPf4p
         sjeeK++VYVul4XweURW7ZYOPYC/DZmkK1WFrgNNdqEC80GefrZ6y99rs1fFfjWUM28OJ
         OQcPQzX4kGNDlEbaYDXcmoL9FScwtEslfTezHtlXFODBUeFnvGe3gUUvF32mBP50jIdX
         GN1w==
X-Gm-Message-State: AAQBX9eqoOD9W8uvG1r6Ejs3icRE3y7NO3rGVz5Zm0bgOsqLiYRdOX5F
        HrU+Dm8/fWPWfkMrQt7Nsow=
X-Google-Smtp-Source: AKy350ZJQHbfDGiWHIhwblbgB5HtAanaHxni7/ltw6lu6SqTLWH4FL9i6mU0K8RaYopqdcTHrg169A==
X-Received: by 2002:a17:902:d4d1:b0:19a:9880:175f with SMTP id o17-20020a170902d4d100b0019a9880175fmr7741229plg.51.1682112111291;
        Fri, 21 Apr 2023 14:21:51 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902b41500b001a1a8e98e93sm3085300plr.287.2023.04.21.14.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 14:21:50 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 3/6] sequencer: factor out part of pick_commits()
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
        <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
        <31bb644e769a085bd2db97cdb5aae78729efc52d.1682089075.git.gitgitgadget@gmail.com>
        <xmqqpm7xjam2.fsf@gitster.g>
        <049a792d-e015-3583-452d-923b9aee4a72@gmail.com>
Date:   Fri, 21 Apr 2023 14:21:50 -0700
In-Reply-To: <049a792d-e015-3583-452d-923b9aee4a72@gmail.com> (Phillip Wood's
        message of "Fri, 21 Apr 2023 21:00:47 +0100")
Message-ID: <xmqqleilhqxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> There are two blocks that might be entered. One guarded by "if
> (reschedule)" - this is not entered because reschedlue is always zero
> when picking a commit. The other is guarded by "else if
> (is_rebase_i(opts) && check_todo && !res)" and so will not be entered
> when we want to return an error because "res" is non-zero in that
> case.

Perhaps the proposed log message can be updated to mention
these to save time from "git log" readers?

>>   * the todo_list->current counter is incremented

The todo_list->current counter gets incremented before leaving the
function now, but all three callers of pick_commits() immediately
call todo_list_release(), the value, whether it is incremented or
not, is discarded without getting looked at.  

So it is not a noop, but the difference in behaviour does not become
externally observable?

Thanks.
