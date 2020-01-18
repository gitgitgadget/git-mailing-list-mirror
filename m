Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21904C32771
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 19:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67992176D
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 19:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sr7op0DX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgARTur (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 14:50:47 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39652 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgARTuq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 14:50:46 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so24588903qtm.6
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 11:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Asy2vNCPfqwOD6mymo0LlWyI6k3zeOo2YPas8LkaS2g=;
        b=sr7op0DXAUZ6kdkC18nljtsuxqnzbErzG8S5F5+6WgdJojx4q/Gowd1Oj3EKLEtfid
         MYy3aQVtegQiS3MgTmGPWHmAU4AHhcmab6RpR72/qmf8DaIb0ppiO39p9y0SSBV6xKvS
         z0wUUOlLwJUEfniBsIWzArsBiQBagsOSQwL14jqCPN4AGF4J9v4spuGkQ1QDKjtiwU4d
         YRveTiR6KGIxU+nMr2uxm1V2PccTcxIzsKLIm7uohrdI3cAdcvoLejNnhv+3Iwtxe8Hf
         u5YWvY2OlglSDrYqVYGXAFOybg/F1kB/Rc7brVM1yIBIz+bZ8V0zoqwyOQyoBOzVEv2K
         C68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Asy2vNCPfqwOD6mymo0LlWyI6k3zeOo2YPas8LkaS2g=;
        b=KsFcUZfW0007vdT8Gc8SjvRVKI/IymogZjUcVbZVJYUBXJ8jmTTlIho675ILsCPV8m
         BcjrC2xhBg25gvEJeq6VdXxWo7/JgA0kO3YyZqwianXR7osTSz+pqWhoSwx1KghBrgCR
         fKbrAHoIDk9sqTShU+404bKpuwhrM/vqaDjSB2jusxTATv10UISlthpsXrQj0ZKxfoyn
         V6RGgQRjv5bHZiYG81MlhoV0vUWa3EeapJdv5Cbo6M/Lsl1ExK8Er6eap9rPqjMOMslG
         SC0ZXeoPkeJgETYEOcJ1FtnTHlRNIGMVcXlC61OcByjBwNR0b5vLO+nIAkYqzeBFIN3C
         XYoA==
X-Gm-Message-State: APjAAAXxEHxq8OqD3ExbKRZjdzK16jD1YRjg5aleEiETQC6+v/WGiT3A
        PSoxAgebQw2WC0TLvFDfA5E=
X-Google-Smtp-Source: APXvYqwzY9ACnw/v2qxvXJmbh90z2oNPPtusB6AU55nGuKNhwkJQEBH+FwXC49KsCTPH61s7RFy18g==
X-Received: by 2002:aed:3b79:: with SMTP id q54mr13492703qte.187.1579377045887;
        Sat, 18 Jan 2020 11:50:45 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id y26sm15453067qtc.94.2020.01.18.11.50.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Jan 2020 11:50:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/4] t2405: use git -C and test_commit -C instead of subshells
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CAPig+cQgh+gmrDwSqJz1hHViBxTP6UDkuHjKTRLbackcxeQE9A@mail.gmail.com>
Date:   Sat, 18 Jan 2020 14:50:43 -0500
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <30360E66-65B3-4669-B661-237813044041@gmail.com>
References: <pull.523.git.1579263809.gitgitgadget@gmail.com> <5060ce3d64419369b2912c395a880fb49a0a3137.1579263809.git.gitgitgadget@gmail.com> <CAPig+cQgh+gmrDwSqJz1hHViBxTP6UDkuHjKTRLbackcxeQE9A@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

>> -       grep "file1 updated" out
>> +       grep "file1-updated" out
>=20
> Why this change? Is it because test_commit() mishandles the whitespace
> in the commit message? If so, it might deserve mention in the commit
> message of this patch. (Even better would be to fix test_commit(), if
> that is the case.)

The only reason is that I didn=E2=80=99t notice that test_commit accepts =
a <tag> argument, which defaults to <message> if unset. So when I =
changed the test to use test_commit and ran it I got errors from =E2=80=98=
git tag=E2=80=99 saying "file1 updated" is not a valid tag name, so I =
added a dash.

I=E2=80=99ll correct that in v2.

Thanks,
Philippe.=
