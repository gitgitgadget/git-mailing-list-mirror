From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cvsexportcommit fails for huge commits
Date: Wed, 12 Dec 2007 01:21:14 -0800
Message-ID: <7vir348e0l.fsf@gitster.siamese.dyndns.org>
References: <20071211200418.GA13815@mkl-desktop>
	<20071212083154.GB7676@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Klinik <markus.klinik@gmx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 10:22:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Nn6-0006fk-VU
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 10:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757607AbXLLJVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 04:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757177AbXLLJVc
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 04:21:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793AbXLLJVb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 04:21:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 14B5864DF;
	Wed, 12 Dec 2007 04:21:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8538A64DE;
	Wed, 12 Dec 2007 04:21:21 -0500 (EST)
In-Reply-To: <20071212083154.GB7676@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 12 Dec 2007 03:31:54 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68020>

Jeff King <peff@peff.net> writes:

> @@ -335,6 +335,22 @@ sub safe_pipe_capture {
>      return wantarray ? @output : join('',@output);
>  }
>  
> +sub xargs_safe_pipe_capture {
> +	my $MAX_ARG_LENGTH = 1024;
> +	my $cmd = shift;
> +	my @output;
> +	while(@_) {
> +		my @args;
> +		my $length = 0;
> +		while(@_ && $length < $MAX_ARG_LENGTH) {
> +			push @args, shift;
> +			$length += length($args[$#args]);
> +		}
> +		push @output, safe_pipe_capture(@$cmd, @args);
> +	}
> +	return @output;
> +}
> +

Makes me wonder why you are not spawning xargs by doing it by hand.  If
the path at the beginning happens to be longer than 1024 then you will
run path-less "cvs status"?
