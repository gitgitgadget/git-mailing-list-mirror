Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B914AC6379F
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 19:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjAMT6I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 14:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjAMT5y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 14:57:54 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE4E892C7
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 11:57:53 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y1so24494188plb.2
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 11:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKM1PRefnFt4SBQg2HFDP6Eoksoc9qb1P5cMVu0UJ9w=;
        b=ffsDuc3BUuzx0uEnKcuA/uzYu+Wh44XS1tlhrbUqqxHCMDBVUdcngC1H/A1Gh2ZMeG
         IL5EQZ5TlmqFqDuMkCNEYVvyD6KVMsQmynPzrIkLdDu4cUnmJ5mO9GJqirs7hverMqtv
         qUnIKTaj5fwI8iSIex4y1Cm8BQdsssRdqmGHjz+KoFau0pa8OdHgXPGTeSksV1EKlKRM
         ZoAB82idQCZMgOLnpfX8ntP7vHVnWfPc8nA1cjlqafqkgdZy2K+36VoZivPagKmsy2cA
         rUkh3f/c7PPDSMV1OiMlP+3gb9k2vdiaQrHEyScI4F7mJvlEd5xZC8uIZ/gtNoWaELHF
         ZnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKM1PRefnFt4SBQg2HFDP6Eoksoc9qb1P5cMVu0UJ9w=;
        b=MV70ervbXxk2EBCyco0cbIECVTJRf3601mrrN5rK0FIGyLAMv3SpkU3ZPsdXLmBNuA
         OQtJB7pLkfOoyKgmBhVdSVyb+muw3Qc3sEsaKBG7jX8Xs8SIhx415F0IssaJneIa6cuh
         K7ow4kPBEOh9NMRkz0HVaQetR4x6ZY8T68QhjPyN3sthRemPwHxeZs+DT0WTGwtOsrda
         o3CTGwKGM0FPGIY4hVP5YqkC8PAEApf0FDxEgWaGj1tdYLhkvZWjCMNd8rXmjQpDZ7I7
         9w70mzUpqXfIE01moaeEVK++UhYzEdVH8fi+VemkoFtHU4pyIc6uA6k8GdPgwVLC91H4
         1TGA==
X-Gm-Message-State: AFqh2kr11yrDuTa46Y3UhJjnhfYqhqbSg1kUb3CMDfFdoUhI0TqBV/MH
        XpyEJXtZOYCxo6QqM2WsdnY=
X-Google-Smtp-Source: AMrXdXvH8xL7vbWR0PEP2Vn5L4AhzeQDnADocLjRxJ0BttNtZYU7IRi2q6y8cI+li6bGe6rJmEs79w==
X-Received: by 2002:a05:6a20:3b22:b0:b6:8317:219b with SMTP id c34-20020a056a203b2200b000b68317219bmr6699696pzh.8.1673639872659;
        Fri, 13 Jan 2023 11:57:52 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l7-20020a655607000000b00477bdc1d5d5sm12060253pgs.6.2023.01.13.11.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:57:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 13/19] builtin/merge.c: always free "struct strbuf msg"
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
        <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
        <patch-v3-13.19-6d99fdcc44e-20230110T054138Z-avarab@gmail.com>
        <71e7d424-b785-9f9e-8b09-955b56fa19b0@web.de>
Date:   Fri, 13 Jan 2023 11:57:51 -0800
In-Reply-To: <71e7d424-b785-9f9e-8b09-955b56fa19b0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 10 Jan 2023 19:52:27 +0100")
Message-ID: <xmqqcz7i2on4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 10.01.23 um 06:43 schrieb Ævar Arnfjörð Bjarmason:
>> Follow-up 465028e0e25 (merge: add missing strbuf_release(),
>> 2021-10-07) and address the "msg" memory leak in this block. We could
>> free "&msg" before the "goto done" here, but even better is to avoid
>> allocating it in the first place.
>
> So contrary to the subject we don't need to free it anymore.

;-)  I appreciate such careful reading.
