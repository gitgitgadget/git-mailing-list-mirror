From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/mingw: brown paper bag fix for 50a6c8e
Date: Mon, 29 Feb 2016 11:10:09 -0800
Message-ID: <xmqqtwkr9vu6.fsf@gitster.mtv.corp.google.com>
References: <56D3E56A.5010608@web.de>
	<20160229092816.GA23910@sigill.intra.peff.net>
	<56D415C6.2040203@web.de>
	<20160229100258.GC2950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 20:10:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTD1-0003Sk-AR
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbcB2TKO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 14:10:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753277AbcB2TKN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Feb 2016 14:10:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2262447E05;
	Mon, 29 Feb 2016 14:10:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=O+va33ChtlMC
	+g5H9Ngjy1xiksc=; b=Z4mKfMpagni3VdRodTd0Q9MFw6YQnFFSU+yRVXYjmSkH
	8yTzyShunQxkXTDWKzqC+pciU1flFEYQoaIYbgN7iB1qHVnX/tTxhTmbUfoytMYO
	hZY5w1xbxoGffMUR5S7y560NeKP7UJGGfUG6buqijYlIeh+ca53Dg5KgVFh0o/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VBxJt0
	erlnuZ7e2HP8z+wHoVtlCDDCpAgOfohvOSbxa4An5c+N1NlxxDmV+pCc11jw9b0y
	s/yRNrEAP3l5JGEAu29aa4PCoxZVICGVQEhCXSCVMT5NkRjQXCbMGgdVHlO0W91D
	1UldEZZCgpTtqB5sIaj5bmu+8ibxuq6jfUCnc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 16D7C47E04;
	Mon, 29 Feb 2016 14:10:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7722947E03;
	Mon, 29 Feb 2016 14:10:10 -0500 (EST)
In-Reply-To: <20160229100258.GC2950@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 29 Feb 2016 05:02:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0D998554-DF18-11E5-A3D1-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287872>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 29, 2016 at 10:56:22AM +0100, Torsten B=C3=B6gershausen w=
rote:
>
>> Thanks for the fast-patch.
>>=20
>> I manually copied the patch, But there are more probles, it seems.
>>=20
>> $ git diff
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index cfedcf9..b1163f2 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -1069,7 +1069,7 @@ static pid_t mingw_spawnve_fd(const char *cmd,=
 const
>> char **argv, char **deltaen
>>                         free(quoted);
>>         }
>>=20
>> -       wargs =3D xmalloc_array(st_add(st_mult(2, args.len), 1), siz=
eof(wchar_t));
>> +       wargs =3D ALLOC_ARRAY(st_add(st_mult(2, args.len), 1), sizeo=
f(wchar_t));
>>         xutftowcs(wargs, args.buf, 2 * args.len + 1);
>>         strbuf_release(&args);
>
> Argh. Let me write "git commit -a" on the inside of my brown paper ba=
g,
> so that I actually send out the fix sitting in my working tree, not t=
he
> half-finished thing I ran "git add" on.

Just to make sure that I am not confused, what you wrote below
matches what I received from you two message upthread.

I am assuming that it is intended that the two messages from you
have the same patch, and the assignment of ALLOC_ARRAY to wargs was
a bug Torsten introduced only to his tree when cutting and pasting.

With that assumption, will queue this one (or the original one,
which to me is the same thing).

Thanks.

> -- >8 --
> Subject: [PATCH] compat/mingw: brown paper bag fix for 50a6c8e
>
> Commit 50a6c8e (use st_add and st_mult for allocation size
> computation, 2016-02-22) fixed up many xmalloc call-sites
> including ones in compat/mingw.c.
>
> But I screwed up one of them, which was half-converted to
> ALLOC_ARRAY, using a very early prototype of the function.
> And I never caught it because I don't build on Windows.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  compat/mingw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index cfedcf9..54c82ec 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1069,7 +1069,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, =
const char **argv, char **deltaen
>  			free(quoted);
>  	}
> =20
> -	wargs =3D xmalloc_array(st_add(st_mult(2, args.len), 1), sizeof(wch=
ar_t));
> +	ALLOC_ARRAY(wargs, st_add(st_mult(2, args.len), 1));
>  	xutftowcs(wargs, args.buf, 2 * args.len + 1);
>  	strbuf_release(&args);
