Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABF4C433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 21:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2EA61166
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 21:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhDNVVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 17:21:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52947 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhDNVUd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 17:20:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34DB0B830B;
        Wed, 14 Apr 2021 17:20:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DjInxyzndfU1xMnpAJmeqI7w6Mw=; b=pgLjlm
        4lT1e838DAdPLvzgym1n9c7Ks3k9qut/IT1pHHxb4WGPbgAM0+kLvgXPXMTvhGOf
        2zciKfyjarSzQbhWNViHDvmUEkvOHTuoRHD2+6cC7JfUi+6NYT0rnHySKeudK3r1
        7yl+7FD5mI1UYWVUZOVFKbU9HBNsi+dKz+mIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LhKGozQCnysgrBcLKarQ18woAuwMXQMe
        kql9/Ig85moz3UPxlGdcHEWP42zK+AWvOzZ3Z4nPd/NsGWoUV4A17O3XgT0Y2ooN
        TN0AGOG6nedSi84MqEu5SdpGA5gpgw7sc2HYPLj/YZlU8LGUwzRpvZD7b2u1IaAJ
        O+UUHnPS48w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 243EDB8305;
        Wed, 14 Apr 2021 17:20:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7CE4BB8303;
        Wed, 14 Apr 2021 17:20:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: What's cooking (draft for #4's issue this month)
References: <xmqqmtu1zn3o.fsf@gitster.g> <YHa5NE3tj/R5kF8N@ncase>
Date:   Wed, 14 Apr 2021 14:20:09 -0700
In-Reply-To: <YHa5NE3tj/R5kF8N@ncase> (Patrick Steinhardt's message of "Wed,
        14 Apr 2021 11:43:16 +0200")
Message-ID: <xmqqeefcy35i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31AA1FCC-9D67-11EB-8DBF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Apr 13, 2021 at 06:11:39PM -0700, Junio C Hamano wrote:
>> On 'seen' there are many topics that have not seen adequately
>> reviews; some tests are broken near its tip (I think they pass the
>> selftests by themselves).
>> 
>>     0e76df05ca Merge branch 'ps/rev-list-object-type-filter' into seen
>>     956fbceb2e ### breaks 6112 6113
>>     c007303ad4 Merge branch 'bc/hash-transition-interop-part-1' into seen
>>     4813f16161 ### breaks 0031
>
> Test breakage for the rev-list filter series has been a bad interaction
> of d8883ed540 (object.c: stop supporting len == -1 in
> type_from_string_gently(), 2021-03-28) and
> ps/rev-list-object-type-filter.

Yuck.  The commit d8883ed5 (object.c: stop supporting len == -1 in
type_from_string_gently(), 2021-03-28) by itself may have meant
well, but in an environment where concurrent group development is
the norm, it is a change that can unnecessarily break other topics
easily, like it just did.

Perhaps a band-aid like this may be necessary.

diff --git i/object.c w/object.c
index 68de229f1a..b4bde9e444 100644
--- i/object.c
+++ w/object.c
@@ -39,6 +39,9 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
 {
 	int i;
 
+	if (len < 0)
+		BUG("type-from-string-gently no longer allows unspecified length");
+
 	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
 		if (!strncmp(str, object_type_strings[i], len) &&
 		    object_type_strings[i][len] == '\0')

> The following patch fixes this, which
> I'll include in my next reroll of this series.

Thanks.

> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index 19e128ef11..33c7718a7a 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -100,7 +100,7 @@ static int gently_parse_list_objects_filter(
>  		return 1;
>
>  	} else if (skip_prefix(arg, "object:type=", &v0)) {
> -		int type = type_from_string_gently(v0, -1);
> +		int type = type_from_string_gently(v0, strlen(v0));
>  		if (type < 0) {
>  			strbuf_addstr(errbuf, _("expected 'object:type=<type>'"));
>  			return 1;

