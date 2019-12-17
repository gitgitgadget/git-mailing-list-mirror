Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6142EC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 01:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3090320CC7
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 01:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QApR6Hg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfLQBlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:41:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39317 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLQBlA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 20:41:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so6617835pfx.6
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 17:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZXi69IazBq94XCNWPovEdXUjfi1aZTSVZP4Mw1P2V8A=;
        b=QApR6Hg3QW3Zcqknq88uR6oNRkQGOAc6a4NXUUVpqQ+WPZPtT4POVP24oMuxUYdxfb
         vVGLIcFLBbAPE9VHl57du9rxUpNoPWfgHA/9hchE8iRnhDR01bPWfwvhDWkECbXdniuM
         S+OiHDtxP7E4YRUHBl3v1Qb4B2oSJ8zHQq604bfsveXWY+U/n3EvvQgy6BOkqr6gpDRa
         mTD1K5Bu0nsAkKkkS0dcye9aEWjPgIRD38JEe5I6XCf22ni5WFX65BorLK2xG2LKI6wO
         HtsMu+bVg65qW5Zqetma7Qu6x+rvcbkUUNyXaCgeyawqZ2rjUa6hYUbJgUQaymXndf2p
         yyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZXi69IazBq94XCNWPovEdXUjfi1aZTSVZP4Mw1P2V8A=;
        b=NE7+K3rrS346ipSSWCGqthpmtfV9rwx//TVKfhCjyTlIpIta/MERrw08/Nt8RuvH29
         fKwt35MKju4pKifGS8ItQfEMgwU3S30uAPP9untXPHgoTMmn8imQEOguPGMa8sg8F0C7
         aAlODA7cGy/7OuDJGjieASU/m3GSK98Ns+wi3Xo1egAAWh8KMg+GIpRWEPu9hqmeN7KQ
         Ne/6Sh0YW4Nr+hFFfI+ogpU9/Lj61cSphW7PUzwf1CsiNySNgG09uWy8kIPwFA2jWRSu
         2e4rAcXc6KHAJlfC7wFG9ffyOwyEO3LNu4t5tpJuROLWaml/9LeGeus4Mft7avswr/zF
         5FUA==
X-Gm-Message-State: APjAAAXtHpApPISPxPt8j6jDpoHzole+Ppqbr6qop40EPh8wXkz2n4XN
        sVTjvTkev8SDOq2KkFs+Av4=
X-Google-Smtp-Source: APXvYqyLkRMLzCc0NfBHeT5HeTIAT+KCTfycVfd1ZpuF676oIgxSRvWtYUEkp/kuxdLQYhbTC49dBw==
X-Received: by 2002:aa7:96b0:: with SMTP id g16mr7027434pfk.99.1576546859862;
        Mon, 16 Dec 2019 17:40:59 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id i4sm783231pjd.19.2019.12.16.17.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 17:40:59 -0800 (PST)
Date:   Mon, 16 Dec 2019 17:40:57 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] Makefile: drop GEN_HDRS
Message-ID: <20191217014057.GE10734@google.com>
References: <xmqq1rt7hkp6.fsf@gitster-ct.c.googlers.com>
 <20191214003820.GA927924@coredump.intra.peff.net>
 <20191214010002.GA945704@coredump.intra.peff.net>
 <xmqqlfrcje1f.fsf@gitster-ct.c.googlers.com>
 <20191216192014.GA2678964@coredump.intra.peff.net>
 <20191217012756.GQ135450@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217012756.GQ135450@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:
> On Mon, Dec 16, 2019 at 02:20:14PM -0500, Jeff King wrote:

>> But this would enable us to start checking command-list.h. I'm on the
>> fence on whether that's useful or not; the patch below makes it pass,
>> but I'm not sure if that is really turning up any useful problems. I
>> suppose somebody besides help.c could include command-list.h, in which
>> case some of those MAYBE_UNUSED bits could become useful.
>
> Firstly, I think if someone besides help.c includes command-list.h it
> blows up because there's no include guards :)
>
> My gut wants to say, "I need to be sure my generated header is correct!"
> But it seems that will also be checked when I try to include that header
> from something actually important. So maybe it's not actually useful.
> But then it seems like hdr-check target isn't that useful for anybody,
> since those headers should always be included sometime down the road (or
> why have them). So that makes me think I must still be missing
> something, like maybe I parsed hdr-check wrong.

"git log -Shdr-check Makefile" gives a hint:

  $ git log -Shdr-check Makefile
  commit ebb7baf02f69f2164b1f89148945d18c376fc6a8
  Author: Ramsay Jones <ramsay@ramsayjones.plus.com>
  Date:   Wed Sep 19 01:07:08 2018 +0100

      Makefile: add a hdr-check target

      Commit ef3ca95475 ("Add missing includes and forward declarations",
      2018-08-15) resulted from the author employing a manual method to
      create a C file consisting of a pair of pre-processor #include
      lines (for 'git-compat-util.h' and a given toplevel header), and
      fixing any resulting compiler errors or warnings.

      Add a Makefile target to automate this process.

So it's primarily about making sure that each header is #include-able
on its own (i.e., that it #includes the headers for any types it
relies on).

That seems like something I'd want to hold for command-list.h, too. :)

Thanks,
Jonathan
