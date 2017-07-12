Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664292035A
	for <e@80x24.org>; Wed, 12 Jul 2017 00:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755735AbdGLAFA (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 20:05:00 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34518 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755627AbdGLAFA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 20:05:00 -0400
Received: by mail-pg0-f51.google.com with SMTP id t186so3766874pgb.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 17:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WqUusuB/9Qa8UnZylcDF8UWfNFNwNsgSc5dkccx6M8Q=;
        b=ExQ5SO5uWBUt/DXBRN3NMbz6UgF/DZiGWuy3spDQC6s5dZ3wiuQDutvUr8hbFF2Z6p
         ZE8lF5onXS1B3cd+F0C6Uf1829aQqIb58DkXJkUaUJ2yR4GnyGjYfYR51CrKJVZrd3V0
         +/BHVQjadw06eHrH1J/Wf6odJbcOQIygeZRsLFk3uFYS063TjYT8UzrapdGTzN0+V34u
         5mUCOmEHhIHPRdXU446oQBL6cspzUwAp6O6K6e11QgXN12Phu7xBD/yXktTdY/NfCuO7
         gc7CRONl4STSarQ7Ue2hyCvzeKn8f6ekwM/EDiqqxLuPUmNaopPti6ol6Mc8pSEGW+U8
         a3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WqUusuB/9Qa8UnZylcDF8UWfNFNwNsgSc5dkccx6M8Q=;
        b=ub5G67ckVWf0hrkuOmaEmrwyreEGv//EZXuYWANDkkFOtvbNHbUjB0N/be+M4AkadC
         R8W5b5vIlXLIttgyhMij1Lzwun7ksPS9r9PH11Q6wb5LRsorIzjIodhCXgDnNzBaDwAR
         Dh0wz3nNapS+jNmj8mtCVzdguCHc6R9lKRTBddi2cipRIxbSpor3WXheuUhrUfNuTeRM
         Df2wvcstPffCD2U/d5DcTq5WiiokjfdNLHOUsqWzKsxqGx450lMbKe3otURuRr2PuqfE
         2u09rFW2d1CCrIbAaFTU8HEugNCMHELM66SjYwwndBHUbZ5JQNtrZkiJg+4OuUt0hy0t
         OB1Q==
X-Gm-Message-State: AIVw110jjX/4SW4UC7BCSRb4K38ShfPUlWjUmtJpDvYjvUQ1sXkf5L21
        PAcoO/qn1cvT7WmMnq28GeqN1Q8QYhQA4Yy6Jg==
X-Received: by 10.99.149.83 with SMTP id t19mr982881pgn.247.1499817898853;
 Tue, 11 Jul 2017 17:04:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Tue, 11 Jul 2017 17:04:58 -0700 (PDT)
In-Reply-To: <20170711220408.173269-4-bmwill@google.com>
References: <20170711220408.173269-1-bmwill@google.com> <20170711220408.173269-4-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Jul 2017 17:04:58 -0700
Message-ID: <CAGZ79kbUggNeiijOWdZX__HSd5uZ1M+TnVb2Gkik9AZpZZeQKQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] grep: recurse in-process using 'struct repository'
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 3:04 PM, Brandon Williams <bmwill@google.com> wrote:

> +       if (repo_submodule_init(&submodule, superproject, path))
> +               return 0;

What happens if we go through the "return 0", do we rather want to
print an error ?

> +       /* add objects to alternates */
> +       add_to_alternates_memory(submodule.objectdir);

Not trying to make my object series more important than it is... but
we really don't want to spread this add_to_alternates_memory hack. :/

I agree with Jacob that a patch with such a diffstat is a joy to review. :)

Thanks,
Stefan
