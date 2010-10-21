From: Camille Moncelier <moncelier@devlife.org>
Subject: Re: [PATCH 2/3] merge-recursive: Small code cleanup
Date: Thu, 21 Oct 2010 21:43:15 +0200
Message-ID: <20101021214315.17c535e1@cortex>
References: <AANLkTimz8qSwefp137-D+vEbsf6soG51u0im9EC911_O@mail.gmail.com>
	<1283806070-22027-3-git-send-email-newren@gmail.com>
	<EF9FEAB3A4B7D245B0801936B6EF4A254B6BBD@azsmsx503.amr.corp.intel.com>
	<AANLkTim5AA7mnAhkbqJaFcUv9vniTVG7siOMxE+y=ehf@mail.gmail.com>
	<EF9FEAB3A4B7D245B0801936B6EF4A25593A57@azsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 21:45:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P914q-0006Z5-6C
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 21:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757170Ab0JUTpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 15:45:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:53452 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756860Ab0JUTpI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 15:45:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P914S-0006NV-5B
	for git@vger.kernel.org; Thu, 21 Oct 2010 21:45:04 +0200
Received: from mal35-3-82-240-201-90.fbx.proxad.net ([82.240.201.90])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 21:45:04 +0200
Received: from moncelier by mal35-3-82-240-201-90.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 21:45:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: mal35-3-82-240-201-90.fbx.proxad.net
X-Newsreader: Claws Mail 3.7.6 (GTK+ 2.22.0; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159555>

On Thu, 9 Sep 2010 13:23:26 -0700
"Schalk, Ken" <ken.schalk@intel.com> wrote:

> >Perhaps you could submit another patch changing your testcase back to
> >using a symlink to make sure someone like me doesn't break your
> >original testcase in the future?
> 
> Here's a patch relative to my last one.  Rather than restoring the
> previous test, I added it so that platforms with no symlink support
> can still test copy vs. rename and platforms with symlink support can
> also test rename vs. rename/symlink.
Hello, I think I have a test case that seems to be related to this
issue.

mkdir -p repo1
pushd repo1
git init .

mkdir dir1
echo file1 > dir1/file1
ln -s dir1 dir2
git add dir1 dir2
git commit -m "Initial status: dir2 -> dir1"

git checkout -b test1
git checkout -b test2

git co test1
git rm dir2
mkdir dir2
touch file2 > dir2/file1
git add dir2/file1
git commit -m "Removing link: dir1/ and dir2/"

message="New file in test1"
echo $message > new_file_test1
git add new_file_test1
git commit -m "$message"

git co test2
message="New file in test2"
echo $message > new_file_test2
git add new_file_test2
git commit -m "$message"

# Tries to get the last commit (which adds new_file_test1)
# into test2 fails.
git cherry-pick test1

# Would work with: git cherry-pick --strategy=resolve test1 
# (using 1.7.3.1) 
