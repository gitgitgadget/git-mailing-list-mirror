From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Thu, 21 Oct 2010 08:56:00 -0400
Message-ID: <1287665760.24161.33.camel@drew-northup.unet.maine.edu>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	 <m3ocar5fmo.fsf@localhost.localdomain>  <4CBFFD79.1010808@alum.mit.edu>
	 <1287660007.24161.10.camel@drew-northup.unet.maine.edu>
	 <968F09BD-2B2D-44C4-9C0F-BF7BD20041F0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 14:57:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8uhY-0001T6-13
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 14:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888Ab0JUM4y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 08:56:54 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:52259 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043Ab0JUM4x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 08:56:53 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9LCu5eo023929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Oct 2010 08:56:10 -0400
In-Reply-To: <968F09BD-2B2D-44C4-9C0F-BF7BD20041F0@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=4
	Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9LCu5eo023929
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288270571.64743@t+ETJ64aQgdtLsNlFmExqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159500>


On Thu, 2010-10-21 at 14:31 +0200, Thore Husfeldt wrote:
> On 21 Oct 2010, at 13:20, Drew Northup wrote:
>=20
> > Ok, so what will "git stage" do when a change of a file is already
> > staged and it is executed again (on new changes)?
>=20
> Presumably what it already does: nothing. But one could argue that th=
e more public-relations minded command =E2=80=9Cgit stage=E2=80=9D shou=
ld give better feedback. Like so:
>=20
> > $ git commit=20
> > $ ... edit A.txt ...
> > $ git stage B.txt
> > git stage: Did nothing. No uncommitted changes to stage in B.txt.
> > $ git stage A.txt
> > $ git stage A.txt
> > git stage: Did nothing. Changes in A.txt already staged. Use `git d=
iff --staged A.txt` to see them.

That's not what I asked.

$ git commit
$ vim A.txt
$ vim B.txt
$ git add B.txt
$ git add A.txt
$ vim B.txt
$ git add B.txt

The above sequence stages two changes on B.txt into the index.
Literally, it adds changes to git's knowledge about B.txt twice, but
does not yet commit any of it permanently to the object store.

Presumably, assuming that A.txt and B.txt did not yet exist, you are
suggesting the following command sequence:

$ git commit
$ vim A.txt
$ vim B.txt
$ git add B.txt
$ git add A.txt
$ vim B.txt
$ git stage B.txt
$ vim B.txt
$ git stage B.txt

This assumes that git SHOULD act like subversion, and I argue that ther=
e
is no reason that it should. What happens if we continue as follows:

$ vim A.txt
$ git stage A.txt
$ git commit
$ vim C.txt
$ vim A.txt
$ git stage A.txt
$ git stage C.txt

Should the last two commands fail? The earlier discussion seems to
suggest that they should. My point is that this does not seem to me to
be a useful extension of the idiom. If anything, it seems to confuse th=
e
matter. Now, if "git stage" were an outright replacement for "git add"
there might be more use (but I'd still not be happy about the corruptio=
n
of the idiom).

--=20
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
