From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6] clone --single: limit the fetch refspec to fetched
 branch
Date: Tue, 18 Sep 2012 12:42:01 -0700
Message-ID: <7vk3vrm83a.fsf@alter.siamese.dyndns.org>
References: <1347909706-22888-1-git-send-email-ralf.thielow@gmail.com>
 <1347995660-9956-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 21:42:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE3gY-0004zR-6P
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 21:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab2IRTmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 15:42:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43721 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754176Ab2IRTmH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 15:42:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 270C79CF7;
	Tue, 18 Sep 2012 15:42:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UVjuf7rfshimTfC//yafQ+cIj1A=; b=V8PwsS
	Q/MiFbUfm3GN7Vk8+jAVXT+ESMDKeJPut8pFE+YcYnB8buEbHOiwKc4nXtbKV3wC
	EZs69MrK6jJBQa8/jh/qlmfaJUqizOWQuSVp3obSBqGK25zo0ag6M8UO6XYbh1h5
	ULpPU5cviT94pm5bezyW3nwPqpnjjZY3sJAW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GaMOBfu8hxJWzQy9zcDRr04EdgHYZEmh
	kOX+nLzdgEQJfumc3p16wIQtjYpg5f8SHOT0iO2CLw4v+3D6T0x311NCFYaDJdzQ
	NOdYynkAxIG9nFvp0pgbsRXcAZCAR3DYHARzT8oJ2zjxAnT68ZhlEpmU5ki6P3jW
	PZ3OO+FeVrI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13DFD9CF6;
	Tue, 18 Sep 2012 15:42:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5054F9CF2; Tue, 18 Sep 2012
 15:42:04 -0400 (EDT)
In-Reply-To: <1347995660-9956-1-git-send-email-ralf.thielow@gmail.com> (Ralf
 Thielow's message of "Tue, 18 Sep 2012 21:14:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC41F060-01C8-11E2-AC30-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205856>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> After running "git clone --single", the resulting repository has the
> usual default "+refs/heads/*:refs/remotes/origin/*" wildcard fetch
> refspec installed, which means that a subsequent "git fetch" will
> end up grabbing all the other branches.
>
> Update the fetch refspec to cover only the singly cloned ref instead
> to correct this.
>
> That means:
> If "--single" is used without "--branch" or "--mirror", the
> fetch refspec covers the branch on which remote's HEAD points to.
> If "--single" is used with "--branch", it'll cover only the branch
> specified in the "--branch" option.
> If "--single" is combined with "--mirror", then it'll cover all
> refs of the cloned repository.
> If "--single" is used with "--branch" that specifies a tag, then
> it'll cover only the ref for this tag.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>
> changes in v6
> - remove initial created tests (they tested in a too deep level)
> - add tests for "--mirror" option
> - add tests for the case of cloning a tag
> - update commit message
>
> I've tried to update "Documentation/git-clone.txt", but I don't
> know in which way this patch changes already described behaviour.
> The resulting refspec seems only be covered in the last part of
> the "--single-branch" section by describing "--no-single-branch",
> but this hasn't changed. Or did I miss something?

I do not think we are changing anything.  The whole "--single-branch"
was an half-baked afterthought hack that nobody anticipated the user
to later issue "git fetch" in the resulting repository, and everybody
involved in the series (the maintainer included) were just happy to
see the resulting code only transferred objects needed for the branch
without wasting bandwidth for objects needed for other branches, and
stopped thinking beyond that X-<.

If anything, we need to _add_ the description of what happens when
further fetches are done.  The second and the third paragraph in
the DESCRIPTION section talks only about the normal case, so at
least at the end of the second paragraph we should say "But if you
use --single-branch, all of this is different".  And what happens
when you do use --single-branch should be described in the part that
describes that option, e.g.

 Documentation/git-clone.txt | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git c/Documentation/git-clone.txt w/Documentation/git-clone.txt
index c1ddd4c..f59bc49 100644
--- c/Documentation/git-clone.txt
+++ w/Documentation/git-clone.txt
@@ -29,7 +29,8 @@ currently active branch.
 After the clone, a plain `git fetch` without arguments will update
 all the remote-tracking branches, and a `git pull` without
 arguments will in addition merge the remote master branch into the
-current master branch, if any.
+current master branch, if any (this is untrue when "--single-branch"
+is given; see below).
 
 This default configuration is achieved by creating references to
 the remote branch heads under `refs/remotes/origin` and
@@ -152,9 +153,11 @@ objects from the source repository into a pack in the cloned repository.
 -b <name>::
 	Instead of pointing the newly created HEAD to the branch pointed
 	to by the cloned repository's HEAD, point to `<name>` branch
-	instead. `--branch` can also take tags and treat them like
-	detached HEAD. In a non-bare repository, this is the branch
+	instead. In a non-bare repository, this is the branch
 	that will be checked out.
++
+`--branch` can also take tags and detaches the HEAD
+at that commit in the resulting repository. 
 
 --upload-pack <upload-pack>::
 -u <upload-pack>::
@@ -193,6 +196,12 @@ objects from the source repository into a pack in the cloned repository.
 	clone with the `--depth` option, this is the default, unless
 	`--no-single-branch` is given to fetch the histories near the
 	tips of all branches.
++
+Further fetches into the resulting repository will only update the
+remote tracking branch for the branch this option was used for the
+initial cloning.  If the HEAD at the remote did not point at any
+branch when `--single-branch` clone was made, no remote tracking
+branch is created.
 
 --recursive::
 --recurse-submodules::
