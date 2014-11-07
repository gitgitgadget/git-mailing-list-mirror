From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore submodules
Date: Fri, 07 Nov 2014 11:20:10 -0800
Message-ID: <xmqqh9yag6mt.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 07 20:20:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmp58-0001ws-KD
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbaKGTUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:20:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54436 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753086AbaKGTUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:20:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 87FA31C720;
	Fri,  7 Nov 2014 14:20:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1e4oXUIY4G+0+MTpmzN9H1gWYxM=; b=QYnB8N
	qU6kNYfxtUCUXV+jyiakQqaEd0tl9n4CebLzgjruOd+W+1ehRVRbL5jr/1/BKiIM
	EGi74qSkl9wt6gvDUCsJwe71uEhzx6uPjq3LICAv/vhKnMAsajNWfOZJaz4M2Ckn
	4m1Hb+P5uOSlMCxRGWFnBQYEZdJSyn53/vsXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SDFzD1sK3Fuc/O9zkJUIfyPRLooeedMV
	3BF2Y/urUs/px4E2euMPimVS3EWlRQ18urZLZ9em5n7Rnda9AqZD/WyNpkscDEm0
	v4+1puamb7VU23KTY2mOCXs5CoQ1NmH1fXf7NFCrEQ40YSJaT7BxEJw+3MQBAgJS
	J8Eaj3VuBQg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C9C71C71E;
	Fri,  7 Nov 2014 14:20:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1A341C717;
	Fri,  7 Nov 2014 14:20:11 -0500 (EST)
In-Reply-To: <84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 7 Nov 2014 14:58:22 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 18186704-66B3-11E4-8536-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> They are not affected by the update anyway.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/receive-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index be4172f..4ba51df 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -740,7 +740,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
>  static void merge_worktree(unsigned char *sha1)
>  {
>  	const char *update_refresh[] = {
> -		"update-index", "--refresh", NULL
> +		"update-index", "--ignore-submodules", "--refresh", NULL
>  	};
>  	const char *read_tree[] = {
>  		"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL

I suspect that you did not squash this into 1/2 on purpose, and I am
guessing the reason is because you were unsure what should happen
when there were differences in submodules' working trees (otherwise,
you would have simply squashed without "oops it was a thinko to
forget passing this option" as a separate patch).  I am not sure
either.

By the way, if the expected use case of updateInstead is what I
outlined in the previous message, would it make more sense not to
fail with "update-index --refresh" failure (i.e. the working tree
files have no changes since the index)?

Thinking about it a bit more, checking with "update-index --refresh"
feels doubly wrong.  You not just want the working tree files to be
pristine with respect to the index, but also you do not want to see
any change between the index and the original HEAD, i.e.

	$ git reset --hard && echo >>Makefile ; git add Makefile
        $ git update-index --refresh ; echo $?
        0

this is not a good state from which you would want to update the
working tree.

Wouldn't the two-tree form "read-tree -u -m" that is the equivalent
to branch switching do a sufficient check?

Also, regarding the new calls to die() in the main patch, shouldn't
they just be returning the error reason in string form, just like
DENY_REFUSE returns "branch is currently checked out" to signal a
push failure to the caller?
