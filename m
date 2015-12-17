From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] git gui: allow for a long recentrepo list
Date: Thu, 17 Dec 2015 11:32:55 -0800
Message-ID: <xmqqsi30c1lk.fsf@gitster.mtv.corp.google.com>
References: <1450310287-4936-1-git-send-email-philipoakley@iee.org>
	<1450310287-4936-5-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GitList <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexey Astakhov <asstv7@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 20:33:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9eIV-0000vz-GA
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 20:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbbLQTc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 14:32:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751832AbbLQTc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 14:32:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C118B35887;
	Thu, 17 Dec 2015 14:32:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wgPUTGTT88I76x88g0eKTbSMwX8=; b=eJnQ/5
	3AK62n3uU+TeW88orZsyGJYR4XqoqDdPvsRQRWvoHJ/yjZ9hIT7mDwDSj3JxIaeY
	uXxg34REQgFlPsD7V4u/xnlE8SC99Zw36nCDhkYbMcNoY+xTj985Zm3bwlFJiGlh
	knjKcR3fFsI+IbUVqLGRzlGrexUtCHueHQ18A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EWSDbDDD6IlDc40bjipCmThD25QqolkX
	SwozhcKzH/AiNWbJ8m20JRWp905RRR6uYDM1pvBXgr5gQh0R61ID0xmwOkK8QvfR
	DWg/RUAxuDeuV5HytdV7z48Wcg0tmQOmMj0/dGzIaEzN8bQwpGl3U5f2lQk37jVK
	ZW/Id2jLZCg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B801F35886;
	Thu, 17 Dec 2015 14:32:56 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 371CC35885;
	Thu, 17 Dec 2015 14:32:56 -0500 (EST)
In-Reply-To: <1450310287-4936-5-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Wed, 16 Dec 2015 23:58:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F9138C9A-A4F4-11E5-ACFC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282669>

Philip Oakley <philipoakley@iee.org> writes:

> The gui.recentrepo list may be longer than the maxrecent setting.
> Allow extra space to show any extra entries.
>
> In an ideal world, the git gui would limit the number of entries
> to the maxrecent setting, however the recentrepo config list may
> have been extended outside of the gui, or the maxrecent setting changed
> to a reduced value. Further, when testing the gui's recentrepo
> logic it is useful to show these extra, but valid, entries.

I do not have a strong objection either way, but the magic number 5
smells like an indication that this is solving a wrong problem or
solving a problem in a wrong approach.  What happens to the entries
beyond $maxrecent-th in the recent list with the current code?  The
list effectively truncated and not shown?  Wouldn't the same thing
happen to the entries beyond ($maxrecent+5)-th in the recent list
with your patch?

Truncating the list at $maxrecent-th to match the display
(i.e. declare that "$maxrecent" is really the max number of entries
we would keep track of), or allowing the UI to scroll so that
entries beyond $maxrecent-th one can be shown, perhaps?

>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> word usage corrected.
> Eric's comments $gmane/282432
> ---
>  git-gui/lib/choose_repository.tcl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
> index ad7a888..a08ed4f 100644
> --- a/git-gui/lib/choose_repository.tcl
> +++ b/git-gui/lib/choose_repository.tcl
> @@ -153,7 +153,7 @@ constructor pick {} {
>  			-background [get_bg_color $w_body.recentlabel] \
>  			-wrap none \
>  			-width 50 \
> -			-height $maxrecent
> +			-height [expr {$maxrecent + 5}]
>  		$w_recentlist tag conf link \
>  			-foreground blue \
>  			-underline 1
