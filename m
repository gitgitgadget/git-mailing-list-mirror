Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2151C04FD0
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 18:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjITS2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 14:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITS2c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 14:28:32 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78974C9
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 11:28:27 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C62437D8C;
        Wed, 20 Sep 2023 14:28:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=zA36De8a/PMqRRbIrD0jAfMKRlgKylj9F1Mt+o
        AttSo=; b=tAUKSjpRr3nXjDlkQyTwbacH+EE0/RdkkGGVD0B35RmFLOeBOFo7T7
        bxvtMePLRqciRe6UI55JzTPWNVCVNUh5iKhvl2QtXsnV4K1tpudFfQrMyIZwsQW5
        u2CQzy3lSQa73ihOd+r+H2lPYVAm2iAdYfmEsOqXW8LcFssRchiME=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 14FBD37D8B;
        Wed, 20 Sep 2023 14:28:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A13B537D89;
        Wed, 20 Sep 2023 14:28:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] completion: loosen and document the requirement around
 completing alias
In-Reply-To: <pull.1585.v2.git.1694538135853.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Tue, 12 Sep 2023 17:02:15 +0000")
References: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>
        <pull.1585.v2.git.1694538135853.gitgitgadget@gmail.com>
Date:   Wed, 20 Sep 2023 11:28:22 -0700
Message-ID: <xmqqy1h08zsp.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B87D966-57E3-11EE-9564-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recently we started to tell users to spell ": git foo ;" with
space(s) around 'foo' for an alias to be completed similarly
to the 'git foo' command.  It however is easy to also allow users to
spell it in a more natural way with the semicolon attached to 'foo',
i.e. ": git foo;".  Also, add a comment to note that 'git' is optional
and writing ": foo;" would complete the alias just fine.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * We've discussed this when we reviewed the topic that just hit
   'master'.  Before we forget...

 contrib/completion/git-completion.bash | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git c/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
index 47fd664ea5..477ef8157a 100644
--- c/contrib/completion/git-completion.bash
+++ w/contrib/completion/git-completion.bash
@@ -28,7 +28,8 @@
 # completion style.  For example '!f() { : git commit ; ... }; f' will
 # tell the completion to use commit completion.  This also works with aliases
 # of form "!sh -c '...'".  For example, "!sh -c ': git commit ; ... '".
-# Be sure to add a space between the command name and the ';'.
+# Note that "git" is optional --- '!f() { : commit; ...}; f' would complete
+# just like the 'git commit' command.
 #
 # If you have a command that is not part of git, but you would still
 # like completion, you can use __git_complete:
@@ -1183,7 +1184,7 @@ __git_aliased_command ()
 			:)	: skip null command ;;
 			\'*)	: skip opening quote after sh -c ;;
 			*)
-				cur="$word"
+				cur="${word%;}"
 				break
 			esac
 		done
