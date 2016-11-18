Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C6F31FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 23:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbcKRXiz (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 18:38:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52121 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752174AbcKRXiy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 18:38:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C8C55036B;
        Fri, 18 Nov 2016 18:38:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d2EAgPbZ/rgucmvLN6h7SDJH3LQ=; b=DbWfOj
        FQt6o6jRQ2pY9KH2JIH9TeAqMrJtcliem8JKZvxsuLNlsORb0eKE73TcYwg1VLH6
        7TphHoaKQDw2BN3RsVCFf16MPmuEfhtJRli4EdkOHfkcnZR8eW60GIgUS+6+dAwA
        QbF4rCBYtP+m5VQ2aqda7SJFQ7/pdFZOUPoHM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S2vL/pbI7FRY7SCxeTp85OQ6++JydGWu
        yORotPxKE27Qpogjsw7bnKi/5vkyQhKR8DvlsCzK4vLC7RlDEmT7dg7CtZZGUiFU
        qEBmWfKmWhgchIWLs05Qv/St8ke3Z56n0Yidctw1L0L5VxLONr5J1eYvocybx3Lj
        9TZ65BsETdo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 843D25036A;
        Fri, 18 Nov 2016 18:38:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED82E50369;
        Fri, 18 Nov 2016 18:38:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/2] add format specifiers to display trailers
References: <20161118230825.20952-1-jacob.e.keller@intel.com>
Date:   Fri, 18 Nov 2016 15:38:51 -0800
In-Reply-To: <20161118230825.20952-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Fri, 18 Nov 2016 15:08:23 -0800")
Message-ID: <xmqq8tsgl5o4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29FE0C48-ADE8-11E6-AF14-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> Git interpret-trailers will not recognize this as a trailer block
> because it doesn't have any standard git tags within it. Would it be ok
> to augment the trailer interpretation to say that if we have over 75%
> trailers in the block that we accept it even if it doesn't have any real
> recognized tags?

I thought the documented way to do this is to configure one of your
custom trailer as such.  Jonathan?

>   pretty: add %bT format for displaying trailers of a commit message

Are %(...) taken already?  In longer term, it would be nice if we
can unify the --pretty formats and for-each-ref formats, so it is
probably better if we avoid adding any new short ones to the former.

We have %s and %b so that we can reconstruct the whole thing by
using both.  It is unclear how %bT fits in this picture.  I wonder
if we also need another placeholder that expands to the body of the
message without the trailer---otherwise the whole set would become
incoherent, no?

