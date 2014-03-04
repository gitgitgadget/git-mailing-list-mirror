From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] upload-pack: allow shallow fetching from a read-only repository
Date: Tue, 04 Mar 2014 10:10:22 -0800
Message-ID: <xmqqr46hltrl.fsf@gitster.dls.corp.google.com>
References: <1393485183-20100-1-git-send-email-pclouds@gmail.com>
	<1393936205-15953-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 19:10:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKtna-0003Yy-Sj
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 19:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbaCDSKe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2014 13:10:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45881 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbaCDSKd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 13:10:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22BFC6F229;
	Tue,  4 Mar 2014 13:10:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Xfdl1EaT9gK9
	oj2xPP6M/RIm4RY=; b=O3ykwRp47KN3EmZwGBvo1sGoHufBFbqRTvMqxdYeM9AD
	awnW8mA2PbcohIlQS19YdT6/tQ7CO4w/Ri3suojX+h+oYC5FUoLjFXq/j10xu5yU
	CGPPw3yfCN+IEWbDFR+amu4BLqiYgO45zKjJbxncSkmXpABsta0W6bH0+bzMrA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LYDXAb
	aE9GYUb0P8jOLX8WjeNA+tlHrj8yb0Fpv28jMAR+3r6d4OWik3RKrbWUGEAmSh8V
	OeVJdK6r21WS3j47B3OZL+wJAoBYSInfjXu6qHrcKEEOWov7tCwasxt/Ux/Q78tP
	u8A4/C2lsZBTdsUOeIzUnyj8ZsGvK1tQdDkBo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D3586F228;
	Tue,  4 Mar 2014 13:10:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8987A6F226;
	Tue,  4 Mar 2014 13:10:25 -0500 (EST)
In-Reply-To: <1393936205-15953-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 4 Mar
 2014 19:30:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4281E1C2-A3C8-11E3-8288-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243364>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Before cdab485 (upload-pack: delegate rev walking in shallow fetch to
> pack-objects - 2013-08-16) upload-pack does not write to the source
> repository. cdab485 starts to write $GIT_DIR/shallow_XXXXXX if it's a
> shallow fetch, so the source repo must be writable.
>
> git:// servers do not need write access to repos and usually don't,
> which mean cdab485 breaks shallow clone over git://
>
> Fall back to $TMPDIR if $GIT_DIR/shallow_XXXXXX cannot be created in
> this case. Note that in other cases that write $GIT_DIR/shallow_XXXXX=
X
> and eventually rename it to $GIT_DIR/shallow, there is no fallback to
> $TMPDIR.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Rebased on top of jk/shallow-update-fix

Hmph.

I notice that the original code, with or without this change, allows
upload-pack spawned by daemon to attempt to write into GIT_DIR.
As upload-pack is supposed to be a read-only operation, this is
quite bad.

Perhaps we should give server operators an option to run their
daemon -> upload-pack chain to always write to a throw-away
directory of their choice, without ever attempting to write to
GIT_DIR it serves?

How well is the access to the temporary shallow file controlled in
your code (sorry, but I do not recall carefully reading your patch
that added the mechanism with security issues in mind, so now I am
asking)?  When it is redirected to TMPDIR (let's forget GIT_DIR for
now---if an attacker can write into there, the repository is already
lost), can an attacker race with us to cause us to overwrite we do
not expect to?

Even if it turns out that this patch is secure enough as-is, we
definitely need to make sure that server operators, who want to keep
their upload-pack truly a read-only operation, know that it is
necessary to (1) keep the system user they run git-daemon under
incapable of writing into GIT_DIR, and (2) make sure TMPDIR points
at somewhere only git-daemon user and nobody else can write into,
somewhere in the documentation.

> diff --git a/fetch-pack.c b/fetch-pack.c
> index ae8550e..b71d186 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -853,7 +853,7 @@ static struct ref *do_fetch_pack(struct fetch_pac=
k_args *args,
>  		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
>  					NULL);
>  	else if (si->nr_ours || si->nr_theirs)
> -		alternate_shallow_file =3D setup_temporary_shallow(si->shallow);
> +		alternate_shallow_file =3D setup_temporary_shallow(si->shallow, 0)=
;
>  	else
>  		alternate_shallow_file =3D NULL;
>  	if (get_pack(args, fd, pack_lockfile))
> diff --git a/shallow.c b/shallow.c
> index c7602ce..ad28af6 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -224,7 +224,8 @@ static void remove_temporary_shallow_on_signal(in=
t signo)
>  	raise(signo);
>  }
> =20
> -const char *setup_temporary_shallow(const struct sha1_array *extra)
> +const char *setup_temporary_shallow(const struct sha1_array *extra,
> +				    int read_only)
>  {
>  	static int installed_handler;
>  	struct strbuf sb =3D STRBUF_INIT;
> @@ -235,7 +236,15 @@ const char *setup_temporary_shallow(const struct=
 sha1_array *extra)
> =20
>  	if (write_shallow_commits(&sb, 0, extra)) {
>  		strbuf_addstr(&temporary_shallow, git_path("shallow_XXXXXX"));
> -		fd =3D xmkstemp(temporary_shallow.buf);
> +		fd =3D mkstemp(temporary_shallow.buf);
> +		if (read_only && fd < 0) {
> +			strbuf_grow(&temporary_shallow, PATH_MAX);
> +			fd =3D git_mkstemp(temporary_shallow.buf, PATH_MAX,
> +					 "shallow_XXXXXX");
> +		}
> +		if (fd < 0)
> +			die_errno("Unable to create temporary file '%s'",
> +				  temporary_shallow.buf);
> =20
>  		if (!installed_handler) {
>  			atexit(remove_temporary_shallow);
> diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
> index b0fa738..171db88 100755
> --- a/t/t5537-fetch-shallow.sh
> +++ b/t/t5537-fetch-shallow.sh
> @@ -173,6 +173,19 @@ EOF
>  	)
>  '
> =20
> +test_expect_success POSIXPERM 'shallow fetch from a read-only repo' =
'

s/POSIXPERM/&,SANITY/, perhaps?

Thinking of it again, perhaps POSIXPERM should imply SANITY is required=
?

> +	cp -R .git read-only.git &&
> +	find read-only.git -print | xargs chmod -w &&
> +	test_when_finished "find read-only.git -type d -print | xargs chmod=
 +w" &&
> +	git clone --no-local --depth=3D2 read-only.git from-read-only &&
> +	git --git-dir=3Dfrom-read-only/.git log --format=3D%s >actual &&
> +	cat >expect <<EOF &&
> +add-1-back
> +4
> +EOF
> +	test_cmp expect actual
> +'
> +
>  if test -n "$NO_CURL" -o -z "$GIT_TEST_HTTPD"; then
>  	say 'skipping remaining tests, git built without http support'
>  	test_done
> diff --git a/upload-pack.c b/upload-pack.c
> index a3c52f6..b538f32 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -84,7 +84,7 @@ static void create_pack_file(void)
>  	const char *shallow_file =3D NULL;
> =20
>  	if (shallow_nr) {
> -		shallow_file =3D setup_temporary_shallow(NULL);
> +		shallow_file =3D setup_temporary_shallow(NULL, 1);
>  		argv[arg++] =3D "--shallow-file";
>  		argv[arg++] =3D shallow_file;
>  	}
