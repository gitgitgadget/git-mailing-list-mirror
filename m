From: Andrew Myrick <amyrick@apple.com>
Subject: Re: git-svn: handling merge-base failures
Date: Sun, 3 Jan 2010 17:37:09 -0800
Message-ID: <7878A426-9D87-43B5-A10A-38F3C9369165@apple.com>
References: <931B0483-7628-488E-BB9F-C40346353149@apple.com>
Mime-Version: 1.0 (Apple Message framework v1130)
Content-Type: multipart/mixed; boundary=Apple-Mail-7-793987720
Cc: Eric Wong <normalperson@yhbt.net>, Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 04 02:37:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRbso-0008U1-LC
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 02:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785Ab0ADBhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 20:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868Ab0ADBhM
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 20:37:12 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:63427 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab0ADBhL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 20:37:11 -0500
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out3.apple.com (Postfix) with ESMTP id 5394D7EE3873;
	Sun,  3 Jan 2010 17:37:10 -0800 (PST)
X-AuditID: 1180711d-b7b18ae000001001-df-4b4146451014
Received: from [17.151.80.156] (Unknown_Domain [17.151.80.156])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay13.apple.com (Apple SCV relay) with SMTP id D9.C6.04097.646414B4; Sun,  3 Jan 2010 17:37:10 -0800 (PST)
In-Reply-To: <931B0483-7628-488E-BB9F-C40346353149@apple.com>
X-Mailer: Apple Mail (2.1130)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136088>


--Apple-Mail-7-793987720
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On Dec 23, 2009, at 11:54 AM, Andrew Myrick wrote:
> One of my projects is failing to clone because merge-base is failing =
on one of the revisions; the branch is a partial branch, so merge-base =
can't find a common ancestor with trunk.  I'd like to catch the =
exception that command_oneline should throw when merge-base fails,

Instead of using the Error.pm module, I was able to handle the exception =
with the more basic eval block.  However, there are some details here I =
would like to discuss with the community.

When git-svn fetches a partial branch, it appears to refetch all of the =
history of the subdirectory from which the branch was created.  This =
creates new commits for the old revisions, and these new commits exist =
as a separate history for the partial branch.   When git-svn fetches the =
revision at which this partial branch is merged back to trunk, git-svn =
attempts to run merge-base to find a common ancestor.  However, because =
the partial branch has its own history, the merge-base fails, and =
git-svn dies.

Naively handling the exception with an eval block and skipping the merge =
ticket works fine in that it brings us back to parity with git 1.6.5.7, =
but it means that the merge parent relationship between trunk and the =
partial branch is lost.  Is there any way to preserve this information, =
or does the separate commit history of the partial branch make it =
fundamentally impossible?

I've created a small svn repository that demonstrates this failure with =
git v1.6.6.  Its dump is attached.

-Andrew



--Apple-Mail-7-793987720
Content-Disposition: attachment;
	filename=partial.dump
Content-Type: application/octet-stream;
	name="partial.dump"
Content-Transfer-Encoding: 7bit

SVN-fs-dump-format-version: 2

UUID: ef8533a7-8eba-4e00-b9e4-68f81a8a4a0e

Revision-number: 0
Prop-content-length: 56
Content-length: 56

K 8
svn:date
V 27
2010-01-04T00:41:48.890110Z
PROPS-END

Revision-number: 1
Prop-content-length: 119
Content-length: 119

K 7
svn:log
V 17
Initial import 


K 10
svn:author
V 7
amyrick
K 8
svn:date
V 27
2010-01-04T00:42:12.648154Z
PROPS-END

Node-path: branches
Node-kind: dir
Node-action: add
Prop-content-length: 10
Content-length: 10

PROPS-END


Node-path: tags
Node-kind: dir
Node-action: add
Prop-content-length: 10
Content-length: 10

PROPS-END


Node-path: trunk
Node-kind: dir
Node-action: add
Prop-content-length: 10
Content-length: 10

PROPS-END


Revision-number: 2
Prop-content-length: 113
Content-length: 113

K 7
svn:log
V 11
New files


K 10
svn:author
V 7
amyrick
K 8
svn:date
V 27
2010-01-04T00:43:30.046704Z
PROPS-END

Node-path: trunk/a
Node-kind: dir
Node-action: add
Prop-content-length: 10
Content-length: 10

PROPS-END


Node-path: trunk/a/file
Node-kind: file
Node-action: add
Prop-content-length: 10
Text-content-length: 0
Text-content-md5: d41d8cd98f00b204e9800998ecf8427e
Text-content-sha1: da39a3ee5e6b4b0d3255bfef95601890afd80709
Content-length: 10

PROPS-END


Node-path: trunk/b
Node-kind: dir
Node-action: add
Prop-content-length: 10
Content-length: 10

PROPS-END


Node-path: trunk/b/file
Node-kind: file
Node-action: add
Prop-content-length: 10
Text-content-length: 0
Text-content-md5: d41d8cd98f00b204e9800998ecf8427e
Text-content-sha1: da39a3ee5e6b4b0d3255bfef95601890afd80709
Content-length: 10

PROPS-END


Revision-number: 3
Prop-content-length: 122
Content-length: 122

K 7
svn:log
V 20
Create full branch


K 10
svn:author
V 7
amyrick
K 8
svn:date
V 27
2010-01-04T00:44:34.670334Z
PROPS-END

Node-path: branches/fullbranch
Node-kind: dir
Node-action: add
Node-copyfrom-rev: 2
Node-copyfrom-path: trunk


Revision-number: 4
Prop-content-length: 112
Content-length: 112

K 7
svn:log
V 10
Add text


K 10
svn:author
V 7
amyrick
K 8
svn:date
V 27
2010-01-04T00:45:11.654184Z
PROPS-END

Node-path: branches/fullbranch/a/file
Node-kind: file
Node-action: change
Text-content-length: 5
Text-content-md5: 6137cde4893c59f76f005a8123d8e8e6
Text-content-sha1: c5d84736ba451747dd5f0eb9d17e104f3697ef47
Content-length: 5

data


Revision-number: 5
Prop-content-length: 129
Content-length: 129

K 7
svn:log
V 27
Merge fullbranch to trunk


K 10
svn:author
V 7
amyrick
K 8
svn:date
V 27
2010-01-04T00:45:41.203114Z
PROPS-END

Node-path: trunk
Node-kind: dir
Node-action: change
Prop-content-length: 59
Content-length: 59

K 13
svn:mergeinfo
V 24
/branches/fullbranch:3-4
PROPS-END


Node-path: trunk/a/file
Node-kind: file
Node-action: change
Text-content-length: 5
Text-content-md5: 6137cde4893c59f76f005a8123d8e8e6
Text-content-sha1: c5d84736ba451747dd5f0eb9d17e104f3697ef47
Content-length: 5

data


Revision-number: 6
Prop-content-length: 125
Content-length: 125

K 7
svn:log
V 23
Create partial branch


K 10
svn:author
V 7
amyrick
K 8
svn:date
V 27
2010-01-04T00:47:34.954727Z
PROPS-END

Node-path: branches/partialbranch
Node-kind: dir
Node-action: add
Node-copyfrom-rev: 5
Node-copyfrom-path: trunk/b
Prop-content-length: 61
Content-length: 61

K 13
svn:mergeinfo
V 26
/branches/fullbranch/b:3-4
PROPS-END


Revision-number: 7
Prop-content-length: 110
Content-length: 110

K 7
svn:log
V 9
Add data

K 10
svn:author
V 7
amyrick
K 8
svn:date
V 27
2010-01-04T00:48:22.334502Z
PROPS-END

Node-path: branches/partialbranch/file
Node-kind: file
Node-action: change
Text-content-length: 10
Text-content-md5: 284b44f9273171eb622b27d9a4df5acd
Text-content-sha1: 59cb3d79577306b6be81d41c273ea47cd47968e1
Content-length: 10

more data


Revision-number: 8
Prop-content-length: 133
Content-length: 133

K 7
svn:log
V 31
Merge partial branch to trunk


K 10
svn:author
V 7
amyrick
K 8
svn:date
V 27
2010-01-04T00:49:11.588697Z
PROPS-END

Node-path: trunk/b
Node-kind: dir
Node-action: change
Prop-content-length: 89
Content-length: 89

K 13
svn:mergeinfo
V 54
/branches/fullbranch/b:3-4
/branches/partialbranch:6-7
PROPS-END


Node-path: trunk/b/file
Node-kind: file
Node-action: change
Text-content-length: 10
Text-content-md5: 284b44f9273171eb622b27d9a4df5acd
Text-content-sha1: 59cb3d79577306b6be81d41c273ea47cd47968e1
Content-length: 10

more data



--Apple-Mail-7-793987720--
