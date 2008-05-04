From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCHv4 1/4] Preparation to call determine_author_info from prepare_to_commit
Date: Sun, 4 May 2008 18:12:19 +0200
Message-ID: <8aa486160805040912h38d81750p83353d21e8c2da6d@mail.gmail.com>
References: <1209917092-12146-1-git-send-email-sbejar@gmail.com>
	 <1209917092-12146-2-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 18:13:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsgpy-00013K-PN
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 18:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbYEDQMa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 12:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbYEDQMa
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 12:12:30 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:17068 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbYEDQM3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2008 12:12:29 -0400
Received: by yw-out-2324.google.com with SMTP id 9so285150ywe.1
        for <git@vger.kernel.org>; Sun, 04 May 2008 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wyHcslMBMU8Aw62HFumJrErN2SDrhh7KDQCk5uotslo=;
        b=RYoAlKCXppOyxtkF7/Ue65bvrYViOUOgZo4HGV59Awa1okIGho6ihoViGbbINVz2gEHAKuS+FEG2lnQDur7VR1QNTIicF6tS1hg8riEnlRdwLLLNzYOL5/6jrKp2hRFpY6V/vZO9bPRtU9Ee8P9fde38srLun90O/O5rqu2xdPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=py1UdKiVCf0L2LaRfWqH0qDEsZregZYOnG2Rq++wGmuG2zcCvWq+iBdnILoUV2Sk90K2BUXJGldOmu4pSctCxAp4Xv9b0aJY+LHgHoJPx24WQ6p5XVCjnrBoTMZQbnmFVWUD/rNfhfT/zfzPiUzrEcHnzDxw8/N4hNNKllRv6jM=
Received: by 10.150.79.32 with SMTP id c32mr5303101ybb.145.1209917539905;
        Sun, 04 May 2008 09:12:19 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Sun, 4 May 2008 09:12:19 -0700 (PDT)
In-Reply-To: <1209917092-12146-2-git-send-email-sbejar@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81182>

On Sun, May 4, 2008 at 6:04 PM, Santi B=E9jar <sbejar@gmail.com> wrote:
> From: Santi B=E9jar <sbjear@gmail.com>

Gggrrr!! I thought I had fixed this. Please remove this line.

Santi

>
>  Reorder functions definitions such that determine_author_info is
>  defined before prepare_to_commit. No code changes.
>
>  Signed-off-by: Santi B=E9jar <sbejar@gmail.com>
>  ---
>   builtin-commit.c |   78 +++++++++++++++++++++++++++----------------=
-----------
>   1 files changed, 39 insertions(+), 39 deletions(-)
>
>  diff --git a/builtin-commit.c b/builtin-commit.c
>  index 256181a..a37d8c3 100644
>  --- a/builtin-commit.c
>  +++ b/builtin-commit.c
>  @@ -395,6 +395,45 @@ static int is_a_merge(const unsigned char *sha1=
)
>
>   static const char sign_off_header[] =3D "Signed-off-by: ";
>
>  +static void determine_author_info(struct strbuf *sb)
>  +{
>  +       char *name, *email, *date;
>  +
>  +       name =3D getenv("GIT_AUTHOR_NAME");
>  +       email =3D getenv("GIT_AUTHOR_EMAIL");
>  +       date =3D getenv("GIT_AUTHOR_DATE");
>  +
>  +       if (use_message) {
>  +               const char *a, *lb, *rb, *eol;
>  +
>  +               a =3D strstr(use_message_buffer, "\nauthor ");
>  +               if (!a)
>  +                       die("invalid commit: %s", use_message);
>  +
>  +               lb =3D strstr(a + 8, " <");
>  +               rb =3D strstr(a + 8, "> ");
>  +               eol =3D strchr(a + 8, '\n');
>  +               if (!lb || !rb || !eol)
>  +                       die("invalid commit: %s", use_message);
>  +
>  +               name =3D xstrndup(a + 8, lb - (a + 8));
>  +               email =3D xstrndup(lb + 2, rb - (lb + 2));
>  +               date =3D xstrndup(rb + 2, eol - (rb + 2));
>  +       }
>  +
>  +       if (force_author) {
>  +               const char *lb =3D strstr(force_author, " <");
>  +               const char *rb =3D strchr(force_author, '>');
>  +
>  +               if (!lb || !rb)
>  +                       die("malformed --author parameter");
>  +               name =3D xstrndup(force_author, lb - force_author);
>  +               email =3D xstrndup(lb + 2, rb - (lb + 2));
>  +       }
>  +
>  +       strbuf_addf(sb, "author %s\n", fmt_ident(name, email, date, =
IDENT_ERROR_ON_NO_NAME));
>  +}
>  +
>   static int prepare_to_commit(const char *index_file, const char *pr=
efix)
>   {
>         struct stat statbuf;
>  @@ -622,45 +661,6 @@ static int message_is_empty(struct strbuf *sb, =
int start)
>         return 1;
>   }
>
>  -static void determine_author_info(struct strbuf *sb)
>  -{
>  -       char *name, *email, *date;
>  -
>  -       name =3D getenv("GIT_AUTHOR_NAME");
>  -       email =3D getenv("GIT_AUTHOR_EMAIL");
>  -       date =3D getenv("GIT_AUTHOR_DATE");
>  -
>  -       if (use_message) {
>  -               const char *a, *lb, *rb, *eol;
>  -
>  -               a =3D strstr(use_message_buffer, "\nauthor ");
>  -               if (!a)
>  -                       die("invalid commit: %s", use_message);
>  -
>  -               lb =3D strstr(a + 8, " <");
>  -               rb =3D strstr(a + 8, "> ");
>  -               eol =3D strchr(a + 8, '\n');
>  -               if (!lb || !rb || !eol)
>  -                       die("invalid commit: %s", use_message);
>  -
>  -               name =3D xstrndup(a + 8, lb - (a + 8));
>  -               email =3D xstrndup(lb + 2, rb - (lb + 2));
>  -               date =3D xstrndup(rb + 2, eol - (rb + 2));
>  -       }
>  -
>  -       if (force_author) {
>  -               const char *lb =3D strstr(force_author, " <");
>  -               const char *rb =3D strchr(force_author, '>');
>  -
>  -               if (!lb || !rb)
>  -                       die("malformed --author parameter");
>  -               name =3D xstrndup(force_author, lb - force_author);
>  -               email =3D xstrndup(lb + 2, rb - (lb + 2));
>  -       }
>  -
>  -       strbuf_addf(sb, "author %s\n", fmt_ident(name, email, date, =
IDENT_ERROR_ON_NO_NAME));
>  -}
>  -
>   static int parse_and_validate_options(int argc, const char *argv[],
>                                       const char * const usage[])
>   {
>  --
>  1.5.5.1.224.gadb29
>
>
