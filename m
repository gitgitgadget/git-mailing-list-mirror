Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11DD2035B
	for <e@80x24.org>; Wed, 12 Jul 2017 18:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbdGLS4x (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 14:56:53 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34155 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbdGLS4w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 14:56:52 -0400
Received: by mail-pg0-f49.google.com with SMTP id t186so17366599pgb.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 11:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h9WJNkcnuRGGL2q+B1ZN7QLQJsLvJnbQFNgV3x2h+h4=;
        b=uVrK6wxdVW9AZ/IYrMKmfyYex+rdnSDmgrsImcU8Qekv+N3fmUbAiAvezXgqseJQK0
         6KYEDMSVSgkjhGwk7QMhQB5OvLGPwDqmU1LjOGfpqVmcqX4kMbrkqd2zQ+3IE0vc1wR2
         133UubbPds9woJqGmyf5Tea2vz7mN6xcqYvchzTvHfNrhmmSrcEXGVnnF23ePZO1zlPS
         g2g2mC7xJxIogS9TN00IXSX8mJ/DQUWxkCAwJk90Hl1tWFcJ0t/0c2zMpuUzyBzy0wUO
         aY90aYhR5K3r7T6ixPmTQcoIDZsv/6MzYVm+r3AXDNXdYT7aAUnpw3lW9grUv1ByhGTR
         L+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h9WJNkcnuRGGL2q+B1ZN7QLQJsLvJnbQFNgV3x2h+h4=;
        b=P0qDR/eaT5w2YhdauEDlPRHRvE3J/Kd7ExqT0si/HJhU4BAejF/JDKuErBpd/tGIbD
         9CeTH3cMpcG+FMo+vQqrDRfuWpcUwNQP/WemK7J+jP74zc1/GXKVKrxHvhj6BBXWxgdb
         CLqc87c82pMAUCaear662DtTg1l1rn9shlw8rT4mJCePPtKrdZlSphWi8zXspf2TpIgl
         Vs4rrQhThJFc7Tmzfa44BFhdO0/YVVhSKax1JQc0dj3/TQPWC48DeuuAuNLY4qjDWJ5M
         Lec/jNsoLDPDYPtubwZT+FEwfW19HIUzn1obQaa4MIYDKtuDXNj4yzrQnwrWbSTSlc+7
         JuLA==
X-Gm-Message-State: AIVw111UTVI96KD9KatsnQQVuCiIvdajAJkFJkOPmih6vnwdNtakruK0
        Ds0+NaJpxo5UUxba8TDExg==
X-Received: by 10.84.136.129 with SMTP id 1mr5857388pll.39.1499885811783;
        Wed, 12 Jul 2017 11:56:51 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3d1f:bb9:8897:56b4])
        by smtp.gmail.com with ESMTPSA id h80sm8053790pfk.80.2017.07.12.11.56.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 11:56:50 -0700 (PDT)
Date:   Wed, 12 Jul 2017 11:56:49 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] grep: recurse in-process using 'struct repository'
Message-ID: <20170712185649.GH65927@google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170711220408.173269-4-bmwill@google.com>
 <CAGZ79kbUggNeiijOWdZX__HSd5uZ1M+TnVb2Gkik9AZpZZeQKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbUggNeiijOWdZX__HSd5uZ1M+TnVb2Gkik9AZpZZeQKQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11, Stefan Beller wrote:
> On Tue, Jul 11, 2017 at 3:04 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> > +       if (repo_submodule_init(&submodule, superproject, path))
> > +               return 0;
> 
> What happens if we go through the "return 0", do we rather want to
> print an error ?

Should just indicate that there is no hit in the submodule, but if we
couldn't init the submodule maybe you're right and we should issue a
warning.

> 
> > +       /* add objects to alternates */
> > +       add_to_alternates_memory(submodule.objectdir);
> 
> Not trying to make my object series more important than it is... but
> we really don't want to spread this add_to_alternates_memory hack. :/

Nope your object series is definitely important IMO.  As I commented in
my reply to Jonathan, I'm not sure if we want to wait till that becomes
a reality or not.

> 
> I agree with Jacob that a patch with such a diffstat is a joy to review. :)
> 
> Thanks,
> Stefan

-- 
Brandon Williams
