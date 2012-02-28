From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] commit: allow {--amend|-c foo} when {HEAD|foo} has
 empty message
Date: Tue, 28 Feb 2012 09:25:34 -0800
Message-ID: <7vmx8227ld.fsf@alter.siamese.dyndns.org>
References: <20120228091422.GC5757@sigill.intra.peff.net>
 <010901fbfffe0f806bb19d556ebc1e512a4697f4.1330425111.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 28 18:25:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Qo2-0007jb-2t
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 18:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263Ab2B1RZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 12:25:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61347 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964770Ab2B1RZg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 12:25:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48DE6644C;
	Tue, 28 Feb 2012 12:25:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+xRLOftWR+5KfjGSCpGmWeipTJc=; b=W1soTp
	MjNAoS/j9e0CumNbbj+fGNrHoJ4olL+VAF0BEAwM0TiXNLwNlkMoFM4S8PsKQv+S
	hpIUPgjG5d0PcURWTtmqdAoffMGlkIiYj8A27nx4ALZgf6d3Kt4DFg5EgA+vQrWn
	xbUjpOJv30gOVeaYEcz6CUYpRVETTrsSbZRfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pIxRX8PH0cGmaQNpbg0sZYS6qHzzXDUl
	8uB1KA/mtDWZfTaGAwqGD4NnC8CUf+VymPUfNuqgQJe2TZWja5nusTQLyPpJuL7h
	EkJd9mFPu6uXiyigXe/4SXUlvArdiun+waP5mcXbFfSn1SLRWr5hvejb30uvYG/R
	E08KakcYIYg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32F75644B;
	Tue, 28 Feb 2012 12:25:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95FBD644A; Tue, 28 Feb 2012
 12:25:35 -0500 (EST)
In-Reply-To: <010901fbfffe0f806bb19d556ebc1e512a4697f4.1330425111.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 28 Feb 2012 11:36:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 398C7DFA-6231-11E1-A97B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191747>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 3714582..5e9a832 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -690,7 +690,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		hook_arg1 = "message";
>  	} else if (use_message) {
>  		buffer = strstr(use_message_buffer, "\n\n");
> -		if (!buffer || buffer[2] == '\0')
> +		if (!buffer)
> +			die(_("commit object has invalid format"));

In line with my previous comment, I think this should be more like:

	if (!buffer) {
		static char v_o_i_d[] = "\n\n";
        	buffer = v_o_i_d;
                warning(_("commit lacks end-of-header. A broken Git emulation?"");
	}

The warning is of course optional.
