From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] http-push: don't always prompt for password
Date: Wed, 02 Nov 2011 10:13:32 -0700
Message-ID: <7vk47ijvlv.fsf@alter.siamese.dyndns.org>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org>
 <4EAEAE13.50101@atlas-elektronik.com> <4EAFC18A.1070502@atlas-elektronik.com>
 <7vmxcfn23i.fsf@alter.siamese.dyndns.org>
 <4EB104EA.2040001@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 18:13:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLeNh-0003cw-Ix
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 18:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755791Ab1KBRNg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Nov 2011 13:13:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41263 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755120Ab1KBRNf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 13:13:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 650AD5C7F;
	Wed,  2 Nov 2011 13:13:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7YTKCd/NMHQo
	WJSOwBak+aLrkC4=; b=qIWXDMZ8Sg7ya5REAChxjeRk3Gverj5aP0ePJ7EvO6OV
	LrBSO8UrfEkmdwBZGt+X45GapDfyqDTLcQRyKfeP99QYM5bQvilKTKvyzV1iMVeP
	TcPXTSgp9i4QD7vDO/dwtWIzywqqu/4Jvqh5ivyYSuqkrY9x0GHmiPx0L1Ch5uQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MMso9Z
	2PYxSL8bGfLnN1+0CHJCX7VCjNjHrpGqxRjGqjitjJtX8q7tAQPMU2ATto/vjYMj
	mSn4z79/zXF1DQUz8TB1tzpt4/YQR1Rv+7vKVJmtbvQ3r8MHsXJSsksaHkeHm2Ax
	SrSt7iK34HdfTgWsrGX/uA+w+vVtKZlvawfjw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C2D65C7E;
	Wed,  2 Nov 2011 13:13:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9D895C7B; Wed,  2 Nov 2011
 13:13:33 -0400 (EDT)
In-Reply-To: <4EB104EA.2040001@atlas-elektronik.com> ("Stefan =?utf-8?Q?N?=
 =?utf-8?Q?=C3=A4we=22's?= message of "Wed, 02 Nov 2011 09:52:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE8BEC44-0575-11E1-A9F0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184648>

Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com> writes:

> Am 01.11.2011 19:12, schrieb Junio C Hamano:
>>=20
>> There are only handful of commits that even remotely touch http rela=
ted
>> codepath between v1.7.7 and v1.7.8-rc0:
>>=20
>>   * deba493 http_init: accept separate URL parameter
>>=20
>>   This could change the URL string given to http_auth_init().
>> ...=20
>> Could you try reverting deba493 and retest, and then if the behaviou=
r is
>> the same "need ENTER", further revert 070b4dd and retest?
>
> I did a little more testing.
> This WIP makes it work for me (i.e. "need ENTER" is gone, works with
> and without .netrc, with 'https://host/repo.git' and=20
> 'https://user@host...' URL). Needs testing, of course.
>
> ---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---
> diff --git a/http.c b/http.c
> index a4bc770..008ad72 100644
> --- a/http.c
> +++ b/http.c
> @@ -279,8 +279,6 @@ static CURL *get_curl_handle(void)
>         curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
>  #endif
>
> -       init_curl_http_auth(result);
> -
>         if (ssl_cert !=3D NULL)
>                 curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
>         if (has_cert_password())
> @@ -846,7 +844,7 @@ static int http_request(const char *url, void *re=
sult, int target, int options)
>                 else if (missing_target(&results))
>                         ret =3D HTTP_MISSING_TARGET;
>                 else if (results.http_code =3D=3D 401) {
> -                       if (user_name) {
> +                       if (user_name && user_pass) {
>                                 ret =3D HTTP_NOAUTH;
>                         } else {
>                                 /*
> @@ -855,7 +853,8 @@ static int http_request(const char *url, void *re=
sult, int target, int options)
>                                  * but that is non-portable.  Using g=
it_getpass() can at least be stubbed
>                                  * on other platforms with a differen=
t implementation if/when necessary.
>                                  */
> -                               user_name =3D xstrdup(git_getpass_wit=
h_description("Username", description));
> +                               if (!user_name)
> +                                       user_name =3D xstrdup(git_get=
pass_with_description("Username", description));
>                                 init_curl_http_auth(slot->curl);
>                                 ret =3D HTTP_REAUTH;
>                         }
> ---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---8<---

This defers the calls to git_getpass* until we get 401 from the server
side.

I am guessing the reason why in the current code get_curl_handle() has =
a
call to init_curl_http_auth() very early, but only when user_name is se=
t,
is because it is likely for a site to require authentication when the u=
ser
already has "username@" in its URL, and doing it this way will avoid th=
e
extra round-trip because by the time we make an HTTP request, we have b=
oth
name and pass. If we apply this patch, the check in init_curl_http_auth=
()
that asks for the password only when user_name is set becomes unnecessa=
ry.

I think the second hunk at l.846 sort of makes sense, but not quite.

"We got 401 even though we know we have supplied name and pass" is a va=
lid
criterion to decide that the name/pass is an invalid combination. But i=
t
makes me wonder if this code in its early days guaranteed whenever we h=
ave
user_name we always have made sure we have user_pass (otherwise by aski=
ng
for it with git_getpass) and that is the reason why it had to check onl=
y
for user_name, and if that is the case perhaps the real breakage is we =
are
not keeping that guarantee in the current code?

IOW, when in the current code do we make a new HTTP request while
user_name is set but no user_pass?  Perhaps if we fix that codepath we =
do
not have to have this extra 401 roundtrip this patch is introducing whe=
n
the username (but not password) is given?

Peff, what do you think?
