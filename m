Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B35B1FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 02:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753646AbdFNCwy (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 22:52:54 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36562 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752854AbdFNCwx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 22:52:53 -0400
Received: by mail-pf0-f178.google.com with SMTP id x63so76754479pff.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 19:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+ADeJljs5MMP9EMI3aZB2AHTXReERTBy7a7V7VJ8nXI=;
        b=m/VP8S8BLYkx82SpXntBh09kdaBxqJ3r9aIWCZljgudxNlbW+XSyZnMlaUD95VROOY
         s18hGMgc1xoYIAdQdbqQCLpxk8bdkfRqyRx/4+t30nryk7g1yn5fo9L8dkYyd9AAnEVo
         EidJ667lsJ2G0TeBnds0V74pUE33eMHHsTQrgd6ETEc5t4NjKIjGVXGSSE56i6meBJXZ
         s2KFVPPdYUICE4XI/JHSzwxPtq5dKeldVfdUReC5V/d7b+M+UpN1DkSyTTDTrlsdK6B8
         NpE4OUgd0hfWnITv+6kf0Q6c2r6I8rJDvCq1ndJjwGSF1bJzjzJVuY7ucQTrmf6OlP8M
         eV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+ADeJljs5MMP9EMI3aZB2AHTXReERTBy7a7V7VJ8nXI=;
        b=kOVP/Q3tXEZBBLz9Pu6hFtjxeFrH2Gpf5Av2gOEht++AlFmWXgVioUvALXHQXYcDjd
         20jW/Ui+4GrNn3mhvpLE8Lfo3eGo9b2zPvdqDMCA5cZrSAM66Z8t5zfwcUboYA2Yw9W4
         j07FWWfeIAuI9h0DEg2tNTJn+uH2WMEstS8AtyMDfHTuPlnT5vY0dkxP4QDkCpxY4GZX
         twftZ9VWop1wEYCrj43rKYEf/usfweSTPcIOPqrnF9o/fP62FGV+xxLfDBc6cPeIrWgC
         fTGQ7sXGhDJ4xbsVVDaKhGwhCh4QzTjTSu1ewYAWTHISP+xj6IZ28oxhEsIIjyqlzeUo
         gGPQ==
X-Gm-Message-State: AKS2vOzB7GVhDT2JN3Cp4JPRR32ojqJFxrKhW7WNLcQrXFXzQbMOLFLT
        neDp1ZzOBPu2cU0AFnlNe64/HVCkgfIe
X-Received: by 10.99.186.91 with SMTP id l27mr2217716pgu.87.1497408772734;
 Tue, 13 Jun 2017 19:52:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 13 Jun 2017 19:52:52 -0700 (PDT)
In-Reply-To: <20170613150722.0bd8fa56@twelve2.svl.corp.google.com>
References: <20170523024048.16879-1-sbeller@google.com/> <20170524214036.29623-1-sbeller@google.com>
 <20170524214036.29623-17-sbeller@google.com> <20170613150722.0bd8fa56@twelve2.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Jun 2017 19:52:52 -0700
Message-ID: <CAGZ79kZEcURkeBv2T4D3cFOQ7Tnzc-GVTfk_QT6K9iW1hvA55g@mail.gmail.com>
Subject: Re: [PATCHv5 16/17] diff: buffer all output if asked to
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 3:07 PM, Jonathan Tan <jonathantanmy@google.com> wrote:

>> +struct diff_line {
>
> Probably should be called diff_emission (or just emission), since these
> may not be full lines.

I think emitted_string would do as well?

>
> Also, can this definition be in the .c file? Callers should use the
> diff_emit_line() below, and not need to know how it is implemented
> internally.

done

>> +#define diff_line_INIT {NULL, NULL, NULL, 0, 0, 0}
>
> Should be DIFF_LINE_INIT (capitalization), and {NULL} is sufficient, I
> think.

done.
