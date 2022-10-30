Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3EBECAAA1
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 19:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ3TYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 15:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3TX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 15:23:59 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F325B1D9
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 12:23:58 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y6so5391211iof.9
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 12:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NfW4sANLCBfMT4pWbLUUEcAoEUBMVenE0d16iP/dWk=;
        b=rkGBtxBqxWtzGfdsVZKqNUpBawP+UNb0BDDx9G0T9jFr2UOnAhkY+xFtF+2gDFItLf
         8UBSukKs/mSpeokjju4yrLxQ7duqr6TLmgdm0/w6AWgGoafCSw5MSoKwAPUPdmfsEQzC
         Lo04pWeQnoJy0P9iNQV6Tm57ye3GIJvT5f63AxMzqsqKwg/w4V4rdq4eHE31g3VIlVNJ
         HIEL5qWVvC1jRmT7Tbni1FDqU2bTN0Py7yDCa8DkwgKQ5p/7TdGaZpnNSZVcjsZxG7W2
         2UnPHHICzzvn64cuUFyrwTez9s38Uw1EKGEVRtb+bld4NSUNlsqYC+vAM+l4ZlYKrp4T
         /bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NfW4sANLCBfMT4pWbLUUEcAoEUBMVenE0d16iP/dWk=;
        b=mn5SPHS8SsxnZOh14R4tJrY/TJ843S9G+Zqnd/P2nYpxNG92T5G3cX5wk5MNQdZv25
         BPDdy9sk86LhWUYlHAgFHSzW46ozYYXd0QphuSvjB7Z/vWl/4puti/o1SsQ1V58a10+i
         0Mf/IHcp1VKUHoOcDWnLS3us6AAiIhykOx6ecS9QxqL594KD4gJrBtC/xsP6ESPaN7gr
         5yuCv7sPB5+J7vpisGPEOVkt8f5HKP3MeCWFed4/sn9q7rO+V5o2u+P4RWkr/eeKHAY/
         +Pmnl9/YyULLcVfrbn62P2DqTWDXjiO9PU7B7fhL3g4BNJay7qzJaCBTQ2y1A53wV5gd
         S76w==
X-Gm-Message-State: ACrzQf1Z70iAyg0VvF5qY0eCQBSIEoJdCa92PgEKpU2RrN4DxupuQ7Sk
        AYqGrUViRpegYPB0qNKkEjHexg==
X-Google-Smtp-Source: AMsMyM7M4Iba+3JShvO3pz4BYpn2OXIFpziI8rxxuUC9uDtHXg4Sg+uYFd+NgPpBZlFMe2jTEsRaMQ==
X-Received: by 2002:a05:6602:2d83:b0:6bc:9e73:8fa7 with SMTP id k3-20020a0566022d8300b006bc9e738fa7mr4820467iow.94.1667157837440;
        Sun, 30 Oct 2022 12:23:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d6-20020a926806000000b002f9537986f3sm1803868ilc.24.2022.10.30.12.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 12:23:57 -0700 (PDT)
Date:   Sun, 30 Oct 2022 15:23:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Subject: Re: [PATCH 1/1] pretty-formats: add hard truncation, without
 ellipsis, options
Message-ID: <Y17PS/2LgRIJKGoo@nand.local>
References: <20221030185614.3842-1-philipoakley@iee.email>
 <20221030185614.3842-2-philipoakley@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221030185614.3842-2-philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 30, 2022 at 06:56:14PM +0000, Philip Oakley wrote:
> Instead of replacing with "..", replace with the empty string "",
> having adjusted the padding length calculation.
>
> Needswork:
> There are no tests for these pretty formats, before or after
> this change.

Hmmph. I see some when searching for l?trunc in
t4205-log-pretty-formats.sh. Is that coverage not sufficient for the
existing feature?

If so, it would be nice to see it bulked up to add coverage where we
are missing some. Either way, we should make sure the new code is
covered before continuing.

> @@ -1743,6 +1749,16 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
>  					    padding - 2, len - (padding - 2),
>  					    "..");
>  			break;
> +		case trunc_left_hard:
> +			strbuf_utf8_replace(&local_sb,
> +					    0, len - (padding),
> +					    "");
> +			break;
> +		case trunc_right_hard:
> +			strbuf_utf8_replace(&local_sb,
> +					    padding, len - (padding),
> +					    "");
> +			break;

If I remember correctly, strbuf_utf8_replace() supports taking NULL as
its last argument, though upon searching I couldn't find any callers
that behave that way. Can we use that instead of supplying the empty
string? If not, should we drop support for the NULL-as-last-argument?

Thanks,
Taylor
