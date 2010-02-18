From: Fabien <fabien.ubuntu@gmail.com>
Subject: git-http-push (git v1.5) problems with DAVLockDB on reiserfs FS
Date: Thu, 18 Feb 2010 11:45:53 +0100
Message-ID: <hlj5ov$rca$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 18 11:50:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni3xi-0001gs-6X
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 11:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171Ab0BRKuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 05:50:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:48526 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756721Ab0BRKuI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 05:50:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ni3xO-0001VP-4X
	for git@vger.kernel.org; Thu, 18 Feb 2010 11:50:06 +0100
Received: from lamppc10.epfl.ch ([128.178.154.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 11:50:06 +0100
Received: from fabien.ubuntu by lamppc10.epfl.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 11:50:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: lamppc10.epfl.ch
User-Agent: Thunderbird 1.5.0.14ubu (X11/20090319)
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140315>

Hi,

I encountered many problems when using a git repository served over
apache/dav on ubuntu 8.04LTS
* versions in use on server:
- kernel 2.6.24
- apache 2.2.8
- git version 1.5.4.3 or 1.6.6.2 (doesn't change anything on server side)

* versions in use on clients
git 1.5.4.3 => causes problem
git 1.6.6.2 => is ok.


With client 1.5, when pushing more than one commit, it fails with this
error:

$ git push origin master
Fetching remote heads...
  refs/
  refs/tags/
  refs/heads/
updating 'refs/heads/master'
  from ad49aa06f145c5176f230744eb047f5f132361ab
  to   3e6a3d8c8d3459c67a50bce55718f3b64db96f84
    sending 6 objects
    done
Updating remote server info
error: http-push died with strange error
error: failed to push some refs to
'http://my.domain.tlt/git-tests/project9.git/'

leaving the repository in the middle of the push which is really bad:
$ git fsck
bad sha1 file:
./objects/1d/881d1c352047547135810123fdc13fb4f8e1db_88cb4b13-a549-445f-b0f1-79aaf746129e
bad sha1 file:
./objects/34/6018f9dafe91cb3fce8af1c49863a72c649e2f_88cb4b13-a549-445f-b0f1-79aaf746129e
bad sha1 file:
./objects/52/bb16c7a3c44d589a2cfd132c8cc749ad270dd4_88cb4b13-a549-445f-b0f1-79aaf746129e
error: HEAD: invalid sha1 pointer 458703bec0ab47149a9b7d70c384581c9cc0d859
error: refs/heads/master does not point to a valid object!
notice: No default references
dangling commit 3295f15a5de9a2e58a577f9fe949dd7c81f72c6e
dangling blob 40f6abca54b4408eedbf4f34116dd99fed8e205d
dangling tree 656844a3f994fae1a92e856ac6b3b5cf9925e79a
dangling tree 6b3d8fa638d004fe80f5512e025d74533a142859

I finally noticed that this problem only occurs when I have the
DAVLockDB file on a reiserfs partition. If I move it on ext3, it's ok.
Weird...

Does somebody know which commit version change this behavior between 1.5
and 1.6 ?

--
Fabien
