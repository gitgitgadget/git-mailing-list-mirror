Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22FD6215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 21:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbcJLV2f (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 17:28:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54869 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751959AbcJLV2e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 17:28:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2108F4557A;
        Wed, 12 Oct 2016 17:28:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VlvjpSVklUFCu07MueXEg6FDdCg=; b=bqLD4A
        n9nQPcLogq7FTwhst4+++Seh7MGuMvAS0XFigosIuJ3tJKvbBWE26oP3Tjwis2O+
        FP2Q9XJ5L4O+RVm6W6AGoMRagbKMoY8AJkGNSt3S3ctU9u09rTyu7viI4t3H/03E
        YZRyP5zJsaN40uXNQt9JbQ+V8T5Lll4jjiNMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b6kV82nhu38rqGXVxSvTmbwXOX0aZiIb
        aF2HmPn3Hg7TfWGXs8yxwCFcw9VnFUk6zc6OMjSDOLgxKYk9ZG6kIc6fQG9lZYsX
        BbcL1DhxCV/w1JTOnEk5/ggM329TXbwfOIuTLJNse74fkO/3MiJiCeQf3f0Xb9dX
        kIIV6WpwHYk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1988D45578;
        Wed, 12 Oct 2016 17:28:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8BD9945576;
        Wed, 12 Oct 2016 17:28:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
References: <20161011235951.8358-1-sbeller@google.com>
Date:   Wed, 12 Oct 2016 14:28:30 -0700
In-Reply-To: <20161011235951.8358-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 11 Oct 2016 16:59:51 -0700")
Message-ID: <xmqqh98h2r5t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3621DBC-90C2-11E6-8A13-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This version adds the actual thread safety,
> that is promised in the documentation, however it doesn't add any optimization,
> i.e. it's a single global lock. But as we do not expect contention, that is fine.

Because we have to start _somewhere_, I agree it is a good approach
to first try the simplest implementation and then optimize later,
but is it an agreed consensus that we do not expect contention?

