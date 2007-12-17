From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] include/asm-arm/: Spelling fixes
Date: Mon, 17 Dec 2007 13:27:20 -0800
Message-ID: <7vy7bt57wn.fsf@gitster.siamese.dyndns.org>
References: <5703e57f925f31fc0eb38873bd7f10fc44f99cb4.1197918889.git.joe@perches.com>
	<20071217195658.GB13515@fieldses.org>
	<1197921847.27386.16.camel@localhost>
	<20071217201219.GC13515@fieldses.org>
	<1197922971.27386.32.camel@localhost>
	<20071217205134.GB2105@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joe Perches <joe@perches.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:29:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4NWE-0001s1-TY
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 22:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765364AbXLQV1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 16:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765354AbXLQV1h
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 16:27:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57992 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765309AbXLQV1g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 16:27:36 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 726DC236F;
	Mon, 17 Dec 2007 16:27:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AF5D1236C;
	Mon, 17 Dec 2007 16:27:22 -0500 (EST)
In-Reply-To: <20071217205134.GB2105@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 17 Dec 2007 15:51:34 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68628>

Jeff King <peff@peff.net> writes:

> Ah. The problem is that git-send-email unconditionally adds a
> message-id. Usually git-format-patch doesn't add one, but for obvious
> reasons, it must when doing --thread. Here is a fix.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 1d6f466..083466a 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -580,7 +580,7 @@ sub send_message
>  		$ccline = "\nCc: $cc";
>  	}
>  	my $sanitized_sender = sanitize_address($sender);
> -	make_message_id();
> +	make_message_id() unless defined($message_id);

Isn't this called inside a loop?  If the outgoing message does not
originally have "Message-Id:", does the loop correctly reinitialize
$message_id to undef, or does this change make everybody reuse the same
$message_id over and over again?

I have a feeling that --thread to format-patch is a misfeature.  Why is
it needed if you are feeding the output to send-email?

I wonder if stripping existing "Message-Id:" away just like we strip
away "Date:" from @xh would be a much saner fix.
