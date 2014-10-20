From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Copy mergetool "bc3" as "bc4"
Date: Mon, 20 Oct 2014 10:32:18 -0700
Message-ID: <xmqqtx2y3avx.fsf@gitster.dls.corp.google.com>
References: <1413803017-30489-1-git-send-email-ocroquette@free.fr>
	<xmqq7fzu4rve.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Olivier Croquette <ocroquette@free.fr>
X-From: git-owner@vger.kernel.org Mon Oct 20 19:32:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgGok-0002bu-0G
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 19:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbaJTRcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 13:32:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751102AbaJTRcV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 13:32:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E8991650F;
	Mon, 20 Oct 2014 13:32:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mbhRKkSMj/9gNJnYN5UqbinmLyc=; b=i9f87b
	DHSk6JDxOy4XxKRGqNt8BoxCzFq/ubiNA1bRdSwtaVbzPIo6THqsSEa/Glr5fXV4
	7tFRH4q7ELOiOtdo8LjlggQ/v6fxE6JG/p9lJ55qDkD0BwOFRyHRDplAiFquI/DW
	gVTF4jR/tMhPzCKmWOl8+0mmy2/zI7PMr5ZR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=agxtBtYuL2T+CPBwW7xoh3soVqXJlmRW
	2QBwt11uR9F70wRZyzkEmC+5tUHsWdIZu6QvgnfOXiBnTtp8bxDK91BAr2Ux044r
	lJF8HEj1YCwc/WghLmJCqXynLqtfNSOvYw/WkMRFOWN+NJJPPczpCPV503kDc/pn
	rvainAlOjWc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6379F1650E;
	Mon, 20 Oct 2014 13:32:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB61D1650D;
	Mon, 20 Oct 2014 13:32:19 -0400 (EDT)
In-Reply-To: <xmqq7fzu4rve.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 20 Oct 2014 09:40:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0B07D5FA-587F-11E4-BCD0-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Olivier Croquette <ocroquette@free.fr> writes:
>
>> Beyond compare 4 is out since september 2014. The CLI interface
>> doesn't seem to have changed compared to the version 3.
>
> Hmph, if this is identical to mergetools/bc3, why is the patch even
> needed?  Do we auto-detect something and try to use bc4 which does
> not exist and fail, and we must supply a copy as bc4 to prevent it?
>
> It may feel somewhat strange to have to say "mergetool --tool=bc3"
> when you know what you have is version 4 and not version 3, but in
> that case, I wonder if there are reasons why calling both versions
> just "bc" is a bad idea.  And assuming that version 5 and later
> would keep the same interface, we will not have to worry about that
> "I have version 7 why do I have to say 3?" if we can go that route.
>
> Perhaps version 2 and before are unusable as a mergetool backend or
> something?

It seems that ffe6dc08 (mergetool--lib: Add Beyond Compare 3 as a
tool, 2011-02-27) is the first mention of "Beyond Compare" and it
only was interested in version 3 and nothing else.

Perhaps something like this, so that existing users can still use
"bc3" and other people can use "bc" if it bothers them that they
have to say "3" when the backend driver works with both 3 and 4?

---
 contrib/completion/git-completion.bash |  2 +-
 git-mergetool--lib.sh                  |  2 +-
 mergetools/{bc3 => bc}                 |  0
 mergetools/bc3                         | 26 +-------------------------
 4 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d548e99..01259cc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1203,7 +1203,7 @@ _git_diff ()
 }
 
 __git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc3 codecompare
+			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc codecompare
 "
 
 _git_difftool ()
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index c45a020..1d8a26d 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -250,7 +250,7 @@ list_merge_tool_candidates () {
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
 		tools="$tools gvimdiff diffuse diffmerge ecmerge"
-		tools="$tools p4merge araxis bc3 codecompare"
+		tools="$tools p4merge araxis bc bc3 codecompare"
 	fi
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
diff --git a/mergetools/bc3 b/mergetools/bc
similarity index 100%
rename from mergetools/bc3
rename to mergetools/bc
diff --git a/mergetools/bc3 b/mergetools/bc3
dissimilarity index 100%
index b6319d2..5d8dd48 100644
--- a/mergetools/bc3
+++ b/mergetools/bc3
@@ -1,25 +1 @@
-diff_cmd () {
-	"$merge_tool_path" "$LOCAL" "$REMOTE"
-}
-
-merge_cmd () {
-	touch "$BACKUP"
-	if $base_present
-	then
-		"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" \
-			-mergeoutput="$MERGED"
-	else
-		"$merge_tool_path" "$LOCAL" "$REMOTE" \
-			-mergeoutput="$MERGED"
-	fi
-	check_unchanged
-}
-
-translate_merge_tool_path() {
-	if type bcomp >/dev/null 2>/dev/null
-	then
-		echo bcomp
-	else
-		echo bcompare
-	fi
-}
+. "$MERGE_TOOLS_DIR/bc"
