From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] status: show 'revert' state and status hint
Date: Tue, 02 Apr 2013 13:19:37 -0700
Message-ID: <7vobdwbs86.fsf@alter.siamese.dyndns.org>
References: <1364689848-52647-1-git-send-email-robin.rosenberg@dewire.com>
 <1364912422-29536-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Apr 02 22:20:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7gg-00077m-3G
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 22:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933252Ab3DBUTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 16:19:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34276 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761364Ab3DBUTk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 16:19:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 970951280F;
	Tue,  2 Apr 2013 20:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IjrHemPkz+OMtdEu8hbrHWUDG7A=; b=QGd7p+
	2mDVCGdmHPu5n0O50BFdwgaIVvamqI2FFI0XLVtH3fbrmkYnDzOReYqhlGtUnxtp
	5nxUkCk4y0Z3eXLfLu+Gx8/hF8WTgWK7z1kVfcGdxpzNU/75gLg7g4m21m9AlWFR
	3bFoKU2y//oqWbmSfXTWfnedba7uZozm/upw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v4TgxuiNBaxcFx9fyKXJ/NXJcII4a593
	pQgQ9wOJGFL3XKIzHS57a41o6R4W9eR5sX9I2dnhpCN/k02ry6MmW9xkjiqtp3zo
	sN794RDfOdhnzkL1/dPN2pPwbXWeMykLzmAI7q/bf0vYkO78Bd9LD2pVruTpqTMt
	pBBLRkJ+St0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AAD31280E;
	Tue,  2 Apr 2013 20:19:39 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B4F31280D; Tue,  2 Apr
 2013 20:19:38 +0000 (UTC)
In-Reply-To: <1364912422-29536-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Tue, 2 Apr 2013 16:20:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A52402DC-9BD2-11E2-858E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219877>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +static void show_revert_in_progress(struct wt_status *s,
> +					struct wt_status_state *state,
> +					const char *color)
> +{
> +	status_printf_ln(s, color, _("You are currently reverting a commit."));
> +	if (advice_status_hints) {
> +		if (has_unmerged(s))
> +			status_printf_ln(s, color,
> +				_("  (fix conflicts and run \"git revert --continue\")"));
> +		else
> +			status_printf_ln(s, color,
> +				_("  (all conflicts fixed: run \"git revert --continue\")"));
> +	}
> +	if (advice_status_hints)
> +		status_printf_ln(s, color,
> +			_("  (use \"git revert --abort\" to cancel the revert operation)"));

Why not a single conditional? i.e.

	if (advice_status_hints) {
		if unmerged
			fix and continue
		else
			say continue
		you can also say abort
	}

Will queue on 'pu', with an straight-forward "SQUASH???" on top.

Thanks.
