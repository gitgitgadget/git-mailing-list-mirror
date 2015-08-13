From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH v3] http: add support for specifying the SSL version
Date: Thu, 13 Aug 2015 17:58:03 +0200
Message-ID: <CA+EOSBkSkvvBQDpxL_ygj+2haMk1U7T00-Xmxn8iyXcnV6RN5Q@mail.gmail.com>
References: <1439479731-16018-1-git-send-email-gitter.spiros@gmail.com>
	<CAPig+cTug2Q3v1K5r76fhJ6OQY9V1e6MbiXQBGQJD51TCOGW=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 17:58:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPutP-0001NL-Mc
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 17:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbbHMP6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 11:58:07 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33752 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbbHMP6F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 11:58:05 -0400
Received: by vkbg64 with SMTP id g64so6420721vkb.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4Zf0/1dpLapMWX9wQzceeK/8BjG7bxd1vF+GWR3vEdE=;
        b=knDtr8HiozGDYV4N1ZYcthLd87UyIMROodhi78J8nsrUyN0vYyu+kz9LqlSm+EfN1w
         NHttlWKVVF/6/zQP104XZTO4wdiRi8zAvPdrTPtRjC+ft2yYHQWku7UjdmmRwZqSU0Xx
         B54sSaQjpPOlg7W7WjvLkOi9/6N0tmUdFdHEOLVKR8K0IDoaxNhSNPehZ4QQDp2yNopx
         JJjlTKAU21g6Wlgos5LzqTFwkmlLKlMbuz0Mnj9G3ITcEmo7CeTQyMKhn5dBRpfnNqNP
         o4EZdd9weQ07bKc0Uj+AN9Q7bYNE3hy9TEvLYQ2rDwh9KvET7NNzikEyHnmZHwqsY4UH
         GOvw==
X-Received: by 10.52.232.161 with SMTP id tp1mr49108701vdc.37.1439481484017;
 Thu, 13 Aug 2015 08:58:04 -0700 (PDT)
Received: by 10.31.16.146 with HTTP; Thu, 13 Aug 2015 08:58:03 -0700 (PDT)
In-Reply-To: <CAPig+cTug2Q3v1K5r76fhJ6OQY9V1e6MbiXQBGQJD51TCOGW=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275852>

2015-08-13 17:47 GMT+02:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Thu, Aug 13, 2015 at 11:28 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
>> Teach git about a new option, "http.sslVersion", which permits one to
>> specify the SSL version  to use when negotiating SSL connections.  The
>> setting can be overridden by the GIT_SSL_VERSION environment
>> variable.
>>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>> This is the third version of the patch. The changes compared to the previous version are:
>
> Looks better. A few comments below...
>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index c97c648..6e9359c 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -364,9 +381,22 @@ static CURL *get_curl_handle(void)
>>         if (http_proactive_auth)
>>                 init_curl_http_auth(result);
>>
>> +       if (getenv("GIT_SSL_VERSION"))
>> +               ssl_version = getenv("GIT_SSL_VERSION");
>> +       if (ssl_version != NULL && *ssl_version) {
>> +               int i;
>> +               for ( i = 0; i < ARRAY_SIZE(sslversions); i++ ) {
>> +                       if (sslversions[i].name != NULL && *sslversions[i].name && !strcmp(ssl_version,sslversions[i].name)) {
>
> This sort of loop is normally either handled by indexing up to a limit
> (ARRAY_SIZE, in this case) or by iterating until hitting a sentinel
> (NULL, in this case). It is redundant to use both, as this code does.
I do not think. sslversions[i].name can be null, see how the structure
is initialized. No ?

The other your observations written below are ok for me, but i will
wait for your answer on this before you send another revision. Thank
you very much.

> The former (using ARRAY_SIZE) is typically employed when you know the
> number of items upfront, such as when the item list is local and
> compiled in; the latter (NULL sentinel) is typically used when
> receiving an item list as an argument to a function where you don't
> know the item count upfront (and the item count is not passed to the
> function as a separate argument).
>
> In this case, the item list is local and its size is known to the
> compiler, so that suggests using ARRAY_SIZE, and dropping the NULL
> sentinel.
>
> Style aside: This 'if' statement is very wide and likely should be
> wrapped over multiple lines (trying to keep the code within an
> 80-column limit).
ok.
>
>> +                               curl_easy_setopt(result, CURLOPT_SSLVERSION,
>> +                                       sslversions[i].ssl_version);
>> +                               break;
>> +               }
>> +               if ( i == ARRAY_SIZE(sslversions) ) warning("unsupported ssl version %s: using default",
>> +                                                       ssl_version);
>
> Style:
> Drop spaces inside 'if' parentheses.
> Place warning() on its own line.
ok.


>
>> +       }
>> +
>>         if (getenv("GIT_SSL_CIPHER_LIST"))
>>                 ssl_cipherlist = getenv("GIT_SSL_CIPHER_LIST");
>> -
>>         if (ssl_cipherlist != NULL && *ssl_cipherlist)
>>                 curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
>>                                 ssl_cipherlist);
>> --
>> 2.5.0.234.gefc8a62.dirty
