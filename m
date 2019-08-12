Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03DAF1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 16:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfHLQt2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 12:49:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60602 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHLQt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 12:49:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F259F7D99E;
        Mon, 12 Aug 2019 12:49:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hEA+63Sch21BXSviOoo0Ugpqx1I=; b=MdpVw0
        +eGM7QV/b570w6rMOFslb0ztKevKRNkL+2HiZou4R66nd8itgPZTWVmjCE0OQ+yq
        miJd6N+wJ/eW9UxZVoiSS1PljC3omtvbf9GaEug1W6v8tcD3+RqlKPkuLoYiNHf8
        NY2k+X+f3TK7aE8ECQimbO05mDSkZmEQgvw8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=njnG05ieec34xJL6+dn3Is4IXyBk3B06
        tykwMmLqXDkntlUHOf/BBd5bLOLyluFrVxQH36O8qtOBCrqqNAkpLz5qPJmwtv2U
        eEMmv109cz2il2FQUivA0dcj/hCqn7x3jfrO99r7fOuLNh0rfFfa2ofHhXeM2t5C
        RIoz1DoHDCY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E95667D99C;
        Mon, 12 Aug 2019 12:49:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2517B7D99B;
        Mon, 12 Aug 2019 12:49:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] path: add a function to check for path suffix
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
        <20190811174748.33552-1-sandals@crustytoothpaste.net>
        <20190811174748.33552-2-sandals@crustytoothpaste.net>
        <xmqq1rxrcjfp.fsf@gitster-ct.c.googlers.com>
        <20190812011054.GA9180@genre.crustytoothpaste.net>
Date:   Mon, 12 Aug 2019 09:49:20 -0700
In-Reply-To: <20190812011054.GA9180@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 12 Aug 2019 01:10:54 +0000")
Message-ID: <xmqq7e7iba7j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2315C2AE-BD21-11E9-A22F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2019-08-12 at 00:32:26, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> > +static ssize_t stripped_path_suffix_offset(const char *path, const char *suffix)
>> 
>> Perhaps
>> 
>>     static ssize_t last_path_component_offset(const char *path, const char *name)
>> 
>> I am tempted to also call the second parameter to this function
>> "basename", as we know from the proposed log message that you wish
>> "basename" were usable for this purpose, but basename itself has
>> another confusing factor (i.e. "are we stripping ".exe" extension?",
>> to which the answer is no in the context of these functions).
>> 
>> If we agree with the "last path component" phrasing, has_path_suffix()
>> would become something like:
>> 
>>     int last_path_component_equals(const char *path, const char *name);
>
> Except this is not necessarily the last path component. It could match
> one or more path components with the way the function is written.

That's fair.  Is the feature that allows the function called
ends_with_component*S* like Szeder suggests designed one, i.e. with
an explicit purpose of supporting callers that pass "foo/bar" as the
"suffix" to it, or is it merely that the implementation happens to
work that way, even though the expected use that is supported is to
pass only one level component but the implementation did not even
bother asserting that the "suffix" does not have a slash in it?

