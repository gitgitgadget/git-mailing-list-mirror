Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03BE820958
	for <e@80x24.org>; Mon, 20 Mar 2017 22:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754780AbdCTWch (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 18:32:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52453 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753439AbdCTWcg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 18:32:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BD0C815DF;
        Mon, 20 Mar 2017 18:32:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T5R5IVlGzVOYYgeeeFi+i6A4Fd4=; b=O6aZyX
        vFGOlIdIPfBicOkyw2/yXeCm64MppVcJCWODtCM0Xx9orHfLSv8Eh8wlf65RJ2CM
        25QOZ4/YX5l+sOpmg8HH64ErfVld1rPG2yYtPwmPdpkfBePn9tW4xivsDaMvFozB
        Pfe2Lvib28CEh9LpDW0DPOLD69O5IcxuS5rmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jda5bmIBqVz3Tu8vpH8NOE+8FaBTj17P
        KosVAz6+Q/s4D2JvNbQZoRbwtWwMoK3XoECsmCTJOos7tSyhTyLyEGdPSoMyFCh6
        Y18bQDTklVrocFWMzsTL4wXYXZRGjITZKuWWZ/K1p1J1TQDSBkoODfMRquDyquuR
        HYQQ2SOx2sY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75330815DE;
        Mon, 20 Mar 2017 18:32:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD2A1815DD;
        Mon, 20 Mar 2017 18:32:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/20] Separate `ref_cache` into a separate module
References: <cover.1490026594.git.mhagger@alum.mit.edu>
Date:   Mon, 20 Mar 2017 15:32:31 -0700
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu> (Michael Haggerty's
        message of "Mon, 20 Mar 2017 17:33:05 +0100")
Message-ID: <xmqqk27jtw8w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C147C2C-0DBD-11E7-97A3-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Michael Haggerty (20):
>   get_ref_dir(): don't call read_loose_refs() for "refs/bisect"
>   refs_read_raw_ref(): new function
>   refs_ref_iterator_begin(): new function
>   refs_verify_refname_available(): implement once for all backends
>   refs_verify_refname_available(): use function in more places
>   Rename `add_ref()` to `add_ref_entry()`
>   Rename `find_ref()` to `find_ref_entry()`
>   Rename `remove_entry()` to `remove_entry_from_dir()`
>   refs: split `ref_cache` code into separate files
>   ref-cache: introduce a new type, ref_cache
>   refs: record the ref_store in ref_cache, not ref_dir
>   ref-cache: use a callback function to fill the cache
>   refs: handle "refs/bisect/" in `loose_fill_ref_dir()`
>   do_for_each_entry_in_dir(): eliminate `offset` argument
>   get_loose_ref_dir(): function renamed from get_loose_refs()
>   get_loose_ref_cache(): new function
>   cache_ref_iterator_begin(): make function smarter
>   commit_packed_refs(): use reference iteration
>   files_pack_refs(): use reference iteration
>   do_for_each_entry_in_dir(): delete function

These mostly seem to be ref-cache but there is one mention of "refs
cache", and also the topic cover says ref_cache.  Which one is the
canonical one?  I'd assume it is "ref-cache" (or "ref cache").

The reason I am asking is because I wanted to give the three
"Rename" ones an "<area>:" prefix, and then noticed that the
shortlog output looked somewhat incoherent.

Thanks.
