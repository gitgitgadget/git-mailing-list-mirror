From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] make diff --color-words customizable
Date: Sat, 10 Jan 2009 17:34:44 -0800
Message-ID: <7vr63atykr.fsf@gitster.siamese.dyndns.org>
References: <87wsd48wam.fsf@iki.fi>
 <1231549039-5236-1-git-send-email-trast@student.ethz.ch>
 <alpine.DEB.1.00.0901101146230.30769@pacific.mpi-cbg.de>
 <200901101225.10719.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901101239550.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 11 02:36:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLpFX-0000wI-2k
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 02:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489AbZAKBey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 20:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754465AbZAKBex
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 20:34:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239AbZAKBex (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 20:34:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 22C098F4DD;
	Sat, 10 Jan 2009 20:34:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BA3138F4DC; Sat,
 10 Jan 2009 20:34:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0AD19AAE-DF80-11DD-AEAE-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105151>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Well, the thing I tried to hint at: it is not good to have a monster 
> patch, as nobody will review it.
>
> In your case, I imagine it would be much easier to get reviewers if you 
> had
>
> 	patch 1/4 refactor color-words to allow for 0-character word 
> 		boundaries
> 	patch 2/4 allow regular expressions to define what makes a word
> 	patch 3/4 add option to specify word boundary regexps via
> 		attributes
> 	patch 4/4 test word boundary regexps
>
> And I admit that I documented the code lousily, but that does not mean 
> that you should repeat that mistake.

Sounds like a reasonable request.  Also I am seeing:

    diff.c: In function 'scan_word_boundaries':
    diff.c:512: warning: enumeration value 'DIFF_WORD_UNDEF' not handled in switch

from this part of the code:

	for (i = 0; i < len; i++) {
		switch (buf->boundaries[i]) {
		case DIFF_WORD_BODY:
			*p++ = text[i];
			break;
		case DIFF_WORD_END:
			*p++ = text[i];
			*p++ = '\n'; /* insert an artificial newline */
			break;
		case DIFF_WORD_SPACE:
			*p++ = '\n';
			break;
		case DIFF_WORD_SKIP:
			/* nothing */
			break;
		}
	}
