From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 5 Jun 2009 12:20:07 +0400
Message-ID: <85647ef50906050120p6dd65b61g9e82b5c14b098246@mail.gmail.com>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	 <ca433830906041944s1a2b12en36eb88b23cb93a7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 10:23:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCUhp-0003Rt-MR
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 10:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728AbZFEIUM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 04:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757783AbZFEIUL
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 04:20:11 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:41482 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755687AbZFEIUH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 04:20:07 -0400
Received: by bwz9 with SMTP id 9so1308145bwz.37
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Glsq2qQS8xz9HXzJTUBY4NcpvPXmG7XHRg8vJo5qn5o=;
        b=wg1CJXV4qgxwTvGP1bCw81YziFcP9OQBBpStAYj5C69R4CPBQ3WxzLhgGJl7tRoqzY
         LMuPMmdbznnN1/Ffu/tZ70/W69+Diqu+iRUzfdEr3Z+edWZPwWFFLM5+jHWDF+cxKWDD
         vLFNTcJBDzgwJEc/K+8TpJHTIIMPNroq4GoDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XQBAxekRKEyGAInqDRVczH6KyTaxzvaobykc6VSV7SzTKyoGMEGPfqN4YWuPrbEq8u
         wvz7WVBdSKurLfDjijvFJheLHLpI2l9D6al0sLm/ltXfXGBnuLP+eDjtyD03dW3T/MM6
         yC7UCSDvVN+Q2mmF6HwVpuf5tE8IrOypHBGTg=
Received: by 10.204.62.68 with SMTP id w4mr2896401bkh.93.1244190007902; Fri, 
	05 Jun 2009 01:20:07 -0700 (PDT)
In-Reply-To: <ca433830906041944s1a2b12en36eb88b23cb93a7c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120761>

How it works if git is run from IDEs (no tty will be available)?
Is there a way to redefine the way the password is got?
What about scripting scenarios where passwordless certificates are
likely to be used?

Regards,
Constantine

On Fri, Jun 5, 2009 at 6:44 AM, Mark Lodato <lodatom@gmail.com> wrote:
> Any thoughts on this? =A0I would love to see this in git 1.6.4, and I
> don't think it affects people who do not use certificates.
>
> ~ Mark
>
> On Wed, May 27, 2009 at 11:16 PM, Mark Lodato<lodatom@gmail.com> wrot=
e:
>> If an SSL client certificate is enabled (via http.sslcert or
>> GIT_SSL_CERT), prompt for the certificate password rather than
>> defaulting to OpenSSL's password prompt. =A0This causes the prompt t=
o only
>> appear once each run. =A0Previously, OpenSSL prompted the user *many=
*
>> times, causing git to be unusable over HTTPS with client-side
>> certificates.
>>
>> Note that the password is stored in memory in the clear while the
>> program is running. =A0This may be a security problem if git crashes=
 and
>> core dumps.
>>
>> The user is always prompted, even if the certificate is not encrypte=
d.
>> This should be fine; unencrypted certificates are rare and a securit=
y
>> risk anyway.
>>
>> Signed-off-by: Mark Lodato <lodatom@gmail.com>
>> ---
>>
>> See http://osdir.com/ml/git/2009-02/msg03402.html for a discussion o=
f
>> this topic and an example showing how horrible the current password
>> prompts are.
>>
>> The next patch adds an option to disable this feature. =A0I split it=
 into
>> two commits in case the configuration option is not wanted.
>>
>> I did not create any tests because the existing http.sslcert option =
has
>> no tests to begin with.
>>
>> I would really like to use git over HTTPS with client certs, but the
>> current situation is just unusable. =A0So, I'm hoping this gets incl=
uded
>> in git.git at some point. =A0I would be happy to hear any comments p=
eople
>> have about this patch series. =A0Thanks!
>>
>>
>> =A0http.c | =A0 40 +++++++++++++++++++++++++++++++++++++++-
>> =A01 files changed, 39 insertions(+), 1 deletions(-)
>>
>> diff --git a/http.c b/http.c
>> index 2e3d649..1fc3444 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -26,6 +26,8 @@ static long curl_low_speed_time =3D -1;
>> =A0static int curl_ftp_no_epsv;
>> =A0static const char *curl_http_proxy;
>> =A0static char *user_name, *user_pass;
>> +static char *ssl_cert_password;
>> +static int ssl_cert_password_required;
>>
>> =A0static struct curl_slist *pragma_header;
>>
>> @@ -167,6 +169,22 @@ static void init_curl_http_auth(CURL *result)
>> =A0 =A0 =A0 =A0}
>> =A0}
>>
>> +static int has_cert_password(void)
>> +{
>> + =A0 =A0 =A0 if (ssl_cert_password !=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 if (ssl_cert =3D=3D NULL || ssl_cert_password_required=
 !=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 =A0 /* Only prompt the user once. */
>> + =A0 =A0 =A0 ssl_cert_password_required =3D -1;
>> + =A0 =A0 =A0 ssl_cert_password =3D getpass("Certificate Password: "=
);
>> + =A0 =A0 =A0 if (ssl_cert_password !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssl_cert_password =3D xstrdup(ssl_cert=
_password);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +}
>> +
>> =A0static CURL *get_curl_handle(void)
>> =A0{
>> =A0 =A0 =A0 =A0CURL *result =3D curl_easy_init();
>> @@ -189,6 +207,16 @@ static CURL *get_curl_handle(void)
>>
>> =A0 =A0 =A0 =A0if (ssl_cert !=3D NULL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0curl_easy_setopt(result, CURLOPT_SSLC=
ERT, ssl_cert);
>> + =A0 =A0 =A0 if (has_cert_password())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 curl_easy_setopt(result,
>> +#if LIBCURL_VERSION_NUM >=3D 0x071700
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CUR=
LOPT_KEYPASSWD,
>> +#elif LIBCURL_VERSION_NUM >=3D 0x070903
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CUR=
LOPT_SSLKEYPASSWD,
>> +#else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CUR=
LOPT_SSLCERTPASSWD,
>> +#endif
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ssl=
_cert_password);
>> =A0#if LIBCURL_VERSION_NUM >=3D 0x070902
>> =A0 =A0 =A0 =A0if (ssl_key !=3D NULL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0curl_easy_setopt(result, CURLOPT_SSLK=
EY, ssl_key);
>> @@ -329,8 +357,11 @@ void http_init(struct remote *remote)
>> =A0 =A0 =A0 =A0if (getenv("GIT_CURL_FTP_NO_EPSV"))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0curl_ftp_no_epsv =3D 1;
>>
>> - =A0 =A0 =A0 if (remote && remote->url && remote->url[0])
>> + =A0 =A0 =A0 if (remote && remote->url && remote->url[0]) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0http_auth_init(remote->url[0]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!prefixcmp(remote->url[0], "https:=
//"))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssl_cert_password_requ=
ired =3D 1;
>> + =A0 =A0 =A0 }
>>
>> =A0#ifndef NO_CURL_EASY_DUPHANDLE
>> =A0 =A0 =A0 =A0curl_default =3D get_curl_handle();
>> @@ -370,6 +401,13 @@ void http_cleanup(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free((void *)curl_http_proxy);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0curl_http_proxy =3D NULL;
>> =A0 =A0 =A0 =A0}
>> +
>> + =A0 =A0 =A0 if (ssl_cert_password !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(ssl_cert_password, 0, strlen(ss=
l_cert_password));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(ssl_cert_password);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssl_cert_password =3D NULL;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 ssl_cert_password_required =3D 0;
>> =A0}
>>
>> =A0struct active_request_slot *get_active_slot(void)
>> --
>> 1.6.3.1
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
