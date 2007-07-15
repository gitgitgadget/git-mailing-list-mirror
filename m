From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Support output ISO 8601 format dates
Date: Mon, 16 Jul 2007 01:19:33 +0200
Message-ID: <200707160119.34509.robin.rosenberg@dewire.com>
References: <20070713202258.14107.18196.stgit@lathund.dewire.com> <20070715212359.GB18293@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:19:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADMl-0000Ly-E9
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759396AbXGOXSr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 15 Jul 2007 19:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758725AbXGOXSr
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:18:47 -0400
Received: from [83.140.172.130] ([83.140.172.130]:23090 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758341AbXGOXSq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2007 19:18:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 121E0802663;
	Mon, 16 Jul 2007 01:11:35 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15284-10; Mon, 16 Jul 2007 01:11:30 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 3F8A8800199;
	Mon, 16 Jul 2007 01:11:30 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070715212359.GB18293@efreet.light.src>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52597>

=46rom 59eafc201aec3be121b33c2ecf16c70cc3521e92 Mon Sep 17 00:00:00 200=
1
=46rom: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Mon, 16 Jul 2007 01:05:19 +0200
Subject: [PATCH] Support output ISO 8601 format dates

Support output of full ISO 8601 style dates in e.g. git log
and other places that use interpolation for formatting.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 Documentation/pretty-formats.txt |    2 ++
 cache.h                          |    2 +-
 commit.c                         |    6 +++++-
 date.c                           |    9 +++++++++
 4 files changed, 17 insertions(+), 2 deletions(-)

s=C3=B6ndag 15 juli 2007 skrev Jan Hudec:
> Hello,
>=20
> On Fri, Jul 13, 2007 at 22:22:58 +0200, Robin Rosenberg wrote:
> > +	else if (mode =3D=3D DATE_ISO8601)
> > +		sprintf(timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
> > +				tm->tm_year + 1900,
> > +				tm->tm_mon + 1,
> > +				tm->tm_mday,
> > +				tm->tm_hour, tm->tm_min, tm->tm_sec,
> > +				tz);
>=20
> I apologise for nitpicking, but ISO 8601 (and RFC 3339) says separato=
r between
> date and time is 'T' and there is no separator between time and timez=
one. So
> this should be
>=20
> +		sprintf(timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%+05d",

Note that my reference is to ISO 8601, not RFC 3339.  Hower I interpret=
 "NOTE By mutual=20
agreement of the partners in information interchange, the character [T]=
 may be omitted in
applications where there is no risk of confusing a date and time of day=
 representation with
others defined in this International Standard" (ISO 8601:2004 4.3.2) as=
 space being
allowed here instead of 'T'.

By "mutual agreement" I mean that I tell you what it looks like and you=
 agree :)

I agree with you about the space before timezone though. I'll go.

> for 100% conformance to the standard. RFC 3339 explicitely mentions u=
sing
> space instead of 'T' as separator as allowed, but does not seem to me=
ntion
> space before time zone. There may be applications that would stop at =
such
> space and assume no timezone information.
>=20
> Furthermore RFC 3339 seems to require colon in the timezone, so it wo=
uld be:
>=20
> +		sprintf(timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%+03d:%02d",
> +				tm->tm_year + 1900,
> +				tm->tm_mon + 1,
> +				tm->tm_mday,
> +				tm->tm_hour, tm->tm_min, tm->tm_sec,
> +				tz / 100, abs(tz % 100));
>=20
> ISO 8601 makes separators optional, so simple 4-digit timezone is OK.

=46or the sake of consequence I should use the extended format for all =
parts and not mix
basic and extended formats.

Updated patch follows that formats dates as "2006-08-17 20:59:46+05:30"

-- robin

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index d922e8e..1296b31 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -106,12 +106,14 @@ The placeholders are:
 - '%aD': author date, RFC2822 style
 - '%ar': author date, relative
 - '%at': author date, UNIX timestamp
+- '%ai': author date, ISO 8601 format
 - '%cn': committer name
 - '%ce': committer email
 - '%cd': committer date
 - '%cD': committer date, RFC2822 style
 - '%cr': committer date, relative
 - '%ct': committer date, UNIX timestamp
+- '%ci': committer date, ISO 8601 format
 - '%e': encoding
 - '%s': subject
 - '%b': body
diff --git a/cache.h b/cache.h
index 5dff2f1..3dc0def 100644
--- a/cache.h
+++ b/cache.h
@@ -389,7 +389,7 @@ extern void *read_object_with_reference(const unsig=
ned char *sha1,
 					unsigned long *size,
 					unsigned char *sha1_ret);
=20
-enum date_mode { DATE_NORMAL =3D 0, DATE_RELATIVE, DATE_SHORT, DATE_LO=
CAL };
+enum date_mode { DATE_NORMAL =3D 0, DATE_RELATIVE, DATE_SHORT, DATE_LO=
CAL, DATE_ISO8601 };
 const char *show_date(unsigned long time, int timezone, enum date_mode=
 mode);
 const char *show_rfc2822_date(unsigned long time, int timezone);
 int parse_date(const char *date, char *buf, int bufsize);
diff --git a/commit.c b/commit.c
index 5632e32..68df3b4 100644
--- a/commit.c
+++ b/commit.c
@@ -773,6 +773,7 @@ static void fill_person(struct interp *table, const=
 char *msg, int len)
 	interp_set_entry(table, 2, show_date(date, tz, 0));
 	interp_set_entry(table, 3, show_rfc2822_date(date, tz));
 	interp_set_entry(table, 4, show_date(date, tz, 1));
+	interp_set_entry(table, 6, show_date(date, tz, DATE_ISO8601));
 }
=20
 static long format_commit_message(const struct commit *commit,
@@ -791,12 +792,14 @@ static long format_commit_message(const struct co=
mmit *commit,
 		{ "%aD" },	/* author date, RFC2822 style */
 		{ "%ar" },	/* author date, relative */
 		{ "%at" },	/* author date, UNIX timestamp */
+		{ "%ai" },	/* author date, ISO 8601 */
 		{ "%cn" },	/* committer name */
 		{ "%ce" },	/* committer email */
 		{ "%cd" },	/* committer date */
 		{ "%cD" },	/* committer date, RFC2822 style */
 		{ "%cr" },	/* committer date, relative */
 		{ "%ct" },	/* committer date, UNIX timestamp */
+		{ "%ci" },	/* committer date, ISO 8601 */
 		{ "%e" },	/* encoding */
 		{ "%s" },	/* subject */
 		{ "%b" },	/* body */
@@ -813,10 +816,11 @@ static long format_commit_message(const struct co=
mmit *commit,
 		IPARENTS, IPARENTS_ABBREV,
 		IAUTHOR_NAME, IAUTHOR_EMAIL,
 		IAUTHOR_DATE, IAUTHOR_DATE_RFC2822, IAUTHOR_DATE_RELATIVE,
-		IAUTHOR_TIMESTAMP,
+		IAUTHOR_TIMESTAMP, IAUTHOR_ISO8601,
 		ICOMMITTER_NAME, ICOMMITTER_EMAIL,
 		ICOMMITTER_DATE, ICOMMITTER_DATE_RFC2822,
 		ICOMMITTER_DATE_RELATIVE, ICOMMITTER_TIMESTAMP,
+		ICOMMITTER_ISO8601,
 		IENCODING,
 		ISUBJECT,
 		IBODY,
diff --git a/date.c b/date.c
index 4690371..c96100e 100644
--- a/date.c
+++ b/date.c
@@ -137,7 +137,15 @@ const char *show_date(unsigned long time, int tz, =
enum date_mode mode)
 	if (mode =3D=3D DATE_SHORT)
 		sprintf(timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
 				tm->tm_mon + 1, tm->tm_mday);
+	else if (mode =3D=3D DATE_ISO8601)
+		sprintf(timebuf, "%04d-%02d-%02d %02d:%02d:%02d%+03d:%02d",
+				tm->tm_year + 1900,
+				tm->tm_mon + 1,
+				tm->tm_mday,
+				tm->tm_hour, tm->tm_min, tm->tm_sec,
+				tz/100,
+				abs(tz%100)
+				);
 	else
 		sprintf(timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
--=20
1.5.2.3
