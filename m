Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7622C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 19:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241076AbiC2T7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 15:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbiC2T7J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 15:59:09 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD5E6D38B
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 12:57:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 856DC196436;
        Tue, 29 Mar 2022 15:57:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zGQFh6W8nuO2xmK7t9S2iGtbg09VroQqOz/bHr
        eqOwQ=; b=g9ghDSEsKd3WTZSruliGzLUMFQ3ep3O2SiJiyqVXLfc05q+FaYWek0
        IMTR6ryf5OLbA+x6iXTcCGQ7GZyZhyCxgXEytJyYjTNK6P3mkkcoUVZRY6jr16Aa
        m/2Rt2JFIwV4166XnxOna5N1aSFP+fU138aIOn1q+Zev5JxZ/f1ek=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7DA3C196435;
        Tue, 29 Mar 2022 15:57:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE8CB196434;
        Tue, 29 Mar 2022 15:57:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v3 3/3] object-info: add option for retrieving object info
References: <20220208235631.732466-1-calvinwan@google.com>
        <20220328191112.3092139-1-calvinwan@google.com>
        <20220328191112.3092139-4-calvinwan@google.com>
Date:   Tue, 29 Mar 2022 12:57:18 -0700
In-Reply-To: <20220328191112.3092139-4-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 28 Mar 2022 19:11:12 +0000")
Message-ID: <xmqq7d8cttup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 711E1A28-AF9A-11EC-A5D0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> diff --git a/transport-internal.h b/transport-internal.h
> index c4ca0b733a..04fa015011 100644
> --- a/transport-internal.h
> +++ b/transport-internal.h
> @@ -59,6 +59,7 @@ struct transport_vtable {
>  	 * use. disconnect() releases these resources.
>  	 **/
>  	int (*disconnect)(struct transport *connection);
> +	int (*fetch_object_info)(struct transport *transport, struct oid_array *oids);
>  };
>  
>  #endif

We need something like this squashed in in order to pass "make hdr-check".

 transport-internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/transport-internal.h b/transport-internal.h
index 04fa015011..1416c9197b 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -5,6 +5,7 @@ struct ref;
 struct transport;
 struct strvec;
 struct transport_ls_refs_options;
+struct oid_array;
 
 struct transport_vtable {
 	/**
-- 
2.35.1-887-g427ebd35eb

