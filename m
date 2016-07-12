Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D81841FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 17:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbcGLRHq (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 13:07:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62581 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750879AbcGLRHq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 13:07:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D243B2A7EC;
	Tue, 12 Jul 2016 13:07:44 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9RvPcSlnYGvd
	Tlem1qNFZjCgge8=; b=NzmFqYWP6mMapOZT65qjW0wUmnmY5mQ/B4X3jUYLTpvw
	exoVcrq1IZwS94y+ouny6DbX4McLZnnrLuPtIX0SNp7cFOtyMLxIekbFnO2bjCDD
	8G8Jl+k7LbaMJaDh5ZtXAF8E4Xc1m7M45+UOJj0nr0Fn8u5Mg8dkWFhtF8nwQfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KS7OXl
	rQfeEzEGKZUk4ZApA6TuMnVZ5uO2J67GQcqkCOO9UXPCJw6+axTpNMwBwAi2dM72
	wRek6YQiZulbrwkaapZNY0SJJblMfMgahzqmAbm0rC8oJ2jp3Niz1XkaiDwRCyJv
	8hi5U4TfGCgN3NDRnfmTDnXVDqIjUR9uP3540=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C9EA72A7EB;
	Tue, 12 Jul 2016 13:07:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 56FBC2A7E9;
	Tue, 12 Jul 2016 13:07:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, michelbach94@gmail.com
Subject: Re: [PATCH 0/5] Number truncation with 4+ GB files on 32-bit systems
References: <1466807902.28869.8.camel@gmail.com>
	<20160705170558.10906-1-pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 10:07:42 -0700
In-Reply-To: <20160705170558.10906-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Tue, 5 Jul 2016 19:05:53 +0200")
Message-ID: <xmqqshve6azl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 26505AC4-4853-11E6-9870-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Since I now could reproduce the problem that Christoph showed, I
> decided to send the good patches out. To sum up, we use "unsigned
> long" in some places related to file size. On 32-bit systems, it's
> limited to 32 bits even though the system can handle files larger than
> that (off_t is 64-bit). This fixes it.
>
> clang -Wshorten-64-to-32 is very helpful to spot these problems. I
> have a couple more patches to clean all these warnings, but some need
> more code study to see what is the right way to do.
>
> Most of the rest seems harmless, except for the local variable "size"
> in builtin/pack-objects.c:write_one(). I might send 6/5 for that one.


Thanks.

> Nguyễn Thái Ngọc Duy (5):
>   pack-objects: pass length to check_pack_crc() without truncation
>   sha1_file.c: use type off_t* for object_info->disk_sizep
>   index-pack: correct "len" type in unpack_data()
>   index-pack: report correct bad object offsets even if they are large
>   index-pack: correct "offset" type in unpack_entry_data()
>
>  builtin/cat-file.c     |  4 ++--
>  builtin/index-pack.c   | 23 ++++++++++++-----------
>  builtin/pack-objects.c |  2 +-
>  cache.h                |  2 +-
>  sha1_file.c            |  2 +-
>  5 files changed, 17 insertions(+), 16 deletions(-)
