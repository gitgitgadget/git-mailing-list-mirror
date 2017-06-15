Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D56A620401
	for <e@80x24.org>; Thu, 15 Jun 2017 20:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751798AbdFOUwY (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 16:52:24 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33546 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbdFOUwX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 16:52:23 -0400
Received: by mail-pf0-f196.google.com with SMTP id w12so2919003pfk.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9aza5tzQ7JbIDhD2VpTDCDSrtx7ZE5hqKtwLwpK+cs4=;
        b=cPYV61ez8SGCwBTnYrEBn6fI8dpHmOlV2fMTMDiELWp5j2o/qWk/g0RBsG8mL+fNcE
         1o19Or52/llicduv0TDaOOk7SA/y+owOWEHcJX3OmitQUYlDwphruSSa8JhdP572fsSE
         PHURtisiCtLMy6zTnPebjFngfQC/11dW5aHkec4ljMOOQYApp+edTsfkBo78YBhbrmDu
         lWHsH3P5l1O6L7Ztvz48BowYbNC6YKQaKzoAx8W9cdK9PeMZfQhTPWBAC71QZBIPc6kJ
         h0bqaDOdKeY3zq00OfHotT7V/yid+gLiLv6+hgdmMnLi4lswZFDV6RoONp7DLXSEGJxK
         fs4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9aza5tzQ7JbIDhD2VpTDCDSrtx7ZE5hqKtwLwpK+cs4=;
        b=Jf9jAknwSv02Lo7a5lS6RIPVRxfUhv3GZ8642wIHrs1XSiqSjao7+nrAwb08hQoOLK
         hJjMdd5K2pm0vdhPfd+R1nw6VQU+xkRqU3ka8T3ETIG+UO4qVBk0oYz6p1VVjXmasccu
         Sd+XfNyq23XDyLsReoPHB0Xb6hWlQk1wTOaD/7/mMpa45l85647HCeSZlp5o6evLdJ5a
         2CGN04ZK3763oKay+34d+/p7ZjFAPEflbw4mRO5ssuAPb6B71u+/QyEJIxqkDS/3qdlO
         JmpbpDHM29RaNWenvHdgDrgxEiEk+HlJJAHYbABKnaxhvMkgL67llw0ePPy3qp3iPV40
         hiGA==
X-Gm-Message-State: AKS2vOxHLRGXA1R/ybLILJs76330CiNk2RxWuNwst/ci969wUjkpUHdV
        9lEeInxWo6rBuA==
X-Received: by 10.99.97.146 with SMTP id v140mr2648445pgb.62.1497559942902;
        Thu, 15 Jun 2017 13:52:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id v186sm308188pgd.9.2017.06.15.13.52.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 13:52:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 4/4] sha1_file, fsck: add missing blob support
References: <cover.1497387713.git.jonathantanmy@google.com>
        <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497387713.git.jonathantanmy@google.com>
        <aa3904dbe16050188a6b70a209bfcbfa86ea3213.1497387714.git.jonathantanmy@google.com>
        <xmqqy3st14my.fsf@gitster.mtv.corp.google.com>
        <20170615133100.55561be6@twelve2.svl.corp.google.com>
Date:   Thu, 15 Jun 2017 13:52:21 -0700
In-Reply-To: <20170615133100.55561be6@twelve2.svl.corp.google.com> (Jonathan
        Tan's message of "Thu, 15 Jun 2017 13:31:00 -0700")
Message-ID: <xmqq4lvh0y9m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> There is indeed no reason why we need to keep multiple ones separate for
> an extended period of time - my thinking was to let fetch/clone be fast
> by not needing to scan through the entire existing manifest (in order to
> create the new one),  letting GC take care of consolidating them ...

Given that fetch/clone already incur network cost and the users
expect to wait for them to finish, I wouldn't have made such a
trade-off.

>> > +int has_missing_blob(const unsigned char *sha1, unsigned long *size)
>> > +{
>> 
>> This function that answers "is it expected to be missing?" is
>> confusingly named.  Is it missing, or does it exist?
>
> Renamed to in_missing_blob_manifest().

Either that, or "is_known_to_be_missing()", would be OK.

Thanks.
