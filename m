Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 015F01F516
	for <e@80x24.org>; Mon, 25 Jun 2018 17:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934693AbeFYRdz (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 13:33:55 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:42937 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934051AbeFYRdy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 13:33:54 -0400
Received: by mail-wr0-f178.google.com with SMTP id w10-v6so14510839wrk.9
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6PBb2KLo18t9GgUk6MpKBU3skdqsf/fNMpSPVwCjaCg=;
        b=ZhU21SSZzz7BRj8QvEdKMJP8UNe+25yLtto4jbXCDxOB8F/oSkD4NKaf5WUSXBuhTX
         /qauEgNKJEmYwzEca2F1Ko5RrvgKxIWjJn4I6kLc7qui7S+OR6Vh0QgMp9M4pzNyzJun
         LKpTyTM1qKNzxMinIdM92QG+0iYVGFB8oTCx65jg6yazH/WJTenr+4Y04wAYtBuC5FP6
         EiL0aj9xvDKrGx+C6ngDgcY+JbVvbQKlRXaiwnAS9lX3FEJiam+zt0iP9qS59IEZQR3+
         k6EWE5Coe96FMF/Xhwpuav/yNOgcHmUTXN7yEe5GAEcxVnHncaED+Mam9KQHHlAS4SV9
         ALOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6PBb2KLo18t9GgUk6MpKBU3skdqsf/fNMpSPVwCjaCg=;
        b=HlbShc30fah0KhHTBLtwtmFGK+t1rP/ju67qqiDDnzWQQVkeJNqSqeqOIjkCyehhoO
         hyLczRpyn+wSpu1kgdhyEelJtzRnqVAjMOCCVUOC4lG91W0G7BIgh31pgelVcTvMJMlI
         0XDBNkC7OsATrPd9pbEMWRsBPLD3OEuJ59ttqJX81U1KR4LP3MAkqXeoimGTQKL9YvDn
         vLNAhsZTiqqJgAbCAnD52TXVfC6611VZdDYOKY7WO40fiBzOF3o6Bng6iHmWGGrMdrU0
         BO5uWQuKPcs6a2y07S4QMowEjNtShgoNoHJ9CMuS4kpjB5I5p6v4m6PbAVXafLMRPmm0
         xPpA==
X-Gm-Message-State: APt69E3m7OIs5/zwI0vUn0F95mgZu61XDoqrp2xQt2aZ5EDbaY9zr/k8
        Jc9cJ5D17MPvo2n4LdqzOUpd0cG/
X-Google-Smtp-Source: AAOMgpcWn8T8pe62Dp4NXk6WLQqJ3zCPfoRDuzdBwWY1CLdBGT7c29O3tf92nImXvsPIlPZzyYlLLQ==
X-Received: by 2002:adf:a6ec:: with SMTP id t99-v6mr10854656wrc.51.1529948032724;
        Mon, 25 Jun 2018 10:33:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r2-v6sm14890865wrq.55.2018.06.25.10.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 10:33:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tiago Botelho <tiagonbotelho@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, haraldnordgren@gmail.com,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list --bisect
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com>
Date:   Mon, 25 Jun 2018 10:33:51 -0700
In-Reply-To: <20180622123945.68852-1-tiagonbotelho@hotmail.com> (Tiago
        Botelho's message of "Fri, 22 Jun 2018 13:39:45 +0100")
Message-ID: <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tiago Botelho <tiagonbotelho@gmail.com> writes:

> +test_expect_success "--bisect-all --first-parent" '
> +cat >expect1 <<EOF &&
> +$(git rev-parse CC) (dist=2)
> +$(git rev-parse EX) (dist=1)
> +$(git rev-parse D) (dist=1)
> +$(git rev-parse FX) (dist=0)
> +EOF
> +
> +cat >expect2 <<EOF &&
> +$(git rev-parse CC) (dist=2)
> +$(git rev-parse D) (dist=1)
> +$(git rev-parse EX) (dist=1)
> +$(git rev-parse FX) (dist=0)
> +EOF
> +
> +git rev-list --bisect-all --first-parent FX ^A >actual &&
> +  ( test_cmp expect1 actual || test_cmp expect2 actual )
> +'

I hate to say this, but the above looks like a typical
unmaintainable mess.

What happens when you or somebody else later needs to update the
graph to be tested to add one more commit (or even more)?  Would it
be enough to add another "rev-parse" plus "dist=X" line in both
expects?  Or do we see a trap for combinatorial explosion that
requires us to add new expect$N?




