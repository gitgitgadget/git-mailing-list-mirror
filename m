Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45618C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 00:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiKVAxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 19:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKVAxO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 19:53:14 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4F2DDFB2
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:53:14 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id q9so12898663pfg.5
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 16:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRJ2yi1YormmHLrZ/DOqLHt/O+w6G0cIwyj4q+gjGPE=;
        b=E80jF8IV4K0VK22QieEONZJV/MEzoi395hQ+WVqJJunTK+Us3y9H0e6ywoGUCnGqKQ
         MnVFN7jh0ZwA1FXhbCpJ8aZxdczwiD2oonuD3j2r8+AzBcZ58GESLqQ6jncO88QND+fr
         0Gr2oaoQOIwcNFLaabu/t1R02afiYB91bl3jcL5HIrVKl4nmAxAkCOZc2uBp63x36sX5
         An+p4lB1VnRbrxACzy5ogrnuSPfUy0r5T0yq5zwCBDtqGfq1FASCZbo5DndwcV0WMWQA
         +ZaBcKEkNez4WcXCXYpvlhd4E1CTew15XRISYm5ZlAV69clB24uaP8lmlLTth2KQ1VWD
         ukKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRJ2yi1YormmHLrZ/DOqLHt/O+w6G0cIwyj4q+gjGPE=;
        b=6fi0vPl+cpXoaj1rY9/M2fwpztAl90vZT9U/a2XmEeyZBUYki2fcVIEr/GmIMfFsaw
         bKFzeKO5LdBW7nYU3OSpnFljVmPdE7h+CNE8G2M8Mm7Q9FxeUSh4hILK075h3AZ4AS7y
         27eOMeXlI5PIPz0iV6nyroVMN4FlkYjdvcbJogGOWDXyYU5iFQm6EEsDjmehd2FfrPFE
         tG4o9J+WVDOQgIrEhFibUllCTMy404QSs58S4PYePKlnLG8xjmE44Mq8SZIimcV/KXRU
         nn+Jru4LUGciHrflNPY0KfOe2nKNHMDwx2CcAG+srrUcEmHFR4FSByCh7AycciVUwbxS
         GaIA==
X-Gm-Message-State: ANoB5pmA2K3E2nK9x1Xvphq8mVx5juJ6fHs/cejJ4bLjHM0qZY1IGgC+
        v/v+iFjqzsWjYs/4RGtd2Zo=
X-Google-Smtp-Source: AA0mqf7laMSxXifqn1lF6BzEDbLtTknfOhKcJtlb7p79rfOaasxU4ReckkcsvmoAZJ5TlP4wiDYtkA==
X-Received: by 2002:a63:7353:0:b0:477:467e:357f with SMTP id d19-20020a637353000000b00477467e357fmr2055932pgn.263.1669078393587;
        Mon, 21 Nov 2022 16:53:13 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b00179e1f08634sm10466410plx.222.2022.11.21.16.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 16:53:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t3920: don't ignore errors of more than one command
 with `|| true`
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
        <eed47577-1e47-2fbb-6344-fd4ae324f6b6@web.de>
Date:   Tue, 22 Nov 2022 09:53:12 +0900
In-Reply-To: <eed47577-1e47-2fbb-6344-fd4ae324f6b6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 21 Nov 2022 23:56:37 +0100")
Message-ID: <xmqqilj7u7wn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>> @@ -12,7 +12,7 @@ create_crlf_ref () {
>>  	cat >.crlf-orig-$branch.txt &&
>>  	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
>
> Useless use of cat.

Very good eyes.

> OK, back on topic: Adding CRs explicitly instead of relying on grep to
> pass them through (which it doesn't on MinGW) also ignores the return
> value of grep as a side effect of the pipe:
>
> 	grep 'Body' .crlf-orig-$branch.txt | append_cr >.crlf-body-$branch.txt &&

Very nice.
