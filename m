From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: Add --include-untracked option to stash and
 remove all untracked files
Date: Sun, 26 Jun 2011 13:02:22 -0700
Message-ID: <7vliwoz7ht.fsf@alter.siamese.dyndns.org>
References: <vpqei2jj7jl.fsf@bauges.imag.fr>
 <1308963366-1697-1-git-send-email-david@porkrind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Caldwell <david@porkrind.org>
X-From: git-owner@vger.kernel.org Sun Jun 26 22:04:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QavZH-0001GD-L2
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 22:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933Ab1FZUDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 16:03:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208Ab1FZUCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 16:02:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0FB085744;
	Sun, 26 Jun 2011 16:04:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ukhHQ3AR2aydWrb6Mt1LE/0b4NI=; b=kMZXSe
	YCM/sRQAZAoDWftshfyY1lICqf6Z3gDNABmK6JUaRh8hxx6sGm4JlaQpDjzJwSU4
	mqY2NVVEWi1xjV6DccuLU7sW4sPDuCagWdy2fHNHn91F02kUxLZ9A3aGzSTO949L
	qvTfZ7XguHPD4c0SNznCFZc5UJgM6K+dpoGz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c41K1BtSl98lkVLG+YuX6kEDK5K7xUG3
	7iolTHZqTnOcFa5WEnY8z/N1rQy20cHezvS+fIo+V2fcL2DUrQTNVTqQC6nLPBe4
	RbvILZxtWPlxlNpTtKSxKGrWvYuebrlnfwvy2aSrWagtDDpv2AiJCulkoEuVAL+V
	w9s2oTyfCEY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 06E135742;
	Sun, 26 Jun 2011 16:04:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6A9F75741; Sun, 26 Jun 2011
 16:04:36 -0400 (EDT)
In-Reply-To: <1308963366-1697-1-git-send-email-david@porkrind.org> (David
 Caldwell's message of "Fri, 24 Jun 2011 17:56:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8449DCE4-A02F-11E0-A1DD-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176330>

David Caldwell <david@porkrind.org> writes:

> @@ -49,6 +57,7 @@ clear_stash () {
>  
>  create_stash () {
>  	stash_msg="$1"
> +	untracked="$2"

Hmm...

> @@ -173,7 +213,7 @@ save_stash () {
>  	test -f "$GIT_DIR/logs/$ref_stash" ||
>  		clear_stash || die "Cannot initialize stash"
>  
> -	create_stash "$stash_msg"
> +	create_stash "$stash_msg" $untracked

Just a minor nit from internal API point of view, I would prefer to see
something like

	create_stash --untracked=all "message"

or even

	create_stash --untracked=all --message="message"

once you start enriching these functions with optional behaviour.
