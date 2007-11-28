From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Replace misleading message during interactive rebasing
Date: Wed, 28 Nov 2007 09:26:55 +0100
Message-ID: <47D3817B-AA0D-4949-99ED-C36611604D5E@wincent.com>
References: <1196111891-18518-1-git-send-email-win@wincent.com> <474BD5CA.7050407@viscovery.net> <7vve7n9eaa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	tsuna@lrde.epita.fr, Johannes.Schindelin@gmx.de,
	mcostalba@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:30:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKux-00045Z-B5
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:17:23 +0100
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxIQs-00039h-Vo
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:38:11 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxIQj-0003wr-Ri
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbXK1I1I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 03:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbXK1I1H
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 03:27:07 -0500
Received: from wincent.com ([72.3.236.74]:44219 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbXK1I1F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 03:27:05 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAS8QvP6031792;
	Wed, 28 Nov 2007 02:26:58 -0600
In-Reply-To: <7vve7n9eaa.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.5, required=5.0, autolearn=disabled, AWL=3.514,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: DDA37463399F1B0180440FA49C3BA92DFC676BA4
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -34 maxlevel 200 minaction 2 bait 0 mail/h: 48 total 724119 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66328>

El 28/11/2007, a las 5:37, Junio C Hamano escribi=F3:

> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Wincent Colaiuta schrieb:
>>> +		export _GIT_CHERRY_PICK_HELP=3D"run 'git rebase --continue'"
>>
>> Isn't this a bashism?
>
> Being an old-fashioned shell programmer myself, "export VAR=3DVAL" do=
es
> raise my eyebrows.  It is in POSIX but are there shells that we do
> support (dash, bash, ksh -- /bin/sh on Solaris does not count) that
> want their exports old-fashioned way?


As I noted earlier in thread, the idiom is used elsewhere in Git =20
already. Below is a list of the instances I found where shell scripts =20
use the idiom. There are also other instances (documentation, test =20
scripts, even a tcl file) where the idiom is used. As far as its =20
suitability I only have directory experience with Bash, and it's =20
always worked in all versions that I've tried in the 2.x and 3.x =20
range. The other shells, I don't know.

In any case, below I'll paste in a revised patch that doesn't use the =20
export FOO=3D... idiom. I can also submit another patch changing the =20
other usages of the idiom elsewhere in the tree, but I'd need guidance =
=20
on how far you'd want to go (only the Git commands? also the tests? =20
don't worry about the docs? etc).

El 27/11/2007, a las 9:49, Wincent Colaiuta escribi=F3:

> I wondered that myself before submitting the patch, but then saw =20
> that the same pattern was used at other places as well:
>
> git-clone.sh:
>
> W=3D$(cd "$GIT_WORK_TREE" && pwd) && export GIT_WORK_TREE=3D"$W"
>
> git-filter-branch.sh:
>
> export GIT_INDEX_FILE=3D"$(pwd)/../index"
> export GIT_COMMIT=3D$commit
> export GIT_COMMIT=3D"$sha1"
>
> git-quiltimport.sh:
>
> export GIT_AUTHOR_NAME=3D$(sed -ne 's/Author: //p' "$tmp_info")
> export GIT_AUTHOR_EMAIL=3D$(sed -ne 's/Email: //p' "$tmp_info")
> export GIT_AUTHOR_DATE=3D$(sed -ne 's/Date: //p' "$tmp_info")
> export SUBJECT=3D$(sed -ne 's/Subject: //p' "$tmp_info")
>
> So if this is a problem, those sites will need to be changed as well.
>
> Cheers,
> Wincent

Here's the revised patch:
--------8<---------
 From cd11e1355011796fe16d0eb7116fae4070f2a30d Mon Sep 17 00:00:00 2001
=46rom: Wincent Colaiuta <win@wincent.com>
Date: Mon, 26 Nov 2007 13:35:46 +0100
Subject: [PATCH] Replace misleading message during interactive rebasing

git-rebase--interactive uses git-cherry-pick under the covers to reorde=
r
commits, which in turn means that in the event of a conflict a message
will be shown advising the user to commit the results and use the -c
switch to retain authorship after fixing the conflict.

The message is misleading because what the user really needs to do is
run "git rebase --continue"; the committing is handled by git-rebase
and the authorship of the commit message is retained automatically.

We solve this problem by using an environment variable to communicate
to git-cherry-pick that rebasing is underway and replace the misleading
error message with a more helpful one.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
  builtin-revert.c           |    8 +++++---
  git-rebase--interactive.sh |    4 ++++
  2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index a0586f9..5a57574 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -229,7 +229,7 @@ static int revert_or_cherry_pick(int argc, const =20
char **argv)
  	unsigned char head[20];
  	struct commit *base, *next, *parent;
  	int i;
-	char *oneline, *reencoded_message =3D NULL;
+	char *oneline, *reencoded_message =3D NULL, *help_message;
  	const char *message, *encoding;
  	const char *defmsg =3D xstrdup(git_path("MERGE_MSG"));

@@ -352,11 +352,13 @@ static int revert_or_cherry_pick(int argc, const =
=20
char **argv)
  		}
  		if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
  			die ("Error wrapping up %s", defmsg);
+		help_message =3D getenv("_GIT_CHERRY_PICK_HELP");
  		fprintf(stderr, "Automatic %s failed.  "
  			"After resolving the conflicts,\n"
  			"mark the corrected paths with 'git add <paths>' "
-			"and commit the result.\n", me);
-		if (action =3D=3D CHERRY_PICK) {
+			"and %s.\n", me,
+			help_message ? help_message : "commit the result");
+		if (action =3D=3D CHERRY_PICK && !help_message) {
  			fprintf(stderr, "When commiting, use the option "
  				"'-c %s' to retain authorship and message.\n",
  				find_unique_abbrev(commit->object.sha1,
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index bf44b6a..3552c89 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -117,6 +117,8 @@ pick_one () {
  		sha1=3D$(git rev-parse --short $sha1)
  		output warn Fast forward to $sha1
  	else
+		_GIT_CHERRY_PICK_HELP=3D"run 'git rebase --continue'"
+		export _GIT_CHERRY_PICK_HELP &&
  		output git cherry-pick "$@"
  	fi
  }
@@ -187,6 +189,8 @@ pick_one_preserving_merges () {
  			fi
  			;;
  		*)
+			_GIT_CHERRY_PICK_HELP=3D"run 'git rebase --continue'"
+			export _GIT_CHERRY_PICK_HELP &&
  			output git cherry-pick "$@" ||
  				die_with_patch $sha1 "Could not pick $sha1"
  			;;
--=20
1.5.3.6.953.gdffc
