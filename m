Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D89C43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 02:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9597206DA
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 02:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhwaSqrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfLOC3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 21:29:18 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:37849 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfLOC3R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 21:29:17 -0500
Received: by mail-lj1-f170.google.com with SMTP id u17so2947563lja.4
        for <git@vger.kernel.org>; Sat, 14 Dec 2019 18:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xLK6XZ34eOIGkXDbkDdrrJ33CpKD5sUAxiODNRGK6OM=;
        b=WhwaSqrXi7j4A8XbivVYsuZpvJde2bZ3TUjfqFiJjDdToX3zvPvqwZGWUoBOIyg/Bx
         nmBElueJGsMuwDvSpq/Bpj02S5Ci+tYPTUhf+8P0fqJEI3AnSTjBiBybpYxeChqlnYMX
         TpyXpo1379dn4IyZFUYIyvfZcu/l7EGWa4L7f9YBHxl9npPoZ3GwzpkxflUCvaqZ2gbx
         ++2PcgaZ9HqPl0srlbwRLjeLl6wB5KN/jSrGiFyHPs49+UNPLbHX6kPceIgGr3+mENqY
         rqKQZ/t9aD58WDQKJviSiHsNhauGxcpgPT/GHxfc4cy/xMEcLPnp+gJlyRr4BkLafdoj
         TjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=xLK6XZ34eOIGkXDbkDdrrJ33CpKD5sUAxiODNRGK6OM=;
        b=AG98ZJeoZZEcuWm9vT44P5QIqmmMiwhVCTDI4BDv+eARWx7P59/yd5YFyCpOs8yAV4
         eWGZIRfIegvsUn9s9Eeo241SQtfBNvl6dZgjJ7/ujYPQcCNKxCISglO1TY1zc71OjFri
         Xuh3Q+g9YaIetLO9A00QHb0q11TF1qekJQ5p69IAEfU0Hy2Ct4B1EkZbynoCNNpgbADc
         e5IwwHhyGyH2MX6k3V7uhNETGQE/3bBHgpmnltXCL+J+iapeaN40W0eCFEcIVKV4EtHX
         Rm/tac4Xzdv2Yv1gNMEafgbCw9I5dS93tM0MMERlnhtfvpbZOzxONPpzlURg4j9nBEoY
         3TMQ==
X-Gm-Message-State: APjAAAXTFC5yg5E5UYrT03g7cvLMm+V6YltV5rlLHRNvomW2/GYG5dvn
        65gA6UFrLU8CR2UZ4q0f5/Q=
X-Google-Smtp-Source: APXvYqzR07h6K72+6vW7NJgSMXSUBkJYo6YkjYBxDoXFYoJPUy8h1SXKTpEAJOMZ8RDeholKkA+f1w==
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr14750793ljk.15.1576376955259;
        Sat, 14 Dec 2019 18:29:15 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id e21sm7428800lfc.63.2019.12.14.18.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Dec 2019 18:29:14 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, KOLANICH <kolan_n@mail.ru>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: Re: Could /Documentation/technical/commit-graph.txt be relicensed under a permissive license?
References: <E2770343-BB39-458C-835E-04F0753783C3@mail.ru>
        <xmqqimmoq6vw.fsf@gitster-ct.c.googlers.com>
        <70575b23-6adb-a29b-8df8-f9099f86eb0e@gmail.com>
Date:   Sun, 15 Dec 2019 03:29:11 +0100
In-Reply-To: <70575b23-6adb-a29b-8df8-f9099f86eb0e@gmail.com> (Derrick
        Stolee's message of "Tue, 10 Dec 2019 15:38:35 -0500")
Message-ID: <86y2ve48zs.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 12/10/2019 3:10 PM, Junio C Hamano wrote:
>> KOLANICH <kolan_n@mail.ru> writes:
[...]
>>> ... the license of git itself is GPL, so I am not
>>> allowed to use these 2 files to create an own permissive-licensed
>>> tool reading this file.=20
>>=20
>> It is a wrong conclusion, isn't it?
>>=20
>> GPL copyright protects the expression of the document, but the
>> copyright protects only the expression, and does not protect the
>> underlying format itself and the idea behind it.  So I do not see a
>> need to relicense the documentation text at all.
>
> (Insert "I am not a lawyer" warning.)
>
> I think this is the correct interpretation. One can interact with
> binary files as you want. In fact, there are likely privately
> licensed products that interact with Git's pack-files even though
> their format documentation is under GPL.
>
> What _could_ be problematic is repeating the documentation directly
> in another permissive-licensed repository.

Sidenote: I wonder if JGit, which is permissively-licensed (EDL,
i.e. new-style BSD) pure-Java implementation of Git, makes use of commit
graph.

I remember that pack bitmaps came to Git from JGit, where that feature
was first implemented.

Best,
--
Jakub Nar=C4=99bski
