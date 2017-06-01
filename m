Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10062027C
	for <e@80x24.org>; Thu,  1 Jun 2017 09:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbdFAJyK (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 05:54:10 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34515 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751600AbdFAJyI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 05:54:08 -0400
Received: by mail-it0-f68.google.com with SMTP id d68so4965206ita.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 02:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AmtYw7d9KS+WbLxTuuj6MSh0zojRazZi4mfRfK1ZeSc=;
        b=MkRn0UthgXXZVobWhvSHBiscAz4YLahIIymgR0LGEVtZI7rGwOqAWh0iBp06vqu4VH
         RNTxeHdSFDXtD8nDmMp8bFL605yP+xYVK75d9JRixotY1Y6Xyp8UcfNWyl/A5/ZMZxO5
         P9k12v5Wx+1/s7dpNxCbPfrMdERWu1+biT/1iEWtAn2AqTwpYl1dlDAHg94rgOsQfTiE
         +gY+wddR+8GZhmzzNKrfuV9oEgBVN/ymmVFF3GqdQwjppRoeUf2DN5jeWTBDMKUIauuL
         SXLSWz2E/OhCs5Ht7TnMNyn3+8zigHF/JKcl0YRG+bSjILT2hlwYrO+hQuaRixahq92M
         GPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AmtYw7d9KS+WbLxTuuj6MSh0zojRazZi4mfRfK1ZeSc=;
        b=QaKG4E9egBizDHZ/qthx4EjFyxxFkTDRaUGlezmoTeGJTrCx1u2BIZVjefq2G5uDXL
         N7Bvqzdd4mFIRcdzmoS+7yOqUcu3eIu9eZxYjQhT2fvdt9zfPC8tyZqXUMW4BJMsDDBl
         RIHkt7l2C5q1vXTkIzE80euhpooSUTdSfrqVrRuofnhxOLBKZLyaokqky9/BSe4ynnIT
         TKi0rbZVNPGivmeqfG8CrpY29h0QRvIeraOBoagTSz+sZA+MQUaj27mhXWLUfs0mR1pn
         Xx13kY2Qgr7xModqx1Qcgy+Y7O/ijNQzNE6Wp1ibRtQLyIhv12ca5O4TsVmr5ddj06kV
         YbGg==
X-Gm-Message-State: AODbwcBJcV4fP58+uWUhNSHb2g2uYl31a8UxRrJQ2nUt830/1GGdaSpy
        Pfq57Mm9u3MipQ==
X-Received: by 10.36.193.134 with SMTP id e128mr1734157itg.43.1496310838067;
        Thu, 01 Jun 2017 02:53:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id g12sm8480299iog.60.2017.06.01.02.53.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 02:53:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Andreas Schwab <schwab@suse.de>, git@vger.kernel.org,
        Marc Stevens <marc@marc-stevens.nl>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Unaligned accesses in sha1dc
References: <mvm4lw0un5n.fsf@suse.de>
        <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
Date:   Thu, 01 Jun 2017 18:53:56 +0900
In-Reply-To: <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com> (Lars
        Schneider's message of "Thu, 1 Jun 2017 11:21:31 +0200")
Message-ID: <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 01 Jun 2017, at 10:28, Andreas Schwab <schwab@suse.de> wrote:
>> 
>> The sh1dc implementation is making unaligned accesses, which will crash
>> on some architectures, others have to emulate them in software.
>
> Is SPARC an architecture that would run into this problem? I think
> there was a thread a few days ago about this...
>
> What architectures are affected by this? I think I read somewhere
> that ARM requires aligned accesses, too, right?
>
> I wonder if it makes sense to emulate SPARC/ARM/... with QEMU on TravisCI [1].
> Is this what you had in mind with "emulate" or do you see a better way?

I think Andreas's "emulate" is that on these architectures often the
kernel catches the hardware trap and makes the unaligned access
appear to "just work" to the userland software, just like in very
old days, i386 and i486 without 387/487 used software floating point
"emulation" to give illusion to the userland softare that the co
processor was available.

Having to trap and emulate of course costs cycles, and if the
userland is written in such a way not to do an unaligned access in
the first place.

Depending on the model of "ARM" (or "SPARC") emulated with QEMU, and
depending on the OS that runs on such an "ARM" or "SPARC", we may
not see this---if the emulated OS has the "software unaligned-access
emulation" our userland may not see a SIGBUS.
