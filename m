From: Junio C Hamano <gitster@pobox.com>
Subject: Re: summaries in git add --patch[PATCH 1/2]
Date: Thu, 04 Dec 2008 00:47:33 -0800
Message-ID: <7vvdu0e38a.fsf@gitster.siamese.dyndns.org>
References: <492F0CAD.3010101@gmail.com>
 <7viqq8adsf.fsf@gitster.siamese.dyndns.org> <492F92C9.7030301@gmail.com>
 <7v8wr48g98.fsf@gitster.siamese.dyndns.org> <49308B4B.3070703@gmail.com>
 <7vskp6j95x.fsf@gitster.siamese.dyndns.org> <4936EE63.209@gmail.com>
 <7vd4g8alp7.fsf@gitster.siamese.dyndns.org> <49377ED8.4050905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 09:49:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L89tK-0007l2-Qa
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 09:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbYLDIrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 03:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbYLDIrj
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 03:47:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbYLDIrj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 03:47:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 193CE83F48;
	Thu,  4 Dec 2008 03:47:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 264F383F45; Thu,
  4 Dec 2008 03:47:34 -0500 (EST)
In-Reply-To: <49377ED8.4050905@gmail.com> (William Pursell's message of "Thu,
 04 Dec 2008 06:55:20 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 340A453C-C1E0-11DD-BBD1-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102329>

William Pursell <bill.pursell@gmail.com> writes:

>> How well does substr() work with utf-8 and other multi-byte encodings
>> these days, I have to wonder...
>
> Hopefully, it works well.

"Hopefully" is the last word I'd like to hear from submitters.  It would
be either "I do not know" or "I studied the topic and I know the code works".

> Here's another go, with your suggestions applied.

Sorry, this came too late for tonight's round.  I have a fixed-up one
based on your previous round parked in 'pu', which I'll be replacing with
this one (or your future re-submission if there is any) later in the week.

By the way, I noticed that you are sending your patches with:

    Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Please don't.  format=flawed tends to destroy whitespaces (I fixed them up
by hand for the ones I parked in 'pu').

> +	# Add some user context, the first changed line that contains
> +	# some non-white character other than a bracket.
> +	for my $line (@{$rhunk->{TEXT}}) {
> +		if ($line =~ m/^([+-][][{}()\s]*[^][{}()\s])/) {

I would say "$line =~ /^[-+].*\w/" (i.e. match any +/- line that contains
a word letter) would be sufficient, and it would be much easier to read.

As you append the entire $line to $summary, there is no need to capture
with ().

> +# Print a one-line summary of each hunk in the array ref in
> +# the first argument, starting wih the index in the 2nd.
> +sub display_hunks {
> +	my ($hunks, $i) = @_;
> +	my $ctr = 0;
> +	$i = 0 if not $i;

I think "$i ||= 0" is more customary.
