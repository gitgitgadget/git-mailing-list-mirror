From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-quiltimport.sh: disallow fuzz
Date: Fri, 26 Sep 2014 14:02:18 -0700
Message-ID: <xmqq4mvu859h.fsf@gitster.dls.corp.google.com>
References: <20140924213512.GA7619@logfs.org>
	<xmqqwq8sb81e.fsf@gitster.dls.corp.google.com>
	<20140925220831.GA14433@logfs.org>
	<xmqq7g0r9v04.fsf@gitster.dls.corp.google.com>
	<xmqq1tqz9uhm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?J=C3=B6rn?= Engel <joern@logfs.org>
X-From: git-owner@vger.kernel.org Sat Sep 27 00:20:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXdsh-0006LH-7T
	for gcvg-git-2@plane.gmane.org; Sat, 27 Sep 2014 00:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934AbaIZWUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 18:20:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57025 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755574AbaIZWUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2014 18:20:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D59E3DD63;
	Fri, 26 Sep 2014 18:20:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uey1bVD61oFdIMbCncL8q1Cn3GU=; b=pQdNzf
	8JL31sQZuLjOQZ08ob8rlUj7500WAoqqF1ames0cAcjDzDIOUKaqtXMHJBJxoBdJ
	vy3Wbn0uBC72V1rk3dmgM8n/9mBKN6/O5uDAq71f3v+JOdg2G/3tBdTaNubH9nad
	aqbcpi1eWpHrxXSvJUgH6xqXg1ghpXZqHmtO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pvAYNVVji/MvW0kNorEldmFzpNjVLSkd
	4/NGQbmxrRip/riUqTIfXfUXRugnta2kbC3Hqxtrp6T0vL4LwK1zHsWFVDR7Lm9W
	pr5RTmHhjHm7wMMZGDNJJrRAKmBUNGp9dyNlR3Ay6EIF2X/t2AEcO4Lntn3O2LzU
	SgyZCnT2KKM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E4803DD61;
	Fri, 26 Sep 2014 18:20:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5315D3C470;
	Fri, 26 Sep 2014 17:02:20 -0400 (EDT)
In-Reply-To: <xmqq1tqz9uhm.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 25 Sep 2014 15:59:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 67AEEB8A-45C0-11E4-9F0F-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257552>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps like this, with some documentation added (do we have/need
> any test???).
>
> -- >8 --
> Date: Thu, 25 Sep 2014 18:08:31 -0400
> Subject: [PATCH] git-quiltimport.sh: allow declining fuzz with --exact option

And on top of that change, if somebody really wants to enforce
stricter check by default, I think we could do something like this.

Obviously not tested at all, as I do not care too deeply myself ;-)

-- >8 --
Subject: [PATCH] git-quiltimport: flip the default not to allow fuzz

Trying to be as strict as possible when applying the patch may be a
good discipline, so let's flip the default but we can be helpful to
those who do rely on the original behaviour thanks to the previous
change to add -C$n option.

Suggest using -C1 when:

 - "git apply" without fuzz fails to apply; and
 - the user did not specify a -C$n or --exact option; and
 - "git apply -C1" (old behaviour) would have succeeded.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-quiltimport.sh | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 929365f..01de26d 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -15,7 +15,8 @@ SUBDIRECTORY_ON=Yes
 
 dry_run=""
 quilt_author=""
-cflag=-C1
+cflag=
+fuzz_specified=
 while test $# != 0
 do
 	case "$1" in
@@ -31,9 +32,11 @@ do
 		*) ;;
 		esac
 		cflag="-C$1"
+		fuzz_specified=yes
 		;;
 	--exact)
 		cflag=
+		fuzz_specified=yes
 		;;
 	-n|--dry-run)
 		dry_run=1
@@ -74,6 +77,25 @@ tmp_msg="$tmp_dir/msg"
 tmp_patch="$tmp_dir/patch"
 tmp_info="$tmp_dir/info"
 
+# Helper to warn about -C$n option
+do_apply () {
+	if git apply --index $cflag "$@"
+	then
+		return
+	fi
+	if test -z "$fuzz_specified" &&
+	   git apply --check --index -C1 "$@" >/dev/null 2>&1
+	then
+		cat >&2 <<-\EOM
+		'git quiltimport' by default no longer attempts to apply
+		patches with reduced context lines to allow fuzz; if you
+		want the old 'unsafe' behaviour, run the command with -C1
+		option.
+		EOM
+
+	fi
+	return 1
+}
 
 # Find the initial commit
 commit=$(git rev-parse HEAD)
@@ -145,7 +167,7 @@ do
 	fi
 
 	if [ -z "$dry_run" ] ; then
-		git apply --index $cflag ${level:+"$level"} "$tmp_patch" &&
+		do_apply ${level:+"$level"} "$tmp_patch" &&
 		tree=$(git write-tree) &&
 		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tree $tree -p $commit) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
-- 
2.1.1-394-g5293c25
