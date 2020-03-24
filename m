Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33A5C43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 15:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864F62076F
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 15:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b55VoxsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgCXPog (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:44:36 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:36605 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgCXPog (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 11:44:36 -0400
Received: by mail-lf1-f52.google.com with SMTP id s1so13613284lfd.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=IWmkmgc3uwNkvMODKS3tZDlm8YjtouJ+Lk9LTzMTaIw=;
        b=b55VoxsDx0A+AnV27o+topmPrtMuIn3Rs0ePj4N3sBTnxiG0Uw6xyM1pBEeTKZAAUY
         +8vhLkaNgDJituKKcdcKRPaO6OYWGbbQ7KL5DbbhZF+MXHx/bUGSqYSIdm/qpPdtWbeS
         CqkWTHmycmeL6arvjP5BpCnYBInXdlKuvYXMaPUa/mn4KxpcuIRYlb2OYBCvFGwl0Dgl
         ZqzbtedusdSfnXS3jHHo+n+Kva8RXAdBdaQxGgKYAsBEIP0t/hxu3OwPuGjX3IIIYsBm
         f7dbj2PKI2qStUE4DV86xdV2s1i93kMa/qocmXoupU26zpcw/6T3TBMxegQlONZn+CH/
         FZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=IWmkmgc3uwNkvMODKS3tZDlm8YjtouJ+Lk9LTzMTaIw=;
        b=HUwUvg3Ej9QJr2r3MCKV9Pce4H/bS49Z8Qbyu4XWYm9BPrrwbrYNtwoNHrI2J+8pS+
         JykgwJZDMGilalRu3pB7wvnWJGiV3NGNmde5AmEkVeRH+qM/icFVDEBXlVA4sWnt+8Ek
         DVl2Dym4y3dAoIL7nQVuJGaYy4xupEpnEN+Ahcu1ESpsc5zA6AqBchIBYQA3YeLkJ1Jt
         kHUmCjwVkWFRDHHitODURcp1qWPvt8GwUfltNRVEsl4PlcNgfmOGtvGp6mhuI+M2jQvG
         r/36ZWPp0NyAeaEPQ7wMAMXdGFO0xRzl+OlTerAeIuvDxaAk/QaSc2jMnURaI8HzIPN1
         qrmg==
X-Gm-Message-State: ANhLgQ375sKqQjx5bdfrRvx/ioHhf1XklyCeGx8uu5wymaqUToAwy+rO
        QVs5B0EEXxwNaQA/ulDHS/4=
X-Google-Smtp-Source: ADFU+vt/bXRgsUOxO+xeNRsm8pjyE8HDechJ43wVJU+NOOJ7elTsdOnGCq7hWqAuLX0iyNImjN/C+Q==
X-Received: by 2002:a05:6512:1109:: with SMTP id l9mr17091687lfg.50.1585064673670;
        Tue, 24 Mar 2020 08:44:33 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id i22sm9699348lfl.78.2020.03.24.08.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 08:44:32 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC][GSoC] Implement Generation Number v2
References: <20200322093526.GA4718@Abhishek-Arch> <86eetkrw8p.fsf@gmail.com>
        <20200323042517.GA1258@Abhishek-Arch>
        <xmqq369z7i1b.fsf@gitster.c.googlers.com> <86mu87qj92.fsf@gmail.com>
        <xmqqtv2f5a6x.fsf@gitster.c.googlers.com>
Date:   Tue, 24 Mar 2020 16:44:28 +0100
Message-ID: <86k139ahb7.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> About moving commit data with generation number v2 to "CDA2" chunk: if
>> "CDAT" chunk is missing then (I think) old Git would simply not use
>> commit-graph file at all; it may crash, but I don't think so.  If "CDAT"
>> chunk has zero length... I don't know what would happen then, possibly
>> also old Git would simply not use commit-graph data at all.
>
> Yeah, if it makes it crash, then we cannot use that "missing CDAT"
> approach.

I have not tested this, but from reading the code it looks like "missing
CDAT" makes Git fail softly -- it would return NULL for the
commit-graph, and thus not use commit-graph data at all... which might
be too high a price (too high performance penalty for old Git).

>> Putting generation number v2 into separate chunk (which might be called
>> "GEN2" or "OFFS"/"DOFF") has the disadvantage of increasing the on disk
>> size of the commit graph, and possibly also increasing memory
>> consumption (the latter depends on how it would be handled), but has the
>> advantage of being fullly backward compatibile.  Old Git would simply
>> use generation numbers v1 in "CDAT", new Git would use generation
>> numbers v2 in "OFFS" -- combining commit creation date from "CDAT" and
>> offset from "OFFS"),
>
> Do we have an option *not* to record meaningful generation numbers
> in CDAT and have the current Git binaries understand and still use
> the rest of the graph file, while not using the optimizations that
> rely on having generation numbers?  If not, then the new version of
> Git that tries to be compatible with old one needs to compute both
> generation numbers, and we would need to keep the topological number
> for quite some time.

We can, as Derrick Stolee wrote, put zero (GENERATION_NUMBER_ZERO) for
generation number.  Without generation number data we lose some of
performance improvements, though.

On the other hand computing generation number v1 (topological level) and
generation number v2 ([monotonic] offset for corrected commit date)
should not be much more costly than calculating single generation
number, assuming that most of the cost is walking the commit graph.  But
this would need benchmarking.

Also, as Stolee wrote, with generation number v2 in separate chunk we
have commit data not together, but split into two areas.

>> and there should be no problems with updating
>> commit-graph file (either rewriting, or adding new commit-graph to the
>> chain).
>
> Would merging by the current Git also work well (meaning, would
> "GEN2" or whatever it does not understand be omitted)?

From the analysis of write_commit_graph_file(), it looks like unknown
chunks are simply skipped (ommitted), but I have not checked it in
practice.

Best,
--=20
Jakub Nar=C4=99bski
