From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: configure submodules
Date: Mon, 24 Sep 2012 11:34:19 -0700
Message-ID: <7vlifzz2vo.fsf@alter.siamese.dyndns.org>
References: <1348385867-17359-1-git-send-email-orgads@gmail.com>
 <7vr4pt16ep.fsf@alter.siamese.dyndns.org> <505F5151.2080208@web.de>
 <7vmx0g0xpm.fsf@alter.siamese.dyndns.org>
 <7v39271j3n.fsf@alter.siamese.dyndns.org> <5060A32D.1060902@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad Shaneh <orgads@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:34:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGDUP-0001Po-TG
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 20:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757650Ab2IXSeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 14:34:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42185 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757756Ab2IXSeW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 14:34:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 749CB99F2;
	Mon, 24 Sep 2012 14:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9onGhKeE2ZS43gRhzdPXOH8Du4Y=; b=Ensv9x
	qfzd0mZY39JyQNHYnlNkZorahbnhexvArIE9vfa4/dkeBrT4NT0wLH5zf4nVvvTs
	c3GpIiUBbFY9MmJPbVmabHxsHo9VUJH5VMcn+WcK6Q96WeeTxMKhxg16ZmL/sKXC
	wEFTL7feSdqWpD/9JxKcnVvmKfn1MzqjKIFb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nU1T3p0ZyImi3yh9zTxqFCQbCIurJTuN
	zkOi/L/ddchxEY8unO6p+9EW/xKY4u9VGDB4q6ZumBHoQFnMl9Gm0wLmho17539Y
	/8fVhvX44bQ7fF6s8KpPdiZ9s29dyrXaYooPQpec403JBe5oEexGh6zS5yOl63yI
	+QNn0CiY8vM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61B1A99F1;
	Mon, 24 Sep 2012 14:34:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAA6799F0; Mon, 24 Sep 2012
 14:34:20 -0400 (EDT)
In-Reply-To: <5060A32D.1060902@web.de> (Jens Lehmann's message of "Mon, 24
 Sep 2012 20:15:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74A9A766-0676-11E2-92AF-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206306>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 24.09.2012 18:27, schrieb Junio C Hamano:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> In any case, the log message I suggested in the review needs to be
>>> updated in the reroll to make it clear that this is about reading
>>> from .gitmodules, not "configuration".  AFAICS, gitmodule_config()
>>> does not even read from $GIT_DIR/config, right?
>> 
>> OK.  gitmodule_config() does not read $GIT_DIR/config, but
>> cmd_status() and cmd_commit() call git_diff_basic_config() that is
>> called from git_diff_ui_config() to read submodule.$name.ignore from
>> it.  So Orgad's patch is _only_ about submodule.$name.ignore that is
>> in in-tree .gitmodule; the log message shouldn't mention "config",
>> as setting configuration variables work for both status and commit
>> just fine.
>
> Yes, I was just checking that call path too to make sure the user
> settings from $GIT_DIR/config really override those found in
> .gitmodules. And of course you are right, while the change to the
> code is sane the commit message still needs some work.

Here is what I tentatively queued on 'pu' (not pushed out yet).

-- >8 --
From: Orgad Shaneh <orgads@gmail.com>
Date: Sun, 23 Sep 2012 09:37:47 +0200
Subject: [PATCH] commit: pay attention to submodule.$name.ignore in
 .gitmodules

"git status" does not list a submodule with uncommitted working tree
files as modified when "submodule.$name.ignore" is set to "dirty" in
in-tree ".gitmodules" file.  Both status and commit honor the setting
in $GIT_DIR/config, but "commit" does not pick it up from .gitmodules,
which is inconsistent.

Teach "git commit" to pay attention to the setting in .gitmodules as
well.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..3cb1ef7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1256,6 +1256,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct wt_status s;
 
 	wt_status_prepare(&s);
+	gitmodules_config();
 	git_config(git_commit_config, &s);
 	in_merge = file_exists(git_path("MERGE_HEAD"));
 	s.in_merge = in_merge;
-- 
1.7.12.1.441.g794a63b
