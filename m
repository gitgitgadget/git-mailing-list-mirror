Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB17C761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 18:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjC3Syc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC3Sya (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 14:54:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADC7B2
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 11:54:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x15so18160850pjk.2
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 11:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680202469;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHxCpZS4VBYt5XZC7Acp+TvqeMfgNDYoEkbayRpVzqU=;
        b=HRXHng9mKm8tgd/tnndzaXXH45rHaC/487uXsol2MSpkXEoQve7GoTuQHAEW8fUwv3
         dNWI8m4fMOhM6+1o3jp5GZisfXP57sJHYPW/odMUnnKaIAM1hqn6wR23qa4QcrWTSTNO
         VhmzG599AbN72KSBHAJ8+sG2+XbratbCOk/ceg/eAFm7reX03Gpi5J1/bSEOyit6r1yK
         W7vMiTVfCMxnS1mC5R0KrGZT4m3YJUMPwhhlTxyBwA6nT1tYqJQMYoKvlnfnWEo4bn+z
         9a//a3Mrg2FZ6+BSJ0WlmopWf7+jpeirOiF7Ynu0zszE4KaR9MqaPpMuaEAVGviDxkxa
         HRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680202469;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IHxCpZS4VBYt5XZC7Acp+TvqeMfgNDYoEkbayRpVzqU=;
        b=S2Kg9ghoqbcEs9i86viLo7vCXH3w0d14XejHiTiaGujGbzH2yEmH425UC76KpZMveU
         cctMKbvdRqYH+ZpoCwh11TpQ+O9uA2G+jBIwlCLHbXYmbEDLuMKpgqUoy3dqypDM4h+9
         9TXNLJVmhkcFqOtVJnMci1RkcOpdQrJLc4Vf5755TJq4kaArT7JUwFxmPh9q9cpWFkW5
         YrJ0YUHEOYLBIcsEIgwYycRRSpzROIwM1vOUdKZ+2BlEIbh8Cg4MUwIqn0xHbyoNe2UI
         bZ7yqeRVJOmKv41IJe3FmzMuxr0Pm+oYcEPTHbc+rK6zg2Hv/vtVvUKqXZKq2s6gHpbg
         w7BA==
X-Gm-Message-State: AAQBX9f8GdzvM/Y2IprAKdBT3NKf6OTMLyQpjStShvUFxsnA/1p6l3h6
        F8eIeXAjGQd9Neh02gc8GWy652ErpDg=
X-Google-Smtp-Source: AKy350bVuZIJsC/In8N2ny/10OOtnBzBFl0Ey4iSlSTEi0ZdGWGr11cdkZoTdLNnrtucsrnkzG5yYQ==
X-Received: by 2002:a17:90b:4b0f:b0:234:721e:51e5 with SMTP id lx15-20020a17090b4b0f00b00234721e51e5mr7429198pjb.10.1680202469131;
        Thu, 30 Mar 2023 11:54:29 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090abb0300b0023371cb020csm3543235pjr.34.2023.03.30.11.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 11:54:28 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] branch, for-each-ref: add option to omit empty lines
References: <20230330112133.4437-1-oystwa@gmail.com>
        <20230330112133.4437-3-oystwa@gmail.com> <xmqqilei1bgk.fsf@gitster.g>
        <20230330182502.GB3286761@coredump.intra.peff.net>
Date:   Thu, 30 Mar 2023 11:54:28 -0700
In-Reply-To: <20230330182502.GB3286761@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 30 Mar 2023 14:25:02 -0400")
Message-ID: <xmqq4jq2jcij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 30, 2023 at 08:54:35AM -0700, Junio C Hamano wrote:
>
>>  * now we care if output is empty anyway, perhaps we can optimize
>>    out fwrite() too, perhaps with something like
>> 
>> 	if (output.len || !omit_empty)
>> 		printf("%.*s\n", output.len, output.buf);
>> 
>>    perhaps?
>> 
>> I am not sure about the latter, but we tend to use "%.*s" liberally
>> when we could use fwrite() in our codebase for brevity, so ...
>
> I think it would be a mistake here, as you can use "%00" in the format
> to include a NUL in the output.

Good point.  Thanks for catching it.

>
> (The rest of your review seemed quite sensible to me, and I like the
> idea of the omit-empty option in general).
>
> -Peff
