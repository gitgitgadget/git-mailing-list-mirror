From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: Really add angle brackets to In-Reply-To if necessary
Date: Sun, 09 Dec 2007 10:09:44 -0800
Message-ID: <7v63z7rb87.fsf@gitster.siamese.dyndns.org>
References: <1197219900-19334-1-git-send-email-mh@glandium.org>
	<1197220648-20433-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Kastrup <dak@gnu.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 19:10:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Qbh-0007eX-Ce
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 19:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbXLISKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 13:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbXLISKE
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 13:10:04 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:37931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbXLISKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 13:10:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 94AED5A90;
	Sun,  9 Dec 2007 13:09:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 119F95A8F;
	Sun,  9 Dec 2007 13:09:51 -0500 (EST)
In-Reply-To: <1197220648-20433-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Sun, 9 Dec 2007 18:17:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67637>

Mike Hommey <mh@glandium.org> writes:

> 3803bcea tried to fix this, but it only adds the branckes when the given
> In-Reply-To begins and ends with whitespaces. It also didn't do anything
> to the --in-reply-to argument.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>
> I just got bitten by this...

Interesting.

>
>  git-send-email.perl |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 76baa8e..1434eb2 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -367,10 +367,11 @@ if ($thread && !defined $initial_reply_to && $prompting) {
>  	} while (!defined $_);
>  
>  	$initial_reply_to = $_;
> -	$initial_reply_to =~ s/^\s+<?/</;
> -	$initial_reply_to =~ s/>?\s+$/>/;
>  }

I wonder what the original rationale for these \s+ was.
Will apply, anyway.  Thanks.

>  
> +$initial_reply_to =~ s/^\s*\<?/\</;
> +$initial_reply_to =~ s/>?\s*$/>/;
> +
>  if (!defined $smtp_server) {
>  	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
>  		if (-x $_) {
> -- 
> 1.5.3.7
