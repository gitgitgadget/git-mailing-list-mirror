Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52B6C388F7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 21:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDD82083B
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 21:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tkaZK7nA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgKDV1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 16:27:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55105 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgKDV1A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 16:27:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 466E6F8A02;
        Wed,  4 Nov 2020 16:26:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pCkpi7J3nSXV55FblYwTsDBZWi8=; b=tkaZK7
        nAjNe1f5UQhxitza+jZff0cHD9BaSVdgnsIiAuNXntvDMfcjQTDzQmjOWhnucO3V
        pywUbG9YF0Co/uoSwR+DkNEhWaUVkpqOTSqU/ye4p4FdFwUFKztSHthu9t82wNNz
        qWGdjk1wHtrC5M3ErX35aJX1Ex+sqc8HmUbN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rZlia2SqnwtzlQIQ81YP2zU4J+j5+sgQ
        /crwlJMGOeRNfPzweBDVbwILhmCTXQF5iUQ1uIVTexWaMOPlShDyHVAKLv26LRuy
        jfXitD++qCffrXLu1dBXboN3s5gFnyBH0Bsu8DX371+qlu19q7n4aUlnEcliQJ1d
        617JyCCaMKo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3EA52F8A01;
        Wed,  4 Nov 2020 16:26:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8B68FF89FD;
        Wed,  4 Nov 2020 16:26:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 09/11] upload-pack, serve: log received client trace2
 SID
References: <cover.1604006121.git.steadmon@google.com>
        <cover.1604355792.git.steadmon@google.com>
        <23f44bc904dfdd31f68a27c587b4b61df4bc0041.1604355792.git.steadmon@google.com>
Date:   Wed, 04 Nov 2020 13:26:54 -0800
In-Reply-To: <23f44bc904dfdd31f68a27c587b4b61df4bc0041.1604355792.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 2 Nov 2020 14:31:07 -0800")
Message-ID: <xmqqeel8lso1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 772E3B20-1EE4-11EB-851E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> diff --git a/upload-pack.c b/upload-pack.c
> index 3bb01c5427..d938603c97 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1058,6 +1058,7 @@ static void receive_needs(struct upload_pack_data *data,
>  		const char *features;
>  		struct object_id oid_buf;
>  		const char *arg;
> +		int feature_len;
>  
>  		reset_timeout(data->timeout);
>  		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
> @@ -1109,6 +1110,12 @@ static void receive_needs(struct upload_pack_data *data,
>  		if (data->allow_filter &&
>  		    parse_feature_request(features, "filter"))
>  			data->filter_capability_requested = 1;
> +		if ((arg = parse_feature_value(features, "trace2-sid", &feature_len, NULL)))
> +		{

Style.  '{' block is opened on the same line as "if (condition)"
ends, e.g.

		arg = parse_feature_value(...);
		if (arg) {

Avoid assignment in the condition part of if/while unless there is a
compelling reason to do so.  e.g.

		if ((arg = ...) && further_check_on(arg)) {
			...

might be justifiable, but here, I do not see any such reason.

> +			char *client_sid = xstrndup(arg, feature_len);
> +			trace2_data_string("trace2", NULL, "client-sid", client_sid);
> +			free(client_sid);
> +		}
>  
>  		o = parse_object(the_repository, &oid_buf);
>  		if (!o) {

Thanks.
