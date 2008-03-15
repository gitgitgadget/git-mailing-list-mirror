From: Bernt Hansen <bernt@norang.ca>
Subject: [PATCH] git-new-workdir: Share SVN meta data between work dirs and the repository
Date: Fri, 14 Mar 2008 22:44:13 -0400
Organization: Norang Consulting Inc
Message-ID: <87ejaczoxu.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Mar 15 03:45:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaMOR-0001cN-3Y
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 03:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbYCOCo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 22:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbYCOCo1
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 22:44:27 -0400
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55300 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbYCOCo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 22:44:26 -0400
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1JaMNk-00043m-Ec; Sat, 15 Mar 2008 02:44:24 +0000
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+DNhaSvm/vg8ULGsYVlNVi
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.97 http://www.acme.com/software/spfmilter/ with libspf-unknown;
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id m2F2iJYU013332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Mar 2008 22:44:20 -0400
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.2/8.14.2/Debian-1) with ESMTP id m2F2iJsH012672;
	Fri, 14 Mar 2008 22:44:19 -0400
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.2/8.14.2/Submit) id m2F2iD27012671;
	Fri, 14 Mar 2008 22:44:13 -0400
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77301>

Multiple work dirs with git svn caused each work dir to have its own
stale copy of the SVN meta data in .git/svn

git svn rebase updates commits with git-svn-id: in the repository and
stores the SVN meta data information only in that work dir.  Attempting to
git svn rebase in other work dirs for the same branch would fail because
the last revision fetched according to the git-svn-id is greater than the
revision in the SVN meta data for that work directory.

Signed-off-by: Bernt Hansen <bernt@norang.ca>
---
 contrib/workdir/git-new-workdir |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
index 2838546..7959eab 100755
--- a/contrib/workdir/git-new-workdir
+++ b/contrib/workdir/git-new-workdir
@@ -63,7 +63,7 @@ mkdir -p "$new_workdir/.git" || die "unable to create \"$new_workdir\"!"
 # create the links to the original repo.  explictly exclude index, HEAD and
 # logs/HEAD from the list since they are purely related to the current working
 # directory, and should not be shared.
-for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache
+for x in config refs logs/refs objects info hooks packed-refs remotes rr-cache svn
 do
 	case $x in
 	*/*)
-- 
1.5.4.4.537.gb75aa
