From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/16] refs: add methods for misc ref operations
Date: Fri, 11 Dec 2015 15:39:58 -0800
Message-ID: <xmqqmvtgd06p.fsf@gitster.mtv.corp.google.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	<1449102921-7707-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 00:40:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7XIR-0006pQ-IJ
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 00:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbbLKXkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 18:40:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55854 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751591AbbLKXkM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 18:40:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF517339AB;
	Fri, 11 Dec 2015 18:40:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VPPje0+uh43fRUmwzyT4BcXMy8s=; b=R+N9WW
	9TQe9ZTpTI7fWbLAb+Gs+lR/inzlijPeOS2+2aZlmNXDzoI6SXBSMDRIA83JtFlk
	QAsO1GRWHC7Zki81wS9jKxK/HjG0veIQz4lmdWrwV0s6R7EyIDHhMzwc0Od1mt19
	UtHK4YUHuLLybBK0D8SjPBEXkaUig85vH2BaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H1PsqBsVUjr+R6UPM+lmT/sas4o1vi9F
	1UbLlLVaiuBOVbQrZBU3x35yRe/eKRUOEVH3iNIfh5V1yB8NiquxBtPKkZdfxFPt
	ca9hNrvBSEg2kv+BcUOS34zTz5bUACU8WA1AtCrHSCFBovsaNTNYeFP6z+vo5pmR
	HGqBsyktyJs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B75C1339A9;
	Fri, 11 Dec 2015 18:40:11 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1CFCD339A8;
	Fri, 11 Dec 2015 18:40:11 -0500 (EST)
In-Reply-To: <1449102921-7707-3-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 2 Dec 2015 19:35:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 84E123D4-A060-11E5-A886-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282287>

David Turner <dturner@twopensource.com> writes:

>  struct ref_be {
>  	struct ref_be *next;
>  	const char *name;
>  	ref_transaction_commit_fn *transaction_commit;
> +
> +	pack_refs_fn *pack_refs;
> +	peel_ref_fn *peel_ref;
> +	create_symref_fn *create_symref;
> +
> +	resolve_ref_unsafe_fn *resolve_ref_unsafe;
> +	verify_refname_available_fn *verify_refname_available;
> +	resolve_gitlink_ref_fn *resolve_gitlink_ref;
>  };

This may have been pointed out in the previous reviews by somebody
else, but I think it is more customary to declare a struct member
that is a pointer to a customization function without leading '*',
i.e.

	typedef TYPE (*customize_fn)(ARGS);

        struct vtable {
		...
        	cutomize_fn fn;
		...
	};

in our codebase (cf. string_list::cmp, prio_queue::compare).
