Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0384DC4167B
	for <git@archiver.kernel.org>; Mon, 26 Dec 2022 01:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiLZBTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 20:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiLZBTB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 20:19:01 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289A8266C
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 17:19:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fy4so9592399pjb.0
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 17:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKMjTc/Up+USv+T+Pd2T8SvnMOusH2FM1eqdBnOU/8k=;
        b=bG8hoqKUop6MKSmxcbLPnVgCO0ZvPl7Qr6yQmw1mgDapWSvKcsAu4iVGxH0qo6hJNH
         RkdD35JiJa8Zaxb94WSJTq68kib4tM5hWycxQRQWeyCJRWYIXE+IluEqdks3NCDUeIQW
         waipwSH6ELVVY22OdVtLwaENZ0ZhcB+Q8bdQO2Lr0NzqFPnlFkrblTiJKOxewxtPiAzP
         buxvsrpXPRnxJj5aJyirZvsyxMTZtp5RP/j8zs610VJ3A94a+Rwkxy0v/XyA4YZ3iiQO
         ZOt0VXtT4M9xTVv1nEdaGQDHl9TbHz3q2WK1zdVuSyu58AK4za5bn90vwpCX1Bb/FBzZ
         q4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKMjTc/Up+USv+T+Pd2T8SvnMOusH2FM1eqdBnOU/8k=;
        b=KUdHo/zJUGISw76nVRV0f/cuB14OPyy5y3QEpLOr/f6e4bxKMFVgUBq6/DB68aiha6
         lXfAaAXoi7ZTq+/zwUcGFGCrsc5hNSlL2+Lmkt3Dasu7qzdhN9Z59fjxWlpFAf38YHKm
         fcbifnvsoKQpxAjY/Fj/QDeY7KRYOqH+eU3RkbD7Hgk1E/XmtazjBWtpNfMrzFHaak8f
         w0agX0acQOeP5LuM4PpDCN6jep3g74vZHIPMXhXfrxAoEDzUtI+lxuS5Gn60deQMpCZm
         eq9cuZg8XHJQzWyjiRYjKVNP95phv2MV5dcZ82OF4DK/Ho9w9P0M1zxvxEFLzoCPQQLS
         67+Q==
X-Gm-Message-State: AFqh2kqU0d3Ky3dTdfNBA/FsORVvKzkDKV46OD8CtgGZx0NHLW3P6jP3
        BPVxk/lBZ7aR4HhT3J+vfhI=
X-Google-Smtp-Source: AMrXdXsv9x9J5QP72CNlakNE289hjKTEBIMGWyc1MxTIfMBfrs8ODm0ZKgHnWg4VvsaoJhwhCNzQKQ==
X-Received: by 2002:a17:903:230a:b0:189:d3d9:9308 with SMTP id d10-20020a170903230a00b00189d3d99308mr24654394plh.34.1672017539524;
        Sun, 25 Dec 2022 17:18:59 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902f35100b00186b04776b0sm5902335ple.118.2022.12.25.17.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 17:18:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 5/6] tests: don't lose "git" exit codes in "! ( git
 ... | grep )"
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
        <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
        <patch-v4-5.6-9596702978e-20221219T101240Z-avarab@gmail.com>
Date:   Mon, 26 Dec 2022 10:18:58 +0900
In-Reply-To: <patch-v4-5.6-9596702978e-20221219T101240Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 19 Dec
 2022 11:19:28
        +0100")
Message-ID: <xmqqr0wnm071.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change tests that would lose the "git" exit code via a negation
> pattern to:

Looking good.  thanks.
