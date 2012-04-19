From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v7 4/4] git-rebase: add keep_empty flag
Date: Thu, 19 Apr 2012 09:12:12 -0400
Message-ID: <20120419131211.GB18339@neilslaptop.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334776680-23460-1-git-send-email-nhorman@tuxdriver.com>
 <1334776680-23460-5-git-send-email-nhorman@tuxdriver.com>
 <4F8FE2CD.3070300@in.waw.pl>
 <873980q6vm.fsf@thomas.inf.ethz.ch>
 <4F9002CA.6040302@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Apr 19 15:12:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKrAL-0001aF-R4
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 15:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755087Ab2DSNMt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Apr 2012 09:12:49 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:51979 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab2DSNMt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 09:12:49 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.202] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SKr9k-0003Qe-Ks; Thu, 19 Apr 2012 09:12:22 -0400
Content-Disposition: inline
In-Reply-To: <4F9002CA.6040302@in.waw.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195941>

On Thu, Apr 19, 2012 at 02:19:22PM +0200, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:
> On 04/19/2012 01:49 PM, Thomas Rast wrote:
> >Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
> >
> >>On 04/18/2012 09:18 PM, Neil Horman wrote:
> >>>Add a command line switch to git-rebase to allow a user the abilit=
y to specify
> >>>that they want to keep any commits in a series that are empty.
> >>>
> >>>When git-rebase's type is am, then this option will automatically =
keep any
> >>>commit that has a tree object identical to its parent.
> >>>
> >>>This patch changes the default behavior of interactive rebases as =
well.  With
> >>>this patch, git-rebase -i will produce a revision set passed to
> >>>git-revision-editor, in which empty commits are commented out.  Em=
pty commits
> >>>may be kept manually by uncommenting them.  If the new --keep-empt=
y option is
> >>>used in an interactive rebase the empty commits will automatically=
 all be
> >>>uncommented in the editor.
> >>>
> >>>Signed-off-by: Neil Horman<nhorman@tuxdriver.com>
> >>
> >>Hi,
> >>this one seems to breaks many tests when /bin/sh=3Ddash. (Both v6 i=
n pu
> >>and this v7).
> >
> >Probably because of the strange return in this function:
> >
> >>>is_empty_commit() {
> >>>	tree=3D$(git rev-parse "$1"^{tree})
> >>>	ptree=3D$(git rev-parse "$1"^^{tree})
> >>>	return $(test "$tree" =3D "$ptree")
> >>>}
> >
> >bash seems to pass on the exit status from $() to the caller, while =
dash
> >doesn't.  It seems bash is actually more correct here, because POSIX
> >says about 'return [n]':
> >
> >     EXIT STATUS
> >        The value of the special parameter '?' shall be set to n, an
> >        unsigned decimal integer, or to the exit status of the last
> >        command executed if n is not specified.
> >
> >Either way, it should simply be spelled as
> >
> >is_empty_commit() {
> >	tree=3D$(git rev-parse "$1"^{tree})
> >	ptree=3D$(git rev-parse "$1"^^{tree})
> >	test "$tree" =3D "$ptree"
> >}
> Yes, this change fixes the problem (all tests pass).
>=20
> Thanks!
>=20
> Zbyszek
>=20
Ok, I'll update it.
Neil
