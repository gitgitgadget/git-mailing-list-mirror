Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C45D20D0E
	for <e@80x24.org>; Fri, 27 Jan 2017 01:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753214AbdA0Bzl (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 20:55:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60268 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750944AbdA0Bzj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 20:55:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E434064274;
        Thu, 26 Jan 2017 20:54:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d60JWRfQVXyGOChqMm2g3qUyXGo=; b=EGZ4e9
        3mg39yUVkSDR7h6Z39GTD4yJRfMB1iHh6nRrYDL2JIU5QSwA+RcQNDt6mRblNFFE
        3hkonrYwNCrwZ/QE8OoCiXTIqNVxyAhBKPUJRCnBC2iTz6oFp9f/Q6M983o6Ce2+
        +t3vR1rXrhVXu56fje8//N9WCD/s2/NbSsSNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xm+tWz1hRgOIM/UKNZ/nGM+PAMSjrUJc
        Z8bQNzLWo6ZMF8Wbkje/icueA+4YIQ3HTHSXeTKuuEIZJmq0iykSq8OOPilhrakG
        Zil6uPdpmTkZDAd4HKeM4QfyPjgT4sbH7JaDphPmtEs9n3pWm9Cc0ufkBCg2zJyb
        2Qo4OWqs0nQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA20364273;
        Thu, 26 Jan 2017 20:54:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3827F64272;
        Thu, 26 Jan 2017 20:54:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC 02/14] upload-pack: allow ref name and glob requests
References: <cover.1485381677.git.jonathantanmy@google.com>
        <cover.1485381677.git.jonathantanmy@google.com>
        <d0d42b3bb4cf755f122591e191354c53848f197d.1485381677.git.jonathantanmy@google.com>
        <xmqqd1f931g7.fsf@gitster.mtv.corp.google.com>
        <dc09e446-6d29-8b94-f440-6aa094ab9dc9@google.com>
Date:   Thu, 26 Jan 2017 17:54:50 -0800
In-Reply-To: <dc09e446-6d29-8b94-f440-6aa094ab9dc9@google.com> (Jonathan Tan's
        message of "Thu, 26 Jan 2017 16:35:31 -0800")
Message-ID: <xmqqinp11d3p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97CA03B8-E433-11E6-9377-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> I am not sure if this "at the conclusion of" is sensible.  It is OK
>> to assume that what the client side has is fixed, and it is probably
>> OK to desire that what the server side has can change, but at the
>> same time, it feels quite fragile to move the goalpost in between.
>
> Do you have any specific concerns as to this fragility? Peff mentioned
> some concerns with the client making some decisions based on the
> initial SHA-1 vs the SHA-1 reported by "wanted-ref", to which I
> replied [1].

There were two but I think you are aware of both.  One is what Peff
already mentioned, the client may want to make the decision before
going through the negotiation.  The other is "moving the goalpost",
the history the last server has may violate the view of the history
common between the server and the client that is established during
the negotiation with previous servers.

