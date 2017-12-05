Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D41020A40
	for <e@80x24.org>; Tue,  5 Dec 2017 15:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbdLEPak (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 10:30:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57731 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751416AbdLEPaj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 10:30:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0705B2689;
        Tue,  5 Dec 2017 10:30:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zu1l6xYfbwy3yHkKP2tRt9CWwFA=; b=tlP8Tu
        Z0qkT5XpSaOCtAI/s+qHUWWcIaOm1GHrD+YY9iv1eTZfDeZ6vEm5nf4KMQ/BB7Tk
        cvU5xrUFP12Eul6z20qqrUwBGDEJnQvxkRePHRU9DaKQObcDOFJ0HW4yI4zIC4PW
        4aDl6ldHV5Yf79S+v09okDi5ofpDmDDWKPthw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oyV95imKMIoooBotr643aPZO+BOmY7f9
        xWMNGTRiYeFgo68EubZQPnkFYAX48Acrd6iOFehL5S+316bJSazAaziQoY47ZP6Y
        l1z7VHaA3rtDa+6g67NHO03KB6Pg7AqQncQi+OoCEF6R4kHpwgXPWe/i8jgoH7Us
        GSrhlb5lWmo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97791B2688;
        Tue,  5 Dec 2017 10:30:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F05C6B2686;
        Tue,  5 Dec 2017 10:30:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        Git List <git@vger.kernel.org>, daniel@haxx.se,
        Jonathan Nieder <jrnieder@gmail.com>, doron.behar@gmail.com,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] imap-send: URI encode server folder
References: <20171129171301.l3coiflkfyy533yz@NUC.localdomain>
        <18c9478b-19fc-69f2-229f-67c05a42d4f5@suse.com>
        <CAPig+cSEYHfupRt+-0sZK6H3_WcT_=wdNB2FfdYuB6geGQYZ3A@mail.gmail.com>
Date:   Tue, 05 Dec 2017 07:30:36 -0800
In-Reply-To: <CAPig+cSEYHfupRt+-0sZK6H3_WcT_=wdNB2FfdYuB6geGQYZ3A@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 30 Nov 2017 12:53:16 -0500")
Message-ID: <xmqqd13tjioz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EA7DCF8-D9D1-11E7-B922-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> ... Can you
> expand the commit message a bit to make it more self-contained? At
> minimum, perhaps show the error message you were experiencing, and
> cite (as Daniel pointed out) RFC 3986 and the bit about a "legal" URL
> not containing brackets.

Thanks for a good suggestion.


>
> Also, a natural question which pops into the head of someone reading
> this patch is whether other parts of the URL (host, user, etc.) also
> need to be handled similarly. It's possible that you audited the code
> and determined that they are handled fine already, but the reader of
> the commit message is unable to infer that. Consequently, it might be
> nice to have a sentence about that, as well ("other parts of the URL
> are already encoded, thus are fine" or "other parts of the URL are not
> subject to this problem because ...").
>
> The patch itself looks okay (from a cursory read).
>
> Thanks.
>
>> Reported-by: Doron Behar <doron.behar@gmail.com>
>> Signed-off-by: Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
>> ---
>>  imap-send.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/imap-send.c b/imap-send.c
>> index 54e6a80fd..36c7c1b4f 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -1412,6 +1412,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
>>  {
>>         CURL *curl;
>>         struct strbuf path = STRBUF_INIT;
>> +       char *uri_encoded_folder;
>>
>>         if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
>>                 die("curl_global_init failed");
>> @@ -1429,7 +1430,12 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
>>         strbuf_addstr(&path, server.host);
>>         if (!path.len || path.buf[path.len - 1] != '/')
>>                 strbuf_addch(&path, '/');
>> -       strbuf_addstr(&path, server.folder);
>> +
>> +       uri_encoded_folder = curl_easy_escape(curl, server.folder, 0);
>> +       if (!uri_encoded_folder)
>> +               die("failed to encode server folder");
>> +       strbuf_addstr(&path, uri_encoded_folder);
>> +       curl_free(uri_encoded_folder);
>>
>>         curl_easy_setopt(curl, CURLOPT_URL, path.buf);
>>         strbuf_release(&path);
>> --
>> 2.15.1.272.g8e603414b
