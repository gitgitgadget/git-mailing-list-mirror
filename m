Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA921F424
	for <e@80x24.org>; Wed, 27 Dec 2017 18:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbdL0So7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:44:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56517 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751145AbdL0So6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:44:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37FDEB6D5C;
        Wed, 27 Dec 2017 13:44:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oEn7O8f69Qer
        NIbNhRukXBl1evQ=; b=wp3DwiuYWw0rbz6LMcfGRfAPsnnH+ewsioI8Qw8DUa8I
        D+nrAqhB0/ToSdxOdvmBOH6ZhtMCLe9nquVi7Ohj0T6WFY43x4A6YgbONC6RPwYp
        bc4MsGN01zQ3AFj3Cbegh/6FRsVV/mmOZ6K9v1l3qoy96M6XQP0GUBVYFRDFv10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=N/BT3w
        yFO1XNdY0z58ACwBWZPrwgKHYCKWdPJh4TO+y29qObcSvU8WEJa4CPZgjZyVDs74
        yxl0VvO/ZTe20fK6g+5DSpbt1K2Y3L/O3QeweMKjoL9pfrl1GAQADHS5Gm79jWGy
        N/FKpAAyg7n9wEv09N+BHEDZvf0E08ZgqHbQ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 305DDB6D5A;
        Wed, 27 Dec 2017 13:44:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A4D39B6D59;
        Wed, 27 Dec 2017 13:44:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wei Shuyu <wsy@dogben.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net
Subject: Re: [RFC PATCH v2] http: support CURLPROXY_HTTPS
References: <20171223150215.8615-1-wsy@dogben.com>
        <878tdts5c0.fsf@evledraar.gmail.com>
Date:   Wed, 27 Dec 2017 10:44:56 -0800
In-Reply-To: <878tdts5c0.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 23 Dec 2017 18:48:47 +0100")
Message-ID: <xmqq4locnh7b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 096BDA96-EB36-11E7-8E5E-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sat, Dec 23 2017, Wei Shuyu jotted:
>
>> Git has been taught to support an https:// used for http.proxy when
>> using recent versions of libcurl.
>>
>> To use https proxy with self-signed certs, we need a way to
>> unset CURLOPT_PROXY_SSL_VERIFYPEER and CURLOPT_PROXY_SSL_VERIFYHOST
>> just like direct SSL connection. This is required if we want
>> use t/lib-httpd to test proxy.
>>
>> In this patch I reuse http.sslverify to do this, do we need an
>> independent option like http.sslproxyverify?
>>
>> To fully support https proxy, we also need ways to set more options
>> such as CURLOPT_PROXY_SSLCERT. However, I'm not sure if we need to
>> support them.
>
> It would be good to add a link to
> https://daniel.haxx.se/blog/2016/11/26/https-proxy-with-curl/ to the
> commit message, since it explains in great detail what this is for and
> how it compares to what we were doing before.

Yeah, I found it a quite readable explanation.

It appears to me that the configuration for the proxy would have to
be different from the configuration for the hosts in the outside
world.  You may want to be a lot more strongly suspicious to the
latter while trusting the former a bit more.  I also suspect that
we'd need options like PROXY_SSLCERT that are parallel to the main
SSL support in the final form, but it may be OK to leave it to a
follow-up series.

And in order to start small and grow later, I think it is not a good
idea to repurpose http.sslverify to imply http.sslproxyverify; you
are declaring "when you disable peer verification, you also disable
proxy verification", and need to worry about backward compatibility
when you later introduce http.sslproxyverify that can control these
independently.  It probably is less bad than usual b/c issues in
that it probably is much more common to disable verification for
proxy than target hosts, though.

In any case, thanks for working on this.

>
>> Signed-off-by: Wei Shuyu <wsy@dogben.com>
>> ---
>>  http.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/http.c b/http.c
>> index 215bebef1..d8a5e48f0 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -708,6 +708,10 @@ static CURL *get_curl_handle(void)
>>  	if (!curl_ssl_verify) {
>>  		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
>>  		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0);
>> +#if LIBCURL_VERSION_NUM >=3D 0x073400
>> +		curl_easy_setopt(result, CURLOPT_PROXY_SSL_VERIFYPEER, 0);
>> +		curl_easy_setopt(result, CURLOPT_PROXY_SSL_VERIFYHOST, 0);
>> +#endif
>>  	} else {
>>  		/* Verify authenticity of the peer's certificate */
>>  		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 1);
>> @@ -865,6 +869,11 @@ static CURL *get_curl_handle(void)
>>  		else if (starts_with(curl_http_proxy, "socks"))
>>  			curl_easy_setopt(result,
>>  				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
>> +#endif
>> +#if LIBCURL_VERSION_NUM >=3D 0x073400
>> +		else if (starts_with(curl_http_proxy, "https"))
>> +			curl_easy_setopt(result,
>> +				CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
>>  #endif
>>  		if (strstr(curl_http_proxy, "://"))
>>  			credential_from_url(&proxy_auth, curl_http_proxy);
