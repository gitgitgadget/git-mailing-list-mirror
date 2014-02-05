From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] fast-import.c: always honor the filename case
Date: Wed, 05 Feb 2014 22:19:54 +0100
Message-ID: <52F2AAFA.1090507@web.de>
References: <1391346784-11891-1-git-send-email-reubenhwk@gmail.com>	<52EEA5D3.9000502@web.de>	<CAD_8n+RZACW0380co75gWSwVmCJdcH4COsySTF3BFCyKEumXNA@mail.gmail.com>	<52EFFA36.8090305@web.de> <CAD_8n+RuwQEXJRCOr+B_PqA7z6LkFdbcRZkiiVJsEhJ=+YjRDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>
To: Reuben Hawkins <reubenhwk@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaA==?= =?UTF-8?B?YXVzZW4=?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 05 22:20:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB9tG-0001eY-Gz
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 22:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbaBEVUF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Feb 2014 16:20:05 -0500
Received: from mout.web.de ([212.227.15.14]:52325 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942AbaBEVT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 16:19:57 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MEVkf-1W0PQo1WW1-00FinG for <git@vger.kernel.org>;
 Wed, 05 Feb 2014 22:19:55 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <CAD_8n+RuwQEXJRCOr+B_PqA7z6LkFdbcRZkiiVJsEhJ=+YjRDg@mail.gmail.com>
X-Provags-ID: V03:K0:cOl5GKX5f7IHUmZrUqtYVcyZqH8xGYwhCzMzhfloSHK9c7jdb/O
 z5XvpFBlfGcSTsjBOS8Dlr70UDKZx3zWSQyeDI1V3wm7/uHNP6/P5qw/PBg7YJiAZF59j6h
 cZPMRonFp8/sLlLbxIrloHIq3onsOEfbTizQIcdhkT3VL++GpVUAq0WfeYhCOvpa+MO57Je
 g56/4gZJKSz5HnTHd+JOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241668>

On 2014-02-03 23.11, Reuben Hawkins wrote:
>
>
>
> On Mon, Feb 3, 2014 at 2:21 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede <mailto:tboegi@web.de>> wrote:
>
>     []
>     > So to summarize, when fast-import uses strncmp_icase (what fast=
-import does now) import on a repository where ignorecase=3Dtrue is wro=
ng.  My patch, "fast-import.c: always honor the filename case" fixes th=
is.  Can you verify?
>     >
>     > Thanks in advance,
>     > Reuben
>     >
>     Yes, I can verify. My feeling is that
>     a) the fast-export should generate the rename the other way aroun=
d.
>        Would that be feasable ?
>
>
> I *think* this is feasible.  I did try this, and it worked, but I did=
n't like the idea of having to fix all the exporters.  I know about hg-=
export and svn-export, but I assume there are more that I don't know ab=
out, and maybe even other tools out there none of us know about, which =
would also have to be fixed in the same way.  As such, I decided fixing=
 fast-export isn't really the right thing to do...I don't really think =
fast-export is broken to begin with.  I'm hoping there is a way to fix =
ignorecase such that it doesn't create this type of problem with this..=
=2E
>
> M 100644 :1 Filename.txt
> D FileName.txt
>
> ..maybe by very carefully identifying when ignorecase should apply an=
d when it shouldn't (I'm still trying to sort that out, the docs on ign=
orecase aren't specific).
>
> But for what it's worth, to "fix" fast-export, I added a check in bui=
ltin/fast-export.c in the function depth_first before all the other che=
cks so it would always make diff_filepair->status =3D=3D 'D' the lesser=
 when not equal...something like this (I'm not looking at the code now,=
 so this may *not* be what I did)...
>
> if (a->status !=3D b->status) {
>   if (a->status =3D=3D 'D') return -1;
>   if (b->status =3D=3D 'D') return 1;
> }
>
> /Reuben
> =20
>
>        Or generate a real rename ?
>
>
> A rename may also work, but it may not.  And that would also require =
fixing all other exporters.  If I understand the docs well enough, a re=
name would be done like so...
>
> R Filename.txt FileName.txt
>
> I think in the ignorecase=3Dtrue situation, case folding would happen=
 and this would be a nop like this...
>
> R Filename.txt Filename.txt
>
> ...Right?  I haven't tested this, but I *suspect* the result would be=
 to not rename the file when ignorecase=3Dtrue...I definitely think it'=
s worth a try just to know the result, but this fixes the ignorecase pr=
oblem in fast-import by passing a requirement to all the fast-exporters=
=2E..a semi-artificial requirement created because ignorecase *could* b=
e true, but may not be.
> /Reuben
> =20
>
>       (I'm not using fast-export or import myself)
>
>     b)  As a workaround, does it help if you manually set core.ignore=
case false ?
>
>
> Yes, this works.  It makes a single step clone, git clone hg::..., in=
to a multi step process like this...
>
> $ mkdir test
> $ git init
> $ git config core.ignorecase false
> $ git remote add origin hg::whatever
> $ git fetch origin
> $ git reset --hard origin/master
> $ git branch --set-upstream-to=3Dorigin/master master
>
> That isn't a too big deal for people fluent in GIT (if you only have =
to do it once and wrote it down too maybe).  It works, just not ideally=
 and it's easy to get burned on because git clone sort-of works, it jus=
t doesn't truly clone.  The resulting cloned repo can be mangled by cas=
e folding.
>
> Typically, unless somebody explains the multi step process to everybo=
dy, some people will have master with commit xxxxxx and others will hav=
e the exact same master with commit yyyyyy.  Some will have Filename.tx=
t instead of FileName.txt way back in history.  Merging those branches =
is a mess.
>
> So setting core.ignorecase=3Dflase does work, it's just a bit cumbers=
ome.  My fingers really want to just type git clone hg::whatever and I =
hope to get a true 'clone' as in an exact, identical copy on all machin=
es regardless of filesystem.  If GIT wants to do case folding after tha=
t I suppose it would be fine.  Maybe I'm expecting too much, but I've b=
een under the impression for years that a clone of any git repo will ha=
ve all the exact same commit id's.
> /Reuben
>
>
>     c)  Does it help to use git-hg-remote ? (could be another workaro=
und)
>
>
> Yes, sorry, I guess I wasn't clear on that point.  That is what I'm u=
sing.=20
> /Reuben
>
>
>     And no,  50906e04e8f48215b0 does not include any test cases.
>     (try git show 50906e04e8)
>
>     This is only a short answer, I can prepare a longer answer about =
ignorecase the next days.
>     /Torsten
>
>
> Thank you!  That would be very helpful.  I'm still trying to wrap my =
head around what ignorecase really needs to do, when and where it needs=
 to do it and what it shouldn't do.  I suspect ignorecase is touching t=
oo many code paths and needs to be reined in a bit.
>
> I'm also wondering if it's possible to test a bunch of situations in =
'make tests' with ignorecase=3Dtrue/false....but I can't think of any w=
ay other than mounting filesystems on loopbacks to setup the tests (to =
ensure a vfat fs for example)....do you know a better way?
>
> /Reuben=20
>
My experience and understanding is that ignorecase=3Dtrue is useful whe=
n working in a Windows environment.
Some tools (or users) change the case of a filename (or directory name)=
 and Git compensates for that.
Which means that you can rename a file behind the back of Git, and Git =
is not complaining.
(Junio recently explained it much better in detail)

The thing is that you can push and pull between different machines, and=
 ignorecase=3Dtrue makes sure that
Git finds the "right file", similar as Windows finds it.

The same is true for directory names, and I could call the whole ignore=
case=3Dtrue feature
a kind of "don't worry" packet, or a "Changing case is harmless insuran=
ce".

Since 50906e04e8 this is even more true, since even the fast-import is =
covered,
The importer will find the "right file" even if the exporter did not te=
ll us about the rename.
(Or should we say re-case ?)

Some trouble starts when you push and pull such a repo to a Linux machi=
ne.
(You can replace Windows with Mac OS+case insensitve HFS+ and Linux wit=
h
Mac OS + case sensitive HFS+ (or Unix))

Especially the the case folding of directory names is interesting:
=46or Linux "Dir1/File", "dir1/file" or "dir1/File" are completely diff=
erent, for Windows not.
So if a mixture of Windows/Linux systems is working together it can hel=
p to set
ignorecase=3Dfalse on Windows, to detect some of the mess seen by Linux=
=2E
(and thats why I suggested to set ignorecase=3Dfalse as a workaround)

Reading the answers from Peff and Junio, I am convinced that the fast-i=
mport should
not look at core.ignorecase at all.

If I am allowed to make a suggestion:
the patch for fast-import.c (0001-fast-import.c-ignorecase-iff-explicit=
ly-told-to.patch)
 you send out is a good starting point.

(I would avoid using ignore_case and  strncmp_icase().
 A file-local variable like fi_ignore_case or so and a local function w=
ill isolate variables.
=20
Perhaps slow_same_name() from name-hash.c can be used (it needs to be m=
ade non-local)

On top of that, a test case could be good.
 You have send a shell script to demonstrate the problem using fast-exp=
ort and fast-import.
 This can be used as a start.

And if you want to experiement with case-sensitive/unsensitve file syst=
ems
under Mac OS, simply get a USB drive (8 GB Flash stick could be enough)
and format it with the HFS+ version you don't have on your hard disk.
/Torsten
=20
