From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] git gui: allow for a long recentrepo list
Date: Thu, 17 Dec 2015 15:29:25 -0800
Message-ID: <xmqqbn9obqne.fsf@gitster.mtv.corp.google.com>
References: <2F62ABA2EE734F5F926C9E102969895F@PhilipOakley>
	<1450392007-600-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GitList <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Alexey Astakhov <asstv7@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Dec 18 00:29:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9hzJ-0002zS-Ah
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 00:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbbLQX33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 18:29:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752574AbbLQX32 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 18:29:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6AA1B3680F;
	Thu, 17 Dec 2015 18:29:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NUNSB+2WxvHoPBwFV/jd+uLw0tI=; b=aTgLKI
	sqXUQO5ixWs/FRTpi3EUd1X3BAWgnKTYOpdWMT/VM4KPBEEtqGmA6xxhKySRkp9C
	Yf1fNZSlejoaUejtcD9585bHwmiTnHuMrNngUfnHNbCrAUhvGI3eTky2SoOdI9QS
	1Fx3AenjC1ZDEbFMCBSJu1TX1oNOY4VB+YBX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rQT0+Vm6ylXoBxBj9jAk/xKzXtjdqFXm
	hNXHOzPLSGaPcubUVKqAU4HvcVCoRZwAmoFezdfuaFYWZBQ8aVU31+hPfhZHbIy3
	txsko47rRnlwOOmQIX981HZeU2R4ItknN5avY57JnY6CD+MGJnWNttn/zZMvQGdN
	AU7t8u9mKVQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 616433680E;
	Thu, 17 Dec 2015 18:29:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D2A693680D;
	Thu, 17 Dec 2015 18:29:26 -0500 (EST)
In-Reply-To: <1450392007-600-1-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Thu, 17 Dec 2015 22:40:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 035A616C-A516-11E5-92CC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282686>

Philip Oakley <philipoakley@iee.org> writes:

> The gui.recentrepo list may be longer than the maxrecent setting.
> Use the actual length determined earlier, now saved as $lenrecent.
>
> In an ideal world, the git gui would limit the number of entries
> to the maxrecent setting, however the recentrepo config list may
> have been extended outside of the gui, or the maxrecent setting changed
> to a reduced value. Further, when testing the gui's recentrepo
> logic it is useful to show these extra, but valid, entries.
>
> The list length will be trimmed to $maxrecent after the user selects
> a repo to open.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> V2:
> word usage corrected.
> Eric's comments $gmane/282432
> V3: 
> Updated list length measure following Junio's comments $gmane/282669
>
> Replaces the previous V2 Patch 4/4.
>
> ---
>  git-gui/lib/choose_repository.tcl | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
> index ad7a888..b4cc7dd 100644
> --- a/git-gui/lib/choose_repository.tcl
> +++ b/git-gui/lib/choose_repository.tcl
> @@ -134,7 +134,8 @@ constructor pick {} {
>  	$opts conf -state disabled
>  
>  	set sorted_recent [_get_recentrepos]
> -	if {[llength $sorted_recent] > 0} {
> +	set lenrecent [llength $sorted_recent]
> +	if {$lenrecent > 0} {
>  		if {$m_repo ne {}} {
>  			$m_repo add separator
>  			$m_repo add command \
> @@ -153,7 +154,7 @@ constructor pick {} {
>  			-background [get_bg_color $w_body.recentlabel] \
>  			-wrap none \
>  			-width 50 \
> -			-height $maxrecent
> +			-height $lenrecent
>  		$w_recentlist tag conf link \
>  			-foreground blue \
>  			-underline 1

Natural questions that come to mind after seeing the above are like
these:

 - Does maxrecent still get used after this change?

 - Does the remainder of the code get upset if -height is set to too
   small (lenrecent might turn out to be 1, for example)?

And grepping for maxrecent shows there is _append_recentrepos that
does this:

proc _append_recentrepos {path} {
	set path [file normalize $path]
	set recent [get_config gui.recentrepo]

	...
	if {[set maxrecent [get_config gui.maxrecentrepo]] eq {}} {
		set maxrecent 10
	}

	while {[llength $recent] > $maxrecent} {
		_unset_recentrepo [lindex $recent 0]
		set recent [lrange $recent 1 end]
	}
}

The last while loop looks to me like truncating the overlong recent
list down to maxrecent.  Perhaps a similar logic needs to be at the
end of _get_recentrepos?
