From: Christian Wiese <morfoh@opensde.org>
Subject: git-svnimport
Date: Tue, 20 Mar 2007 20:00:11 +0200
Message-ID: <20070320200011.444bd942@athlon>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_lNzk4UjCLhQ+MZm3IL7Ofy_;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 20 19:07:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTijw-00008u-9Y
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 19:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbXCTSHP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 14:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbXCTSHP
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 14:07:15 -0400
Received: from foxtrot388.server4you.de ([85.25.140.218]:60315 "EHLO
	speakerboxxx.ixplanet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbXCTSHO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 14:07:14 -0400
Received: (qmail 14998 invoked from network); 20 Mar 2007 18:00:54 -0000
X-Mail-Scanner: Scanned by qSheff-II-2.1-r2 (http://www.enderunix.org/qsheff/)
Received: from unknown (HELO athlon) (morfoh@opensde.net@[80.97.102.202])
          (envelope-sender <morfoh@opensde.org>)
          by speakerboxxx.ixplanet.net (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 20 Mar 2007 18:00:54 -0000
X-Mailer: Claws Mail 2.8.1 (GTK+ 2.10.6; i686-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42755>

--Sig_lNzk4UjCLhQ+MZm3IL7Ofy_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello folks,

I'd like to use git-svnimport to mirror the subprojects within our svn
repository, but I encountered some pitfalls while testing.

Our Layout is like this:

<SVN_Repository_Root>/{subproject-a,subproject-b}/{trunk,branches,tags}

=46rom the documentation of git-svnimport I assumed that I can use:
------------------------------------------------------
$ git-svnimport -v <SVN_Repository_Root>/subproject-a
------------------------------------------------------
to just fetch subproject-a, but the import fails with an error like
this:
-------snip--------------------------------------------------------------
40: Unrecognized path: /subproject-b/tags
40: Unrecognized path: /subproject-b/trunk
41: Unrecognized path: /subproject-a/trunk/foo/bar.txt
42: Unrecognized path: /subproject-a/trunk/foo/bar.txt
43: Unrecognized path: /subproject-a/trunk/foo/bar.txt
Generating pack...
Done counting 0 objects.
Nothing new to pack.
Removing unused objects 100%...
Done.
DONE; creating master branch
cp: cannot stat `/repos/test/tmp/.git/refs/heads/origin':
No such file or directory
fatal: master: not a valid SHA1
-------snip--------------------------------------------------------------

What am I doing wrong ?

When I am using:
--------------------------------------------------------
$ git-svnimport -v -T subproject-a <SVN_Repository_Root>
--------------------------------------------------------
it gets happily imported.

So I have the impression that the described <SVN_repository_URL> in
the documentation of git-svnimport is in fact the Repository Root of the
svn repo.

For me it looks like git-svnimport makes the assumption that most svn
repos are organized in the following way:

<SVN_repository_URL>/{trunk,branches,tags}/{subproject-a,subproject-b}

I have never seen svn repos organized that way if there are more than
one project inside a repo, and it is even not recommended by the svn
people as we can see here:
http://svnbook.red-bean.com/nightly/en/svn-book.html#svn.branchmerge.maint.=
layout

So the assumption of git-svnimport, that trunk, branches and tags are
always top-level directories is unlikely the case in most svn
deployments. Most subprojects hosted in a svn repo have their own
trunk, branches and tags directories.

I think the '-P' option of git-svnimport should rather define the
relative path of the subproject from the svn repository root than from
a trunk toplevel directory, which is not existing in most cases.

It might be even useful to rename <SVN_repository_URL> to
<SVN_Repository_Root>

-P <Path_from_SVN_Repository_Root>
	By default, the whole  repository is imported.
	-P my/proj will import starting only from my/proj.
	This option is useful when you want to import one project from
	a svn repo which hosts multiple projects, that have their own
	trunk, branches and tags directory structure.


<SVN_Repository_Root>/<Path_from_SVN_Repository_Root>/{trunk,branches,tags}

As far as I can see now that would ease the use of git-svnimport a lot
and would help people to migrate from svn to git as well.

Any suggestions are highly welcome!

Thanks in advance.
Cheers
--Chris

--Sig_lNzk4UjCLhQ+MZm3IL7Ofy_
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGACEyFAiA38MZhZ0RAr0KAJ42vxQ+5iC3fSxZg9sqfsi8KXcuNQCfWZ5G
1sDEeGRgVVckUl+/4XqMb0M=
=Qhe0
-----END PGP SIGNATURE-----

--Sig_lNzk4UjCLhQ+MZm3IL7Ofy_--
