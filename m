From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH v3] http: add support for specifying the SSL version
Date: Fri, 14 Aug 2015 21:51:29 +0200
Message-ID: <CA+EOSBmqVo8LsOLjzc6vLV1YFT2t=57f-GM7DC8Na6Ggi2anUQ@mail.gmail.com>
References: <1439479731-16018-1-git-send-email-gitter.spiros@gmail.com>
	<55CCBF6F.3070808@web.de>
	<xmqqlhddiy5a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 21:51:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQL0p-000363-HY
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 21:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbbHNTvb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2015 15:51:31 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35626 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbbHNTva convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2015 15:51:30 -0400
Received: by vkfi73 with SMTP id i73so34181866vkf.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 12:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3hVVf0/JcOje7Uk3sh+wcc1houst0mHcUgEGmmDaMx0=;
        b=SvJmpXmatRs1YYFLwEBfZGw4/VoOPJx66Ip3tZv6R0ugmS2reiadwn2Xa+nSo/Goyq
         vqPIDg5JSCLt7L7BJn/kOFdwYmuN/rmTLoK5ZSQIxaSIjrtKWKTM82AMMERf/a3XK6rT
         4NWt11NEIY/SYhiXR11eumolyWFnnfWqInzjFtIcl/DaEF8igCPPx9uz1IvGKqLfId4W
         2M9k5ukqm/jbEvUn9bts82+FLSaozcKStZKmu9h7pEcb/93CngtD0RRTiBTIqjmd0KVX
         dtRhuiqFHiWfE9wYTYy/berc4nhuTnDHiPaj0BPQVut9j1o//bRz+ErcVkLwmTMmLH4t
         Rsbw==
X-Received: by 10.52.226.161 with SMTP id rt1mr2554312vdc.53.1439581889710;
 Fri, 14 Aug 2015 12:51:29 -0700 (PDT)
Received: by 10.31.16.146 with HTTP; Fri, 14 Aug 2015 12:51:29 -0700 (PDT)
In-Reply-To: <xmqqlhddiy5a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275930>

2015-08-14 19:21 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>>> index 315f271..b23b01a 100644
>>> --- a/Documentation/config.txt
>>> +++ b/Documentation/config.txt
>>> @@ -1595,6 +1595,28 @@ http.saveCookies::
>>>      If set, store cookies received during requests to the file spe=
cified by
>>>      http.cookieFile. Has no effect if http.cookieFile is unset.
>>>
>>> +http.sslVersion::
>> should this be https.sslVersion ?
>> (http doesn't use ssl)
>
> But there are sslCipherList, etc., already present, and more
> importantly, I think you want http.proxy to apply even if you happen
> to be talking http over SSL.
>
> More importantly, given that we have the "limited to this URL"
> mechanism "http.<url>.<variable>" that overrides "http.<variable>",
> introducing "https.sslWhatEver" would force people to have two
> configuration sections for no real benefit, other than silencing
> pedants that want to say "these things should be defined only for
> https".
>
>>> + if (sslversions[i].name !=3D NULL && *sslversions[i].name &&
>>> !strcmp(ssl_version,sslversions[i].name)) {
>>> +                            curl_easy_setopt(result, CURLOPT_SSLVE=
RSION,
>>> +                                    sslversions[i].ssl_version);
>> This is what my man page says:
>>  CURLcode curl_easy_setopt(CURL *handle, CURLoption option, paramete=
r);
>> []
>>
>> RETURN VALUE
>>        CURLE_OK (zero) means that the option was set properly...
>> Should the return value checked (and we die() if we fail ?
>
> Probably.  Do we check status from other calls to setopt?
No. In this case anyway is not important i think: we already check if
the version is accepted by curl, and if it is deprecated ( sslv2 for
eample) we have an error in any case. refs
http://curl.haxx.se/libcurl/c/CURLOPT_SSLVERSION.html

Best Regards
