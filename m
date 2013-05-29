From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup! rebase: implement --[no-]autostash and rebase.autostash
Date: Wed, 29 May 2013 10:32:18 -0700
Message-ID: <7vzjvdu1y5.fsf@alter.siamese.dyndns.org>
References: <7vli6yydmv.fsf@alter.siamese.dyndns.org>
	<1369825880-8608-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 19:32:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhkEc-0001p9-4L
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 19:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791Ab3E2RcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 13:32:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34387 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932471Ab3E2RcV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 13:32:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C972022184;
	Wed, 29 May 2013 17:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y77zWHkSwCWrue6+o4Zvu9UGUQg=; b=Whm36z
	Uz6FnFwaxdy7xVbJUicYY6ArIjf2WXj2UAf5Hn5ILJnAnC4pQLuWTBY27MytSve1
	QmnfIfDmfNqsPPZSfWB43AoMTDz1h2Qi//VaITtNLg37JwLEYqmbYsZz5Ju4zJq3
	5vy5c+7SJZL+atHbm5fHj0t3sGkGyuKRN6+eM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X3C16Le6hD8f8cQM20Z1hBZGEIpoKXQd
	a5OlWMox7qmE+Nb00AIZ2Ot85fi5M8G4C//NcyB3o6EWuu0IY8dYxcZZo7rmKhGw
	khxdYDLDOwpM2AXb1KU07aCZuOh2PmiPF3DdxH9iF1so3gdxhppbuV0rHXYyox3e
	EGu8KN0CvEw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE36222183;
	Wed, 29 May 2013 17:32:20 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE98522180;
	Wed, 29 May 2013 17:32:19 +0000 (UTC)
In-Reply-To: <1369825880-8608-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Wed, 29 May 2013 16:41:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6D0F528-C885-11E2-B5AD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225848>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> For rr/rebase-autostash, which is stalled in pu.  See $gmane/225689.
>
> This is a super-minor fix anyway: if you disagree with something, change
> it; there's no need to ask me.

As I wasn't the one who were disagreeing, that would not work
well.

Was there anybody "disagreeing" in the first place?  I thought
everybody was helping the series to get better.

>  git-rebase.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 709ef6b..5906757 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -151,16 +151,16 @@ finish_rebase () {
>  		stash_sha1=$(cat "$state_dir/autostash")
>  		if git stash apply $stash_sha1 2>&1 >/dev/null
>  		then
> -			echo "Applied autostash"
> +			echo "$(gettext 'Applied autostash.')"
>  		else
>  			ref_stash=refs/stash &&
>  			: >>"$GIT_DIR/logs/$ref_stash" &&
>  			git update-ref -m "autostash" $ref_stash $stash_sha1 \
>  				|| die "$(eval_gettext 'Cannot store $stash_sha1')"
> -			echo "
> -$(gettext 'Applying autostash resulted in conflicts.
> +			gettext 'Applying autostash resulted in conflicts.
>  Your changes are safe in the stash.
> -You can apply or drop it at any time.')"
> +You can run "git stash pop" or "git stash drop" it at any time.
> +'
>  		fi
>  	fi
>  	git gc --auto &&
