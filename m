From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 17:41:20 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801161717160.2806@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <BA518A23-FBF8-49BB-BEFB-D9A6BA1E302C@simplicidade.org> <alpine.LFD.1.00.0801161615330.2806@woody.linux-foundation.org>
 <E8E76634-FFEC-426B-B04D-3C2CD3790D5E@simplicidade.org> <85zlv5nvge.fsf@lola.goethe.zz> <B2E52451-5153-4EFD-ADBE-AACDCEF6169E@simplicidade.org> <D32FF2AF-EA90-4737-8320-836B52AF4612@wincent.com> <alpine.LSU.1.00.0801170106390.17650@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>,
	Pedro Melo <melo@simplicidade.org>,
	David Kastrup <dak@gnu.org>, Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>, Mark Junker <mjscod@web.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:42:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFJlc-0006eT-No
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 02:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbYAQBlg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 20:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbYAQBlg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 20:41:36 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34268 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751262AbYAQBlf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 20:41:35 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H1fLOR004969
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 17:41:22 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H1fKcA003144;
	Wed, 16 Jan 2008 17:41:20 -0800
In-Reply-To: <alpine.LSU.1.00.0801170106390.17650@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70805>



On Thu, 17 Jan 2008, Johannes Schindelin wrote:
> On Thu, 17 Jan 2008, Wincent Colaiuta wrote:
>=20
> > El 17/1/2008, a las 1:40, Pedro Melo escribi=F3:
> >=20
> > > That's the point I'm making. The fact that I need to set LANG acr=
oss=20
> > > all users of a project is insane...
>=20
> FWIW if you use another filesystem, such as reiserfs or ext[2-4], the=
=20
> filenames will be _unaffected_ by your particular setting of LANG.  T=
hey=20
> will be stored byte-wise exactly like asked for.  That's why I call t=
hem=20
> "sane".

One of the advantages (the biggest one, in fact, apart from the obvious=
=20
US-ASCII down-compatibility and the fact that you can do C-compatible=20
NUL-terminated strings) of UTF-8 is that it's locale-independent, and=20
doesn't care about LANG, because it's valid in all languages.

And that's really important. It's important for a very simple reason:=20
there is almost never such a thing as "a locale" except for US-ASCII. O=
nce=20
you move away from US-ASCII, it actually tends to be much more common t=
hat=20
you have a *mixture* of locales - often in the same "document" - than t=
o=20
have one single locale.

It very much happens even in filenames - people "mix" locales in trivia=
l=20
ways even within a single pathname component (non-US-ASCII filename, bu=
t=20
with a regular file extension), but much more interestingly they do so=20
within a directory tree (ie you have have translation subdirectories wh=
ere=20
the filenames themselves are in another language, and you can have full=
=20
pathnames where different components are in different languages, for=20
example).

And UTF-8 is _wonderful_ for this, because LANG doesn't matter, and=20
cannot matter, and thus mixing isn't a problem.

Of course, you can screw it up. Locales still can change things like so=
rt=20
order and capitalization etc, so even if you use UTF-8, you sure can ge=
t=20
into trouble with LANG and thinking that a per-session locale makes sen=
se.

So choosing UTF-8 for the filesystem isn't wrong per se. It's a fine=20
choice, and has no issues with LANG in itself. Limiting it to strictly=20
valid UTF-8 encodings is also fine. Limiting it (further) to only=20
character normalized UTF-8 is also fine.

Most Linux filesystems don't limit it in any way, so you can make=20
filenames that aren't valid UTF-8 at all, much less normalizing=20
multi-character sequences.

I personally think that's the best option, but I probably do so mostly=20
because I know some people still use Latin1 as their only locale (and I=
=20
suspect Asia will take decades before it has converted to UTF-8 and wil=
l=20
also have cases where they use other non-UTF locales).

But enforcing clean UTF-8 is not a bad idea per se. Not allowing byte=20
sequences that aren't a valid UTF-8 encoding (eg \xc0\xc0 is not a vali=
d=20
UTF-8 character) is fine.

I wouldn't call people crazy for doing that, although it does mean that=
=20
you cannot, for example, decide to write a Latin1 filename (which is no=
t=20
necessarily a *good* idea in this day and age, but I think there's a=20
difference between "that's not a good idea" and "you cannot do that").

And even limiting the UTF-8 charset further to only the minimal=20
representation of one particular glyph (ie not allowing multi-character=
=20
sequences that can be represented more simply) may be even *more*=20
big-brother, but would at least not cause the technical aliasing issues=
=2E I=20
personally think that's so controlling as to be stupid (and has no real=
=20
advantage), but hey, at least it doesn't *corrupt* anything silently.

So I think that using UTF-8 as a character encoding is a *good* thing t=
o=20
do, and that automatically means that LANG shouldn't matter for filenam=
es,=20
but within that choice of UTF-8 there are still mistakes that you can=20
make. Notably multi-character normalization and case-insensitivity.

			Linus
