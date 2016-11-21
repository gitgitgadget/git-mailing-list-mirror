Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFE031FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 17:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbcKURXd (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 12:23:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58492 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753586AbcKURXc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 12:23:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38F5E512E2;
        Mon, 21 Nov 2016 12:23:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hJecjDdlIh91/I9uPrdASRUtV1A=; b=xNgmpt
        3koXlqgaPTjwJegKquR/X7SXgYqG57aI4D3ZSyQGsNouXGckFZTFaDdkbaQjizq0
        ydkFbIQXTBOuIEuNIXMfJ5D9TIHtoW3dd/GfuGFM2ao0X6W1/IIwtTJZWdarfw+h
        AKY1wU1IPLR70sWKLT2q5TBqDNGQtEfxnlRNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sAIKK4zaFkojjFD/8q9UmcctHfa+ZPF8
        OjIigAya1Yocp7eAXxEiMn70FXktC8fHSvY1jcWxzk8/4gARVU4ThXAy/YD4Ta5Y
        dtsYfxSbLfm+OvfAQaMdxCjCAZSwUF0yFPsxPuQpMt+BRpeLAn4nv1kRj2KXmS/K
        6jn7T24iriQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30737512E0;
        Mon, 21 Nov 2016 12:23:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9FF35512D4;
        Mon, 21 Nov 2016 12:23:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] add format specifiers to display trailers
References: <20161118230825.20952-1-jacob.e.keller@intel.com>
        <xmqq8tsgl5o4.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xrQEBYQQhqJQQCpLrs+4WOJOvH1X27w5Ou=2VPT=FegGQ@mail.gmail.com>
Date:   Mon, 21 Nov 2016 09:23:29 -0800
In-Reply-To: <CA+P7+xrQEBYQQhqJQQCpLrs+4WOJOvH1X27w5Ou=2VPT=FegGQ@mail.gmail.com>
        (Jacob Keller's message of "Fri, 18 Nov 2016 15:42:52 -0800")
Message-ID: <xmqqwpfwkar2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38E1ECC4-B00F-11E6-BA2B-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>> We have %s and %b so that we can reconstruct the whole thing by
>> using both.  It is unclear how %bT fits in this picture.  I wonder
>> if we also need another placeholder that expands to the body of the
>> message without the trailer---otherwise the whole set would become
>> incoherent, no?
>
> I'm not entirely sure what to do here. I just wanted a way to easily
> format "just the trailers" of a message. We could add something that
> formats just the non-trailers, that's not too difficult. Not really
> sure what I'd call it though.

I was wondering if %(log:<name of a part>) was a better way to go.

%(log:title) and %(log:body) would be equivalents of traditional %s
and %b, and %(log:body) in turn would be a shorter way to write
%(log:description)%+(log:trailer), i.e. show the message body, and
if there is a trailer block, add it after adding a blank line.

Or something like that?
