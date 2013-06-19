From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Wed, 19 Jun 2013 13:00:55 -0700
Message-ID: <7v38sdzx8o.fsf@alter.siamese.dyndns.org>
References: <1371640304-26019-1-git-send-email-artagnon@gmail.com>
	<1371640304-26019-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 22:01:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpOYw-0008Ex-FE
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 22:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362Ab3FSUA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 16:00:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756805Ab3FSUA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 16:00:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 401AE29AEB;
	Wed, 19 Jun 2013 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x3pcElC9PvGHsJcokf6BK/sHJDc=; b=H0BXkV
	vNTgxUkJtoNDjVjVHz6RE5OSfwhVDddkxpyBJr0pDFs3qsi8GpuwPMtmS6J4G1Yq
	YbK/jMr6XBdXzec+h/USbCGS6072MUrqDFTWOw5qeE2C8w+QebRE7v1R3o8cB0pO
	d9ZUZaXOQPmAo5hmUsDI5tScuqB+qJx74pcjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KF0ePU9sPiSz7tJdrvQjWn69NnBfqvEj
	RpXxTk9klXwEAqx2R+Ag0j4st18TL/20GzKzZPTtcQ7XYXC8pnXYSCvhblMqbr+j
	xedO/EGvUHycG6RkGwPOZHaWN3U4czvzyVE5LkF+JiV7usUByF8eHszze/NUWvqZ
	qMUxZEcqF+M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35F4629AEA;
	Wed, 19 Jun 2013 20:00:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DF8829AE6;
	Wed, 19 Jun 2013 20:00:56 +0000 (UTC)
In-Reply-To: <1371640304-26019-4-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 19 Jun 2013 16:41:41 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F447A50A-D91A-11E2-B33A-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228419>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> When remote.pushdefault or branch.<name>.pushremote is set (a triangular
> workflow feature), master@{u} != origin, and push.default is set to
> `upstream` or `simple`:
>
>   $ git push
>   fatal: You are pushing to remote 'origin', which is not the upstream of
>   your current branch 'master', without telling me what to push
>   to update which remote branch.
>
> Unfortunately, in the case of `upstream`, the very name indicates that
> it is only suitable for use in central workflows; let us not even
> attempt to give it a new meaning in triangular workflows, and error out
> as usual.

Sensible.

> However, the `simple` does not have this problem: it is poised to
> be the default for Git 2.0, and we would definitely like it to do
> something sensible in triangular workflows.
>
> Decouple `simple` from `upstream` completely, and change it to mean
> `current` with a safety feature: a `push` and `pull` should not be
> asymmetrical in the special case of central workflows.

Double negation confused my parser.  'push' and 'pull' should be
kept symmetrical in central workflows?

> +* `simple` - a safer version of `current`; push the current branch to
> +  update a branch with the same name on the receiving end, with a
> +  safety feature: in central workflows, error out if
> +  branch.$branch.merge is set and not equal to $branch,

If branch.$branch.merge is _not_ set, what happens in the current
code, and what should happen?

> + to make sure
> +  that a `push` and `push` are never asymmetrical.  It will become the
> +  default in Git 2.0.

Ditto.

>  * `matching` - push all branches having the same name on both ends
>    (essentially ignoring all newly created local branches).
> diff --git a/builtin/push.c b/builtin/push.c
> index 2d84d10..d8d27d9 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -120,6 +120,25 @@ static const char message_detached_head_die[] =
>  	   "\n"
>  	   "    git push %s HEAD:<name-of-remote-branch>\n");
>  
> +static void setup_push_simple(struct remote *remote)
> +{
> +	struct branch *branch = branch_get(NULL);
> +	if (!branch)
> +		die(_(message_detached_head_die), remote->name);

OK.

> +	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
> +		/* No upstream configured */
> +		goto end;

Without any configuration the current branch is pushed out, which
loosens the safety we implemented in the current 'safer upstream'.

I am not convinced this is a good change.  I am not convinced this is
a bad change, either, yet, but this loosening smells bad.

> diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
> index 69ce6bf..e54dd02 100755
> --- a/t/t5528-push-default.sh
> +++ b/t/t5528-push-default.sh
> @@ -85,7 +85,7 @@ test_expect_success 'push from/to new branch with current creates remote branch'
>  test_expect_success 'push to existing branch, with no upstream configured' '
>  	test_config branch.master.remote repo1 &&
>  	git checkout master &&
> -	test_push_failure simple &&
> +	test_push_success simple master &&
>  	test_push_failure upstream
>  '

Likewise.
