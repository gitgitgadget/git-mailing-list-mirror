From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Bug: `gitsubmodule` does not list modules with unicode
 characters
Date: Sat, 8 Jun 2013 03:05:56 +0200
Message-ID: <20130608010556.GA28819@paksenarrion.iveqy.com>
References: <loom.20130323T171809-46@post.gmane.org>
 <51500B34.30801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilya Kulakov <kulakov.ilya@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jun 08 03:03:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul7Z4-0000ny-Vx
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 03:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757120Ab3FHBD1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 21:03:27 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:57477 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756939Ab3FHBD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 21:03:26 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so712804lab.36
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 18:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TE3vzrIWXvED8QlnSmCcx2RL5PS+K5EjC7y+JeqdgUs=;
        b=ScSTnbbVIv8seBU4Ro/GQZLModNgsi0nQbfK/jS80SDjwZsKmag7xkUfCgp0+t0nut
         +NFIqeSUY1lxwMvrRWeo9Ty0X6Ah9WcplullftyccjuY3al0XwqUEbV07EbH7OKTA5mk
         6daVCyuDJxqZiOfU3bItEKnOvEAZ4rBsNfVjWjrD/O0nQQdWjS+9EOxtVeT/GBRAlvLf
         p1OJI6JPc0YQkvdsIP6XGgdqjyZQDwpPWeIPw8A5sCZWo8dpg8AGNES1Zco+rQIWiZv9
         /7Pc+uOaxH/Nyx/0miKMmDt1LL46y5e9bem8g36Bbp/zCbt5dTVl3BSypmLM/k+J5tCZ
         9sNg==
X-Received: by 10.152.1.137 with SMTP id 9mr543202lam.10.1370653404910;
        Fri, 07 Jun 2013 18:03:24 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id p16sm1788470lbi.13.2013.06.07.18.03.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 18:03:24 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Ul7bQ-0007YV-5Z; Sat, 08 Jun 2013 03:05:56 +0200
Content-Disposition: inline
In-Reply-To: <51500B34.30801@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226777>

On Mon, Mar 25, 2013 at 09:30:44AM +0100, Jens Lehmann wrote:
> Am 23.03.2013 17:28, schrieb Ilya Kulakov:
> > The `git submodule` commands seem to ignore modules which paths con=
tain
> > unicode characters.
> >=20
> > Consider the following steps to reproduce the problem:
> >=20
> >   1. Create a directory with name that contains at least one unicod=
e character
> >      (e.g. "=FB=F1=EF=E7=F6d=E9-r=E8p=F8")
> >=20
> >   2. Initialize git repository within this directory
> >=20
> >   3. Add this repository as a submodule to another repository so th=
at
> >      unicode characters will appear in the path to the module
> >      (e.g. "../=FB=F1=EF=E7=F6d=E9-r=E8p=F8")
> >=20
> >   4. Check that .gitmodules file is updated and contains record
> >      about just added module
> >=20
> >   5. List submodules with using `git submodule` and find out
> >      that just added module is not listed
>=20
> Thanks for your report. It is known that git submodule does not behav=
e
> very well when path names contain special characters. I'll look into
> that when I find some time to see if we can easily fix your problem.

I've looked into this a bit.

git ls-files will return all filenames "c-style quoted". Hence the
filename =E5=E4=F6 will be returned as "303245303244303266". This is of=
 course
also wrong as it should be "\303\245\303\244\303\266".

However, if we tell git ls-files to use \0 instead of \n for line
termination. We get =E5=E4=F6 returned. So how can the choose of line t=
ermination
effect the encoding?

Look in quote.c. The following patch will solve this particular problem
(but break other usecases!)

diff --git a/quote.c b/quote.c
index 911229f..2870ca5 100644
--- a/quote.c
+++ b/quote.c
@@ -284,7 +284,7 @@ void quote_two_c_style(struct strbuf *sb, const cha=
r *prefix, const char *path,
 void write_name_quoted(const char *name, FILE *fp, int terminator)
 {
 	if (terminator) {
-		quote_c_style(name, NULL, fp, 0);
+		fputs(name, fp);
 	} else {
 		fputs(name, fp);
 	}

Why don't we always print names quoted? IMHO the choose of line
termination should not do anything else than alter the line termination=
=2E

However, an other solution would be to use git ls-files -z in
git-submodule.sh and then rewrite the perl-code to handle \0 instead
of \n.

(The same perl-code I wanted to throw away 13 months ago but
Junio wanted to keep because perl can handle \0 and eventually -z shoul=
d
be used according to him. He was right.)

However, a shortcut would be to the patch below. It will work as long a=
s
there's no newline in the filename (is that really something we want to
support? If not, let's throw away perl and stick with the sed solution
below).

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..31524d3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -113,9 +113,10 @@ resolve_relative_url ()
 module_list()
 {
 	(
-		git ls-files --error-unmatch --stage -- "$@" ||
+		git ls-files --error-unmatch --stage -z -- "$@" ||
 		echo "unmatched pathspec exists"
 	) |
+	sed -e 's/\x00/\n/g' |
 	perl -e '
 	my %unmerged =3D ();
 	my ($null_sha1) =3D ("0" x 40);

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
