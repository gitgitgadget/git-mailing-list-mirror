From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [Feature Request] Better Subversion integration
Date: Sun, 10 Feb 2008 17:52:15 +0100
Message-ID: <47AF2BBF.1060403@alum.mit.edu>
References: <FC5B6F22-27A9-4F0F-85EE-0B72B94C69E2@gmail.com> <20080210035611.GA2454@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Granieri Jr <sjgdev@gmail.com>,
	Git Users List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 17:53:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOFQT-0004sz-Nx
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 17:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbYBJQwe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 11:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbYBJQwe
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 11:52:34 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:45887 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbYBJQwd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 11:52:33 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.135] (kaiserty.in-dsl.de [217.197.85.174])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m1AGqSfm019949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 10 Feb 2008 17:52:30 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.8pre) Gecko/20071022 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
In-Reply-To: <20080210035611.GA2454@atjola.homenet>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73375>

Bj=F6rn Steinbrink wrote:
> On 2008.02.09 20:44:59 -0600, Sam Granieri Jr wrote:
>> Right now, git-svn import (or clone) will convert tags and branches =
as =20
>> remote branches.
>> I would like it if git could pick up subversion tags and translate t=
hem=20
>> as git tags upon importing
>=20
> SVN tags aren't like git tags. A "tag" in SVN is just another directo=
ry,
> which you can modify at will. Yeah, I know, you _should_ not commit a=
ny
> changes to SVN "tags", but shit happens. And once you modify the "tag=
"
> in SVN, you would have to invalidate the git tag, and finding a commi=
t
> that matches the SVN state of things is probably way too expensive to=
 be
> practical. Maybe some --we-never-mess-up-svn-tag-alike-branches could
> be added to allow git-svn to create teal git tags though? Dunno, I do=
n't
> care much. Shouldn't be too hard to find some shell magic to create
> tags, if one wants them.

Because of the way an SVN repository is stored, it should be cheap to
ask SVN whether the contents of a tag in the HEAD revision are identica=
l
to the contents at the time the tag was created.  If there was any
change anywhere under the tag directory, then the node of the tag
directory will be different in the two revisions.

=46or that matter, you could ask SVN for information about the revision=
s
in which the tags/ directory was changed (this is also very cheap), and
make sure that none of those changes modified an existing tag.  This
scan could be done at the beginning of a conversion to determine which
tags were handled as pure tags (and therefore convertible as git tags)
and which were not (and therefore require more complicated handling).

Michael
