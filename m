From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 21:06:07 -0500
Message-ID: <20080123020607.GC1320@mit.edu>
References: <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org> <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org> <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org> <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org> <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu> <E6F76F93-24C9-4D10-813C-770A9C3A9828@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:06:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHV0l-0002OY-Ax
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 03:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbYAWCGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jan 2008 21:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbYAWCGN
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 21:06:13 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:56097 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751222AbYAWCGM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 21:06:12 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m0N269Uk026967;
	Tue, 22 Jan 2008 21:06:09 -0500 (EST)
Received: from closure.thunk.org (c-66-30-1-139.hsd1.ma.comcast.net [66.30.1.139])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m0N2684p001024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 22 Jan 2008 21:06:08 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JHV0C-0006XC-0O; Tue, 22 Jan 2008 21:06:08 -0500
Content-Disposition: inline
In-Reply-To: <E6F76F93-24C9-4D10-813C-770A9C3A9828@sb.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71491>

On Tue, Jan 22, 2008 at 07:38:04PM -0500, Kevin Ballard wrote:
> * Any new characters added to Unicode will only have one form (decomp=
osed),=20
> so HFS+ will always accept new characters as they will be NFD. The on=
ly=20
> exception is case-sensitivity, as the case-folding tables in HFS+ are=
=20
> static, so new characters with case variants will be treated in a=20
> case-sensitive manner. However, as they are already decomposed, the N=
=46D=20
> algorithm will not change their encoding. This means that no, there a=
re=20
> zero problems moving HFS+ drives between versions of OS X.

Except there *are* problems, because this promise doesn't apply to
Unicode 2.1 (Mac OS 10.2 and before) and Unicode 3.2 (Mac OS 10.3 and
above).  And there were changes between the normalization algorithm
between Unicode 3.2 and the Unicode version 4.1.  So taking a hard
drive between Mac OS X 10.2 and 10.3 *will* cause problems.  The
guarantees of Unicode stability didn't come until well past Unicode
2.1.

Also, I know of no guarantee that there will be no more new
compositions.  According to Unicode Stnadard Annex #15
(http://unicode.org/reports/tr15/), new characters that can be
decomposed are strongly discouraged, but "It would be possible to add
more compositions in a future version of Unicode".  Got a reference to
back up your claim that there will never be any more?

> * At the time HFS+ was developed, there was no one common standard fo=
r=20
> normalization. The HFS+ developers picked NFD because they thought it=
 was=20
> "a more flexible, future-looking form", but Microsoft ended up pickin=
g the=20
> opposite just a short time later. Interestingly, NFC is a weird hybri=
d form=20
> which only has composed forms for pre-existing characters, and decomp=
osed=20
> forms for all new characters (as they only have one form). So in a se=
nse=20
> NFD is more sane then NFC.

NFC is better if you care about compatibility with existing legacy
character sets, where you want round-trip conversions to be
idempotent.  On the other hand, given that Mac OS has historically
never cared about being compatible with the rest of the world, it
makes sense that it would choose NFD.

> * The core issue here, which is why you think HFS+ is so stupid, is t=
hat=20
> you guys see no problem with having 2 files "M=E4rchen" (NFC) and "M=E4=
rchen"=20
> (NFD), whereas the HFS+ developers don't consider it acceptable to ha=
ve 2=20
> visually identical names as independent files.

Yep.  No problems to do that.  You seem to think that supporting
Unicode requires imposing this constraint, but that's simply not true,
except maybe in some kind of religious sense.

> Unfortunately, the only way=20
> to do this matching is to store the normalized form in the filesystem=
,=20
> because it would be a performance nightmare to try and do this matchi=
ng any=20
> other way.

Nope.  They were just not clever enough.  If they use a hashed key for
their b-tree and used a hash which had the property that two strings
that were equivalent in the Unicode sense have the same hash value,
it's quite possible to do Unicode-equivalence lookups quickly.  Yeah,
calculating the hash algorithm takes a bit amount of time, but it gets
called no more than the normalization routine, and its performance
overhead is no worse than the normalizing a string.

I know how to do it in a Linux filesystem; it's just an insane thing
to do, and so I choose not to do it.  But it is doable; if you must
persue the course of filesystem insanity, it's possible to do it in a
performant way, without normalization; it's the same way that you can
use b-tree lookups in a case insensitive way.

> I must say it is shocking that someone as smart as you is still more=20
> interested in finding ways to prove me wrong then to actually address=
 the=20
> problem. It's obvious that the only research you did was intended to =
find=20
> ways to call me stupid.

No, I did the research to try to find the HFS-specific filename
mangling algorithm.  And given that's based on an back-level, old
version of Unicode, you can't just use NFD algorithm from the latest
Unicode spec.  As I did that research, I came across the evidence that
claims you had made (i.e., that HFS had never changed the Unicode
version for its Normalization algorithm), was directly contradicted by
the Apple TechNote.

    	  					- Ted
