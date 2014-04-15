From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: show staged submodules regardless of ignore config
Date: Tue, 15 Apr 2014 15:32:41 -0700
Message-ID: <xmqq1twyjkae.fsf@gitster.dls.corp.google.com>
References: <53444E6B.7000107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Apr 16 00:33:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaBuq-0004TY-30
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 00:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbaDOWdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 18:33:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbaDOWcq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 18:32:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D4957DE0A;
	Tue, 15 Apr 2014 18:32:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TyCN/qAt7QnlrfjY0WtLZ8vlQT4=; b=idD54K
	yWFshFyJBGIE85+sT6N0g0VHbqlEhHjNW+x7mKYGlhXSlZ/jXaW5vI1i6Cv0/uwC
	Ua2dRhv74ZQZB9F0QuwZxnXI2af5ANNL/5JZLDO+MMmS0JP+lfJtFGJb9nVRjxkR
	BJjHntHHnZMYG7+S2f6fQ0RJHT5Ft/xo/1K14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CziqLKN/rhx3yexIQcjmF5mGrwjZ9Jgu
	IQzcY8pztMKTrZDevSG3CzKNkI/7rcWao+3sMhL6G6YO0X7mho3+/b+O1biRVbmQ
	tYG8l9wZwfObKAi0KeMeS0mnFvTeEKay6BCASUBOsmPZKHm28wGOsKrnRmvVipVc
	cxJix8VQ6Hs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14E067DE09;
	Tue, 15 Apr 2014 18:32:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BCA27DE07;
	Tue, 15 Apr 2014 18:32:43 -0400 (EDT)
In-Reply-To: <53444E6B.7000107@web.de> (Jens Lehmann's message of "Tue, 08 Apr
	2014 21:30:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DC672B08-C4ED-11E3-A016-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246306>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Currently setting submodule.<name>.ignore and/or diff.ignoreSubmodules to
> "all" suppresses all output of submodule changes for git-gui. This is
> really confusing, as even when the user chooses to record a new commit for
> an ignored submodule by adding it manually this change won't show up under
> "Staged Changes (Will Commit)".
>
> Fix that by using the '--ignore-submodules=dirty' option for both callers
> of "git diff-index --cached" when the underlying git version supports that
> option.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---

I'll tentatively queue this on jl/git-gui-show-added-submodule-changes
and park it on 'pu'.

I'll be tagging 2.0.0-rc0 later this week; if you have some
accumulated changes (I saw that your public repository is at
gitgui-0.19.0 which I already have), please plan to get them
in by the end of next week.

Thanks.

>  git-gui.sh   | 6 +++++-
>  lib/diff.tcl | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index cf2209b..c69bfb3 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -1558,7 +1558,11 @@ proc rescan_stage2 {fd after} {
>
>  	set rescan_active 2
>  	ui_status [mc "Scanning for modified files ..."]
> -	set fd_di [git_read diff-index --cached -z [PARENT]]
> +	if {[git-version >= "1.7.2"]} {
> +		set fd_di [git_read diff-index --cached --ignore-submodules=dirty -z [PARENT]]
> +	} else {
> +		set fd_di [git_read diff-index --cached -z [PARENT]]
> +	}
>  	set fd_df [git_read diff-files -z]
>
>  	fconfigure $fd_di -blocking 0 -translation binary -encoding binary
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index 30d9a79..b0a5180 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -287,6 +287,9 @@ proc start_show_diff {cont_info {add_opts {}}} {
>  	if {$w eq $ui_index} {
>  		lappend cmd diff-index
>  		lappend cmd --cached
> +		if {[git-version >= "1.7.2"]} {
> +			lappend cmd --ignore-submodules=dirty
> +		}
>  	} elseif {$w eq $ui_workdir} {
>  		if {[string first {U} $m] >= 0} {
>  			lappend cmd diff
