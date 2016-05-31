From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git reset --hard with staged changes
Date: Mon, 30 May 2016 23:02:03 -0700
Message-ID: <xmqqvb1u7okk.fsf@gitster.mtv.corp.google.com>
References: <loom.20160523T023140-975@post.gmane.org>
	<CAP8UFD0dQGmfhPuHjEGRZjEZHwUHR_XzAASwq+87Obf26yi+BQ@mail.gmail.com>
	<xmqqeg8s8og8.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0yB8XjUi0f2OTUrW9W1UPC_ekY3+8--CC5rk_5RciYAA@mail.gmail.com>
	<4067AC3B-D369-4E86-9EB9-ED19FD362E2D@yotamgingold.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>
To: Yotam Gingold <yotam@yotamgingold.com>
X-From: git-owner@vger.kernel.org Tue May 31 08:02:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7ckm-0006Je-TG
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 08:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbcEaGCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 02:02:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54584 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751288AbcEaGCH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 02:02:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76D1421D45;
	Tue, 31 May 2016 02:02:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q1w0IHM6FXHAEbCNR8IlJSp2oF4=; b=Nr9Dbx
	MrPVp/J5ge+R7ui1p/M7LdLAHm/GCRO2Uw+A9AaPzsX2l8k9BtGvlIC2OeisyDE5
	dFEcL6ft/JAYl8yWRzKduRmLK/ZqqjkVPA7QLwC2BEM67lxHHSO4Yz/AdHnlIHBx
	/EPMK2+Hj3ZiL9ipyrkDKQQUq3tOOQ5zGYlcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fgvnt3yhMPBphaO8W4cRThnN0Ot73wNI
	9Eu0rYDYNnkUW4vV2UAYJuZITb04FJNpyy5ZsFQogON6sMjCWHweG3u4kDQpLHl7
	pepzEhJt/LyvDO3FtmehIX5aC1LySXwGPJaWcFEJvtAr8j6j+CXWOy2kCA+OHvVR
	XyMPybHi8n8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 700FA21D44;
	Tue, 31 May 2016 02:02:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF24021D43;
	Tue, 31 May 2016 02:02:04 -0400 (EDT)
In-Reply-To: <4067AC3B-D369-4E86-9EB9-ED19FD362E2D@yotamgingold.com> (Yotam
	Gingold's message of "Mon, 30 May 2016 01:07:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 333D6D1E-26F5-11E6-B1CA-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295953>

Yotam Gingold <yotam@yotamgingold.com> writes:

> I read Junio's enumerations of the situations, and I appreciate that the
> current behavior of git reset --hard cannot be changed because of the
> many tools that rely on the current behavior. After reading it, I have
> modified my proposed amendment to the git reset --hard documentation:
>
>     A file is considered tracked if it exists in a prior commit or in the
>     staging area. Note that a newly added file not in any prior commit will be
>     removed. This is useful for aborting a failed merge.
>
> Shall I submit a patch?

I think the root cause of the confusion is that the description of
"reset --hard" uses an undefined word "tracked", which does not
appear anywhere else in "git reset --help".

A better rewrite is probably a one that does not to use such a fuzzy
word that is not even in official Git lingo (there is no glossary
entry for it).

 Documentation/git-reset.txt | 10 ++++++++--
 t/perf/perf-lib.sh          |  4 +++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 25432d9..c4cc035 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -65,8 +65,14 @@ If `-N` is specified, removed paths are marked as intent-to-add (see
 linkgit:git-add[1]).
 
 --hard::
-	Resets the index and working tree. Any changes to tracked files in the
-	working tree since <commit> are discarded.
+	Reset the index and the working tree to be identical to the
+	tree of the given <commit> (defaults to HEAD) by discarding
+	the changes made to them relative to <commit>.  Paths
+	modified in the index and in the working tree are reset to
+	what is recorded in <commit>.  Paths removed in the working
+	tree and in the index are resurrected from <commit>.  Paths
+	added to the index and the working tree since <commit> are
+	removed.
 
 --merge::
 	Resets the index and updates the files in the working tree that are
