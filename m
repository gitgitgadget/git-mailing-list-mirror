From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] ignore unknown color configuration
Date: Tue, 15 Dec 2009 17:29:18 -0800
Message-ID: <7vy6l3vh8x.fsf@alter.siamese.dyndns.org>
References: <20091212122524.GA17547@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 02:29:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKihn-0007eo-Fb
	for gcvg-git-2@lo.gmane.org; Wed, 16 Dec 2009 02:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934395AbZLPB31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 20:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758153AbZLPB30
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 20:29:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44610 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756152AbZLPB3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 20:29:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B15C588D5B;
	Tue, 15 Dec 2009 20:29:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xDVdWi44F+J6Q4ejclf457nC4Fs=; b=vD3fgv
	4W2uexs0lfx33gdghT3qi70xVCmecYOwNICWi2YgLy2ZtoqP057OEDDosLaxP2Ip
	TP6pB06m1Mbmnnk2hKtdHimLhq+8xTfvzWL5XkRfnlARlKRqQr37UxSXM0fmiEC6
	SPV1BkJG0Pgs2cEGOXKAYXbTPXjjRqI6pEVSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SuwgTmFHkcb1JCM4ZN1xAvC2roIvkzkg
	+56IUc4WxeruAcru0WBLU70F6807mZujQQDWmIMa1VnqIwrbh2v2uHqSPE7oeuhn
	HAAp0ehCP61rRvxVkkPsXyrpjX26Q875cGtx2C9XbQ1QWyoO8p/Ker5gtcAb4xwA
	eHrFfv+r4AE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 88F2C88D59;
	Tue, 15 Dec 2009 20:29:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE51B88D55; Tue, 15 Dec
 2009 20:29:19 -0500 (EST)
In-Reply-To: <20091212122524.GA17547@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 12 Dec 2009 07\:25\:24 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7064C770-E9E2-11DE-AA61-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135315>

Jeff King <peff@peff.net> writes:

> diff --git a/builtin-branch.c b/builtin-branch.c
> index 05e876e..c87e63b 100644
> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -65,7 +65,7 @@ static int parse_branch_color_slot(const char *var, int ofs)
>  		return BRANCH_COLOR_LOCAL;
>  	if (!strcasecmp(var+ofs, "current"))
>  		return BRANCH_COLOR_CURRENT;
> -	die("bad config variable '%s'", var);
> +	return -1;
>  }
>  
>  static int git_branch_config(const char *var, const char *value, void *cb)
> @@ -76,6 +76,8 @@ static int git_branch_config(const char *var, const char *value, void *cb)
>  	}
>  	if (!prefixcmp(var, "color.branch.")) {
>  		int slot = parse_branch_color_slot(var, 13);
> +		if (slot < 0)
> +			return 0;
>  		if (!value)
>  			return config_error_nonbool(var);
>  		color_parse(value, var, branch_colors[slot]);
> diff --git a/builtin-commit.c b/builtin-commit.c
> index e93a647..326cd63 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -890,7 +890,7 @@ static int parse_status_slot(const char *var, int offset)
>  		return WT_STATUS_NOBRANCH;
>  	if (!strcasecmp(var+offset, "unmerged"))
>  		return WT_STATUS_UNMERGED;
> -	die("bad config variable '%s'", var);
> +	return -1;
>  }
>  
>  static int git_status_config(const char *k, const char *v, void *cb)
> @@ -910,6 +910,8 @@ static int git_status_config(const char *k, const char *v, void *cb)
>  	}
>  	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
>  		int slot = parse_status_slot(k, 13);
> +		if (slot < 0)
> +			return -1;

Shouldn't this return 0, to say "we handled it (by ignoring), don't
worry", instead of saying "hey it's error" by returning -1?  That's what
is done on the "diff" side below...

> diff --git a/diff.c b/diff.c
> index d952686..08bbd3e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -122,6 +122,8 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
>  
>  	if (!prefixcmp(var, "diff.color.") || !prefixcmp(var, "color.diff.")) {
>  		int slot = parse_diff_color_slot(var, 11);
> +		if (slot < 0)
> +			return 0;
>  		if (!value)
>  			return config_error_nonbool(var);
>  		color_parse(value, var, diff_colors[slot]);
