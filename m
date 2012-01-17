From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/3] git-p4: Search for parent commit on branch creation
Date: Tue, 17 Jan 2012 17:18:30 -0500
Message-ID: <20120117221830.GA366@padd.com>
References: <1326674360-2771-1-git-send-email-vitor.hda@gmail.com>
 <1326674360-2771-3-git-send-email-vitor.hda@gmail.com>
 <20120116185738.GA21996@padd.com>
 <CAOpHH-UkyK-c_AHUOPbQQmW9cQQypDvirMR0Jb7vTGSQF7RZpw@mail.gmail.com>
 <CAOpHH-XUj7tF4O_kXfxq2e9Y4VmybNLCqGku_-9H1X+c7v=xwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 23:18:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnHMU-0000D8-Jj
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 23:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003Ab2AQWSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jan 2012 17:18:34 -0500
Received: from honk.padd.com ([74.3.171.149]:59558 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755234Ab2AQWSd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 17:18:33 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id 1514A5B3A;
	Tue, 17 Jan 2012 14:18:33 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3351831446; Tue, 17 Jan 2012 17:18:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAOpHH-XUj7tF4O_kXfxq2e9Y4VmybNLCqGku_-9H1X+c7v=xwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188723>

vitor.hda@gmail.com wrote on Tue, 17 Jan 2012 00:10 +0000:
> On Mon, Jan 16, 2012 at 11:41 PM, Vitor Antunes <vitor.hda@gmail.com>=
 wrote:
> > On Mon, Jan 16, 2012 at 6:57 PM, Pete Wyckoff <pw@padd.com> wrote:
> >> 1. =A0Move the tempBranch commit outside of the "for blob" loop.
> >> =A0 =A0It can have no parent, and the diff-tree will still tell yo=
u
> >> =A0 =A0if you found the same contents. =A0Instead of a ref for
> >> =A0 =A0each blob inspected for each change, you'll just have one r=
ef
> >> =A0 =A0per change. =A0Only one checkpoint() after the tempBranch
> >> =A0 =A0commit should be needed.
> >
> > You're right. Completely oversaw that. Will improve the code
> > accordingly.
>=20
> Apparently I did not oversee it. Assume you have added a new file to
> HEAD of parent branch, but you branched from a previous commit. When =
the
> new branch is committed over HEAD the new file will, incorrectly, be
> part of it and diff-tree will not work as expected.

I don't get it.  This algorithm works on the fact that a "branch"
in p4 creates a new change that looks exactly like a previous
change.

The git-p4 sync step, when it detects a branch, starts by saving
the change in a commit with parent =3D null, so it is its own new
branch, an orphan, with no parents.

Now the task is to find some commit that has an identical tree to
this temporary one.  You walk back all known p4 commits to try to
find one that is the same.  It doesn't matter if any of those p4
commits have other commits on top of them.

At each step in the backward walk, the comparison is against the
unchanged orphan commit.

An ascii-art picture might help me.  Or even a test case.

> I should avoid taking 6 months to submit a patch to avoid forgetting =
why
> I did what I did :)

Yeah, and now you have to explain it all over to me again too.  :)

		-- Pete
