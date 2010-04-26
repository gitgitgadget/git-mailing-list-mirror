From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/3] pretty: make %H/%h dependent on
 --abbrev[-commit]
Date: Sun, 25 Apr 2010 22:11:37 -0500
Message-ID: <20100426031012.GA29953@progeny.tock>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 05:11:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Eio-0007WD-Ei
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 05:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab0DZDKw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 23:10:52 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:63990 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab0DZDKv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 23:10:51 -0400
Received: by qyk9 with SMTP id 9so16606268qyk.1
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 20:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=h+1cJUEzK65Ra187bBXB4j2mD3iqOaw3IsjdBdQj/U8=;
        b=g9CgbdqA9iMFQlJaLR4M0tH82wWJvibIZKgyqGD2WVa8kE0N9MAurGRKE2h6ZPnKMC
         M0+fdleWXdHR4gLhX7STk8q8PL9CaNbfUy1Nqf40eNTmv4EZCLdII8ZMzAdjYp7h5vIw
         wyFP3qGts4WXIt1MDBsKGToVmc34M5wkqcFHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=pk70W+gAxeOIZ46AqsnNn/f58BJOpRZdZA8Xi8kW+RbreUeRCEbEKmfl1TAwqyYu3G
         3X4iqvaFESLhHw15qq4tTdONzeJx6UxaHMid2+DU6jK3AXrXpzNjqKjDUd0nftDKiWx9
         XC8c3JR2rJy7DkCsgEUqlMURFkx7KKVH5d5ew=
Received: by 10.229.191.1 with SMTP id dk1mr4111565qcb.18.1272251450765;
        Sun, 25 Apr 2010 20:10:50 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2731337iwn.2.2010.04.25.20.10.47
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 20:10:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145780>

Will Palmer wrote:

> Here we make "git log --pretty=3D%H --abbrev-commit" synonymous with
> "git log --pretty=3D%h", and make %h/abbreviated-%H respect the lengt=
h
> specified for --abbrev.
>=20
> The same is applied to other commit-placeholders %P and %p, and
> --abbrev is respected for %t, though %T is not changed.
>=20
> Signed-off-by: Will Palmer <wmpalmer@gmail.com>
> ---
>  builtin/rev-list.c |    1 +
>  builtin/shortlog.c |    2 ++
>  commit.h           |    1 +
>  log-tree.c         |    2 ++
>  pretty.c           |   30 +++++++++++++++++++-----------
>  5 files changed, 25 insertions(+), 11 deletions(-)

I agree that this is the right to do, since this is how the built-in
formats work (the =E2=80=98commit ...=E2=80=99 line follows the semanti=
cs of your %H,
and =E2=80=98Merge: ...=E2=80=99 line your %p, for example).

Documentation and tests?

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 5a53862..1d1e59c 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -98,6 +98,7 @@ static void show_commit(struct commit *commit, void=
 *data)
>  		struct strbuf buf =3D STRBUF_INIT;
>  		struct pretty_print_context ctx =3D {0};
>  		ctx.abbrev =3D revs->abbrev;
> +		ctx.abbrev_commit =3D revs->abbrev_commit;
>  		ctx.date_mode =3D revs->date_mode;
>  		ctx.use_color =3D DIFF_OPT_TST(&revs->diffopt, COLOR_DIFF);
>  		pretty_print_commit(revs->commit_format, commit, &buf, &ctx);

Makes sense.

> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 7aee491..5c0721c 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -143,6 +143,8 @@ void shortlog_add_commit(struct shortlog *log, st=
ruct commit *commit, struct rev
>  	struct strbuf ufbuf =3D STRBUF_INIT;
>  	struct pretty_print_context ctx =3D {0};
> =20
> +	ctx.abbrev =3D rev->abbrev;
> +	ctx.abbrev_commit =3D rev->abbrev_commit;
>  	ctx.use_color =3D DIFF_OPT_TST(&rev->diffopt, COLOR_DIFF);
>  	pretty_print_commit(CMIT_FMT_RAW, commit, &buf, &ctx);
>  	buffer =3D buf.buf;

Shortlog doesn=E2=80=99t print commit hashes, does it?

> diff --git a/commit.h b/commit.h
> index b6caf91..7a476a0 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -72,6 +72,7 @@ struct pretty_print_context
>  	int need_8bit_cte;
>  	int show_notes;
>  	int use_color;
> +	int abbrev_commit;
>  	struct reflog_walk_info *reflog_info;
>  };
> =20

nitpick: I=E2=80=99d stick this up with abbrev and maybe add a comment =
to
explain their distinct uses.

> diff --git a/log-tree.c b/log-tree.c
> index 6bb4748..0a2309c 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -282,6 +282,8 @@ void show_log(struct rev_info *opt)
>  	int abbrev_commit =3D opt->abbrev_commit ? opt->abbrev : 40;
>  	const char *extra_headers =3D opt->extra_headers;
>  	struct pretty_print_context ctx =3D {0};
> +	ctx.abbrev =3D opt->abbrev;
> +	ctx.abbrev_commit =3D opt->abbrev_commit;
>  	ctx.use_color =3D DIFF_OPT_TST(&opt->diffopt, COLOR_DIFF);
> =20
>  	opt->loginfo =3D NULL;

There is a

ctx.abbrev =3D opt->diffopt.abbrev;

later in the same function; how do these interact?

> @@ -741,24 +744,29 @@ static size_t format_commit_one(struct strbuf *=
sb, const char *placeholder,
[...]
>  			strbuf_addstr(sb, find_unique_abbrev(
> -					p->item->object.sha1, DEFAULT_ABBREV));
> +				      p->item->object.sha1,
> +				      c->pretty_ctx->abbrev));

nitpick: the new indentation makes these look like parameters to
strbuf_addstr.

Here=E2=80=99s an alternative implementation of the more controversial =
half of
your patch, for your amusement.  The big downside is that it requires
one to specify --abbrev-commit before the --format option.

Thanks for the pleasant read.

Jonathan

diff --git a/pretty.c b/pretty.c
index 7cb3a2a..1008a41 100644
--- a/pretty.c
+++ b/pretty.c
@@ -12,10 +12,31 @@
=20
 static char *user_format;
=20
+static void abbreviate_commit_hashes(char *fmt)
+{
+	char *p;
+	for (p =3D fmt; p !=3D NULL; p =3D strchr(p + 1, '%')) {
+		p++;
+		switch (*p) {
+		case 'H':
+			*p =3D 'h';
+			break;
+		case 'P':
+			*p =3D 'p';
+			break;
+		case 'T':
+		default:
+			break;
+		}
+	}
+}
+
 static void save_user_format(struct rev_info *rev, const char *cp, int=
 is_tformat)
 {
 	free(user_format);
 	user_format =3D xstrdup(cp);
+	if (rev->abbrev_commit)
+		abbreviate_commit_hashes(user_format);
 	if (is_tformat)
 		rev->use_terminator =3D 1;
 	rev->commit_format =3D CMIT_FMT_USERFORMAT;
