From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sat, 14 Feb 2009 12:19:11 -0800
Message-ID: <7viqncsreo.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
 <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>
 <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 21:21:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYR0W-0003B0-VD
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 21:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbZBNUTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 15:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbZBNUTV
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 15:19:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbZBNUTT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 15:19:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BBCA62B222;
	Sat, 14 Feb 2009 15:19:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CF76B2B223; Sat,
 14 Feb 2009 15:19:12 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sat, 14 Feb 2009 20:59:36 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C1824310-FAD4-11DD-BD6C-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109915>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +	else if (given_config_file) {
>> +		if (!is_absolute_path(given_config_file) && file)
>> +			file = prefix_filename(file, strlen(file),
>> +					       given_config_file);
>> +		else
>> +			file = given_config_file;
>> +		config_exclusive_filename = file;
>
> It took me a considerable amount of time to figure out that "file" is 
> actually the "prefix"!  That cleanup would be nice to have before the 
> parseopt patch, methinks, especially since the code is reindented, and 
> thus hard to follow in the diff.

I noticed that "file" thing during my review of the first round.  It
probably was a cute attempt to avoid using two variables "prefix" and
"file", but made the result a lot harder to read.  I agree that a clean-up
*before* code restructuring would be good for this particular wart.

    A note that is off-topic to this patch.

    I also noticed that the diff was impossible to read because it matched
    the lines with only an indented close brace or whitespace between the
    preimage and the postimage too aggressively.  Your --patience did seem
    to help a little bit, at least it produced a different result, but not
    much (not that patience was meant to make this kind of change easier
    to read).  It may have helped if we had that "do not match trivial
    lines too aggressively just to reduce the patch size" option.
