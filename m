From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problems with git am
Date: Mon, 26 Oct 2009 17:52:11 -0700
Message-ID: <7vvdi1bqv8.fsf@alter.siamese.dyndns.org>
References: <59976.134.134.139.70.1256602329.squirrel@clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alan" <alan@clueserver.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 01:52:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2aIU-0007kq-3Q
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 01:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834AbZJ0AwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 20:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755504AbZJ0AwP
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 20:52:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553AbZJ0AwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 20:52:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 19AB186A6B;
	Mon, 26 Oct 2009 20:52:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6TNTApSmXwquvGUgA+++tlJIMgE=; b=BrOTP6
	+DmhmEElAAEPp1a4mGSSe0d/w41phoM+qW0ev7owFlAgAJcj3DF/QdcWHajvdYRM
	jRy/LUZHw0pDBpGE/tfEDDDrkVgqq0UzjNdyMPLt4hM8g7j8WAXzLAu96JR6zo4z
	12WxwtucFybazctLXyi2OTYKdvW60Mx/L3sa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uyIsz/buHoL4V5HrNvdh4txHZln9MlLW
	EPo+wtdAcCjjT/Bs4CbCZjKncwRHKYGs0ys7uZ/gDONTGvC+v8b2PO/86T7G8Xfl
	RrjQtOPL74cxe4YE5XY0DJ05hPQkDPpAGN10f218yew4tqwAlPTNr0p0ZtJEyGAR
	/33nWVur5FE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF97786A67;
	Mon, 26 Oct 2009 20:52:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EBDBE86A5C; Mon, 26 Oct 2009
 20:52:12 -0400 (EDT)
In-Reply-To: <59976.134.134.139.70.1256602329.squirrel@clueserver.org>
 (alan@clueserver.org's message of "Mon\, 26 Oct 2009 17\:12\:09 -0700
 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F8979A0E-C292-11DE-A7DF-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131296>

"Alan" <alan@clueserver.org> writes:

> The header of the patch looks like:
>
> commit 62b266585bb5555d44a764c90d80f9c4bb8188c1
> Author: Joe Example <joe@example.com>
> Date:   Wed Sep 19 10:03:47 2009 -0600

It shouldn't.

The format "git am" understands is a mbox file and format-patch is the
command to write commits out in that form.  It should begin with lines
that look like:

    From 610f99ec7d22b5750f12350f67c1341d6be8030f Mon Sep 17 00:00:00 2001
    From: Junio C Hamano <gitster@pobox.com>
    Date: Sun, 25 Oct 2009 18:41:09 -0700
    Subject: [PATCH] Update draft release notes to 1.6.6

    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    ---
    .... patch follows here ...

I do not think it is particularly hard to add a new case arm in "am" to
support "git log" output.  It is different from a mbox format in that it

 * begins each commit with "commit " marker;
 * has Author: and Date: header that is different from a mailbox;
 * lacks Subject: but makes it part of the message body; and
 * indents the message by 4 places.

Nobody has bothered to do so, probably because nobody needed it.

The easiest, safest and quickest for you right now (meaning, before
waiting for anybody to help you by adding a new feature to "am") would be
to see if it is possible for you to get the commits re-exported in an
appropriate format.

I say the "safest" in the above because you _could_ massage what you have
into a format that looks like a mbox with some Perl script, but it risks
mismassaging.
