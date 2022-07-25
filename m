Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24892C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 23:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiGYXo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiGYXo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 19:44:56 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C424093
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 16:44:53 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id u12so9462393qtk.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 16:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bInwPkmCOlg8dtbJF3cp7bLBaDBY5SWKDXcJFw8sqSY=;
        b=rm00DtsLnrzNMAwDpKuPMoYenZlcUcD45t6glWa4T6MyYnjsquYUsRLPcwdBaHdN4N
         CZwP+ZtMCblNlRIU3ZOUDcav0Am5AgAZivlJxusCHjW76uHO/KPQa22xx49uRF/G1DNq
         1FbvrZPQR2ux+BDDjgYNftSt5S6tO83UUauj6HZwXTCXLCfpiPgtwvI0ADTFBbrrM+ud
         Fr47aJi+gW0YFCRXE8BcByxd3TS/Wrc7W8at4BZtXHuaIWcb5YNlKmGRK6amisEeE7p4
         UwwS/yWtH6MdBmxqomkzfeNhPigZreLVsrwGmcyCCI0bj3kBbTT5ACzKXHaqUmiri/YS
         ZJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bInwPkmCOlg8dtbJF3cp7bLBaDBY5SWKDXcJFw8sqSY=;
        b=FC2p9mi8ldraO4891tF7sxdcoZCND65S4m3+6zU6rbIviycCxfvbMdO3jrIOE6z0B7
         chrSKs/wlWc4CeWgsZCbfeIDhubUQ8uD4DMnJYwYJddlCMIVyGiFchWhtY0t9Y/5+qOs
         YgAdRvnGVeerokdmFDtSiEOlXzjSgDlncJ+hKFfQfKuH4FCqDbBH6BKK4LX7miaBU96I
         2MDCN2ljKzhv/xpXf4nF0R80dVJHDp0km4PnCU/U9+pBtsYAVROAWw4Sc/OzU9Alrqur
         DR7mJtdoUKnMdRxEhW8wUpHd/zBpWkN6ZayScN6c7W/OpREUkYKofrLJkntWIyxjcI36
         MF3Q==
X-Gm-Message-State: AJIora8hyCXVrNBEJzSOw4JbeI1cF7V5EFOcNgtuvxZyAs82UblTXlik
        XRD7jKzxxuJr2Ste79km5kOD5w==
X-Google-Smtp-Source: AGRyM1v7dL2XHbcynORDJGOjo1YoTvGrn6Tr0xvsTxbHduekIMjNNdKZTNFByBm2jKwswyx5VBJ4qw==
X-Received: by 2002:a05:622a:608c:b0:2f1:e3fa:b603 with SMTP id hf12-20020a05622a608c00b002f1e3fab603mr12329598qtb.48.1658792692502;
        Mon, 25 Jul 2022 16:44:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bi14-20020a05620a318e00b006aee5df383csm9288652qkb.134.2022.07.25.16.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:44:52 -0700 (PDT)
Date:   Mon, 25 Jul 2022 19:44:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] builtin/cat-file.c: support NUL-delimited input with
 `-z`
Message-ID: <Yt8q8xvtXmztLIln@nand.local>
References: <cover.1658532524.git.me@ttaylorr.com>
 <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
 <220723.86leskqtej.gmgdl@evledraar.gmail.com>
 <xmqqmtczafku.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqmtczafku.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, Jul 23, 2022 at 10:45:05AM -0700, Junio C Hamano wrote:
> > So isn't this just an accident in of us having used the strbuf_getline()
> > function to mean "\n", but actually it also does "\r\n".
> >
> > Which is a really unfortunately named function b.t.w., since it sneaks
> > this bit of Windows portability into places that may not want it in the
> > first place.
>
> getline() is to read a single "logical" line, so it is fine for it
> to strip CRLF on platforms with CRLF, and to leave CR at the end of
> line on a LF platform.  If the "protocol" is defined to use LF on
> any platform (and allow a payload that ends with CR to be passed),
> you can argue that it is a wrong helper to call.

Reading your email up to this point makes me think that we should ignore
any CR bytes we see next to a LF. So by this point I think that we
should take Ævar's suggestion and call:

    strbuf_getwholeline(&buf, stdin, opt->nul_terminated ? '\0' : '\n');

But...

> But does that result in a sensible behaviour?  I am not sure.  Some
> editors that are popular on LF platforms can produce CRLF files when
> the user asks (either on purpose or by mistake), and when not using
> the "-z" mode of input, I suspect that most users would expect CR at
> the end of the "line" (terminated with LF on their platform of
> choice) would be thrown away even on their LF platform, simply
> because it is unlikely that the kind of input they are preparing can
> usefully and legitimately end with CR, as their colleagues on CRLF
> platforms may also have to produce similar input.  IOW, the presence
> of CRLF platforms makes text lines that end with CR much less useful
> everywhere.
>
> And from that point of view, "getline() or getwholeline(NUL)" may be
> a pattern that is practically more useful than the old "use always
> getwholeline(NUL or LF)" convention that I invented more than 10
> years ago.

This makes me think that we should retain support for dropping the CR
preceeeding a LF and treat it as a historical wart that we are stuck
supporting.

Do you have a preference? I am fine with either approach, FWIW.

Thanks,
Taylor
