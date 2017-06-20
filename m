Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C303720D0C
	for <e@80x24.org>; Tue, 20 Jun 2017 20:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751144AbdFTUJJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 16:09:09 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36778 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdFTUJI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 16:09:08 -0400
Received: by mail-pf0-f174.google.com with SMTP id x63so74152961pff.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 13:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2rYh6e0biPEmv+EYQMLA8nGBCim06dbAEyfUhN9XQOI=;
        b=JltCKtifFyvbU+XV1A+ZoMh/rUm3XMUlNs50uXkPBSu9UGNu4vPwi9SS/IvSI35F7N
         a1Ra9nAT/a9vh0YgrFWbMhbpBc4mflTugRMTHgVTFYYe24jnuBvm/+YnBXfISq7HSZrD
         rRS1Bh64yIYJ5pRKoHs6+Ury8ALFKeY5nZ5FkUPKqun51TR7zgD72dKOOfiNix/SjAkp
         uAYaE9BjR1h7xdtGLaoNVrPBtzG+hwgaN3+x0oxKdQfCVJPD03s3VkUJWRZytxH9hUx6
         DmpY7CZ0pactZKL6YkIZIxEAmkwEYIV94hsS0penbJC2jkTqZ9LTZz67wXN7/H2kvxDV
         oBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2rYh6e0biPEmv+EYQMLA8nGBCim06dbAEyfUhN9XQOI=;
        b=KBEOl2K23yuhqRFEORFpfqATMZ8hg9rCYzh6wC6YGdwRPgC4w6viBDLtj1D6k+qIHA
         G/MOr1AyK1btyWfZ3RxejZfc1nPiR8rVj+c8hbIPBvwa1dyMC0dW7cucEMQz73v0tkzM
         CAlras1Q71/vfn4mV74ySaFBoAs/j+1pu/3f3WFTg7+jIO1Xrm4vOeHOBHXv1LDMBa3Q
         8Noj4RJXhbtLUEJu3UzefZjLcK3qpOLFN22CoMPZBX0IZ/Fevuq8I2Q9uZkKq+DFymZK
         VjfQWm58dbuZgZUNbTTdZeZlyD+XpQ7QIsKZqlkZARpzgo6A6/+ZBx5MYcBUdv4Li7PR
         q36w==
X-Gm-Message-State: AKS2vOyjheKujL3Iqk7kG9TR07l1Q74ERVGE/omPwjw50PlD03AsU7kd
        m6KfCYumOH8egC7R
X-Received: by 10.98.75.79 with SMTP id y76mr32100747pfa.39.1497989347608;
        Tue, 20 Jun 2017 13:09:07 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:6c40:b92c:899d:9917])
        by smtp.gmail.com with ESMTPSA id p90sm23830002pfj.8.2017.06.20.13.09.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 13:09:07 -0700 (PDT)
Date:   Tue, 20 Jun 2017 13:09:03 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, mhagger@alum.mit.edu, peff@peff.net,
        philipoakley@iee.org
Subject: Re: [PATCH 15/26] submodule.c: migrate diff output to use
 emit_diff_symbol
Message-ID: <20170620130903.36b1e696@twelve2.svl.corp.google.com>
In-Reply-To: <20170620024816.20021-16-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-16-sbeller@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 19 Jun 2017 19:48:05 -0700
Stefan Beller <sbeller@google.com> wrote:

> As the submodule process is no longer attached to the same stdout as
> the superprojects process, we need to pass coloring explicitly.

I found this confusing - what difference does the stdout make? If they
were the same stdout, one process could set a color for the other
process to follow, but it wouldn't be able to affect color changes
inside the output, right?

> Remove the colors from the function signatures, as all the coloring
> decisions will be made either inside the child process or the final
> emit_diff_symbol.

This seems to be of the same pattern as the others. I would write this
as:

    Create diff_emit_submodule_.* functions that make its own coloring
    decisions and migrate submodule.c to use them. This centralizes
    diff output, including coloring information, in one file.

or something like that.
