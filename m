Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7386C201C2
	for <e@80x24.org>; Tue, 18 Apr 2017 18:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbdDRSlG (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 14:41:06 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35143 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752817AbdDRSlE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 14:41:04 -0400
Received: by mail-pf0-f177.google.com with SMTP id i5so656180pfc.2
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MaC+OQsvAJoBADRSolwcG1kWZEYrSWQ2VkGU33QareY=;
        b=AI312GTY/STu3Mu2O1RvbSdl4jpam3CR8wDPGHZmvsOTJ8lgYIV6s/xytjmpTXNlRF
         TgWIliMf8Im3+FHCfZf9f6m2XvM/cQ+Tjt05iVeaUnKZpZaYBxKMQ2Jg3EsbUvCP4yi2
         Ihgct9wHEgBw9hHn0c2lA/q/bpMS2Z9EGSNzcZfZDxfF/h2z6xxfM1g/sOKK2wQRP1oq
         QWgNGXqJWlLTn77MjC/keKPhNQ2IynumuoEo2YbCZbkW4umm5eqWC4/Aj+kS+/PEGwkz
         Gnwg3eSbISYWudklIBKi4HUTxxfRMpkTaj5qcQWK0R9lKo8DK6rEetcU62k9bWy1i8q/
         NCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MaC+OQsvAJoBADRSolwcG1kWZEYrSWQ2VkGU33QareY=;
        b=s8C5EbQ8sw+smRx1i4eIlJ71+Lch7JZ/yDc+D2ZJ45on3wNNeHEWuQhbX7KyaJWgQU
         AogOOWyEohZ84P7WC6Px9HxnXNR/hoaeKykeSCeuUn/IC32kw2MIKPLvm5ymKOZ93ROy
         b4D3t0N3VJKm2oRJjWpJxG9gKpM+npckihL7DDN+HY1uTWeY/Ykw6vJkCpNz0O5BGWf2
         ks+FBujT9u3zOMmU9UdWBMq3ZIRiTNCtrjTVX8Yen0nmODqSrymZ5W3xFVmV548s5bhX
         sl47zCf7iqudzPA8SUCQtJD1JkGg5GypbeWFp6hoCni40cWfuFmuPg6iazLcnlpYwV7H
         Iquw==
X-Gm-Message-State: AN3rC/7QBM4+SM2uAy1zJAulTD6x27BJUa8UkWLT3cWC8NqxUKzGY2qj
        9ChPCRxeF991NDOT0I7jk2c6tLwPYwLv7HKAdQ==
X-Received: by 10.98.24.195 with SMTP id 186mr19094841pfy.35.1492540862497;
 Tue, 18 Apr 2017 11:41:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Tue, 18 Apr 2017 11:41:01 -0700 (PDT)
In-Reply-To: <xmqqk26ih3qf.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xqE-SZ5D6pk6-Dx+-VzHijmgmrUR2F=-370Rh8oKr10Nw@mail.gmail.com>
 <20170413171224.3537-1-jacob.e.keller@intel.com> <20170413171224.3537-2-jacob.e.keller@intel.com>
 <xmqqk26ih3qf.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 18 Apr 2017 11:41:01 -0700
Message-ID: <CAGZ79kY9aEPp6BgWxp85ssNhdr=0AjMAh5tHJkMo6c+JhLjg-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ls-files: fix path used when recursing into submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 7:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Don't assume that the current working directory is the root of the
>> repository. Correctly generate the path for the recursing child
>> processes by building it from the work_tree() root instead. Otherwise if
>> we run ls-files using --git-dir or --work-tree it will not work
>> correctly as it attempts to change directory into a potentially invalid
>> location. Best case, it doesn't exist and we produce an error. Worst
>> case we cd into the wrong location and unknown behavior occurs.
>>
>> Add a new test which highlights this possibility.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>> I'm not sure that I'm convinced by this method of solving the problem as
>> I suspect it has some corner cases (what about when run inside a
>> subdirectory? It seems to work for me but I'm not sure...) Additionally,
>> it felt weird that there's no helper function for creating a toplevel
>> relative path.
>
> Is this a similar issue as discussed in a nearby thread e.g.
>
>   <CACsJy8CLBY22j3EjR4PW3n+K6PWUzb-HCgxTVeCGpwtApZF-6g@mail.gmail.com>

yes, it's the same broader issue.

>
> I do think it is a bug that sometimes we do not go to the root of
> the working tree when we know the repository is not a bare one.

ok, that would have been my understanding as well.

That nearby thread however highlights how it may be a user breaking if
we just fix the paths. The patch here doesn't cd to the root of the repo,
but constructs the correct path, which is correct. It may be considered
clumsy if we decide that cd'ing to the root of the repo is the correct bug fix
for the underlying issue.

Thanks,
Stefan
