From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 02/11] git-p4: test debug macro
Date: Sun, 18 Dec 2011 13:48:11 -0800
Message-ID: <7vwr9to8kk.fsf@alter.siamese.dyndns.org>
References: <1324147942-21558-1-git-send-email-pw@padd.com>
 <1324147942-21558-3-git-send-email-pw@padd.com> <4EED1B06.80007@diamand.org>
 <20111218013651.GA18735@padd.com>
 <20111218032238.GA6368@elie.hsd1.il.comcast.net>
 <20111218140633.GB16487@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Dec 18 22:48:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcOaj-0002Ud-8R
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 22:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab1LRVsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 16:48:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42098 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198Ab1LRVsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 16:48:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 179F77D63;
	Sun, 18 Dec 2011 16:48:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FTuETwWFapFuiIt3L/Y1Z8V7Q7s=; b=mcCqrT
	UfnQbt4eggkxphCJUetm3sApqddHv6HAVQWQZ9bgl1ldVsvsOTnGkD7ppKx5P2bh
	ZTVncOvUyQFdX8zohudD038h2XtIBq8ugUET1Nv6ALlGsst2eIHadjP88vBNGD1P
	G1IUnxNWPVMlPAlYb5G2m9aHMQa4MKjt4CRDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RfPB+/ROns+49+/taATPgt/pfy8+xokO
	dwT8gYp3UVbolFusUSly2y9GjXNLxUYRyo9FCgDmz7mN7l+M1S8IaxKsYRjh4dkF
	P0nz8kdMgeu2bDvgjnaQis2aDa117wIaUB73suot3gMeqegTu3R09MslLG3BtdUK
	fWLAN04EvNg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E48D7D62;
	Sun, 18 Dec 2011 16:48:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F8D37D61; Sun, 18 Dec 2011
 16:48:13 -0500 (EST)
In-Reply-To: <20111218140633.GB16487@padd.com> (Pete Wyckoff's message of
 "Sun, 18 Dec 2011 09:06:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC408146-29C1-11E1-A40B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187427>

Pete Wyckoff <pw@padd.com> writes:

> Call this from a test to have it pause and wait for you to
> investigate.  It prints out its current directory and the
> P4 environment variables.  It waits for ctrl-c before continuing
> the test.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
...
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index a870f9a..4c30960 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -72,3 +72,34 @@ kill_p4d() {
>  cleanup_git() {
>  	rm -rf "$git"
>  }
> +
> +#
> +# This is a handy tool when developing or debugging tests.  Use
> +...
> +debug() {
> +	echo "*** Debug me, hit ctrl-c when done.  Useful shell commands:"
> +	echo cd \"$(pwd)\"
> +	echo export P4PORT=$P4PORT P4CLIENT=$P4CLIENT
> +	trap "echo" INT
> +	sleep $((3600 * 24 * 30))
> +	trap - INT
> +}
> +

You may have found this handy yourself, but I would rather not to see it
here in the current form for multiple reasons.

 - Why "ctrl-c"? You are not even spawning shell from here but are having
   the user interact with this state in the middle of a test from another
   shell, no?

   Why not "When done, type <RET>" and have a "read junk" or something
   instead? That would be a lot simpler and you do not have to worry about
   portability with many lines of comments.

   An alternative is to spawn an interactive shell here, and change the
   "Debug me" comment to say "ctrl-d when done".

 - This is not linked to the generic "debug" option "txxxx-name.sh -d".
   Shouldn't you be extending test_debug so that it can go interactive,
   give customized comments&insns (i.e. "cd $here" may be useful for test
   scripts outside testing p4, but "P4PORT=..." would not be, so the user
   of test_debug in t9800-git-p4.* needs customizability of the message).

Also could we please rename p4 related tests in t/t98* series so that it
is clear that they are about git-p4 from "ls t/" output (i.e. have them
all have "git-p4" in their names)?
