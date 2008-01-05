From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Sat, 5 Jan 2008 09:57:24 +0100
Message-ID: <e5bfff550801050057v485a7491qa8997b5b9c3b0f60@mail.gmail.com>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
	 <7vy7b5glmr.fsf@gitster.siamese.dyndns.org>
	 <e5bfff550801050025g6758bfb6p751e69e93d4299be@mail.gmail.com>
	 <7vbq80d5yp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 09:57:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB4qo-0003BM-4Q
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 09:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbYAEI52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 03:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbYAEI52
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 03:57:28 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:8132 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbYAEI51 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 03:57:27 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6401843rvb.1
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 00:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=T6tZBOD1xi51kdDEa5gmIiUcrJHtDghQoYK4VGYfAuw=;
        b=rjtn9z4t0+Irx9zWQ4PW4K1b6L/jWtaPwKqquz1SbMOEzGVqUP/Uw2Bp5nDdqCD0tLyJ+dMVJxgNRBF9jlAH0LEQjQe5vYgZ8P7/mUYu1+qi1cMNHSLtfAlcs5u20WMpCpEtUR/UT/BMWMTcqTTTVv6YeppaIfvkqtOwkPbn3eA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BylAxsJ4q6yyR/6Yj2w7AUxywzUewZf0UXPpmliXvIxuuJCUaPy9/6f/jDb/Z6SMvkEVbD8vJoa5etqoRZmxiKzzOUvzbeL5sNpkDWqIeRi7rKm+y5GyEtAiplLoKr7kK2jydMN7HW0RmZs4gq8s+HGRZhLtjh3impHEj5sZOT4=
Received: by 10.141.152.8 with SMTP id e8mr9411500rvo.19.1199523444518;
        Sat, 05 Jan 2008 00:57:24 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 5 Jan 2008 00:57:24 -0800 (PST)
In-Reply-To: <7vbq80d5yp.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69655>

On Jan 5, 2008 9:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> IOW, I do have much less objections to what your patch actually
> does, than I have problems with the way the reason for the
> change is stated.  The change is not fixing anything to conform
> to some standard behaviour.  It is more about bending
> (admittedly only slightly) backwards to help broken callers.
> That is what I have most trouble with.
>
>

Thanks for your understanding.

--------------------- CUT -----------------------------------

Subject: [PATCH] git-stash: use stdout instead of stderr for not error messages

Some scripts/libraries commonly check stderr to detect a
failing command. This is not standard nor good behaviour but
is quite common and in this case the change does not seem to hurt.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 git-stash.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 06cb177..4d5e5c0 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -86,7 +86,7 @@ save_stash () {

 	if no_changes
 	then
-		echo >&2 'No local changes to save'
+		echo 'No local changes to save'
 		exit 0
 	fi
 	test -f "$GIT_DIR/logs/$ref_stash" ||
@@ -99,7 +99,7 @@ save_stash () {

 	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
 		die "Cannot save the current status"
-	printf >&2 'Saved working directory and index state "%s"\n' "$stash_msg"
+	printf 'Saved working directory and index state "%s"\n' "$stash_msg"
 }

 have_stash () {
@@ -229,7 +229,7 @@ create)
 	if test $# -eq 0
 	then
 		save_stash &&
-		echo >&2 '(To restore them type "git stash apply")' &&
+		echo '(To restore them type "git stash apply")' &&
 		git-reset --hard
 	else
 		usage
-- 
1.5.4.rc2.18.g530e6-dirty
