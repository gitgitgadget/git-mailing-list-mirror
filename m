From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: commit/from command in git-fast-import
Date: Fri, 27 Jan 2012 15:09:36 -0600
Message-ID: <20120127210936.GC3124@burratino>
References: <20120127124837.GA24084@glandium.org>
 <CAFfmPPPYc=9BdwuE+ANiHKrFk+_7aXDgnMv3fHxVmF0ttZu8bA@mail.gmail.com>
 <20120127140808.GA31535@glandium.org>
 <CAFfmPPN9BOp3tDetEeMjVmfFam3bgHzf=q5Am4OkTz0TqLWfbQ@mail.gmail.com>
 <20120127144702.GA6693@glandium.org>
 <CAFfmPPM_xqZoMd391UdqRtK5bgW5V2z9Mg=8LYLA7ZVZQGR3Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	Dmitry Ivankov <divanorama@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 22:09:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqt3N-0000JK-Od
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 22:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab2A0VJp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 16:09:45 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55711 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab2A0VJo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 16:09:44 -0500
Received: by ggnb1 with SMTP id b1so1066614ggn.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 13:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HBkW7u06PePcV5WSqxAwc1/TYC0SnTePUPj69f5aLTw=;
        b=A4rkk7WvLPbAikYJ2RE+ZxadGjMUMwOCXyD1Cf44W+LAhHCZxPqcGXqF893dRswWyB
         w8yxfsRXwoQ+x1XHlSLM0FWB7DeryJxugENjk1mG2/hkLX/6sOnqmJ1zKiZAwmFuhGoW
         JCT96n7N5tF926NA8+65ANTiDyQLLAvd8gMeY=
Received: by 10.101.144.8 with SMTP id w8mr3956447ann.14.1327698584014;
        Fri, 27 Jan 2012 13:09:44 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h43sm15783294yhj.2.2012.01.27.13.09.42
        (version=SSLv3 cipher=OTHER);
        Fri, 27 Jan 2012 13:09:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFfmPPM_xqZoMd391UdqRtK5bgW5V2z9Mg=8LYLA7ZVZQGR3Mg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189233>

David Barr wrote:
>>> On Sat, Jan 28, 2012 at 1:08 AM, Mike Hommey <mh@glandium.org> wrot=
e:

>>>> This is however not what the manpage suggests in what I quoted in =
my
>>>> message:
>>>> =C2=A0Omitting the from command on existing branches is usually de=
sired, as
>>>> =C2=A0the current commit on that branch is automatically assumed t=
o be the
>>>> =C2=A0first ancestor of the new commit.
[...]
> Looks like we have a real fast-import bug, in Debian Unstable at leas=
t.

Yep, this is a real fast-import documentation bug.  The manual says:

	Omitting the from command in the first commit of a new branch
	will cause fast-import to create that commit with no ancestor.
	This tends to be desired only for the initial commit of a
	project.
[...]
	The special case of restarting an incremental import from the
	current branch value should be written as:

		from refs/heads/branch^0

The unfortunate term here is "existing branches", which seems to have
been intended to refer to refs that have already been populated in
this fast-import stream by a "commit" or "reset" command, rather than
any old ref that already exists in the repository.

In other words, instead of "existing branch", the manual should say
something along the lines of "branch already in fast-import's internal
branch table".

Here's a sketch.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-fast-import.txt |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast=
-import.txt
index ec6ef311..28a317ff 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -306,9 +306,9 @@ and control the current import process.  More detai=
led discussion
 (with examples) of each command follows later.
=20
 `commit`::
-	Creates a new branch or updates an existing branch by
-	creating a new commit and updating the branch to point at
-	the newly created commit.
+	Creates a new branch or updates a branch by creating a new
+	commit and updating the branch to point at the newly created
+	commit.
=20
 `tag`::
 	Creates an annotated tag object from an existing commit or
@@ -317,7 +317,7 @@ and control the current import process.  More detai=
led discussion
 	in time.
=20
 `reset`::
-	Reset an existing branch (or a new branch) to a specific
+	Reset an existing branch or a new branch to a specific
 	revision.  This command must be used to change a branch to
 	a specific revision without making a commit on it.
=20
@@ -439,13 +439,15 @@ The `from` command is used to specify the commit =
to initialize
 this branch from.  This revision will be the first ancestor of the
 new commit.
=20
-Omitting the `from` command in the first commit of a new branch
+Omitting the `from` command in the first commit of a branch that
+has not been created previously with a `commit` or `reset` command
 will cause fast-import to create that commit with no ancestor. This
 tends to be desired only for the initial commit of a project.
 If the frontend creates all files from scratch when making a new
 branch, a `merge` command may be used instead of `from` to start
 the commit with an empty tree.
-Omitting the `from` command on existing branches is usually desired,
+Omitting the `from` command on branches that have already been
+initialized in the same stream is usually desired,
 as the current commit on that branch is automatically assumed to
 be the first ancestor of the new commit.
=20
--=20
1.7.9.rc2
