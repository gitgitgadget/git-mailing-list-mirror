Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C9691F406
	for <e@80x24.org>; Tue, 19 Dec 2017 21:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbdLSVmE (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 16:42:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54062 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753913AbdLSVi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 16:38:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70E24AFF17;
        Tue, 19 Dec 2017 16:38:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3m61fMhlhQ4BTY1Tj8/tFG9ogkk=; b=DV6Eyc
        DIclUlRh25cekU1XN666nBAkrUjCsQ00E97u8C6j1BP2Ct/4aZHtTQrDX5i7NrWs
        i24BDSaW8HA5YB2+zXtXJOO2uBJThktb4z5isUvzH0K+cH+bPXzAF7PzJLM/3G9c
        8iGGs3tODAYgZYhjutKvJEuqTVB+vfc3njqGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OUk8cn4JNu5AlIh4+SaPkRlSPb4KVE5g
        Bxxlzqj4OA5wJ5+q96PezdMz5I0jskWuiUyC+SzXNyMkUDgP72WCsj962/NxVgK5
        0jO6L46I7W1Ew9lY60r+GKswm2NQ4+dvU9xaHJqn3udx8rhlu3ia2FX4fYyUhWAl
        q2A++bHVftU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69980AFF16;
        Tue, 19 Dec 2017 16:38:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB2D5AFF15;
        Tue, 19 Dec 2017 16:38:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Wei Shuyu <wsy@dogben.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: support CURLPROXY_HTTPS
References: <20171219172401.5263-1-wsy@dogben.com>
        <20171219205807.GC240141@aiede.mtv.corp.google.com>
Date:   Tue, 19 Dec 2017 13:38:54 -0800
In-Reply-To: <20171219205807.GC240141@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 19 Dec 2017 12:59:21 -0800")
Message-ID: <xmqq7etiv1n5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03C801C8-E505-11E7-AEB7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Wei Shuyu wrote:
>
>> HTTP proxy over SSL is supported by curl since 7.52.0.
>> This is very useful for networks with protocol whitelist.
>>
>> Signed-off-by: Wei Shuyu <wsy@dogben.com>
>> ---
>>  http.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>
> Thanks for writing this.  Can you give an example of how I'd use it
> (ideally in the form of a test in t/ so we avoid this functionality
> regressing, but if that's not straightforward then an example for the
> commit message is fine as well)?

Just FYI, here is an entry I added to the What's cooking report
(which will be used as the log message for a merge commit that pulls
this topic in, and will become an entry in the release notes if this
topic ever becomes a part of a release).

 Git has been taught to support an https:// used for http.proxy when
 using recent versions of libcurl.

There are multiple ways other than http.proxy configuration variable
that a user can use to tell Git to use a proxy; I do not think the
log message of this change is a place to enumerate all of them, but
showing one of them to the readers would be good to remind them what
we are talking about, I would guess.

>> diff --git a/http.c b/http.c
>> index 215bebef1..32d33261c 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -865,6 +865,11 @@ static CURL *get_curl_handle(void)
>>  		else if (starts_with(curl_http_proxy, "socks"))
>>  			curl_easy_setopt(result,
>>  				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
>> +#endif
>> +#if LIBCURL_VERSION_NUM >= 0x073400
>
> Can this use #ifdef CURLPROXY_HTTPS instead?  That way, if someone's
> copy of curl has backported support then they get the benefit of this
> change as well.

It sounds like a worthwhile thing to do (assuming that these are
always implemented as preprocessor macros).

>> +		else if (starts_with(curl_http_proxy, "https"))
>> +			curl_easy_setopt(result,
>> +				CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
>>  #endif
>>  		if (strstr(curl_http_proxy, "://"))
>>  			credential_from_url(&proxy_auth, curl_http_proxy);
>
> Thanks and hope that helps,
> Jonathan
