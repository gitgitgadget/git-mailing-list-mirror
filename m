From: "=?iso-8859-1?Q?Fran=E7ois_Beausoleil?=" 
	<francois.beausoleil@bloomdigital.com>
Subject: merge --no-ff on case insensitive when replacing case-changing file fails
Date: Wed, 24 Mar 2010 16:35:45 -0400
Message-ID: <BEA422D6-7434-447C-B0AE-A2BAC4E8E74B@bloomdigital.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 21:36:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuXJ6-0007u9-J7
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 21:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623Ab0CXUfw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 16:35:52 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:34419 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932435Ab0CXUfu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 16:35:50 -0400
Received: by ewy8 with SMTP id 8so74261ewy.28
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 13:35:49 -0700 (PDT)
Received: by 10.216.88.202 with SMTP id a52mr4863645wef.101.1269462949094;
        Wed, 24 Mar 2010 13:35:49 -0700 (PDT)
Received: from [192.168.142.101] (modemcable134.176-201-24.mc.videotron.ca [24.201.176.134])
        by mx.google.com with ESMTPS id u14sm1124585gvf.17.2010.03.24.13.35.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 13:35:48 -0700 (PDT)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143122>

Hi!

I don't yet have a reproduction recipe, but I think this is something t=
hat can be reproduced quickly. I'm on Mac OS X, using git 1.6.5.2.

On branch master I have a file named public/clippy/clippy.hx. I created=
 a new branch from master, named ticket-726. On this branch, I replaced=
 public/clippy with a new version, where clippy.hx was renamed to Clipp=
y.hx (note capital C).

Merging with --no-ff from ticket-726 onto master results in:

$ git merge --no-ff ticket-726-clippy-from-page
Removing public/clippy.swf
Removing public/clippy/clippy.hx
Removing public/clippy/config.md
Removing public/clippy/library.swf
Removing public/clippy/swfmill
Merge made by recursive.
fatal: unable to read files to diff

After this, the tree is unclean:

$ git status
# On branch master
# Your branch is ahead of 'origin/master' by 9 commits.
#
# Changed but not updated:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working dire=
ctory)
#
#       deleted:    public/clippy/Clippy.hx
#

If I merge without the --no-ff flag, the merge succeeds:

$ git merge ticket-726-clippy-from-page=20
Updating 8527f71..f9f070d
=46ast forward
=2E..
 public/clippy/Clippy.hx                 |   45 +++++++++++++
=2E..
 public/clippy/clippy.hx                 |   28 --------
=2E..
 21 files changed, 312 insertions(+), 79 deletions(-)
=2E..
 create mode 100644 public/clippy/Clippy.hx
=2E..
 delete mode 100644 public/clippy/clippy.hx
=2E..

Google didn't turn up anything, except the reference in the source code=
 where this error message is defined. There was also a prior report of =
this bug http://collab.sakaiproject.org/pipermail/sakai-ux/2010-March/0=
01058.html but I couldn't read anything interesting from it.

As noted above, I'm on Mac OS X, which has is case insensitive, but cas=
e preserving.

Thanks!
=46ran=E7ois Beausoleil