Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37128C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 23:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFCD613AD
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 23:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhFAXV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 19:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbhFAXV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 19:21:28 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E88EC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 16:19:45 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id d21so949141oic.11
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 16:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=kdO2raQ0a+ET9pzmkQV8elpTLvfnNClJT4yqmWXgWOM=;
        b=Dw3vF/hBBU0jIGDXSininiCmGyj8ljQ/SiaSg+BOkU15vmVnMC9HRy0R20HSyl0sEK
         zYTe4MGQFnUNChcc3AuwQbvOHYQewmAmBTBVu4b4b7Ifk0LG1xdqCuVUyF1UMHKWe2fh
         1M7iuq1PYLKMTfWzn1f4G9CbPbxnH6Ay+bRS7KcOjpoGQ2h/taTiWoqjKTegfsFYfFi1
         TL4Pmzn5bmXdlnr6RQgoGKYslZrxABdN9P7r6OcsXX79yZn1DKzSTMmRKhSNZtdJdSER
         qlON7ZwE5IROYxNfr9LQChS77Ysw70d4odRwnw4TzVyxzu/JNEVoQk17/bZs5XC0gKTP
         EVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=kdO2raQ0a+ET9pzmkQV8elpTLvfnNClJT4yqmWXgWOM=;
        b=cHgdv4SZ95mxrXaFI+74IIdZ14o4ATQ/SnxSAVBTq5wGY+MrEtlSxEAsYgOq2M+tCO
         xrJG3utJVUENbDBX43C4PW98D9hwdjfXnXNjVXpWU3RUCmrRwNA4iC2dmQpxwKaVULJt
         n8ulcY9GsUs7evW05O+NgFJhlWfNayXi4qFR0UJNBdW3bcYixkuBnCL9nSkXa0mpFJZ5
         G9JVHpBSUgsjLb+hDQzx50ojm+xWVw5G5VEaQ6s+y5uIpxGlmmjogzLh3NLf/FRWFxBT
         7nDFjgIMFOyX+3poASgERnVNUVht/O4Ou9Q5WGAmMSg/SHUpWlgQARL9BTin9a8LICoX
         XepQ==
X-Gm-Message-State: AOAM530snqK0mL6/ue8Yxl7gFYwnAu4RDWi3PNxshMi0b9dOtyspQNtD
        13CUDV8XeoPHBAAnGDczu1gNZcHYKj3t8w==
X-Google-Smtp-Source: ABdhPJxEQznk2jf2+Yl85rMEJWqL2yN0fV+vTnB5kWon/S5TUC5F2Dv9197zbvlX4D9tWMPnx1EsWw==
X-Received: by 2002:aca:4343:: with SMTP id q64mr19751647oia.33.1622589584930;
        Tue, 01 Jun 2021 16:19:44 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id u14sm3764745oif.41.2021.06.01.16.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 16:19:44 -0700 (PDT)
Date:   Tue, 01 Jun 2021 18:19:43 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60b6c08f75c1c_40442086d@natae.notmuch>
In-Reply-To: <87wnrd6wqj.fsf@osv.gnss.ru>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <87wnrd6wqj.fsf@osv.gnss.ru>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

> > These are the configurations I've chosen:
> >
> >   [merge]
> >     conflictstyle = diff3
> >   [sendemail]
> >     smtpserver = /usr/bin/msmtp
> >
> 
> [pull]
> 	rebase = merges

Can you do `git pull --rebase=merges` for a while?

> [push]
> 	default = simple

This is the default, you don't need it.

> [rerere]
> 	enabled = true
> 	autoupdate = true

We are seeing a pattern here.

> [diff]
> 	algorithm = patience

Does this make a lot of difference?

> [merge]
>         conflictStyle = diff3

Same here.

-- 
Felipe Contreras
