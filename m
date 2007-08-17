From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reset terminal attributes when terminating git send-email
Date: Fri, 17 Aug 2007 15:19:15 -0700
Message-ID: <7vr6m1g5y4.fsf@gitster.siamese.dyndns.org>
References: <11873867051906-git-send-email-seanlkml@sympatico.ca>
	<11873867051589-git-send-email-seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat Aug 18 00:19:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMAAC-0005XO-4h
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 00:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbXHQWTX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 18:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbXHQWTX
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 18:19:23 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:53482 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbXHQWTW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 18:19:22 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8349A12344E;
	Fri, 17 Aug 2007 18:19:39 -0400 (EDT)
In-Reply-To: <11873867051589-git-send-email-seanlkml@sympatico.ca> (Sean
	Estabrooks's message of "Fri, 17 Aug 2007 17:38:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56091>

Sean Estabrooks <seanlkml@sympatico.ca> writes:

> If you break out of the prompts presented to you by git send-email
> your terminal can be left in an inconsistent state.  Here we trap
> the interrupt signal and reset the terminal before exiting.
>
> Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
> ---
>  git-send-email.perl |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 69559b2..f1a8855 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -21,8 +21,11 @@ use warnings;
>  use Term::ReadLine;
>  use Getopt::Long;
>  use Data::Dumper;
> +use Term::ANSIColor;
>  use Git;
>  
> +$SIG{INT} = sub { print color("reset"), "\n"; exit };
> +
>  package FakeTerm;
>  sub new {
>  	my ($class, $reason) = @_;

I wonder if this is something Term::ReadLine when not using
FakeTerm should and does provide...  Is this the standard
workaround all the applications that use Term::ReadLine need to
implement themselves?
