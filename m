From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] t4011: illustrate "diff-index -p" on stat-dirty
 paths
Date: Thu, 01 Mar 2012 08:18:15 -0800
Message-ID: <7vzkc0nvlk.fsf@alter.siamese.dyndns.org>
References: <1330568057-27304-1-git-send-email-gitster@pobox.com>
 <1330568057-27304-3-git-send-email-gitster@pobox.com>
 <87399slmh4.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 01 17:18:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S38i2-0007x2-0z
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 17:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297Ab2CAQST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 11:18:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756199Ab2CAQSR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 11:18:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 501ED6EAA;
	Thu,  1 Mar 2012 11:18:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bYoEAIQ9dVdpqj/VEjiK1lHGR0o=; b=lXSGnL
	YWeDW6VIemRKY/AJxGrL17GwIyr03xq6XDON1wWRWdsvmX6a32+Kz8qdon/BtIS0
	7+BV1E7FBSXVsn3Ct2feD4L8YzH3LilhH9TExtnGf+TU970IVrb+jB8HCFjRdKIu
	RJnunKSEmR0/MXxy5PHegylLGJaF7eOdK62AE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JVsWSIC02g9tVGQhJ2bbaKs0RpVtYVBv
	em/iXL1tdCwY8mbRKzLU4IVcLAbJlA3mtC/m4JZ1yWM6Nkd2/bLcbJKUX4eJp2tu
	JgW0tPRgQImbKNs8NmtVeC+KB46q3fRxCuYHsoPYMeVsHdiVC4NS63cJrXdtjvIH
	rd7xzheBK7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47BDF6EA9;
	Thu,  1 Mar 2012 11:18:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD31D6EA8; Thu,  1 Mar 2012
 11:18:16 -0500 (EST)
In-Reply-To: <87399slmh4.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Thu, 1 Mar 2012 10:05:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26FFF92A-63BA-11E1-9BE2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191941>

Thomas Rast <trast@inf.ethz.ch> writes:

> If that analysis is correct, then
>
>   we do not show any "diff --git" header for blobs whose true contents
>   are different but compares the same when whitespaces are ignored
>
> is not what is going on here; the blobs have exactly the same content.

True; an earlier draft actually had an 'echo " xyzzy" >nitfol' in there,
but it meant that it needed another annoying 'sleep 3' (I could have used
test-chmtime), so the test was updated but the above description stayed.

> The difference is that
>
> * without -w, the code "knows" from the lstat() data that the files are
>   different, prints a header, and then fails to find any differences;

Correct. Those quotes around "knows" are the most important ;-)

The code incorrectly thinks the stat dirtyness is all that it "knows";
even though it has a way to act on a better knowledge from the xdiff these
days, it does not utilize it.

> * with -w, the code correctly holds off on printing anything since it
>   will invariably have to inspect the contents beforehand.
>
> So perhaps you can say
>
>   Illustrate this current behaviour.  Also demonstrate that with the
>   "-w" option, we (correctly) hold off showing a "diff --git" header
>   until actual differences have been found.  This also suppresses the
>   header for merely stat-dirty files, which is inconsistent.

That is much better; thanks.
