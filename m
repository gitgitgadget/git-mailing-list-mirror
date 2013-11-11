From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/10] transport-helper: updates
Date: Mon, 11 Nov 2013 15:37:15 -0800
Message-ID: <xmqq38n2jys4.fsf@gitster.dls.corp.google.com>
References: <1384210507-26561-1-git-send-email-felipe.contreras@gmail.com>
	<1384210507-26561-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 00:37:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg12r-00068J-KH
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 00:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab3KKXhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 18:37:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36167 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369Ab3KKXhV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 18:37:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C362A51475;
	Mon, 11 Nov 2013 18:37:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xHBuAJCANr0u57j92OjAdzYbVqI=; b=RHl+7w
	njmuaGNwoSGChYTAVk689tXQ4LqQ8DNft0SFUWdjJptuEJoFgyoXgO1mJvM7G28E
	HzELpt/2NQBtxOZRGkOykphEzRGNs5ldpP8N93+bmdm2PvtpSrrW0Tztk5h+8z4O
	PpzyxKjL0L/XXnK2y4oxoJzBj/YuFlPpLz4iY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vt5jzIhXcwYDh5sYQNRRO8fq0//pIbwX
	+0jtS51BCNnIS6FQTbBueBxdkW9LWOJJ8xRpirf6IHAv04r8nYfTm9Dmb5T3a2H0
	fLyVdEcIdccWdQOPurQ6XqqxzaIfV67jYc3S4GjhLmoR36sv8CXnOpE3fA8Cn8xH
	cm0c37HMRfg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4F6951474;
	Mon, 11 Nov 2013 18:37:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C938551473;
	Mon, 11 Nov 2013 18:37:18 -0500 (EST)
In-Reply-To: <1384210507-26561-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 11 Nov 2013 16:54:58 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 343C29CA-4B2A-11E3-A1D0-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237679>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Small changes since v5:
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 8ed41b4..4b76222 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -736,9 +736,10 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>  		usage_with_options (fast_export_usage, options);
>  
>  	if (refspecs_list.nr) {
> -		const char *refspecs_str[refspecs_list.nr];
> +		const char **refspecs_str;
>  		int i;
>  
> +		refspecs_str = xmalloc(sizeof(*refspecs_str) * refspecs_list.nr);
>  		for (i = 0; i < refspecs_list.nr; i++)
>  			refspecs_str[i] = refspecs_list.items[i].string;
>  
> @@ -746,6 +747,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
>  		refspecs = parse_fetch_refspec(refspecs_nr, refspecs_str);
>  
>  		string_list_clear(&refspecs_list, 1);
> +		free(refspecs_str);
>  	}
>  
>  	if (use_done_feature)
> diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
> index 716aa4c..1c006a0 100755
> --- a/git-remote-testgit.sh
> +++ b/git-remote-testgit.sh
> @@ -15,6 +15,8 @@ test -z "$refspec" && prefix="refs"
>  
>  export GIT_DIR="$url/.git"
>  
> +force=
> +
>  mkdir -p "$dir"
>  
>  if test -z "$GIT_REMOTE_TESTGIT_NO_MARKS"

Looking good, modulo a few minor nits I noticed while comparing with
the one that has been queued in 'pu', which I commented separately.

Will re-queue.  Thanks.
