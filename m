From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -e: ignore dirty submodules
Date: Tue, 07 Feb 2012 00:21:07 -0800
Message-ID: <7vk43z2gwc.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.00.1202070504340.24259@s15462909.onlinehome-server.info>
 <7vaa4v42fi.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1202070124020.4897@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 07 09:21:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RugIf-0004lx-0U
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 09:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755897Ab2BGIVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 03:21:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349Ab2BGIVK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 03:21:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC9772C41;
	Tue,  7 Feb 2012 03:21:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e7fRFblSmiiBlqyEyrZ821FUoXQ=; b=VnrwlS
	J5gV/uoOjN9bZ6IyzB/yjilM9zoC9/FBKYonLvdLdtsGw6/+BrkuFF87JF+wx39+
	AmVXOMiS42/z2kDqdxtwFJeRphrlqSnb2U7xgLqyVSsNyHLZF1Q9gqyfahX65z6g
	4gRh+AJ2txez6QvDtW9Ij9hwfEiR+Ngqj+4J8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aBcOG6hK/u/i1Mt3TYK3Qt+HImdPdKgh
	UoK0VtmV//mZgo8ITwdGi46zDnUpH7xXTqFU7WtwpoOFEh82HEWd/VC90lNFIQzI
	hfc8L+4rSK1DPFmyvA7QUM+Q+WgsxOSe2DHK/6kfOA7/KcZ7MvPyEdY3WqZu0Odc
	qCosTZhKm6c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2BAF2C40;
	Tue,  7 Feb 2012 03:21:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF9652C3F; Tue,  7 Feb 2012
 03:21:08 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1202070124020.4897@bonsai2> (Johannes
 Schindelin's message of "Tue, 7 Feb 2012 01:45:36 -0600 (CST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B00128CE-5164-11E1-89BC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190153>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Offering to add changes represented by a diff like
>
> diff --git <blub>
> <header>
> -deadbeef...
> +deadbeef...-dirty
>
> does not make sense.

Now you are being much clearer.  If you had the above from the beginning,
I wouldn't have had to ask.

So after all, this is a noise reduction patch, and I think that it is a
good change.

> Even a diff like
>
> diff --git <blah>
> <header>
> -deadbeef...
> -coffeebabe...-dirty
>
> would be refused by git-apply.

That would be refused, but if you replace '-coffeebabe' with '+coffeebabe',
which is what you would get from "git diff" without ignore-dirty-submodule,
I think it would be accepted by "git apply" just fine.

Have you tried it?

> I actually enjoyed writing this text so much, may I respectfully ask to
> include it verbatim in the commit message?

With mostly irrelevant mumblings and all?  Of course not.

I was asking what you meant to achieve with the patch, because you did not
even include relevant bits of information.

But now I think I learned what you meant by this patch, so let me try to
see if I understood it correctly by rephrasing it.

Like this?

-- >8 --
Subject: add -e: do not show difference in a submodule that is merely dirty
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date: Tue, 7 Feb 2012 05:05:48 +0100 (CET)

When the HEAD of the submodule matches what is recorded in the index of
the superproject, and it has local changes or untracked files, the patch
offered by "git add -e" for editing shows a diff like this:

    diff --git a/submodule b/submodule
    <header>
    -deadbeef...
    +deadbeef...-dirty

Because applying such a patch has no effect to the index, this is a
useless noise.  Generate the patch with IGNORE_DIRTY_SUBMODULES flag to
prevent such a change from getting reported.

This patch also loses the "-dirty" suffix from the output when the HEAD of
the submodule is different from what is in the index of the superproject.
As such dirtiness expressed by the suffix does not affect the result of
the patch application at all, there is no information lost if we remove
it. The user could still run "git status" before "git add -e" if s/he
cares about the dirtiness.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

 builtin/add.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 1c42900..b79336d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -280,6 +280,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+	DIFF_OPT_SET(&rev.diffopt, IGNORE_DIRTY_SUBMODULES);
 	out = open(file, O_CREAT | O_WRONLY, 0644);
 	if (out < 0)
 		die (_("Could not open '%s' for writing."), file);
