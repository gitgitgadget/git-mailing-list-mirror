Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963C7C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 04:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6547B2064B
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 04:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbhASEJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 23:09:13 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:47622 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbhASEJB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 23:09:01 -0500
Date:   Tue, 19 Jan 2021 04:07:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1611029252;
        bh=Q2PHDxiO44KS3hDnPHA9OOTcP6a5AU2hsrsCVkaLbbI=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=ffM6UASrcu4+LwEqLb7Yk6vyRHXRdv9LFagWygUxmiZ2arKaISlvldFbU4LfX+kV6
         GJJrpdmWY4BE/BHF1jzBt9miKcd6GyM7E+J2nrBg1b/4zyIs51kKV//uxxr84HBgwV
         HNdAYN+rZTgAylqIRhx5YAWS/stzTGyVwsM13t3Y=
To:     Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>
From:   Joey Salazar <jgsal@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: Multiple-line parsing of packets dissected over HTTP
Message-ID: <s1Sx5qZaXOlypsQCtHxGBayhdqUl1j2vuywQN6cG59KarFM9HZu32n0CEtcje206DeKXAYuqBoNbDOA8bgwXZI3u_3nwPxYFme2GcqV0I3s=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

In commit 33af2649 [1] we can keep dissecting the contents of the req, adv,=
 and res packets by setting
 while (plen > 0) { }
either in `dissect_git_pdu()` or in `dissect_one_pkt_line()`, but for now i=
n `dissect_git_pdu()` it'd be a bit messy, so wanted to ask for your feedba=
ck for getting `dissect_one_pkt_line()` to work properly first.

As you can see in pcap 169 [2], it correctly parses the length of the first=
 line as 0x0014 (20 bytes) until `0x0a`, then it's supposed to get the leng=
th of the next line by the first 4 hex bytes in that line, but instead of r=
eading the length as 0x0018 (24 bytes) it's reading it as 0x0010 (16 bytes)=
, and anyways, this particular line's length actually is 59 bytes.

Suggestions on how to approach this?

Thank you all,
Joey

[1] gitlab.com/joeysal/wireshark/-/commit/33af2649927cb5660d4aeb64b9a9e9a58=
a1823aa
[2] www.imgur.com/a/91GMo6U
