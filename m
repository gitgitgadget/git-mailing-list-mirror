From: Johan Herland <johan@herland.net>
Subject: Re: Using trees for metatagging
Date: Thu, 18 Feb 2010 22:00:08 +0100
Message-ID: <201002182200.09100.johan@herland.net>
References: <20100218041240.GA4127@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 22:00:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiDU3-0005xV-BG
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 22:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126Ab0BRVAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 16:00:22 -0500
Received: from smtp.opera.com ([213.236.208.81]:40773 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab0BRVAV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 16:00:21 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o1IL09ax004633
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Feb 2010 21:00:14 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20100218041240.GA4127@lapse.rw.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140380>

On Thursday 18 February 2010, martin f krafft wrote:
> Git's object store uses trees mainly to represent a hierarchical
> filesystem. It occurs to me that you could layer additional
> hierarchies on top =E2=80=94 specifically, you could use it to track =
subsets
> of files, i.e. "tagging".
>
> For instance you want some sort of representation for "the set of
> files that need review". You /could/ create a new tree and reference
> all files in that set as children. Now if you wanted to find out
> what to review, you'd list the children of this tree. After
> reviewing a file, you write a new tree with the set less that file's
> ref.. Obviously, if you made changes to the file, it should be
> reconnected to all other trees that referenced it.
>
> I have a couple of questions about this:
>
> 1. Does Git provide plumbing for me to find out which trees
>    reference a given blob? If not, I will have to iterate all trees
>    and record which ones have a given message as a child.
>
> 2. Is there a way you can fathom by which unlinking a blob from the
>    main hierarchy also causes it to be unlinked from this meta tree
>    I am speaking of as well? Similarly, if a blob is rewritten, how
>    could I make sure it replaces the old blob in all referencing
>    trees?
>
> 3. Am I right in assuming that I'd have to track a completely
>    seperate ancestry for this tree, that is create e.g. a commit
>    object, point refs/metatrees/mytree to it, and reference the tree
>    from the commit?
>
> 4. Since this hierarchy is not really to be mapped into the
>    filesystem, how would one resolve conflicts when merging
>    ancestries? Of course it would be nice if I could check out this
>    meta tree into the filesystem, make changes, and be assured that
>    new blobs replace old blobs in other referencing trees, as per
>    (2.), but that's a pipedream maybe.
>
> 5. Do you know of similar efforts? Are there must-reads out there,
>    apart from the design of Git?

Take a look at the (relatively) new notes feature. (See the jh/notes=20
series in 'pu' and various recent discussions on this mailing list.)=20
Git notes probably won't satisfy the exact requirements you list above,=
=20
but it _does_ tackle some parallel issues (e.g. how to maintain a tree=20
that is not checked out, storing metadata associated with Git objects,=20
etc.). If you take a step back and reconsider your original problem,=20
you might find that it's solvable by using commit notes.

=46or example, you could add a simple note to each blob that has been=20
reviewed, on the refs/notes/reviewed notes ref. You could then write a=20
simple script (using "git notes list") that lists all blobs (i.e.=20
files) without a corresponding note in refs/notes/reviewed.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
