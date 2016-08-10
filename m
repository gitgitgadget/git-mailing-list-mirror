Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DFEB1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 20:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933571AbcHJUdw (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 16:33:52 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62932 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933324AbcHJSQm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 14:16:42 -0400
X-AuditID: 1207440c-217ff700000008d5-0b-57ab60bb154e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 59.37.02261.BB06BA75; Wed, 10 Aug 2016 13:13:31 -0400 (EDT)
Received: from [192.168.69.130] (p5B104255.dip0.t-ipconnect.de [91.16.66.85])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7AHDTLv005868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 10 Aug 2016 13:13:30 -0400
Subject: Re: [PATCH 5/8] xdl_change_compact(): fix compaction heuristic to
 adjust io
To:	Junio C Hamano <gitster@pobox.com>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <ae7590443737a3996ec4973fd868ce89dc78a576.1470259583.git.mhagger@alum.mit.edu>
 <xmqqshuk2x3p.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <badb2c5b-e2da-03d0-e315-7b92659bb464@alum.mit.edu>
Date:	Wed, 10 Aug 2016 19:13:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqshuk2x3p.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1N2dsDrc4OIvU4uuK91MFg29V5gt
	di/uZ7ZYcXUOs8WPlh5mi82b21kc2Dx2zrrL7rFgU6nHs949jB4XLyl7fN4kF8AaxWWTkpqT
	WZZapG+XwJXRtPIVe8Er1ooTrb8ZGxjPs3QxcnJICJhIrJ26GMjm4hAS2Moo8bLrJiOEc5ZJ
	4trWu0AZDg5hgTCJvW+SQBpEBNQkJrYdgmrYySjRv/wNK0iCWeAco8T3KdogNpuArsSinmYm
	EJtXwF5i34znzCA2i4CqxPvpd8FsUYEQiW03G9ggagQlTs58AraLU8Ba4vXGCoiRehI7rv+C
	Gi8vsf3tHOYJjPyzkHTMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6
	qSmlmxghAc2zg/HbOplDjAIcjEo8vBuYVoULsSaWFVfmHmKU5GBSEuUVjlkdLsSXlJ9SmZFY
	nBFfVJqTWnyIUYKDWUmEty0CKMebklhZlVqUD5OS5mBREudVXaLuJySQnliSmp2aWpBaBJOV
	4eBQkuDljQdqFCxKTU+tSMvMKUFIM3FwggznARruD1LDW1yQmFucmQ6RP8Woy7Hgx+21TEIs
	efl5qVLivO4gRQIgRRmleXBzYInoFaM40FvCvAEgVTzAJAY36RXQEiagJUmqK0CWlCQipKQa
	GFPO7097Kq7ZY3ah4PiZWfs97ndOUY8vZyybtsx92qcTh/QSdk3g+R1UPlGv+Flb7jNPoynp
	WqY3zl652Bf65tL2tJn2vp9Tt9lcL+ZwtL3M523hp6BgoBxVbvl37yoXn8Jb95WOhCXY5n9L
	NJsX2plXMlU6YdajrX1rY0zNO4ttOv0m2e+QUWIpzkg01GIuKk4EAJxe0/sfAwAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 08:43 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> The code branch used for the compaction heuristic incorrectly forgot to
>> keep io in sync while the group was shifted. I think that could have
>> led to reading past the end of the rchgo array.
> 
> I had to read the first sentence three times as "incorrectly forgot"
> was a bit strange thing to say (as if there is a situation where
> 'forgetting to do' is the correct thing to do, but in that case we
> would phrase it to stress that not doing is a deliberate choice,
> e.g. 'refraining from doing').  Perhaps s/incorrectly // is the
> simplest readability improvement?

Yes, that makes it clearer. Will change.

Michael

