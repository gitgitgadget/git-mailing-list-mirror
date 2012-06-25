From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] i18n: leave \n out of translated diffstat
Date: Sun, 24 Jun 2012 21:24:27 -0700
Message-ID: <7vzk7shvd0.fsf@alter.siamese.dyndns.org>
References: <1340541692-10834-1-git-send-email-pclouds@gmail.com>
 <20120624160411.GA18791@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 06:24:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj0qq-0001xO-9t
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 06:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab2FYEYb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 00:24:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61533 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518Ab2FYEYa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 00:24:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10BA532C0;
	Mon, 25 Jun 2012 00:24:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8SA7niyBFnLx
	rKCfbleNazE088w=; b=STG36/YDDWK8TuxcidLC1JR/jaJaeemOAdZxfFstPlFv
	UMM7GCkWPjGJg1So69uBZ1ugeiQGiKx/idB5JdGILR2PrKP6Wzhxly0QY/beohph
	gjNKe0YD/WMRB6ueX9SkJAT+uChTprK75hHVBuXe8eBtdEWbbEuMuVwFY9Zjz5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dClOPT
	Deq6oVB7T0Y92+wMOi5mmjl86G+6gij5MS+OQLqRXnvJ4o8V+Dm+lhNqh7sN3J6k
	EpXW1LI54KK25bybRfWu8T5HkS+gy47o6YWrnayCVr1u2w7+3PJ+lAb60O6l79mV
	tTW2DA2c3Y86NAO3wq5/slxUfxaqNwaUZzcyU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 085F732BF;
	Mon, 25 Jun 2012 00:24:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72A5632BE; Mon, 25 Jun 2012
 00:24:29 -0400 (EDT)
In-Reply-To: <20120624160411.GA18791@burratino> (Jonathan Nieder's message of
 "Sun, 24 Jun 2012 11:04:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7E4B364-BE7D-11E1-8220-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200543>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> GETTEXT_POISON scrapes everything in translated strings, including \=
n.
>> t4205.12 however needs this \n in matching the end result. Keep this
>> \n out of translation to make t4205.12 happy.
> [...]
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -1397,7 +1397,7 @@ int print_stat_summary(FILE *fp, int files, in=
t insertions, int deletions)
>> =20
>>  	if (!files) {
>>  		assert(insertions =3D=3D 0 && deletions =3D=3D 0);
>> -		return fputs(_(" 0 files changed\n"), fp);
>> +		return fprintf(fp, "%s\n", _(" 0 files changed"));
>
> More importantly, this makes the string more similar to other
> translated strings in the same file and saves translators from having
> to remember to worry about appropriate whitespace at the end of the
> string.
>
> Actually, it should be possible to make their lives even easier.  How
> about this?
>
> diff --git i/diff.c w/diff.c
> index 1a594df4..c53eea50 100644
> --- i/diff.c
> +++ w/diff.c
> @@ -1395,11 +1395,6 @@ int print_stat_summary(FILE *fp, int files, in=
t insertions, int deletions)
>  	struct strbuf sb =3D STRBUF_INIT;
>  	int ret;
> =20
> -	if (!files) {
> -		assert(insertions =3D=3D 0 && deletions =3D=3D 0);
> -		return fputs(_(" 0 files changed\n"), fp);
> -	}
> -
>  	strbuf_addf(&sb,
>  		    Q_(" %d file changed", " %d files changed", files),
>  		    files);

Yeah, I think that is going in the right direction.

Thanks for careful reviews.
