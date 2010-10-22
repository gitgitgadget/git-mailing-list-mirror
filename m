From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Test failure with old svn [Re: [ANNOUNCE] Git 1.7.3.2]
Date: Fri, 22 Oct 2010 04:58:57 -0400
Message-ID: <1287737937.3785.15.camel@balanced-tree>
References: <7vwrparhjq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Walter <swalter@lpdev.prtdev.lexmark.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 10:59:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9DT2-0004FB-AV
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 10:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab0JVI7K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 04:59:10 -0400
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:64191 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751917Ab0JVI7I (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 04:59:08 -0400
X-AuditID: 1209190f-b7c1dae000000a2b-bd-4cc1525b56e0
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id 5B.24.02603.B5251CC4; Fri, 22 Oct 2010 04:59:08 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o9M8x75j020158;
	Fri, 22 Oct 2010 04:59:07 -0400
Received: from [192.168.1.32] (c-71-192-162-193.hsd1.nh.comcast.net [71.192.162.193])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o9M8ww9c019302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Oct 2010 04:59:02 -0400 (EDT)
In-Reply-To: <7vwrparhjq.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.30.3 
X-Brightmail-Tracker: AAAAAhZpJzsWaefU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159668>

On Thu, 2010-10-21 at 21:13 -0700, Junio C Hamano wrote:
> Steven Walter (1):
>       git-svn: check_cherry_pick should exclude commits already in ou=
r history

The new test in this commit fails with Subversion 1.4 and below (for
example, on Ubuntu 6.06 and 8.04), where =E2=80=98svn merge=E2=80=99 re=
quired at least
two arguments.  I=E2=80=99m guessing that with Subversion < 1.5, the te=
st
doesn=E2=80=99t make sense and should just be skipped.

Anders


*** t9157-git-svn-fetch-merge.sh ***
Initialized empty Git repository in /build/buildd/git-1.7.3.2/t/trash d=
irectory.t9157-git-svn-fetch-merge/.git/
expecting success:=20
	svn_cmd mkdir -m x "$svnrepo"/trunk &&
	svn_cmd mkdir -m x "$svnrepo"/branches &&
	svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
	(
		cd "$SVN_TREE" &&
		touch foo &&
		svn add foo &&
		svn commit -m "initial commit" &&
		svn cp -m branch "$svnrepo"/trunk "$svnrepo"/branches/branch1 &&
		touch bar &&
		svn add bar &&
		svn commit -m x &&
		svn cp -m branch "$svnrepo"/trunk "$svnrepo"/branches/branch2 &&
		svn switch "$svnrepo"/branches/branch1 &&
		touch baz &&
		svn add baz &&
		svn commit -m x &&
		svn switch "$svnrepo"/trunk &&
		svn merge "$svnrepo"/branches/branch1 &&
		svn commit -m "merge" &&
		svn switch "$svnrepo"/branches/branch1 &&
		svn commit -m x &&
		svn switch "$svnrepo"/branches/branch2 &&
		svn merge "$svnrepo"/branches/branch1 &&
		svn commit -m "merge branch1" &&
		svn switch "$svnrepo"/trunk &&
		svn merge "$svnrepo"/branches/branch2 &&
		svn resolved baz &&
		svn commit -m "merge branch2"
	) &&
	rm -rf "$SVN_TREE"
	rm -rf "$SVN_TREE"


Committed revision 1.

Committed revision 2.
Checked out revision 2.
A         foo
Adding         foo
Transmitting file data .
Committed revision 3.

Committed revision 4.
A         bar
Adding         bar
Transmitting file data .
Committed revision 5.

Committed revision 6.
D    bar
Updated to revision 6.
A         baz
Adding         baz
Transmitting file data .
Committed revision 7.
D    baz
A    bar
Updated to revision 7.
svn: Not enough arguments provided; try 'svn help' for more info
not ok - 1 initialize source svn repo
