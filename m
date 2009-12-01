From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_ref_states: strdup entries and free util in stale
 list
Date: Mon, 30 Nov 2009 16:21:57 -0800
Message-ID: <7viqcrbl22.fsf@alter.siamese.dyndns.org>
References: <0458f16c6ce906997aaf357c0c7368841ae83c36.1259625072.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 01:22:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFGVc-0004dR-CN
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 01:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbZLAAWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 19:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbZLAAWL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 19:22:11 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbZLAAWK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 19:22:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9183B84479;
	Mon, 30 Nov 2009 19:22:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bznN7uPvmdbPZfP2Oka+p31HVRI=; b=do7TXu
	BhsreXFnYA05qe5Fx5JSwPfN78f43wjU2TUm3c7PMZjM79/j0FgGqrqygChDQ2Ns
	Z1s1JkDCt3mBPQhal72ELV8pslL7d6ueactn/TtT2tbvcsADo3DQNMlLJMQ+N+YA
	EkdzwNfG5P226V8qpHP96TqfiYbOAJE/mdEZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q5G0oBZzKuwqRp7kxr9fgqu36zv8MTUm
	FYqSepxAYaJVHPtkJWqatGUknxuubqWkR5wtdazvVHRvhwwi/gZUDLLTwY5JU+bQ
	UXf3BaCETg7Xh5ZVKKnxaJ6Xji7ogwxAd8JUAAjiarZyegH6+q781erA42qF1agB
	vEuYrrdy3zI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F037F84474;
	Mon, 30 Nov 2009 19:22:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEC7084471; Mon, 30 Nov
 2009 19:21:59 -0500 (EST)
In-Reply-To: <0458f16c6ce906997aaf357c0c7368841ae83c36.1259625072.git.bert.wesarg@googlemail.com> (Bert Wesarg's message of "Tue\,  1 Dec 2009 00\:57\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F672CBE-DE0F-11DE-834F-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134155>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

Hmm, the Subject: matches what the code does, but nobody mentions why it
is necessary (iow, what breaks in the current code and what becomes better
if the patch is applied).  The blank space before your "S-o-b:" line is
for you to describe these things.

> ---
>  builtin-remote.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin-remote.c b/builtin-remote.c
> index 7916626..bb72e27 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> @@ -272,7 +272,9 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
>  			die("Could not get fetch map for refspec %s",
>  				states->remote->fetch_refspec[i]);
>  
> -	states->new.strdup_strings = states->tracked.strdup_strings = 1;
> +	states->new.strdup_strings =
> +	states->tracked.strdup_strings =
> +	states->stale.strdup_strings = 1;
>  	for (ref = fetch_map; ref; ref = ref->next) {
>  		unsigned char sha1[20];
>  		if (!ref->peer_ref || read_ref(ref->peer_ref->name, sha1))
> @@ -768,7 +770,7 @@ static void clear_push_info(void *util, const char *string)
>  static void free_remote_ref_states(struct ref_states *states)
>  {
>  	string_list_clear(&states->new, 0);
> -	string_list_clear(&states->stale, 0);
> +	string_list_clear(&states->stale, 1);
>  	string_list_clear(&states->tracked, 0);
>  	string_list_clear(&states->heads, 0);
>  	string_list_clear_func(&states->push, clear_push_info);
> -- 
> 1.6.6.rc0.253.g1ec3
