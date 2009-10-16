From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Introduction and Wikipedia and Git Blame
Date: Fri, 16 Oct 2009 10:04:38 -0700
Message-ID: <7vbpk7w9qx.fsf@alter.siamese.dyndns.org>
References: <ee9cc730910160207x49feb40ej692188abb0a57473@mail.gmail.com>
 <alpine.DEB.1.00.0910161321550.4985@pacific.mpi-cbg.de>
 <ee9cc730910160443k7e5f718bs964923a796cf38d1@mail.gmail.com>
 <alpine.DEB.1.00.0910161548550.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "jamesmikedupont\@googlemail.com" <jamesmikedupont@googlemail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 16 19:04:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyqEZ-0007U4-QC
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 19:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbZJPREp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 13:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbZJPREp
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 13:04:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbZJPREo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 13:04:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 47FC85B2AB;
	Fri, 16 Oct 2009 13:04:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l6iFOKCJRY8LN50gvuc9fh6AH+s=; b=PR0K2D
	+1kjKHnYFNtdzbOB1I1U+VxU+sFo9gL568i/9hSv4mNpS9JEXbPXgw3IL3Z/xEL1
	mokmh2T09uPjNf5/akAV/YT2HnMO1oTBu2W6rxgONH6P7da2r3PQ5B4yk6Xzsfgi
	j4naOQHWdrFALAXrcrWVltIZwvkTLMD7DX69A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TggTYxUQQPGsqegzaNdnoGsl2AZA7XNM
	PamvoTmaN4x+wOeNwK4i/FljKblkEO9oiYGm5zqvwuiN4K5fQRqm0vWUq6izaoYh
	biyeHbjN5JeD7eIHpWadGM64qCK6/QPGh1Oag7ZBXfLimtaPwzj1H/6GN5vsaE5h
	yIt2KULjhtk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D35E5B2A7;
	Fri, 16 Oct 2009 13:04:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 695755B2A3; Fri, 16 Oct
 2009 13:04:40 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0910161548550.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Fri\, 16 Oct 2009 16\:11\:02 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0041CAB0-BA76-11DE-A561-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130509>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Then I would make modified "texts" from the blob of the file in the 
> current revision and its parent revision, by inserting newlines after 
> every single byte (probably replacing the original newlines by other 
> values, such as \x01).
>
> The reason for this touchup is that the diff machinery in Git only handles 
> line-based diffs.
>
> Then you can parse the hunk headers, adjust the offsets accordingly,...

I would agree that text converted to "byte-per-line" format would be the
easiest way to re-use the diff engine, but if you go one more step, you
can even reusel the blame engine as well.  You convert the text into
"byte-in-hex-and-lf" (e.g. "AB C\n" becomes "41\n42\n20\n43\n0a\n") and
feed it into existing blame and have it produce script-readable output,
instead of feeding that to your reinvention of blame using diff engine.

You would need to postprocess the computed result (either by diff or
blame) to lay out the final text output in either case anyway, and making
the existing blame engine do the work for you would be a better approach,
I think.
