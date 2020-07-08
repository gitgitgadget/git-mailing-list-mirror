Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA5BC433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 01:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0C320708
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 01:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="ZpIA8vpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgGHBUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 21:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbgGHBUt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 21:20:49 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A08DC08C5DC
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 18:20:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id z5so20848611pgb.6
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 18:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=U84+UIw1H+E2+EUmKS3hbAn53A/a7GBVMP7hg5+3Q+g=;
        b=ZpIA8vpnHTW3p1rM/IgaKEaBDZr4RRAc7p9ftaX2tJG0zKOTX9t0Rg6dAkDV06koIZ
         MvBz/0qtvQvKkPvoQtohPnQhxlM7VwbXWOtoB2oCKqASAK966RZjHHxuKpMRStOt+Y9N
         rgf2JuP1jpBJw+aX4oCrqkn1Ce1S7AkRTwC40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=U84+UIw1H+E2+EUmKS3hbAn53A/a7GBVMP7hg5+3Q+g=;
        b=M4+FkYea2RtZwFwDQ7ZaOje0+BZCVZaGSGQ1Xxr03YhJTgR8kng0JJwk7F5ApQBy3x
         w1kN0Q3RhWRtnpYJdHc+YciZbzgleYrWXBYlGMU4lzGH2i2RGIJGwPg6jmXCxmWkUtto
         QHEggymBjoDAz7z/EFb7y7H93qMh6yCZX4CP/mGG1MT5e5qTroQ+ZbFSTBZCWV9UP8QE
         pVFjB5s7rtO+xlPc1kXMIxPDj6ewm03S+K/ohoRyP4Am9cfIXUX4eXQmIzHtE4IykIW8
         lBxfeqGfOr6abWEKkxjFSi+8pXmjDnpX0LqrpnitCek5VClOE792e712HOWRR5K3NXwp
         TzDg==
X-Gm-Message-State: AOAM530u90sTsxcqp4ofaYkHQQ1P4TRqWEwwOseVCZPO7wkstCql/W8s
        YNqgbIwUiLo4qbkqDIq5cRls0FlicYXVUnJH4Qwp0CahNMF8d084D6p+lSkESwGANiMmSlcafYS
        0p273HNrwiWKDcEX4fYSRzHg5S7WkBY0vcEkOVOnaRJ2fqZ/cYW4Ghw5UjQ==
X-Google-Smtp-Source: ABdhPJxhU+4F6mpKEItUy4vKT2Na6JBLKLIC6HIcZ+7jJvkQSbRRfBcaWut25abif2vY5i7lNPR1qg==
X-Received: by 2002:a62:5c03:: with SMTP id q3mr51494966pfb.58.1594171247449;
        Tue, 07 Jul 2020 18:20:47 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id z8sm2244230pgz.7.2020.07.07.18.20.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 18:20:46 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
References: <pull.781.v8.git.git.1593825400699.gitgitgadget@gmail.com>  <pull.781.v9.git.git.1594002423685.gitgitgadget@gmail.com>      <xmqqzh8c8eda.fsf@gitster.c.googlers.com>       <31ab701d65428$b7ca6cd0$275f4670$@zoom.us> <xmqqmu4b5l8l.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmu4b5l8l.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH v9] Support auto-merge for meld to follow the vim-diff behavior
Date:   Wed, 8 Jul 2020 09:20:40 +0800
Message-ID: <04e201d654c6$016bfb40$0443f1c0$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL0yMj140bttmss0MgcyFqN96deswLuUIqGAi/Ktd8BxoWcLQGsJAXcpntt0IA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> You cannot interpret an empty output from "git config =
section.variable"; it could be "[section] variable" (which is true), or =
it could be a sign that there is no "[section] variable =3D value" in =
the configuration (which you treat as false)

Yes, I notice that both "[section] variable " and "[section] variable =
=3D " output empty string but have reverse Boolean value.

> Catching common spellings of 'true' and 'false' in the output of the =
string version of "git config", while checking for 'auto' at the same =
time, may not be too bad as an optimization to save an extra call to =
"git config --bool 2>/dev/null" (and ignoring errors)...

With preview point, ` git config --bool ...` would better than "not be =
too bad"  : )

With the return code and return string from ` git config --bool ...`,=20
follow pseudo-code maybe good for current situation.
if meld_use_auto_merge_option =3D` git config --bool ...`
then
	# success, maybe "(empty)"/true/false
	if test -z "$ meld_use_auto_merge_option"
	then
		meld_use_auto_merge_option=3Dfalse
	fi
else
	# failed, the option is not empty or Boolean
	if test "auto" =3D ` git config `
	then
		# detect the "--auto-merge" option
	else
		meld_use_auto_merge_option=3Dfalse
	fi
fi

Changes will upload with the [PATCH v12].
I'll update to you when the patch is ready.=20

Regards
Lin

