Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99849C432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 01:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3732084D
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 01:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575163241;
	bh=kdjjWcmGZSbFECmmKfrJjHwPqBaZXSkT9/VHe93sEgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A1k/6JK+QS0DIUWDxL3Ui+ffShYup0efWq3kIyAZ/1SANbkjWJfbvrFJ2JmCezMvu
	 QKcmWUnUdREp02AMeh3NWO+kng70H8ZoHxXVj58x78OFXUv4opamk7/5WIW0AVDogz
	 //7/Wib9itDAZ40j8MUYd1HBlLk5/xzXVbgMBZHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfLABUb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 20:20:31 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37676 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfLABUb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 20:20:31 -0500
Received: by mail-lj1-f196.google.com with SMTP id u17so8469270lja.4
        for <git@vger.kernel.org>; Sat, 30 Nov 2019 17:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0sdyX7pLiN3khasqHk8bUQ9XUbFlvA+ggCvkUq3ym4=;
        b=VdzPIjj7upEn6ny8xuTXugmr4OGIeP6C8ULT9OL37bMP1d2OSdpEfaoBZpqgH7LuHP
         Swrmr5nNhrVM3Imc1ILzNpFbBFdnntv8o1t1l6rtW+uvQEtkXeprLU0dLER2GAET+AAH
         xSybPBIdVnqZ6T5MIXTavVKrx2R8fXnJ5nom4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0sdyX7pLiN3khasqHk8bUQ9XUbFlvA+ggCvkUq3ym4=;
        b=CeDJmVL9wMrdrqJ8tOcDTdLOSSdRyNluygOI5jdvEorVD6arnugBMUMz917v4ipVsh
         SxOBMRdA7oqb+EeJMAiQeuNL9cqo++YcifuWWCvr3MhG8SuvuB/MjP3dZwfyt296sCSb
         ClR477m3q/+lR+oUSm7KmJ65Dvm1QVidcP3afvekfe7e51xpTkDQqi38QDPwYyX0ROO8
         2+QjTLB6oXYa6Cc5NaV32oSdrjULv8Jr2kfM+x4ozgMvH6d78wsYLnYVya9EeeQepfmb
         F5RfNOQzzf9l+lhTjHI0P06Ta3JCUQ1j/YYMiTCGVHd38vb6zf8L1j6GfOlVI3zxKhbo
         5gRQ==
X-Gm-Message-State: APjAAAU4x15UZl8kdYmTFO2Ai/6/nLmP3ddNzo4RcdXaHD6bLAed0Q6j
        u7Qd509SWVN4P6+tu7AiTwe7AYLRifE=
X-Google-Smtp-Source: APXvYqyPr9gk4MzWI9X2Z9k5qEXwvBd2hoJVNTYDkhBdPN8zjC1/XCg+WONwANr/TV5NlJpso8UjMg==
X-Received: by 2002:a2e:144b:: with SMTP id 11mr28276307lju.216.1575163228299;
        Sat, 30 Nov 2019 17:20:28 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m18sm12756587ljg.3.2019.11.30.17.20.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2019 17:20:27 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id f16so25292714lfm.3
        for <git@vger.kernel.org>; Sat, 30 Nov 2019 17:20:27 -0800 (PST)
X-Received: by 2002:ac2:4946:: with SMTP id o6mr25806008lfi.170.1575163226904;
 Sat, 30 Nov 2019 17:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20191130180301.5c39d8a4@lwn.net>
In-Reply-To: <20191130180301.5c39d8a4@lwn.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 Nov 2019 17:20:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj8tNhu76yxShwOfwVKk=qWznSFkAKyQfu6adcV8JzJkQ@mail.gmail.com>
Message-ID: <CAHk-=wj8tNhu76yxShwOfwVKk=qWznSFkAKyQfu6adcV8JzJkQ@mail.gmail.com>
Subject: Re: Fw: [PATCH] Documentation: networking: device drivers: Remove
 stray asterisks
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Git List Mailing <git@vger.kernel.org>,
        Junio Hamano C <junio@pobox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 30, 2019 at 5:03 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Attached.  The patch itself was not an attachment, but it was
> base64-encoded.

Ok, so presumably git removed the CRLF from the email, but then the
base64 encoded part had another set of CRLF.

And when I try to apply that patch (in a test-tree reset to commit
facd86390be2, so I think the patch should apply) I see the CRLF in
.git/rebase-apply/patch, but then I get

  error: patch failed: Documentation/networking/device_drivers/intel/e100.rst:1
  error: Documentation/networking/device_drivers/intel/e100.rst: patch
does not apply

for every hunk. I assume that's because the CR part doesn't match the old code.

But my git version is d9f6f3b619 ("The first batch post 2.24 cycle")
and some private patches.

So the problem might be limited to only some versions. I'm surprised,
though - when git applies patches, it really wants the surrounding
lines to match exactly. The extra CR at the end of the lines should
have made that test fail.

Do you use some special options for git? Like --whitespace=nowarn or
--3way or something like that?

            Linus
