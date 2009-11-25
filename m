From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shortlog: respect commit encoding
Date: Tue, 24 Nov 2009 17:12:14 -0800
Message-ID: <7vfx8376hd.fsf@alter.siamese.dyndns.org>
References: <20091111141342.GA1849@pengutronix.de>
 <1259075555-7831-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 02:12:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND6Qq-0008R9-Jw
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 02:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933898AbZKYBMS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2009 20:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933891AbZKYBMS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 20:12:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933840AbZKYBMR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2009 20:12:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2DBD8A1BAB;
	Tue, 24 Nov 2009 20:12:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=J8PhrSrCksB0QEx7SKYacpH8R
	0Q=; b=aChmIRWddl29y0F0vCEtP4ioYl+toMDCQNQk9mtPaIUOhTpZVciBoKFwh
	Q7fVr9Kns+gGWl4jbLyZpD/wEOv39IqDcoNw71MHDKNtt2Yty7Idlf0x5+NMQTjJ
	DfZ4cAuBIile4U4QwqE6YD1ybQv1c5bqJgkgGcIK7TQmNI8hJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=OKmsvKOkkYhCiop+msl
	ZiHKCEQEMCjXhecnijjY5ErCLgAkln7tq31C7q3vIZdVFhgfnprDQ7jgyAkI7maS
	ArpABVU5KdaMXm8q449zORBTrspy0IuU6Te7MSYROFy7PEQ6jcM9bak3GdGuyF0V
	fhx2CD6dENreDMmYf5SXUqhI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F2B88A1BAA;
	Tue, 24 Nov 2009 20:12:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6AE40A1BA9; Tue, 24 Nov 2009
 20:12:16 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 94D0A50E-D95F-11DE-8D36-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133604>

Uwe Kleine-K=C3=B6nig  <u.kleine-koenig@pengutronix.de> writes:

> Before this change the author was taken from the raw commit without
> reencoding.

I see people often begin with "before this change" and stop the log
message after making a statement of a fact.  I mildly dislike this styl=
e,
especially when the resulting message does not state that it is bad (an=
d
if necessary why it is bad) nor state in what way the code after the
change is good.

	Don't take the author name information without re-encoding
        from the raw commit object buffer.

is easier to read, at least for me.

>  	while (*buffer && *buffer !=3D '\n') {
>  		const char *eol =3D strchr(buffer, '\n');
> =20
> -		if (eol =3D=3D NULL)
> +		if (eol =3D=3D NULL) {
>  			eol =3D buffer + strlen(buffer);
> -		else
> +		} else
>  			eol++;
>  		if (!prefixcmp(buffer, "author "))

What is this hunk for?

> @@ -157,20 +162,20 @@ void shortlog_add_commit(struct shortlog *log, =
struct commit *commit)
>  		die("Missing author: %s",
>  		    sha1_to_hex(commit->object.sha1));
>  	if (log->user_format) {
> -		struct strbuf buf =3D STRBUF_INIT;
>  		struct pretty_print_context ctx =3D {0};
>  		ctx.abbrev =3D DEFAULT_ABBREV;
>  		ctx.subject =3D "";
>  		ctx.after_subject =3D "";
>  		ctx.date_mode =3D DATE_NORMAL;
> +		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &ufbuf, &ctx);
> +		buffer =3D ufbuf.buf;
> +
> +	} else if (*buffer)
>  		buffer++;
> +

You probably wanted to add an extra pair of {} around this "else
if" clause instead, not the earlier one.

Otherwise the change looks good from my cursory look.

> diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> index 405b971..118204b 100755
> --- a/t/t4201-shortlog.sh
> +++ b/t/t4201-shortlog.sh
> @@ -51,5 +51,29 @@ git log HEAD > log
>  GIT_DIR=3Dnon-existing git shortlog -w < log > out
> =20
>  test_expect_success 'shortlog from non-git directory' 'test_cmp expe=
ct out'
> +iconvfromutf8toiso885915() {
> +	printf "%s" "$@" | iconv -f UTF-8 -t ISO-8859-15
> +}

A bad use of "$@" that expands to $# individual words; you meant
to say "$*".

Could we please have the following inside its own test, so that
any failure while preparing the test data is caught as an error?

> +git reset --hard "$commit"
> +git config --unset i18n.commitencoding
> +echo 2 > a1
> +git commit --quiet -m "set a1 to 2 and some non-ASCII chars: =C3=84=C3=
=9F=C3=B8" --author=3D"J=C3=B6h=C3=A4nn=C3=ABs \"Dsch=C3=B6\" Schind=C3=
=ABlin <Johannes.Schindelin@gmx.de>" a1
> +
> +git config i18n.commitencoding "ISO-8859-15"
> +echo 3 > a1
> +git commit --quiet -m "$(iconvfromutf8toiso885915 "set a1 to 3 and s=
ome non-ASCII chars: =C3=A1=C3=A6=C3=AF")" --author=3D"$(iconvfromutf8t=
oiso885915 "J=C3=B6h=C3=A4nn=C3=ABs \"Dsch=C3=B6\" Schind=C3=ABlin <Joh=
annes.Schindelin@gmx.de>")" a1
> +git config --unset i18n.commitencoding
> +
> +git shortlog HEAD~2.. > out
> +
> +cat > expect << EOF
> +J=C3=B6h=C3=A4nn=C3=ABs "Dsch=C3=B6" Schind=C3=ABlin (2):
> +      set a1 to 2 and some non-ASCII chars: =C3=84=C3=9F=C3=B8
> +      set a1 to 3 and some non-ASCII chars: =C3=A1=C3=A6=C3=AF
> +
> +EOF
> +
> +test_expect_success 'shortlog encoding' 'test_cmp expect out'

t3900-i18n-commit already uses 8859-1 so if it is not too much to
ask, it would be much nicer to have these test work between UTF-8
and 8859-1, not -15.

That way, I do not have to worry about breaking tests for people
who were able to run existing iconv tests because they do not have
working 8859-15.

Thanks
