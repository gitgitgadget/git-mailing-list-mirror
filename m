From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: blame on a deleted/renamed file
Date: Wed, 5 Aug 2009 18:56:18 +0200
Message-ID: <20090805165618.GB17792@atjola.homenet>
References: <449c10960908050516k25ef0a92sd8616de29a93ea5f@mail.gmail.com>
 <20090805123754.GA13340@atjola.homenet>
 <449c10960908050654v3823da76p1ddb5a2bbb5c323d@mail.gmail.com>
 <20090805140941.GB13340@atjola.homenet>
 <449c10960908050849pa4df6c6x3f5aa4510e9a2642@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 18:56:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYjmx-0007j9-1n
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 18:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934524AbZHEQ4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 12:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934517AbZHEQ4W
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 12:56:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:50163 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934516AbZHEQ4V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 12:56:21 -0400
Received: (qmail invoked by alias); 05 Aug 2009 16:56:20 -0000
Received: from i59F55BB1.versanet.de (EHLO atjola.homenet) [89.245.91.177]
  by mail.gmx.net (mp035) with SMTP; 05 Aug 2009 18:56:20 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19YnBUaI6RYYKNxrcVrllX96C6egm1WeMWR5JN/EI
	QBMD+uk877HVu2
Content-Disposition: inline
In-Reply-To: <449c10960908050849pa4df6c6x3f5aa4510e9a2642@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124922>

On 2009.08.05 10:49:09 -0500, Dan McGee wrote:
> 2009/8/5 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> > Hm, I still don't see what you mean. For some lines it stopped at
> > e19d7da4, yeah, but those were new lines, added in that commit, at =
least
> > those that I checked (e.g. "local ct=3D0" in generate_checksums()).=
 For
> > the others, it already went back further.
>=20
> Thought I'd just clarify the lines off-list that I actually cared abo=
ut:
>=20
>     # fix flyspray #6246
>     local file_type=3D$(file -bizL "$file")
>     local cmd=3D''
>     case "$file_type" in
>       *application/x-tar*|*application/zip*|*application/x-zip*|*appl=
ication/x-cpio*)
>         cmd=3D"bsdtar -x -f" ;;
>       *application/x-gzip*)
>         cmd=3D"gunzip -d -f" ;;
>       *application/x-bzip*)
>         cmd=3D"bunzip2 -f" ;;
>       *application/x-xz*)
>         cmd=3D"xz -d -f" ;;
>       *)
>         # Don't know what to use to extract this file,
>         # skip to the next file
>         continue;;
>=20
> Which moved in that commit into a bash function, and I wanted to trac=
e
> them back further.

Ah, ok. Most of these got changed later, so the blame is right for them=
,
but for example the *application/x-gzip*) line was just literally moved
in the file, and blame should be able to follow at least that one. And
it does that as long as you don't cross commit
68c10690eae369928b6cdc2d658588ad06e4b1a5, which changed the cmd=3D"..."
lines. Even with -M5 -C5 -C5 -C5 (which should set the scores low
enough, and enables the hardest following mode) it starts to blame that
line to e19d7da4 then. The same is true if you blame too few lines.

git blame -M5 -C5 -C5 -C5 -w -L/x-gzip/,+3 \
	68c10690eae369928b6cdc2d658588ad06e4b1a5^ -- scripts/makepkg.sh.in

vs.

git blame -M5 -C5 -C5 -C5 -w -L/x-gzip/,+2 \
	68c10690eae369928b6cdc2d658588ad06e4b1a5^ -- scripts/makepkg.sh.in

The first one follows back to 7ed7977e, the other stops at e19d7da4.

I wonder whether that's a plain limitation, or a bug...

Bj=F6rn
