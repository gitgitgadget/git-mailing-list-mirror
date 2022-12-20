Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C3CC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 01:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiLTBql (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 20:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiLTBqN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 20:46:13 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04D45F5D
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 17:36:33 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so10674818pjd.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 17:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybHdWBHLvPQW7wGy46PfSdp28AmDXXlB74CpFd1y+n8=;
        b=O36+5UFqViiI90dt88ZG65j4xwMO4rerOJBUv/ctsb+2U3dklM3j+KEe1gPsWpBAPZ
         DnKgSclkSUkBMrPKV+HgYxI0NdDG2gCAnU/zccnXoOg4fkZkkJWePpYzjE1q2cjyw6g+
         fl0crOraW+ERYm1waOqAewrFB8l5gHKltt+lPldz7HI3R1IfMiZ4ZoL/9+fL9Wp4ZTr4
         ZzW0jqt4qpDNq6fo2xCqRMrDthenPZ+sPyoW7waC/A6KCe9CGCE8BzLj5bn/f//aCZ1/
         ctBcDrqr2w19iVbcovmRSoLIwb0wM3DOC3CqkS+ro4XBjjlp8i/Epmajz2w21+tueOrf
         7CfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ybHdWBHLvPQW7wGy46PfSdp28AmDXXlB74CpFd1y+n8=;
        b=uCp6oxIYXrTuH/L+jn3P8rT7as3xtzE7oiJF6Lu4Icf3wwo/WwPyBrcLDkz1wp3dYT
         y+N71ZT+iadqOe5YpRHC85CxJ7blT0EsJgvOJbPHIubbcX6+QFIQecL/zP3Drg4cjPCf
         FxSXFeJdvT7tj7U9s/mw+rwXFkaFNr3P57MWmixT0MtGi7OWkR58JGr38RdSn4Ols26g
         M3a17nN+uiy8qo1hHVIQrExKuZib077PBh2aJxnUPAHy7E35UIEMMFpHmyDBTJKXq06m
         pvqNi+6fkeFVHnJw2f1ZKL6PUimeFdWFrsYWuiR+QUIRDIdxPIjQZtuK8ZrQu4s39ytb
         Q6Fg==
X-Gm-Message-State: ANoB5plyVo2x7/xeRQvLIZqyY+cH0DUuxyGct9SLLg1Nc84+HtO+IO2A
        u0/r/ne+HvL2tyrmp1tZwRkodRR6Aj8x4Q==
X-Google-Smtp-Source: AA0mqf4pzCPe09Bg9KQq1QOGXxkmNnQrZdZttTxQx+AnQ2Psx7AdBZJ3EK9a0COo8DopfZrMwhKWlA==
X-Received: by 2002:a05:6a20:6d03:b0:af:8786:f7d7 with SMTP id fv3-20020a056a206d0300b000af8786f7d7mr18845473pzb.21.1671500193335;
        Mon, 19 Dec 2022 17:36:33 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709027e4d00b00183c6784704sm7766692pln.291.2022.12.19.17.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 17:36:32 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Webster <chris@webstech.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] Make `check-whitespace` failures more helpful
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
        <67f60e4e5cbb470bbf3f556f962403af5dd5938c.1671179520.git.gitgitgadget@gmail.com>
        <xmqqo7s3mzlt.fsf@gitster.g>
        <CAGT1KpXDHc2bqiiPqxwBiW2UV8BKMnbKD68hKa3fHdCA5GDAzw@mail.gmail.com>
Date:   Tue, 20 Dec 2022 10:36:32 +0900
In-Reply-To: <CAGT1KpXDHc2bqiiPqxwBiW2UV8BKMnbKD68hKa3fHdCA5GDAzw@mail.gmail.com>
        (Chris Webster's message of "Mon, 19 Dec 2022 16:30:43 -0800")
Message-ID: <xmqq5ye6zwin.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Webster <chris@webstech.net> writes:

>> I suspect that we are already depend on <<< Bash-ism, so one more
>> dependency to Bash-ism is not a problem here?  I dunno.
>
> While GitHub could probably allow other shells to be used, changing
> the default would probably break a lot of things at this point.

Do we specifically ask for bash in our .github/ files?  That would
be perfectly acceptable.  Then we only have to worry about their
withdrawing support for bash which would never happen ;-)

Thanks.
