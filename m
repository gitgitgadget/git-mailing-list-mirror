From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: Use args as pathspec to unmerged files
Date: Fri, 16 Sep 2011 13:17:10 -0700
Message-ID: <7vaaa4fdix.fsf@alter.siamese.dyndns.org>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
 <7vipox2wd6.fsf@alter.siamese.dyndns.org>
 <D3CA81F2-647B-4AD0-A4FC-4C22772FD791@JonathonMah.com>
 <7vsjnysuyl.fsf@alter.siamese.dyndns.org>
 <C5AD8BFC-DA48-4CE9-B821-D0076825F33C@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dan McGee <dpmcgee@gmail.com>,
	David Aguilar <davvid@gmail.com>
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 22:17:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4eqm-000403-Fy
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 22:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267Ab1IPURO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 16:17:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754413Ab1IPURN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 16:17:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A789450C1;
	Fri, 16 Sep 2011 16:17:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=juPvi97RGO3sJFibjcZRsGtZOAw=; b=C7BteT
	/wQnhPRTtLTryl7QKINJjUOJ43RgTSqinMT4KwDErgXn9xf6bLFdYmxGFTi16sjD
	hWG9qPfGHcEIPrVbwdlEPkNdYBkOV7UsMZNYs++Es1O6mt/3450lgj10/eFS+ni+
	sq6CnK/SbLbi/1kW1/squzAE1D1lZDs6JlJK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PfifIg8Cu4IiOQvDDQfmqWN1q6MZxpvz
	V/Vmw5oz6oNWJrxIn6LjSZp/qObUVGajbDJwswEo+S8rm/KhnJTYzekrknm7+7mH
	PJlzVs63Ll4FomEUHOPQgXil7oF8+og/haYubAajOid2aHK/Yj6jXdolrFM1ah0t
	m9kiPwU7Vyc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E77F50BF;
	Fri, 16 Sep 2011 16:17:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 280FA50BE; Fri, 16 Sep 2011
 16:17:12 -0400 (EDT)
In-Reply-To: <C5AD8BFC-DA48-4CE9-B821-D0076825F33C@JonathonMah.com> (Jonathon
 Mah's message of "Thu, 15 Sep 2011 19:12:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC9C9C22-E0A0-11E0-AF89-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181549>

Jonathon Mah <me@JonathonMah.com> writes:

> Mergetool now treats its path arguments as a pathspec (like other git
> subcommands), restricting action to the given files and directories.
> Files matching the pathspec are filtered so mergetool only acts on
> unmerged paths; previously it would assume each path argument was in an
> unresolved state, and get confused when it couldn't check out their
> other stages.
>
> Running "git mergetool subdir" will prompt to resolve all conflicted
> blobs under subdir.
>
> Signed-off-by: Jonathon Mah <me@JonathonMah.com>

It looks like this simplifies the code quote a bit and make the result
easier to follow ;-)  Nicely done.

As nobody reads from a pipe in while loop and runs merge_file or prompt
inside, there no longer is a reason to redirect the original standard
input and make it available, hence we could perhaps add this patch on top
of your change.

Ack from mergetool/difftool folks?

Thanks.

 git-mergetool.sh |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 83551c7..0a06bde 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -362,20 +362,18 @@ if test -z "$files" ; then
     exit 0
 fi
 
-# Save original stdin
-exec 3<&0
-
 printf "Merging:\n"
 printf "$files\n"
 
 IFS='
-'; for i in $files
+'
+for i in $files
 do
     if test $last_status -ne 0; then
-	prompt_after_failed_merge <&3 || exit 1
+	prompt_after_failed_merge || exit 1
     fi
     printf "\n"
-    merge_file "$i" <&3
+    merge_file "$i"
     last_status=$?
     if test $last_status -ne 0; then
 	rollup_status=1
