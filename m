From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 4/3] t3700: avoid racy git situation
Date: Thu, 08 Nov 2007 10:27:11 -0500
Message-ID: <1194535631.27305.3.camel@hinata.boston.redhat.com>
References: <Pine.LNX.4.64.0711081213580.4362@racer.site>
	 <Pine.LNX.4.64.0711081414160.4362@racer.site>
	 <47331E65.9010209@viscovery.net>
	 <Pine.LNX.4.64.0711081511440.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:34:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq9P7-0006Q4-Rz
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 16:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758964AbXKHPed convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 10:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757649AbXKHPed
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 10:34:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60677 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755186AbXKHPec (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 10:34:32 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA8FRJrE024137;
	Thu, 8 Nov 2007 10:27:19 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA8FRJRO025790;
	Thu, 8 Nov 2007 10:27:19 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA8FRHdq017965;
	Thu, 8 Nov 2007 10:27:17 -0500
In-Reply-To: <Pine.LNX.4.64.0711081511440.4362@racer.site>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64044>

On Thu, 2007-11-08 at 15:16 +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 8 Nov 2007, Johannes Sixt wrote:
>=20
> > Johannes Schindelin schrieb:
> > > Wow, the builtin commit is fast.  It sometimes triggers a racy
> > > situation in the test case for "git add --refresh -- foo".
> > >=20
> > > So when that test fails, simply sleep one second and try again.
> >=20
> > [/me looks at the calender - no, it's not April Fool's day]
>=20
> No. The builtin commit is really that fast.
>=20
> > Wouldn't it be better to fix git-commit (or git-add)? I would like =
to=20
> > help, but you already seem to have done the analysis, so...
>=20
> The problem is that the index has the same timestamp as the file "foo=
".
>=20
> Therefore, git cannot tell if "foo" is up-to-date in the index, since=
 it=20
> could have been modified (and indeed is) just a fraction of a second =
later=20
> than the index was last updated.
>=20
> And since diff-index, as called from the test script, does not genera=
te a=20
> diff, but really only determines if the index information suggests th=
at=20
> the files are up-to-date, there is not really much you can do.
>=20
> This is our good old friend, the racy git problem.
>=20
> NOTE: other scms do not have this problem, mostly because they are to=
o=20
> slow to trigger it.

Ah, so that's what that was.  Thanks for fixing that, I wasn't sure wha=
t
was going on and didn't have the time to dig into it.  I have a patch
that fixes the author date for commit in determine_author_info() instea=
d
and fixes some of the option validation problems mentioned by Bj=C3=B6r=
n.  I
have an updated launch_editor patch too, but what you sent out looks
good, so I'll just send the latest builtin-commit.

cheers,
Kristian
