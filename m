From: Will Palmer <wmpalmer@gmail.com>
Subject: Fwd: [PATCH 2/2] pretty.c: allow date formats in user format strings
Date: Sun, 6 Mar 2011 21:54:01 +0000
Message-ID: <AANLkTikaN=wsg6RLFaFxh=L3RCYjKkVGFR4VTrQ=KRZk@mail.gmail.com>
References: <20110305195020.GA3089@sigill.intra.peff.net> <20110305200010.GB32095@sigill.intra.peff.net>
 <AANLkTinH8zwX2sbd5bpk=x4R3zOAg3Dc92Fbspfdv03T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 22:54:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwLuG-0001WA-2g
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 22:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687Ab1CFVyW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Mar 2011 16:54:22 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43345 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab1CFVyW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Mar 2011 16:54:22 -0500
Received: by iyb26 with SMTP id 26so3425010iyb.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 13:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=qseapcqoF9DKprv1j95MpcObt78Uyru9CokhS9kY2k8=;
        b=mc6BnhokpPrLGmAuO29DVFTaWWisi11bynavWoWqGLR2hKgs2L3TUmkm7HR1pO7Ab1
         MI10nIYNq6prxTUg1DAFOSomJt56ykUaPjrJ0iIG8LuGHNGfP98VkTDmHjXhMMLQ6PDp
         lsYc6DvZhBfiTWnqE2INToMRRwzQ+k5iJkEGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=VCTK+orWJm6QTBjAuabLOzfNjKRd8qHClH0PS/UifgygHm9h433gEX6/8dwwvktQwk
         yc5V+hz3fo2dTNrJgTtZlBIVQd3g6cVLReIT6cUPbQOrd7qra2mVr23pR4QGDc1eqJNL
         JV9XhxNXp/zhCUmUyLk8st3kb3jium//Eiv8k=
Received: by 10.43.59.4 with SMTP id wm4mr2444360icb.372.1299448461279; Sun,
 06 Mar 2011 13:54:21 -0800 (PST)
Received: by 10.42.170.3 with HTTP; Sun, 6 Mar 2011 13:54:01 -0800 (PST)
In-Reply-To: <AANLkTinH8zwX2sbd5bpk=x4R3zOAg3Dc92Fbspfdv03T@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168534>

(I think I accidentally hit "reply" instead of "reply all", there, so
forwarding to list)

On Sat, Mar 5, 2011 at 8:00 PM, Jeff King <peff@peff.net> wrote:
> You can now do "%ad(short)" or similar (using any format
> that works for --date). This makes some formats like %aD
> redundant (since you can do "%ad(rfc)"), but of course we
> keep them for compatibility.
>

The more I see long formats like this, the more I think it would make
sense to make formats %(likeThis), the way for-each-ref does.
Ideally, these formats could even be unified, at some point.

I tried this a long while ago, as part of my attempt to make all
pre-defined formats work in terms of format strings, but that turned
into too much of a bloated mess to bother submitting. I don't know
if there's enough interest in such a thing to justify trying again (or =
to
justify rebasing the bloated version, cleaning it up and submitting it
as-is, for that matter)

Point is: we're going to keep having more and more format options,
I think that's a given. At some point, these short mnemonics will just
stop making sense, and it makes sense to have an escape plan when
that happens.

> While we're updating the docs, let's explain in more detail
> how the placeholder mode, the --date=3D option, and the
> log.date config all interact.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> My only reservation here is the strdup() we need to call
> parse_date_format(). We usually try to keep the formatting parsing
> lightweight since it gets re-parsed for each commit.
>
> My timings for logging all of git.git showed that the slowdown is los=
t
> in the noise, so it's probably not worth caring about.
>
> =A0Documentation/pretty-formats.txt | =A0 21 +++++++++++++++++++--
> =A0pretty.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 33 =
+++++++++++++++++++++++++++++----
> =A0t/t6006-rev-list-format.sh =A0 =A0 =A0 | =A0 12 ++++++++++++
> =A03 files changed, 60 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-=
formats.txt
> index 561cc9f..a73a9ac 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -109,7 +109,7 @@ The placeholders are:
> =A0- '%aN': author name (respecting .mailmap, see linkgit:git-shortlo=
g[1] or linkgit:git-blame[1])
> =A0- '%ae': author email
> =A0- '%aE': author email (respecting .mailmap, see linkgit:git-shortl=
og[1] or linkgit:git-blame[1])
> -- '%ad': author date (format respects --date=3D option)
> +- '%ad': author date (see below for format information)
> =A0- '%aD': author date, RFC2822 style
> =A0- '%ar': author date, relative
> =A0- '%at': author date, UNIX timestamp
> @@ -118,7 +118,7 @@ The placeholders are:
> =A0- '%cN': committer name (respecting .mailmap, see linkgit:git-shor=
tlog[1] or linkgit:git-blame[1])
> =A0- '%ce': committer email
> =A0- '%cE': committer email (respecting .mailmap, see linkgit:git-sho=
rtlog[1] or linkgit:git-blame[1])
> -- '%cd': committer date
> +- '%cd': committer date (see below for format information)
> =A0- '%cD': committer date, RFC2822 style
> =A0- '%cr': committer date, relative
> =A0- '%ct': committer date, UNIX timestamp
> @@ -151,6 +151,23 @@ insert an empty string unless we are traversing =
reflog entries (e.g., by
> =A0`git log -g`). The `%d` placeholder will use the "short" decoratio=
n
> =A0format if `--decorate` was not already provided on the command lin=
e.
>
> +Dates given by `%ad` and `%cd` are formatted according to the follow=
ing
> +rules:
> +
> + =A01. A date mode in parentheses may follow the placeholder. For ex=
ample,
> + =A0 =A0 `%ad(iso8601)` will format the author date in the ISO8601 f=
ormat.
> + =A0 =A0 You may specify any mode valid for the `--date=3D` option o=
f
> + =A0 =A0 linkgit:git-log[1].
> +
> + =A02. If no date mode is specified, and the command respects the
> + =A0 =A0 `--date=3D` option, the mode specified by that option is us=
ed.
> +
> + =A03. Otherwise, if the format is used by the log family of command=
s and
> + =A0 =A0 the `log.date` config option is set, the mode specified by =
that
> + =A0 =A0 option is used.
> +
> + =A04. Otherwise, the format is equivalent to that of --date=3Ddefau=
lt.
> +
> =A0If you add a `{plus}` (plus sign) after '%' of a placeholder, a li=
ne-feed
> =A0is inserted immediately before the expansion if and only if the
> =A0placeholder expands to a non-empty string.
> diff --git a/pretty.c b/pretty.c
> index 00bcf83..d0bf2a0 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -440,6 +440,27 @@ static int mailmap_name(char *email, int email_l=
en, char *name, int name_len)
> =A0 =A0 =A0 =A0return mail_map->nr && map_user(mail_map, email, email=
_len, name, name_len);
> =A0}
>
> +static size_t format_date(struct strbuf *sb, const char *part,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long date,=
 int tz, enum date_mode dmode)
> +{
> + =A0 =A0 =A0 int consumed =3D 0;
> + =A0 =A0 =A0 if (*part =3D=3D '(') {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *v;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 consumed++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (part[consumed] && part[consumed]=
 !=3D ')')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 consumed++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* yuck, we do this malloc for every co=
mmit */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D xstrndup(part + 1, consumed - 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dmode =3D parse_date_format(v);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(v);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (part[consumed] =3D=3D ')')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 consumed++;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (sb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addstr(sb, show_date(date, tz, d=
mode));
> + =A0 =A0 =A0 return consumed;
> +}
> +
> =A0static size_t format_person_part(struct strbuf *sb, const char *pa=
rt,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const=
 char *msg, int len, enum date_mode dmode)
> =A0{
> @@ -519,9 +540,9 @@ static size_t format_person_part(struct strbuf *s=
b, const char *part,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0switch (*part) {
> - =A0 =A0 =A0 case 'd': =A0 =A0 =A0 /* date */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 strbuf_addstr(sb, show_date(date, tz, d=
mode));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return placeholder_len;
> + =A0 =A0 =A0 case 'd': =A0 =A0 =A0 /* date, possibly with format */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return placeholder_len +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format_date(sb, part + =
1, date, tz, dmode);
> =A0 =A0 =A0 =A0case 'D': =A0 =A0 =A0 /* date, RFC2822 style */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strbuf_addstr(sb, show_date(date, tz, =
DATE_RFC2822));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return placeholder_len;
> @@ -538,9 +559,13 @@ skip:
> =A0 =A0 =A0 =A0 * bogus commit, 'sb' cannot be updated, but we still =
need to
> =A0 =A0 =A0 =A0 * compute a valid return value.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (*part =3D=3D 'n' || *part =3D=3D 'e' || *part =3D=3D=
 't' || *part =3D=3D 'd'
> + =A0 =A0 =A0 if (*part =3D=3D 'n' || *part =3D=3D 'e' || *part =3D=3D=
 't'
> =A0 =A0 =A0 =A0 =A0 =A0|| *part =3D=3D 'D' || *part =3D=3D 'r' || *pa=
rt =3D=3D 'i')
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return placeholder_len;
> + =A0 =A0 =A0 /* handle 'd' separately, as it is variable length */
> + =A0 =A0 =A0 if (*part =3D=3D 'd')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return placeholder_len +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 format_date(NULL, part =
+ 1, 0, 0, 0);
>
> =A0 =A0 =A0 =A0return 0; /* unknown placeholder */
> =A0}
> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index d918cc0..b9cef1f 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> @@ -176,6 +176,18 @@ test_expect_success '%ad respects --date=3D' '
> =A0 =A0 =A0 =A0test_cmp expect.ad-short output.ad-short
> =A0'
>
> +test_format 'date-with-mode' '%ad(short)%n%ad(iso)' <<'EOF'
> +commit f58db70b055c5718631e5c61528b28b12090cdea
> +2005-04-07
> +2005-04-07 15:13:13 -0700
> +commit 131a310eb913d107dd3c09a65d1651175898735d
> +2005-04-07
> +2005-04-07 15:13:13 -0700
> +commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
> +2005-04-07
> +2005-04-07 15:13:13 -0700
> +EOF
> +
> =A0test_expect_success 'empty email' '
> =A0 =A0 =A0 =A0test_tick &&
> =A0 =A0 =A0 =A0C=3D$(GIT_AUTHOR_EMAIL=3D git commit-tree HEAD^{tree} =
</dev/null) &&
> --
> 1.7.4.rc1.24.g38985d
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
