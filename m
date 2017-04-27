Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D260207BD
	for <e@80x24.org>; Thu, 27 Apr 2017 00:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbdD0Adh (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 20:33:37 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33202 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdD0Adg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 20:33:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id c198so4028115pfc.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 17:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qGQK2B4nEtZuW8ZbS7cNJpehAEabZw95OA+VvkFjZeQ=;
        b=C7k8Ztk1z6cJtXYQqlbe+haGs66/dISbeVvrT+DBvvs4RCS2HXfQUKC9DB1hJy8IiL
         DhRifOnav0s91pHw9V3bfFdG5vPEH8wf5irdL6a4NO/ttXq9Q5Gfhyc0pKoieAJefdu1
         IVXYkfSHok7aG1obqtj0oGxj4xrxSMwTwOF9BUjm/QTC8eg51tLHpr4egfJN1gcPU6q6
         D7ZGn/4rc/Xi1VjzY9icn/I3afI8lJtbnR5OGisz1QIGrlR4G+ZWgZy2zaQwA8hhOZHd
         JJ6+FP+G9JsIC5KV8K4czex2Hf2pn0aHA00eu5iKerTdVRZGQlaPbUaBAtKKo8Muujxl
         If4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qGQK2B4nEtZuW8ZbS7cNJpehAEabZw95OA+VvkFjZeQ=;
        b=sswr2GjUGLtKst0uJv4Kra3pqJt6gdXcg71F2dZ3bMPdRFkQIEHeVg/9V0yGPFbB5c
         Ls8fj3jz34lWK+2E58dWD8aRBE7IpqMLLN11kf8I7yYkElHXp9lFldUK8+EcEW416vUU
         Wmk1EIYzL8t+7lt4nsSKHP1dcaIlHV333GtKZcXktVEnOgEUc3e3L1sutSKdFKQw+c/Z
         JjhBN3dtS0g2+s5Su3FIn597jL7w2bZ8HqzHfocP/r7lyJBYcVZjD/6vfin3QkDbr7IX
         gmLpioCe70R5kRsXupZyPjlKlO+1+MoXJk72Lz5LHB8c5uCXwCvEJvscDIo1lGJZ73SX
         2lKA==
X-Gm-Message-State: AN3rC/4t+Sgna5Px2fLMCe9F7nWb1/UakXmiMuiU81Wb3l49k9RJ1Ag4
        kYe3Vm3JNbnvuA==
X-Received: by 10.98.199.18 with SMTP id w18mr2770467pfg.209.1493253215745;
        Wed, 26 Apr 2017 17:33:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id d76sm716811pfj.68.2017.04.26.17.33.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 17:33:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, j6t@kdbg.org, sbeller@google.com, e@80x24.org,
        jrnieder@gmail.com, peff@peff.net
Subject: Re: [PATCH v9 2/2] run-command: restrict PATH search to executable files
References: <xmqqzif4t01f.fsf@gitster.mtv.corp.google.com>
        <20170426171017.82737-1-bmwill@google.com>
Date:   Wed, 26 Apr 2017 17:33:34 -0700
In-Reply-To: <20170426171017.82737-1-bmwill@google.com> (Brandon Williams's
        message of "Wed, 26 Apr 2017 10:10:17 -0700")
Message-ID: <xmqqefwer8o1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> This [2/2] patch has the exact same diff as v8, the only difference is to the
> commit message per Junio's request to add an explanation for why this
> particular behavior is desirable (because it matches what execvp() does).
>
> I didn't resend out [1/2] of this fixup because it is identical to the v8
> version.

Thanks.  It is already explained well in the in-code comment, but it
is good to help "git log" readers with this information.

Will queue.
