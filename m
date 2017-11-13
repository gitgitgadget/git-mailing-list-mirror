Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9141F43C
	for <e@80x24.org>; Mon, 13 Nov 2017 06:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbdKMGyO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 01:54:14 -0500
Received: from avasout06.plus.net ([212.159.14.18]:39572 "EHLO
        avasout06.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751583AbdKMGyN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2017 01:54:13 -0500
Received: from hashpling.plus.com ([212.159.69.125])
        by smtp with ESMTP
        id E8dGeS4zZFv8cE8dHeRKRE; Mon, 13 Nov 2017 06:54:12 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Ful1xyjq c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=kj9zAlcOel0A:10 a=sC3jslCIGhcA:10 a=BNFp--SqAAAA:8 a=IiEBc0-VF2folawl5A8A:9
 a=CjuIK1q_8ugA:10 a=wCHOS_8tIzIYXQCUOVd6:22
Received: from charles by hashpling.plus.com with local (Exim 4.89)
        (envelope-from <charles@hashpling.org>)
        id 1eE8dG-00077K-Kz; Mon, 13 Nov 2017 06:54:10 +0000
Date:   Mon, 13 Nov 2017 06:54:10 +0000
From:   Charles Bailey <charles@hashpling.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] Fix NO_LIBPCRE1_JIT to fully disable JIT
Message-ID: <20171113065410.rb43utcbncy7ndrv@hashpling.org>
References: <20171112165938.8787-1-charles@hashpling.org>
 <87tvxzxm0j.fsf@evledraar.booking.com>
 <xmqqmv3qal78.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmv3qal78.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfMoePLNo0KJ6HEuZ69GV+0OnJbM1VqXO2icb263b+1ZdPTg0QhTs8LB2KXED9Yiu6z22xhtKvOlvIcN64FBhHE+70igpfKkHgQLJ9vP43xPZMo6TOhfk
 fXN99K8TohYIhDc/OFbajA+pL0XHUIqX7kejbxxYV/QFTYv0tdHU2UlX2LsQLnp9C+5IshlSNG7kJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 12:53:15PM +0900, Junio C Hamano wrote:
> 
> Thanks.  This patch needs a sign-off, by the way.

Signed-off-by: cbailey32@bloomberg.net

(I can resend the full patch if required or if anyone requests futher
changes.

> > But that we should take it anyway regardless of that since it'll *also*
> > work on Linux with your patch, and this logic makes some sense whereas
> > the other one clearly didn't and just worked by pure accident of some
> > toolchain semantics that I haven't figured out yet.
> 
> That is curious and would be nice to know the answer to.

The error that I was getting - if I remember the details of the very
brief debugging session that I performed - was an unaligned memory
access causing a SIGBUS in PCRE code whose function name contained 'jit'
and which was being called indirectly from pcre_study.

My guess is that we are just exposing a pre-existing bug in our Solaris
build of libpcre. Unaligned memory accesses on x86 / x86_64 "only" cause
performance issues rather than fatal signals so even if the same bug
exists on Linux it probably has no noticeable effect (or at least no
noticed effect).

Charles.
