Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A9DC433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 00:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945A223104
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 00:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbhATALe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 19:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbhATAKj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 19:10:39 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2923C061575
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 16:09:58 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e9so7343619plh.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 16:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=c+2W5RsyzS8o7scDyLNim/3R/AT5lGc22Sd6mkveNow=;
        b=WbPYFyJCBJDHTakB7HhlklxHNVxdF/cxtFQrdlLLh49ZcWH5ZDdBeHnh/BqUQYLl8v
         nl8xbiZoo8Hk1nmuN55lNwmPnHi2Roxq9huyoTpKKshvzdvQmTNeZHjHXM/ozj3fgUxI
         lvUtBOl5EatFq6umCt6Z+P19XDianKAPbIZqHj+/ZFtqOUWpNAwxinEW7CNyzV07bemA
         uPDbTjMHumYSFq349VYp1mWdLo2t1dBTAEsL33BkFs6oTGWFvtaUlgjSivztwcEdr0g2
         guLcsAoaA46qiWFK1x6bLXXVO1kcCKkCkdoxHkF7+yPYdPC2sNJFMdsnEf7VW4sKPLSQ
         nulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c+2W5RsyzS8o7scDyLNim/3R/AT5lGc22Sd6mkveNow=;
        b=m6xed/ON3zn5TFrOp96Q1K7ZHSa1ERHrnoAjmbIDLr4ZOclMV1tAoMvlXq/pu5Djsf
         O7qOdmDpHQoRU67hTBa6Uo0lH3zcRJZsGyo9SsZk+tdYDKSoUHjSHz3yFz0aOkFOpQWw
         WSrOWSOzXQd1H82bPd9/XkOYXc5mzlFtps/KFBmznqWPSn1gPELffuvSgpjHAKE0QWit
         r9DfKWI/k3nHxF2DSwYVmWmBtjYKs3EejignialQKgfHS9jgUh/1iFtAZjmTLa5wqv9n
         O7FH5iuNCpSVZbiSgmpUj0gybuvID3HtNiSB3btd1Y21XFXXG+sv2QOnu3Cso+M5PLCH
         Shpg==
X-Gm-Message-State: AOAM5317PdLky8oRgKKTQ55/VuIsCOIQIoeYFeMZuYarWmvGSCAc7uWM
        iaDYA4WXXzg9z+akjtqMVDs=
X-Google-Smtp-Source: ABdhPJyyMLdFFuc9APWBnZswg7dlxCFCZW/aCfzzJ+hmgocVvDBdbaF0QNC1R3vsrbj8b95+iu7VIw==
X-Received: by 2002:a17:902:a5cb:b029:de:cd0b:1424 with SMTP id t11-20020a170902a5cbb02900decd0b1424mr3553741plq.63.1611101398472;
        Tue, 19 Jan 2021 16:09:58 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:4575:ac29:34a5:6fb8])
        by smtp.gmail.com with ESMTPSA id b185sm218020pfa.112.2021.01.19.16.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 16:09:57 -0800 (PST)
Date:   Tue, 19 Jan 2021 16:09:55 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Developer support list for Wireshark <wireshark-dev@wireshark.org>
Cc:     Joey Salazar <jgsal@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Wireshark-dev] Multiple-line parsing of packets dissected over
 HTTP
Message-ID: <YAd0044tbht/DOKq@google.com>
References: <s1Sx5qZaXOlypsQCtHxGBayhdqUl1j2vuywQN6cG59KarFM9HZu32n0CEtcje206DeKXAYuqBoNbDOA8bgwXZI3u_3nwPxYFme2GcqV0I3s=@protonmail.com>
 <CAGka-81Ze71igsW2zsfzYqqkr+sz5FE6YYo3mEpdEQUSUxZvaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGka-81Ze71igsW2zsfzYqqkr+sz5FE6YYo3mEpdEQUSUxZvaw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Pascal Quantin wrote:
> Le mar. 19 janv. 2021 à 17:45, Joey Salazar via Wireshark-dev <
> wireshark-dev@wireshark.org> a écrit :

>> In commit 33af2649 [1] we can keep dissecting the contents of the req,
>> adv, and res packets by setting
>>  while (plen > 0) { }
>> either in `dissect_git_pdu()` or in `dissect_one_pkt_line()`, but for now
>> in `dissect_git_pdu()` it'd be a bit messy, so wanted to ask for your
>> feedback for getting `dissect_one_pkt_line()` to work properly first.
>>
>> As you can see in pcap 169 [2], it correctly parses the length of the
>> first line as 0x0014 (20 bytes) until `0x0a`, then it's supposed to get the
>> length of the next line by the first 4 hex bytes in that line, but instead
>> of reading the length as 0x0018 (24 bytes) it's reading it as 0x0010 (16
>> bytes), and anyways, this particular line's length actually is 59 bytes.

Interesting.  Let me summarize your question: getting the information
in one place here, the relevant code at line 114 looks like

| +  while (plen > 0) {
| +    proto_tree_add_uint(git_tree, hf_git_packet_len, tvb, offset, 4, plen);
| +    offset += 4;
| +    plen -= 4;
| +
| +    proto_tree_add_item(git_tree, hf_git_packet_data, tvb, offset, plen, ENC_NA);
| +    offset += plen;
| +    // To-do: add lines for parsing of terminator packet 0000
| +  }

The relevant part of the pcap is shown in an image; transcribing
imperfectly, I see

| 0014command=ls-refs\n
| 0018agent=git/2.29.0.rc2
| 0016object-format=sha1
| 0001
[etc]

where \n denotes a newline byte and there are no newlines between
these pkt-lines.

That first pkt-line has 4 bytes for the length, followed by 12 bytes
for "command=ls-refs\n", including newline.  So why does this parse as

	packet-length: 0x0014
	packet data: "command=ls-refs\n"
	packet-length: 0x0010
	packet data: "agent=[etc]"

?

[...]
> So what is the code leading to this dissection? It does not seem to be
> https://gitlab.com/joeysal/wireshark/-/commit/33af2649927cb5660d4aeb64b9a9e9a58a1823aa
> as dissect_one_pkt_line() seem to read only one line (BTW using a while
> loop in this commit is useless as you are incrementing offset by plen, and
> the code you shared considers that plen includes the 4 bytes of the packet
> length field while your screenshot does not assume that).

This reply is a bit dense, but it contains the hints to move forward:

First, there's the matter of the contract of the dissect_one_pkt_line()
function.  The name suggests it would dissect a *single* pkt-line, but
it has this loop in it.  What does it actually do?  And what do we
want it to do?

That second question is easy to answer: this code will be much easier
to read if dissect_one_pktline dissects a single pkt-line!  For
example, if we imagine a contract like

	/** Dissects a single pkt-line.
	 *
	 * @param[in] tvb Buffer containing a pkt-line.
	 * @param offset Offset at which to start reading.
	 * @param[out] tree Tree to attach the dissected pkt-line to.
	 * @return Number of bytes dissected, or -1 on error.
	 */
	static int dissect_one_pkt_line(tvbuff_t *tvb, int offset, proto_tree *tree)

then we could call this in a loop, like:

	int offset = 0;

	while (offset < total length)
		offset += dissect_one_pkt_line(tvb, offset, tree);

Obtaining the total length and including some error handling left as
an exercise to the reader.

As for the first question: what does the current code do?  The loop at
l114 doesn't modify plen except by subtracting 4 from it.  So instead
of reading the pkt-length from the next pkt-line, it assumes it is 4
bytes less.  0x14 - 4 is 0x10, hence the 0x10 as pkt length
assumption.

Thanks and hope that helps,
Jonathan
