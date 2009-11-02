From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Binary files in a linear repository
Date: Mon, 2 Nov 2009 16:34:28 +0100
Message-ID: <20091102153428.GA4778@atjola.homenet>
References: <S1754797AbZKBONX/20091102141323Z+268@vger.kernel.org>
 <8470D32E-2CAA-4E3F-8BA0-B4578372A3C4@jump-ing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Markus Hitter <mah@jump-ing.de>
X-From: git-owner@vger.kernel.org Mon Nov 02 16:34:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4yvY-0004yl-Iv
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 16:34:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbZKBPe3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2009 10:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755377AbZKBPe3
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 10:34:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:42787 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755363AbZKBPe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 10:34:29 -0500
Received: (qmail invoked by alias); 02 Nov 2009 15:34:32 -0000
Received: from i59F546D3.versanet.de (EHLO atjola.homenet) [89.245.70.211]
  by mail.gmx.net (mp005) with SMTP; 02 Nov 2009 16:34:32 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/6OrJrhzn6MhhbIkz3qmD609iE7cOdyqSNr7Arix
	IifXhkxf3c1GWO
Content-Disposition: inline
In-Reply-To: <8470D32E-2CAA-4E3F-8BA0-B4578372A3C4@jump-ing.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131914>

On 2009.11.02 16:08:25 +0100, Markus Hitter wrote:
> The situation I'm trying to solve is:
>=20
> - A revision earlier than the latest one is checked out.
>=20
> - Files of this earlier commit are modified.
>=20
> - I want to record this earlier commit along with it's modifications
> as a new commit on top of master, ignoring intermediate commits:
>=20
> com005  <-- master
> com004
> com003  <-- HEAD, files modified
> com002
> com001 (initial commit)
>=20
> One solution to do this is to move all files somewhere else, check
> out master, deleting all checked out files, placing the moved away
> files back into place and committing the result as com006.
> Obviously, this is a pretty complex operation, just waiting to
> exploit coding mistakes. Additionally, this will be slow.

Instead of doing "git checkout com003", which detaches HEAD, you could
do:
git read-tree -u --reset com003

Which will update the index and working tree to reflect the contents of
com003. The modify stuff, add, commit, done.

> Now I'm thinking about a much simpler solution: Simply declare the
> current set of files as (a modified) master/com005 and commit them.
> A "cp $GIT_DIR/master $GIT_DIR/HEAD" followed by a commit would do
> it.
>=20
> Now my question: Is it safe to tweak the files in $GIT_DIR this way
> or will this corrupt the repository?

Ignoring that $GIT_DIR/master is the wrong path, that 'cp' would (at
best) act like detaching HEAD.

Bj=F6rn
