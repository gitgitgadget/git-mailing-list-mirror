From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] mergetool--lib: Improve the help text in
 guess_merge_tool()
Date: Sun, 27 Jan 2013 15:12:32 -0800
Message-ID: <7vehh6te3j.fsf@alter.siamese.dyndns.org>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
 <1359321886-80523-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 00:13:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzbPP-0006Pz-Gu
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 00:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756863Ab3A0XMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 18:12:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39596 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755707Ab3A0XMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 18:12:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49EE9BB20;
	Sun, 27 Jan 2013 18:12:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lewCUTsiMBejiIcIjdOHZi9ZWG8=; b=EtbLVG
	/TlPAhggAmjHvYUhz21nEn+YT8H0WLa0YRE6Uo3ZSG7/dmjSkXb4V/uycq1gyUYG
	Vhl2ZxaIV5G1j9WnF8ICtuxOQ2W0StUyYzqHrvnfshdABR2VtQ5pdIbRFLGNWaJz
	uH1E0t0SQu5YEzmuSqQniBbFkWw+s9SHYyx4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=haaxNTnsRikrHJpaltjtU3tDJWKCwc5Z
	W6XwZPwX/WlWkETHXaOD7/rswZrkgouq7eQmKnZebupdurR8t/LNYJdh29J2TRht
	WXZkihPr4viAtpXAypwo5DZ92Q0LAk7f2fsfdtjKKOd4H+PmT4gunwoS6IQ4gT/6
	wjQwuzokuj4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31081BB1E;
	Sun, 27 Jan 2013 18:12:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5AC4BB1A; Sun, 27 Jan 2013
 18:12:33 -0500 (EST)
In-Reply-To: <1359321886-80523-3-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sun, 27 Jan 2013 13:24:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 081709E0-68D7-11E2-B010-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214749>

David Aguilar <davvid@gmail.com> writes:

> This code path is only activated when the user does not have a valid
> configured tool.  Add a message to guide new users towards configuring a
> default tool.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-mergetool--lib.sh | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 9a5aae9..cf52423 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -240,7 +240,14 @@ show_tool_help () {
>  
>  guess_merge_tool () {
>  	list_merge_tool_candidates
> -	echo >&2 "merge tool candidates: $tools"
> +	msg="\
> +
> +This message is displayed because '$TOOL_MODE.tool' is not configured.
> +See 'git ${TOOL_MODE}tool --tool-help' or 'git help config' for more details.
> +'git ${TOOL_MODE}tool' will now attempt to use one of the following tools:
> +$tools
> +"
> +	printf "$msg" >&2

This is not wrong per-se, but wouldn't it be much easier to read to
use an indented HERE-text like this?

	cat >&2 <<-EOF
	... a long message with $var substitution ...
        ... comes here ...
        EOF
