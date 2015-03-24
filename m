From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 09/15] http: release the memory of a http pack request as well
Date: Tue, 24 Mar 2015 09:54:07 -0700
Message-ID: <CAGZ79kZbe9d7wG+CJ0o93hDs3sFjkSp68pBHXpjOysbzgvjo3w@mail.gmail.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-10-git-send-email-sbeller@google.com>
	<xmqq1tkgddto.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 17:54:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaS5n-0006fN-4e
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 17:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbbCXQyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 12:54:10 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35844 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbbCXQyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 12:54:07 -0400
Received: by igbud6 with SMTP id ud6so77581058igb.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 09:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VU8dfMtRpGegyRouvpr3lVQuMLjAsL6abHkTDzXNl6s=;
        b=JGJ+BLQStSbUxJgBNGbYsJMZzlsTG1EAzIRHPn/UNn3Zi6uLcdUCxlmnt349/+L4oj
         LO5xTa4jedXE5n+OHjl66jrURdjkw2it3Zxjxo8gqXbLEX7qjdw4oO1y2ARhZf/u0NVA
         D3argbid7mdvcjQKC1X7uAErCB8FV8E2de4MN8AQOPysOjJXWMDPhPmjxLKQIYLF8D16
         SRlDgiRpGOxl6uDjqDHjbYm4diL9XpgDIMvsMe+UAInebU9m2X8ivnX+LsRsTKbiLGHN
         umGL6g1oNE2w4JGfBfuQnwpimC6rWAyE5OfiNL41CuP6jmG79U3/ODBz9Gpd1h4weCYr
         lJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VU8dfMtRpGegyRouvpr3lVQuMLjAsL6abHkTDzXNl6s=;
        b=QYH90J9zSC7CPOrj9t3XaF0g/1uMYlqPZQWJzXVopNIsST0Vf0Tptk2i2l/+mZfzer
         ANvqiph5EdsbP9DhQBpEzhESam9OCf4OBr7a8PEJtYz1BzBOHygt+YsUvJtobLkHBos9
         vBKUDD+G8bNRjDYDK/DMhVgwH+v/DzjK2AfRNiNGVS+k9WmhSM4wor/8pCSjsY6aC7xM
         dP0PCU+ui9RZqkPYrXS/prPsBUrtTuXn5eQSo0YyBgVer+XMQb9OzZwcI2X5LYaQZN1P
         GcDbuN3h7UCGiQwS0OULiYqFAQ2OGp//Bs6uLgrNPm86uYthfqkIZ0A7J9TKJNBa1VxX
         MIjw==
X-Gm-Message-State: ALoCoQnG7UVM5RBnQ/ZYBi2f0DQtwIMsEXVG61g2rnFEiVQzMjF5a3rt1UfkYhFLd/mMZwYWMmUL
X-Received: by 10.42.30.139 with SMTP id v11mr22752269icc.76.1427216047299;
 Tue, 24 Mar 2015 09:54:07 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Tue, 24 Mar 2015 09:54:07 -0700 (PDT)
In-Reply-To: <xmqq1tkgddto.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266200>

On Sun, Mar 22, 2015 at 12:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The cleanup function is used in 4 places now and it's always safe to
>> free up the memory as well.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  http.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/http.c b/http.c
>> index 9c825af..4b179f6 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -1462,6 +1462,7 @@ void release_http_pack_request(struct http_pack_request *preq)
>>       }
>>       preq->slot = NULL;
>>       free(preq->url);
>> +     free(preq);
>>  }
>>
>>  int finish_http_pack_request(struct http_pack_request *preq)
>
> Freeing of preq in all the callers of this one looks sensible,
> except for the one in finish_request() of http-push.c that pulls an
> preq instance out of request->userData.
>
> Can somebody help me follow the dataflow to convince me that this is
> not leading to double-free in start_fetch_packed()?

I am not sure where you suspect the double free problem.

In start_fetch_packed we have a call to release_http_pack_request
2 times but just in an error-out-and-cleanup case, so either of one cases
is called.

In the latter place (http-push.c lines 335-347), we have code like
    request->userData = preq;
    if (!start_active_slot(preq->slot)) {
        release_http_pack_request(preq);
        repo->can_update_info_refs = 0;
        release_request(request);
    }

Do you mean that the release_http_pack_request and release_request may collide
as the `release_request(request);` has a pointer to preq via its userData field?

Well there is hope, as `release_request` only touches
    free(request->url);
    free(request);

and not the userData pointer.


I am a bit puzzled what you're trying to hint at.

>
> Thanks.
>
