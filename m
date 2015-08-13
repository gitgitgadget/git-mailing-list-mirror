From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH v3] http: add support for specifying the SSL version
Date: Thu, 13 Aug 2015 18:10:48 +0200
Message-ID: <CA+EOSBkzU=6pKkqYdGqRRcbbudTJkRwcXxswP+zMshVrZaM_mw@mail.gmail.com>
References: <1439479731-16018-1-git-send-email-gitter.spiros@gmail.com>
	<55CCBF6F.3070808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:10:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPv5i-0003Ml-Rx
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 18:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbbHMQKu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2015 12:10:50 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34954 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbbHMQKt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2015 12:10:49 -0400
Received: by vkfi73 with SMTP id i73so19672962vkf.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JB/I49KwGhQYRNGq7SUwgV3X9FLHUEFvc9h0nOQd/Tg=;
        b=ePj8dp+cAHPkRI1xrEQklE4tJFgcJLXp6NSOfraNf8fCLRyOjb5K/i7V3WDFyKmuDF
         aFnSW+ECEpdfPNUxYtUR9Irca7BQ2dbzBEchCz+e/6S21Burm0xLL8EDtBm9cRTXPCoK
         IUFAN1BUqar12qCRwm0GKCBsOxOc/tVGSt4KWZkRaqh9N3DI1oMOMdLORexKgO4de8KS
         pOtwGguB965FBu0rgmf9djUl7h2sI1J/04xQBfbx7Ayi4HkpUHXIZNEklxTtyGavc7q2
         zm48XIbM0RIeQh4rc48n7hZBinZXgANTdnRFqQMPb+s7kDjU8hUjr0P659W9U+mpQqQV
         9kzw==
X-Received: by 10.52.113.5 with SMTP id iu5mr46372289vdb.49.1439482248809;
 Thu, 13 Aug 2015 09:10:48 -0700 (PDT)
Received: by 10.31.16.146 with HTTP; Thu, 13 Aug 2015 09:10:48 -0700 (PDT)
In-Reply-To: <55CCBF6F.3070808@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275854>

2015-08-13 18:01 GMT+02:00 Torsten B=C3=B6gershausen <tboegi@web.de>:
> (need to drop Eric from cc-list, no DNS from web.de)
>
> On 2015-08-13 17.28, Elia Pinto wrote:
>> Teach git about a new option, "http.sslVersion", which permits one t=
o
>> specify the SSL version  to use when negotiating SSL connections.  T=
he
>> setting can be overridden by the GIT_SSL_VERSION environment
>> variable.
>>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>> This is the third version of the patch. The changes compared to the =
previous version are:
>>
>> - Eliminated the unnecessary blank (Junio)
>> - Place a structure to associate mnemonic names with the curl enum c=
onstant (Junio)
>> - Eliminated the invocation to curl_easy_setopt to set the default S=
SL value. Also removed the static global variable.
>>   (Junio)
>> - Slight correction in config.txt (Eric)
>>
>>  Documentation/config.txt               | 22 ++++++++++++++++++++++
>>  contrib/completion/git-completion.bash |  1 +
>>  http.c                                 | 32 +++++++++++++++++++++++=
++++++++-
>>  3 files changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 315f271..b23b01a 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1595,6 +1595,28 @@ http.saveCookies::
>>       If set, store cookies received during requests to the file spe=
cified by
>>       http.cookieFile. Has no effect if http.cookieFile is unset.
>>
>> +http.sslVersion::
> should this be https.sslVersion ?
> (http doesn't use ssl)
>
>> +     The SSL version to use when negotiating an SSL connection, if =
you
>> +     want to force the default.  The available and default version =
depend on
>> +     whether libcurl was built against NSS or OpenSSL and the parti=
cular configuration
>> +     of the crypto library in use. Internally this sets the 'CURLOP=
T_SSL_VERSION'
>> +     option; see the libcurl documentation for more details on the =
format
>> +     of this option and for the ssl version supported. Actually the=
 possible values
>> +     of this option are:
>> +
>> +     - sslv2
>> +     - sslv3
>> +     - tlsv1
>> +     - tlsv1.0
>> +     - tlsv1.1
>> +     - tlsv1.2
>> +
> from
> https://en.wikipedia.org/wiki/Transport_Layer_Security#SSL_1.0.2C_2.0=
_and_3.0
> sslv2 and sslv3 are deprecated.
> Should there be a motivation in the commit message why we want to sup=
port them ?
They are those provided by the documentation (TLS in particular). We
let the underlying library to say what is deprecated or not. In this
case the call fail.
>
>
>> ++
>> +Can be overridden by the 'GIT_SSL_VERSION' environment variable.
>> +To force git to use libcurl's default ssl version and ignore any
>> +explicit http.sslversion option, set 'GIT_SSL_VERSION' to the
>> +empty string.
>> +
>>  http.sslCipherList::
>>    A list of SSL ciphers to use when negotiating an SSL connection.
>>    The available ciphers depend on whether libcurl was built against
>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index c97c648..6e9359c 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2118,6 +2118,7 @@ _git_config ()
>>               http.postBuffer
>>               http.proxy
>>               http.sslCipherList
>> +             http.sslVersion
>>               http.sslCAInfo
>>               http.sslCAPath
>>               http.sslCert
>> diff --git a/http.c b/http.c
>> index e9c6fdd..d5fecd6 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -37,6 +37,21 @@ static int curl_ssl_verify =3D -1;
>>  static int curl_ssl_try;
>>  static const char *ssl_cert;
>>  static const char *ssl_cipherlist;
>> +static const char *ssl_version;
>> +static struct {
>> +     const char *name;
>> +     long ssl_version;
>> +     } sslversions[] =3D {
>> +             { "sslv2", CURL_SSLVERSION_SSLv2 },
>> +             { "sslv3", CURL_SSLVERSION_TLSv1 },
>> +             { "tlsv1", CURL_SSLVERSION_TLSv1 },
>> +#if LIBCURL_VERSION_NUM >=3D 0x072200
>> +             { "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
>> +             { "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
>> +             { "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
>> +#endif
>> +             { NULL }
>> +};
>>  #if LIBCURL_VERSION_NUM >=3D 0x070903
>>  static const char *ssl_key;
>>  #endif
>> @@ -190,6 +205,8 @@ static int http_options(const char *var, const c=
har *value, void *cb)
>>       }
>>       if (!strcmp("http.sslcipherlist", var))
>>               return git_config_string(&ssl_cipherlist, var, value);
>> +     if (!strcmp("http.sslversion", var))
>> +             return git_config_string(&ssl_version, var, value);
>>       if (!strcmp("http.sslcert", var))
>>               return git_config_string(&ssl_cert, var, value);
>>  #if LIBCURL_VERSION_NUM >=3D 0x070903
>> @@ -364,9 +381,22 @@ static CURL *get_curl_handle(void)
>>       if (http_proactive_auth)
>>               init_curl_http_auth(result);
>>
>> +     if (getenv("GIT_SSL_VERSION"))
>> +             ssl_version =3D getenv("GIT_SSL_VERSION");
>> +
> Minor nit to shorten:
> if (ssl_version && *ssl_version) {
>
>> +             int i;
>> +             for ( i =3D 0; i < ARRAY_SIZE(sslversions); i++ ) {
> I think Git-style is not to have  ' ' before/after ')' /'('
> for (i =3D 0; i < ARRAY_SIZE(sslversions); i++)
>
>> +                     if (sslversions[i].name !=3D NULL && *sslversi=
ons[i].name && !strcmp(ssl_version,sslversions[i].name)) {
>> +                             curl_easy_setopt(result, CURLOPT_SSLVE=
RSION,
>> +                                     sslversions[i].ssl_version);
> This is what my man page says:
>  CURLcode curl_easy_setopt(CURL *handle, CURLoption option, parameter=
);
> []
>
> RETURN VALUE
>        CURLE_OK (zero) means that the option was set properly...
> Should the return value checked (and we die() if we fail ?
It is not strictly necessary. If it fails the other curl call fail,
try to use sslv2 for example (libcurl deprecated nss dunno)

Thanks !

>
>> +                             break;
>> +             }
>> +             if ( i =3D=3D ARRAY_SIZE(sslversions) ) warning("unsup=
ported ssl version %s: using default",
>> +                                                     ssl_version);
> Should we die() here to make things very clear to the user ?
>
>> +     }
>> +
>>       if (getenv("GIT_SSL_CIPHER_LIST"))
>>               ssl_cipherlist =3D getenv("GIT_SSL_CIPHER_LIST");
>> -
>>       if (ssl_cipherlist !=3D NULL && *ssl_cipherlist)
>>               curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
>>                               ssl_cipherlist);
>>
>
