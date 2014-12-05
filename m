From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Show number of commits being rebased interactively
Date: Fri, 05 Dec 2014 13:37:19 -0800
Message-ID: <xmqq388tpyls.fsf@gitster.dls.corp.google.com>
References: <5460E893.7080003@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Onno Kortmann <onno@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 22:37:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx0Z5-0006vd-3L
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 22:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbaLEVhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 16:37:23 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751535AbaLEVhW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 16:37:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B786223701;
	Fri,  5 Dec 2014 16:37:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yDTMWd1WPz0wHzvU23+uVFT/iis=; b=HnJe3n
	aVUNKs8X6WFhaayFJiMA+p/NLffi6c46lPY8PO9R9VhzIVb3/+R6HwK9mEmvAMRG
	6kOOhbMS0CpKQTkymhjYCuAstqhuhPw2u2C1IefLQf4vSNVdz06tKJF5IejAgd7m
	WfOzO91F/76DJRdwqLUFK7woGNujbY2Kt+mR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mmac2jk3rSyPkewmoX2bovVDK4qiWpB7
	MqC82QYVSL4/eZA6lxQGgUZJjmwyUKj6Slx63jNUib2QvI5Ec8HumDA2tUGsDZFa
	JwLV7/Nimr63sSw2C7OaMVazejL6UCicrT8UuMmE3ABzhlDrrB3cgbw2UTNea1Il
	rRgXKaz0tmY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE9EF23700;
	Fri,  5 Dec 2014 16:37:21 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 343F2236FF;
	Fri,  5 Dec 2014 16:37:21 -0500 (EST)
In-Reply-To: <5460E893.7080003@gmx.net> (Onno Kortmann's message of "Mon, 10
	Nov 2014 17:32:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E4D11088-7CC6-11E4-90D9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260895>

I see nobody commented on this, which probably fell into cracks.
Even though I am personally not very interested, I obviously am not
the only user of Git, and there may be others who are interested in
a change like this.

Onno Kortmann <onno@gmx.net> writes:

> Hi again,
>
> oops, I realized that my MUA mangled the patch, even though it
> shouldn't. Here it is again, with a bit more description.
> ---

These lines above "---" will become the only log message text, which
is probably not what you intended.  Use "-- >8 --" marker instead
(that is a perforation line with a pair of scissors on it)?

> During 'rebase -i', one wrong edit in a long rebase session might
> inadvertently drop commits. This change shows the total number of
> commits in the comments below the commit list. After the rebase
> edit, the number can be quickly compared to the line number of
> the last commit - by scrolling to the last entry in the rebase
> TODO list. This gives peace of mind that no commits have been
> lost in the edit.
>
> Signed-off-by: Onno Kortmann <onno@gmx.net>
> ---
>  git-rebase--interactive.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index b64dd28..b266dc0 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1031,9 +1031,11 @@ test -s "$todo" || echo noop >> "$todo"
>  test -n "$autosquash" && rearrange_squash "$todo"
>  test -n "$cmd" && add_exec_commands "$todo"
>
> +commitcount=$(git stripspace --strip-comments <"$todo"  | wc -l)

Does this count the number of commits?  I suspect it at least needs
to filter "x|exec" out.

>  cat >>"$todo" <<EOF
>
> -$comment_char Rebase $shortrevisions onto $shortonto
> +$comment_char Rebase $shortrevisions onto $shortonto ($commitcount commit(s))
>  EOF
>  append_todo_help
>  git stripspace --comment-lines >>"$todo" <<\EOF
