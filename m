Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F209202DD
	for <e@80x24.org>; Thu, 13 Jul 2017 00:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbdGMAyD (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 20:54:03 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32912 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdGMAyB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 20:54:01 -0400
Received: by mail-pf0-f178.google.com with SMTP id e7so20886449pfk.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 17:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=w/+8t5jnOPLjQqXLDP87HhFERGYYmRn1/hWdArwImgw=;
        b=KzAnG2S0c8MR/XlsPLGXAryXaKzx6LdI59wxsjy/jlA8MG/JUUP6GK0B1j54pQbm6s
         FvSCNS2mt0t0BF9Vxn1wxhnDDYtSIGul2eFtsHt1fb8syu7vzhxbD88I6vkSXAIRn6Vl
         7yX4fWcTn+jDx0DUs/hYFGZkzLDQCo4YutKQ4AnicC+BK/iPXOANpvinTCy1Ev5zpTT+
         DadrpgTWGLWsM6kZggQd+sbho884PQkuXFsiH+aa9quHDWniYSNOYI1/r/biWDBLMfcj
         F4i0njJ7MQuPlI4N26BJjEKrQ9yyJqFuequrZjxNAKVMjpU9bfoLKuoYevZaunasu/w+
         bUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=w/+8t5jnOPLjQqXLDP87HhFERGYYmRn1/hWdArwImgw=;
        b=tvolfyC8Mq0l0kfpBbG6JLytiWw7fk2ahaqlhMMdAoaRW+kBh75cm3a5i2KBBPPFG+
         2s7STkma6tVfvJCIZzKRxLK2MeOmBSOjrFBu/OhRu+HnNcQ6JovkaRKRJoH3Xs/E2f8F
         EuAmChG6SN9vuj6EGwkmfLTHCiPg33zL/M0SRcoXOj2xWTmAlMwdt+KtdGvq61/LCoqa
         DpNHoCgCHsjuujpWX4zQUYDXerFtEzgDnKC7y+4n19OTus8/50hWItxy5zm05oNAxqek
         B6seMn3eMKnURtWW+UbitJjSPwp3GrLIDYzTRpRW+2aDXyn7mzZxLAnAsnPf5NcgzaUN
         ipYA==
X-Gm-Message-State: AIVw113s/nhKRFZam5JU68maln1675bhbye/52nNxr2f0xwklQxxnhyT
        2ngfzh6iOeOJ1g==
X-Received: by 10.84.169.3 with SMTP id g3mr7079503plb.136.1499907241000;
        Wed, 12 Jul 2017 17:54:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8c0d:cddc:dbb9:7a95])
        by smtp.gmail.com with ESMTPSA id d89sm9761824pfl.7.2017.07.12.17.54.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 17:54:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] submodule: use cheaper check for submodule pushes
References: <20170712234504.15811-1-sbeller@google.com>
        <20170713000117.GJ93855@aiede.mtv.corp.google.com>
Date:   Wed, 12 Jul 2017 17:53:59 -0700
In-Reply-To: <20170713000117.GJ93855@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 12 Jul 2017 17:01:17 -0700")
Message-ID: <xmqq60exyx5k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> In the function push_submodule[1] we use add_submodule_odb[2] to determine
>> if a submodule has been populated. However the function does not work with
>> the submodules objects that are added, instead a new child process is used
>> to perform the actual push in the submodule.
>>
>> Use is_submodule_populated[3] that is cheaper to guard from unpopulated
>> submodules.
>>
>> [1] 'push_submodule' was added in eb21c732d6 (push: teach
>>     --recurse-submodules the on-demand option, 2012-03-29)
>> [2] 'add_submodule_odb' was introduced in 752c0c2492 (Add the
>>     --submodule option to the diff option family, 2009-10-19)
>> [3] 'is_submodule_populated' was added in 5688c28d81 (submodules:
>>     add helper to determine if a submodule is populated, 2016-12-16)
>
> These footnotes don't answer the question that I really have: why did
> this use add_submodule_odb in the first place?
>
> E.g. did the ref iteration code require access to the object store
> previously and stop requiring it later?

Yes, the most important question is if it is safe to lose the access
to the object store of the submodule.  It is an endgame we should
aim for to get rid of add_submodule_odb(), but does the rest of this
codepath not require objects in the submodule at all or do we still
need to change something to make it so?
