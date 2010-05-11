From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: Multiple line ranges and files in line level history browser
Date: Tue, 11 May 2010 14:28:51 +0800
Message-ID: <AANLkTimhMLazMDk53fY3g3Fy0FXXHWIC9o5VST7fPQjG@mail.gmail.com>
References: <p2q41f08ee11005090700xdb6070dajab0e2d77b1d0f9fc@mail.gmail.com>
	 <20100509210654.GA1637@progeny.tock>
	 <20100510093120.GA4445@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 11 08:29:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBixg-00057G-4u
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 08:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756985Ab0EKG2z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 May 2010 02:28:55 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:64923 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756968Ab0EKG2y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 May 2010 02:28:54 -0400
Received: by qyk13 with SMTP id 13so7591560qyk.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 23:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4/ZR9Co89s1Fjct1vgo+lgm6Hnf2P/1XxtRMua9KkDA=;
        b=Ma6jRETDQu7IvR22FwKg3rbXU9GQY1Rw9d+HJk2m6qOhzl5/xUGRm83hg+wMcjJknh
         rwzNgP44ZqwGsMAvqO3/DL8Ehol2KWo2JQNcOIuRkZ+HPxLF4xkFlK7NttN3cYv+aFU0
         bnTHzp///ZTbDMpj8SsNgqQtebyWnBGx5kr6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YNnwdva9e5/wi2KImk97DCsDbkej2w/Pjdx6GNaW8r7D9OsIbNsXUzIaQ8D+LZBaaw
         +xmzHzK0iN04k3cueQJaiB7xi93rgsbzK9PlFbi0sR5EYAzJ7H/D++jr/JFUlDDYmnYl
         L1G1ih451yQ2K3W0+9idtPJ4gCUQTqQFtJlI8=
Received: by 10.229.211.68 with SMTP id gn4mr4167852qcb.79.1273559331726; Mon, 
	10 May 2010 23:28:51 -0700 (PDT)
Received: by 10.229.97.80 with HTTP; Mon, 10 May 2010 23:28:51 -0700 (PDT)
In-Reply-To: <20100510093120.GA4445@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146875>

Hi Jonathan,
    Many thanks to provide so much precious advice and even a patch, I
think the patch is really helpful. Thanks.
    After some thought, I think we should keep the syntax as simple,
see my following comments.

On Mon, May 10, 2010 at 5:31 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jonathan Nieder wrote:
> The -L arguments describe lines in some particular revision of the
> files, so how would arbitrary =91rev-list=92-style revision specifier=
s
> work here? =A0They don=92t: in =91blame=92, one "positive" revision i=
s allowed
> and the rest must be negative. =A0Good.

A great reminder, thanks!

> The modified proposal was, roughly:
>
> =A0git blame [options, no -L among them] revs ((-L range)... filespec=
)...
> =A0git blame [options, -L permitted] revs -- [filespec...]
> =A0git blame [options, -L permitted] revs [filespec...]
>
> =93...=94 means =93one or more=94. =A0How to know whether the -L or r=
evision
> arguments are encountered first? =A0One approach is to abuse
> STOP_AT_NON_OPTION to catch the -L, revisions, and filespecs as they
> appear. =A0Probably better would be to make -L an unknown option and
> rely on parse_revision_opt leaving a residue of any revisions it
> finds, so that after the first pass, the first syntax can be
> distinguished from the others by the first argument starting with "-L=
".

How if the user provide now <revs> argument at all. In that case, we
may encounter the '-L' firstly too. And then we need to check whether
the non option argument is revision specifier. I think this kind of
check is not good to appear in builtin/log.c

> Feel free to do something else entirely (including another syntax) if
> you prefer, of course.

Yeah, I want to make a simpler syntax for the line level browser. It is=
:

git log [options without -L] revs ((-Llines)... filespec)...

We can then parse the options by:
1. Make -L a unknown option and call parse_revision_opt to filter out
all options and leave out  revs, -L and pathspec.
2. Parse the remain options with '-L' a known option and your
STOP_AT_NON_OPTION way to matching all line ranges with pathspec.
Error out when there are some pathspec which has no line ranges
specified. And this time, leaving out the revs and pathspec. And put a
'--' just before the first '-L'.
3. Call setup_revisions using the remain arguments.

> Here=92s a patch that makes STOP_AT_NON_OPTION easier to abuse, witho=
ut
> affecting current users. =A0Maybe it would make it easier to play
> around.
>
> Good night,
> Jonathan
>
> =A0parse-options.c | =A0 =A03 ++-
> =A0parse-options.h | =A0 =A01 +
> =A02 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 8546d85..4e3532b 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -372,7 +372,7 @@ int parse_options_step(struct parse_opt_ctx_t *ct=
x,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (parse_nodash_opt(c=
tx, arg, options) =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0contin=
ue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ctx->flags & PARSE=
_OPT_STOP_AT_NON_OPTION)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
PARSE_OPT_NON_OPTION;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctx->out[ctx->cpidx++]=
 =3D ctx->argv[0];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -454,6 +454,7 @@ int parse_options(int argc, const char **argv, co=
nst char *prefix,
> =A0 =A0 =A0 =A0switch (parse_options_step(&ctx, options, usagestr)) {
> =A0 =A0 =A0 =A0case PARSE_OPT_HELP:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(129);
> + =A0 =A0 =A0 case PARSE_OPT_NON_OPTION:
> =A0 =A0 =A0 =A0case PARSE_OPT_DONE:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0default: /* PARSE_OPT_UNKNOWN */
> diff --git a/parse-options.h b/parse-options.h
> index 7581e93..4773cf9 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -160,6 +160,7 @@ extern NORETURN void usage_msg_opt(const char *ms=
g,
> =A0enum {
> =A0 =A0 =A0 =A0PARSE_OPT_HELP =3D -1,
> =A0 =A0 =A0 =A0PARSE_OPT_DONE,
> + =A0 =A0 =A0 PARSE_OPT_NON_OPTION,
> =A0 =A0 =A0 =A0PARSE_OPT_UNKNOWN,
> =A0};
>
> --
> 1.7.1
>
>

Really thanks for this patch I will use it.

Regards!
Bo
--=20
My blog: http://blog.morebits.org
