From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Print hunk number in prompt of add --patch.
Date: Wed, 26 Nov 2008 23:14:26 -0800
Message-ID: <7vwsepbpyl.fsf@gitster.siamese.dyndns.org>
References: <492E3B6D.9090309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 08:16:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5b6c-0007Vm-9O
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 08:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbYK0HOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 02:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbYK0HOt
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 02:14:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbYK0HOs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 02:14:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4E8D4816C8;
	Thu, 27 Nov 2008 02:14:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D589A816C4; Thu,
 27 Nov 2008 02:14:28 -0500 (EST)
In-Reply-To: <492E3B6D.9090309@gmail.com> (William Pursell's message of "Thu,
 27 Nov 2008 06:17:17 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 12B3E5E2-BC53-11DD-A5A1-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101795>

William Pursell <bill.pursell@gmail.com> writes:

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index b0223c3..7974cd1 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -919,7 +919,7 @@ sub patch_update_file {
>  		for (@{$hunk[$ix]{DISPLAY}}) {
>  			print;
>  		}
> -		print colored $prompt_color, "Stage this hunk [y/n/a/d$other/?]? ";
> +		print colored $prompt_color, "Stage hunk $ix [y/n/a/d$other/?]? ";
>  		my $line = <STDIN>;
>  		if ($line) {
>  			if ($line =~ /^y/i) {

Do we know how many hunks we have at this point (and remember we need to
adjust the number of hunks after splitting)?

The original one was unfriendly in that it asked "Do you want this or not?
We'd rather not to say where you are nor how many more there are".  Your
update is slightly better but not enough: "Do you want this one or not?
It is the second one but we still won't tell you how many more there are".

I'd prefer it to ask "Stage hunk 2 (of 35)?" if you are adding more words
here.

I doubt "jump to hunk specified by hunk number" is useful in general.  You
wouldn't know what hunk number the hunk you are interested in has, until
you scroll through them all.

"Jump to hunk around line number X in the preimage", or "jump to a hunk in
function Y" may be useful (the latter you can do with "/^@@.*funcname"
with your slash-search patch).
