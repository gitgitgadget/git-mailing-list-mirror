Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF77C4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 00:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D3420873
	for <git@archiver.kernel.org>; Fri,  1 May 2020 00:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcXwHwVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEAAaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 20:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726545AbgEAAaq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 20:30:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FAEC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 17:30:45 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y25so835584pfn.5
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 17:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YXnqSAT5WFoy7WU4OAV1Vy3dwSEbA8INT5cWXKzdVcQ=;
        b=lcXwHwVmiriHA8pphPMhGl2kVl4BXxQObnlndyMspMqJe4V7z/UKgjLeOzi1wcrSVT
         GL9d0QXf+7NCwUMqECnFRpPEBBiP69vefKIzHQ2olnamCTo4rol1qVnvYQhXIGChCj7q
         VnMJ4/AzgL+9c/GdLV1xy2Jj+erPdOrB6YKMx4s7MB2Ld49sFrl8Ubto1J3c/Du9UnqF
         +4UqEpUTK9KBtfjtL+SbZAxBRL/j3+JTkhM1cbG8sRQ6/rFOhgGPniEhqDGCQBMFivU7
         BdRa2YHX2aGyp7MBqULl5NozLMbmzJ23wUWq/IrQxQ5HrQjI2SACMKyBtI1xh0VEEl89
         leMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YXnqSAT5WFoy7WU4OAV1Vy3dwSEbA8INT5cWXKzdVcQ=;
        b=S1cgLNqLzYTOgvixD70mvVcBPaIi0sYWsmQJXurAHgalAOEOyBGAs8O9y8+e3KDPn6
         8kn99CUHxPhWN6WkBdUD0W6ayXiaqFNNZkSvOpDuraTg4t31Z+mmrhOYmr9SCHzZhCNk
         e17Wq1VHFuEOF7TQkmMnRzYS4FgDnkPQnDIh5q3uQPAYwM/OcTgtsGMy+wSxisRwH+UM
         nVugTf2bV3qBzeZZVEFprJMDGwOGg4ENbYTovsaHPy+sAaJmt7N/rPzvN312Kf3U2NOJ
         okCfMyxcpuG5xNLfSdD9+dVgvplES7orZpR8dHccBML91j/ZHz+6/TRWFUWkkKRH2/t6
         adLQ==
X-Gm-Message-State: AGi0PuZCSCOtsVbbjgE9Mh59UqECf9F8YYD4ylwi9Kl32I/xS30jk4hW
        wb1F2fm1+39E0Ysk23l0Kzs=
X-Google-Smtp-Source: APiQypJQVuinfdxN2tvIP82LVtwonx9yMTRvSSytR8ncQ9L7k9dESataqplnD376dlDaUAfgfKhpWg==
X-Received: by 2002:a63:1d46:: with SMTP id d6mr1728843pgm.236.1588293044912;
        Thu, 30 Apr 2020 17:30:44 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id n9sm738793pjt.29.2020.04.30.17.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 17:30:44 -0700 (PDT)
Date:   Thu, 30 Apr 2020 17:30:41 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v9] credential-store: warn instead of fatal for bogus
 lines from store
Message-ID: <20200501003041.GD33264@Carlos-MBP>
References: <20200430011959.70597-1-carenas@gmail.com>
 <20200430160642.90096-1-carenas@gmail.com>
 <xmqq1ro4sp1p.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1ro4sp1p.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 01:21:06PM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:
> > @@ -23,17 +34,24 @@ static int parse_credential_file(const char *fn,
> >  		return found_credential;
> >  	}
> >  
> > -	while (strbuf_getline_lf(&line, fh) != EOF) {
> > -		credential_from_url(&entry, line.buf);
> > -		if (entry.username && entry.password &&
> > -		    credential_match(c, &entry)) {
> > +	while (strbuf_getline(&line, fh) != EOF) {
> 
> Hmph, I probably have missed some discussion that happened in the
> last few days, but from the use of _lf() in the original, I sense
> that it is very much deliberate that the file format is designed to
> be LF delimited records, *not* a text file in which each line is
> terminated with some end-of-line marker that is platform dependent.
> IOW, an explicit use of _lf() shouts, at least to me, that we want a
> sequence of LF terminated records even on Windows and Macs.

apologize for the confusion, the only discussion was the one I had
with myself late at night when I realized that specific corruption
was not being detected, and might be related to issues that seemed
to be common[1]

the problem is that practically speaking, if users in Windows and Macs
edited the file they "might" had saved lines with the wrong line ending (*)
(part of the reason I added a warning about "encoding" to the documentation),
and those are difficult to "see" as invalid.

using the non _lf() version ensures any trailing '\r' character would
get removed from the credential and allow us to use them, instead of
silently failing.

originally I added a explicit check for it, which I assume you would prefer
but .. 

> So, I am not sure why this change is desirable.

to give users immediate relief from what seems to be a commonly seen issue.

IMHO after we get this released out and they see the updated documentation
explaining the risks, and some learn how to fix their credential files (
and hopefully use an editor that lets them see the problem); we could then
add also a detection for this edge case and go back to _lf()

I also had to admit I might had overreacted, as I was testing before v8 with
a very corrupted file and was seeing warnings twice on each operation and
somehow even got myself into the original fatal, which I had to admit I can't
replicate now after some needed rest.

Carlo

[1] https://github.com/desktop/desktop/issues/9597

(*) textedit, which comes with macOS doesn't even write an EOF record when
    creating files, for example, and that behaviour seems to be common for
    most other native editors but a credential line WITHOUT line ending works
