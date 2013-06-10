From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rebase -i: write better reflog messages for start
Date: Mon, 10 Jun 2013 11:32:31 -0700
Message-ID: <7v8v2hizpc.fsf@alter.siamese.dyndns.org>
References: <1370881332-9231-1-git-send-email-artagnon@gmail.com>
	<1370881332-9231-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 20:32:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um6tV-0002Rh-88
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 20:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab3FJSch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 14:32:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58257 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557Ab3FJScg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 14:32:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ABB426043;
	Mon, 10 Jun 2013 18:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M9tSmzA3e4lUOLFTPMYMea52IDk=; b=sa6h74
	KtqVLFA6t4QiC8J3cjaQKGZ7QaQTZR3w2IpBDWltn9tNyASrvjTBrwe3kZ9PtIWO
	jhvXC4Br/TVmVdHIydNBpzaVYOXwSHBj3Eyf1t9UNlYfZGZ4Qx5gdNlQvpuh2boq
	iTlgp453fi+DKt84zL24cpyqcMJvYOEKVXRqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mmz7mHcGbnKWNtJ9/hd9lVqEKE4lXGNJ
	AtsH7ID1PUDJhHY261tj8LX5c1rxyaYHKbVF8VtGqnTufJJegpRY4YcFZwt1UZKy
	aXxetLNbEqnS6d4wnHSHiBFptsC6roXLAXQzoStwYwpPge44GqoTuUNRo1uIlNEQ
	AhTVkw64Yik=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09A6226041;
	Mon, 10 Jun 2013 18:32:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EC112603F;
	Mon, 10 Jun 2013 18:32:33 +0000 (UTC)
In-Reply-To: <1370881332-9231-4-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Mon, 10 Jun 2013 21:52:12 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DA6F5D4-D1FC-11E2-B329-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227345>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Invoking 'git rebase -i' writes the following line to the reflog at the
> start of the operation:
>
>   rebase -i (start)
>
> This is not very useful.  Make it more informative like:
>
>   rebase -i (start): checkout master

Makes sense to me, at least within the scope of the patch context.

I am curious what breaks, though.

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-rebase--interactive.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 5822b2c..a05a6e4 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -837,6 +837,7 @@ comment_for_reflog start
>  
>  if test ! -z "$switch_to"
>  then
> +	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
>  	output git checkout "$switch_to" -- ||
>  		die "Could not checkout $switch_to"
>  fi
> @@ -980,6 +981,7 @@ has_action "$todo" ||
>  
>  test -d "$rewritten" || test -n "$force_rebase" || skip_unnecessary_picks
>  
> +GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
>  output git checkout $onto || die_abort "could not detach HEAD"
>  git update-ref ORIG_HEAD $orig_head
>  do_rest
