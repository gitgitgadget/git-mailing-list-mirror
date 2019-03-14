Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FE5C20248
	for <e@80x24.org>; Thu, 14 Mar 2019 07:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfCNHXS (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 03:23:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54430 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfCNHXR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 03:23:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so1733560wmj.4
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 00:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3qyzYf/RBUIKbbViffZvEa+EzWK8uxl6d26aK3lvEYw=;
        b=JsIMLnaG/iYWOlOU7EgLO6bLsg6XLPL0ItOdmtiXX1S+0REFMbhTW8h5twiZXnjng1
         4EfxtryN0un6thCtit81nml+rCPADkKFPq81MtPrf0AR1qryVVcNX4efV0LiCQWm71JZ
         IoQ/EJuGTbblmGmlrFt6P8vkPNg6X5qL/1504pnZJ9HnXTDs7H9HwRFJMQzbTYzTW+wc
         SDWrW/U3G3CMoRnnArIVbRkcQBwef7aSQ+DnhSqdi1EYGgxcycB3KdjP2HamUrIxbwmh
         z1LBlCf3MD5VAhTDZK5pxofnr7uerWKAi1NGgJu3a5y9g8VphoZewN+/Yzjy2TM+Noyh
         TVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3qyzYf/RBUIKbbViffZvEa+EzWK8uxl6d26aK3lvEYw=;
        b=M3fvb0Dg/vraAlyhuve/IdbiS/kWt4E89gXa9SayoOzj2WemubUvin7uzJMoSKdcRO
         hU5Endwe6xWh3cCkEZot3WS0cgArxb7NgEdb0zJrJciYphF1D9W4CgGMMk996Tf2l8m2
         cuq3OS38JpNcif50x799HNjKFhx65D2BmuRKPeNUqBnw6XdoDaqHDAqQ/X+xEHSw3oe0
         7jUbsWAHKQ5OhGnVydwEVyQVmCn6MoPIJgKtvRxeFrrpdU30csTObL2U/dZhWOaNGtUn
         RqWpi83//fPARgJG1WZW0sUw4Qty5O/vi9JmTOar+eEpr/06I+GWN9gToF0zIYh8HDAt
         aQ0g==
X-Gm-Message-State: APjAAAVlw5pu7oXT2L9fPV3pVEhhkU3ovWQ6tdArtneR4V671BltHG2i
        74cLXRUsGUie5gK8bg6YgVI=
X-Google-Smtp-Source: APXvYqxH+E71p13/vc5v0EnR7DVD/5h3VU6nt39KOf2hJexAYtnohwqGzwFVm1SnCJOFuSsiLc7zQw==
X-Received: by 2002:a1c:1cf:: with SMTP id 198mr1316766wmb.52.1552548195250;
        Thu, 14 Mar 2019 00:23:15 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x17sm42742351wrd.95.2019.03.14.00.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 00:23:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
References: <20190208090401.14793-1-pclouds@gmail.com>
        <20190308095752.8574-1-pclouds@gmail.com>
        <20190308095752.8574-11-pclouds@gmail.com>
        <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
        <CACsJy8CuNQR7javX7KTC7txivH1OkejCbVJdHGD+XJ-0ftT3ag@mail.gmail.com>
        <CABPp-BHB3c0XqS57Do8=YFtbVyBEe26kbJtgDxWAaWAMzsgdoA@mail.gmail.com>
Date:   Thu, 14 Mar 2019 16:23:09 +0900
In-Reply-To: <CABPp-BHB3c0XqS57Do8=YFtbVyBEe26kbJtgDxWAaWAMzsgdoA@mail.gmail.com>
        (Elijah Newren's message of "Wed, 13 Mar 2019 22:59:20 -0700")
Message-ID: <xmqqsgvp9axu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> I think sometimes a 3-way merge creates marker conflicts in file, and
>> this does not look easy to reverse when switching back. If it's true
>> and we can detect it, we can still abort this case (i.e. requiring -m

Paths with actual conflicts are much easier to recover from than
paths that cleanly merge.   You have your original in stage #2, so
you should be able to "restore-path --stage=2 --from-stage path..."
them.  Once the contents are auto-resolved cleanly, however, the
cached contents are automaticaly updated to the auto-resolved result,
and it needs more work to reverse the effect of the merge (it is
doable, of course, as you know exactly the contents of the
switched-to branch and the contents of the switching-from branch, so
it is just the matter of running 3-way merge in the right direction
to recover what used to be in the working tree).
