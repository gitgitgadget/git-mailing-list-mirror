Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60E8E20960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755716AbdDMSfU (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:35:20 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34085 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755796AbdDMSfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:35:16 -0400
Received: by mail-pg0-f43.google.com with SMTP id 21so34273845pgg.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tm/93exK3+AOwI2h//VuHD69lqeWkghQU7JZoyxElg4=;
        b=HEJM13hfeUtUYEuWyZQijD2xTGKy/oE+HhUeisqOngFcSOuDpjmnWNKyjEyNgUyX4j
         90kmMGbi3PA8HleCsKxYp4KFbjTS/1M4+i2ASuY2nrvXasMZQNMMcSlRG3nSs+JbapUG
         cci/WHkwNg3EhixPIVIjrn5B/ebrH4K7l/u2NN62J5s7ax7elM0PvPRg5hoclm6PJMYt
         eBYdoRghkauZ18+VPOqJgxyHv+P/fJC/KveCVCjnAkn7h3niL/I5rCXAqXuf7V7KbDlG
         05RNR270eOdDaarXx0YgRcjl0lCvqEj8jINL5JYaIxPhDcF8v2smRVcc8T6Dm53IESZX
         P0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tm/93exK3+AOwI2h//VuHD69lqeWkghQU7JZoyxElg4=;
        b=A+Mi9YGQ1kUyuayJO342xSFdwDb7QkmzQ265234EmBEU5nt6sIPiv52Bba6XQkx8GF
         rvJOn8wPzj7wS9//kwe0lcxSZU8S/xr3L0dWuUv4+jgzdqtuYEzXyqc10Ryoqg03n2sr
         mGBABBHyrqFfcWSpaQ2ZSnsqP7HTpwnLRYwpEDzW93zedr4SBBqW8pkFOoPETRGeG8Uk
         ZfgP2KwPU1OWREVDPJGjTOKdVtooqXSimJLvyDNukfxZNGA62aTVdCIcR8DGpuaBoRdo
         OJFkuQHK3a4v5PgZKGaNonQ1xUZ0X7/eGgKYUwlqtdR9+t8Byo857E8ikQCMrcE2ujDt
         9M4w==
X-Gm-Message-State: AN3rC/56QmSl5j/YeAxWOF0V6PF418t4WKMgvIR3vQ32UWYokO06fHBn
        YzIKQMXO7Pa3KOQ/VHvUR4nJKdpECQoY
X-Received: by 10.98.9.29 with SMTP id e29mr4207442pfd.101.1492108510272; Thu,
 13 Apr 2017 11:35:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Thu, 13 Apr 2017 11:35:09 -0700 (PDT)
In-Reply-To: <CA+P7+xr6zkb4kLTM-+0f5OTtt583WR_0j=NEebOdYuO3Z6h1+w@mail.gmail.com>
References: <CA+P7+xqE-SZ5D6pk6-Dx+-VzHijmgmrUR2F=-370Rh8oKr10Nw@mail.gmail.com>
 <20170413171224.3537-1-jacob.e.keller@intel.com> <20170413180357.GA96917@google.com>
 <CA+P7+xr6zkb4kLTM-+0f5OTtt583WR_0j=NEebOdYuO3Z6h1+w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Apr 2017 11:35:09 -0700
Message-ID: <CAGZ79kaRpAPFd8+rQUxKTmDfrQWdPGEEWGSVzstwUbj-7hRAKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ls-files: fix recurse-submodules with nested submodules
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 11:31 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> Spinning out a process is one of the big downsides of working with
> submodules in our code. Unfortunately, spinning out a process is also
> one of the biggest ways we isolate submodules, and if we wanted to do
> this "in-process" we would need to add an abstraction layer that lets
> us handle submodules in-process in some clean way.

Yeah if we had less globals and a repo struct (class) which we could
operate on, that would be bring in the abstractions that we'd need.

Stefan
