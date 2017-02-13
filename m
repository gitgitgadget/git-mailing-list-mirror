Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E14D71FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 23:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbdBMXSG (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 18:18:06 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36171 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdBMXSF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 18:18:05 -0500
Received: by mail-oi0-f67.google.com with SMTP id u143so1094974oif.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 15:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bnCu+xYfWoorfMMoJriCOuefCnuEbDQJpKVXscHc2DI=;
        b=jNmlfdprGGX2A2NdC61KWKaF6OtCwbyj5beLL4VtIFKEcuPLEO/jv/CGk0+LEmZ0lW
         FTtHr+3963js+wOTk8FaBN1EKa+dF+lS/iQ0oldQ9eKm4ilCBZG+1rjvHjvhgPCz0Wit
         R7v5mB+5jbuboO/yZrstn29nGps9zr3GcFSCZBh828prRJ7hgwoMCZXazSjLPokg9b0R
         1fsR7hQm45gaXrWhQ9zPE5r40YXmlig8QiyEMc4STbQNpHqXE2nMn8lECXEBBULxUNPg
         xFSD6U4spbdt4j5M/c7sfZTaeBljAtblE8nrKkcnfPU/heuBBScRVp0tczSpDovkAPmo
         RMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bnCu+xYfWoorfMMoJriCOuefCnuEbDQJpKVXscHc2DI=;
        b=BCChEfoP1ZbrgkrM94FlFt2cHFM8zMgVrl0BWzNs8ZEjfVyiDmEwAknSOWIX2amkCu
         vv/hCRAq3cmaIjPPEJ6BX8nW08QIRkxLncWqkRmBNp0xOGuSqN5rk0KB9z8Fm8Nu9pZb
         v5YJ0jADvF4KMUR+5zb6mWrVoYWDgJOCoWGVKZaE4xXFeAssjLjB3XRsr/C/Hm0FQgow
         VrpFbLsQGOEalnbsg4so1241unHfxx7oW59KaoGcS0KJM9Y1YKWLmVw8OuCs9XsC+/eA
         gT3xprnE4Kwdk9t0PS97ln8AuXST+d1hUian0VLFDgsntapzGhA2g/7PRT0TTEY854yq
         kwWQ==
X-Gm-Message-State: AMke39n4aun0k15Ibo6HOSHfa6ckv1dl2MWw2kiMunBpLFkag/5xR3wNUbQC58crsEOJqQ==
X-Received: by 10.84.229.143 with SMTP id c15mr32830455plk.177.1487027884829;
        Mon, 13 Feb 2017 15:18:04 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id o12sm22862439pfg.15.2017.02.13.15.18.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 15:18:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 9/9] read_loose_refs(): read refs using resolve_ref_recursively()
References: <cover.1486724698.git.mhagger@alum.mit.edu>
        <d8e906d969700acbca8dc717673d0a9cdc910f62.1486724698.git.mhagger@alum.mit.edu>
        <xmqqbmu9lul6.fsf@gitster.mtv.corp.google.com>
        <ff0b0df6-9aed-9417-d9d4-1234d53f05c3@alum.mit.edu>
Date:   Mon, 13 Feb 2017 15:18:03 -0800
In-Reply-To: <ff0b0df6-9aed-9417-d9d4-1234d53f05c3@alum.mit.edu> (Michael
        Haggerty's message of "Mon, 13 Feb 2017 07:40:57 +0100")
Message-ID: <xmqqh93xbrys.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I pushed the fixed commit to branch `submodule-hash` in my fork [1]. If
> you'd like me to send it to the mailing list again, please let me know.

I was tempted to ask you to send it again, because fetching,
comparing and then cherry-picking is a lot more work than just
replacing one, but just to make sure my intuition about the
work required is correct, I did it anyway and yes, fetching,
comparing, cherry-picking and then amending the sign-off in was a
lot more work ;-)

So no need to resend.  Thanks.

