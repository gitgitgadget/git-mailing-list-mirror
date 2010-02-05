From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] receive-pack: Wrap status reports inside
 side-band-64k
Date: Fri, 05 Feb 2010 13:14:37 -0800
Message-ID: <7vd40j1j2a.fsf@alter.siamese.dyndns.org>
References: <1265403462-20572-1-git-send-email-spearce@spearce.org>
 <1265403462-20572-6-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 22:14:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdVVq-0006bm-Ey
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 22:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757471Ab0BEVOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 16:14:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939Ab0BEVOo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 16:14:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 88DD697165;
	Fri,  5 Feb 2010 16:14:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IR3RZ9jjwcDechUHHSj5hk/27IM=; b=ERAq07
	EhFvkjbq6Ffl8udmRVnXmVazZVv6id1EdAKqXcAM0rHZ/CwJqxTJPQCg1//6QhPt
	pErR/DDYz6TFwyVDexLH+vYDn0sIxx4EI1KTa+6qmXJIFM3FZTo6rBDVkCaY0KkP
	K35dEcF4HYzzEdzKHzDT520HGGVzs+DToEQiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ciu3TanFSbAHFwtLT5AoiMX7O/D1xrCW
	EQ9PLQTjC6pzFhuK5VEi0vXoFMIiIDIwl6ZzDxUlxXlyWFIE+pFZmGswCGfD8i82
	CYJHsdSeXQT3UNcpkm3KXhkMbWwrtyuSq1YngHs8YdN9HVgwKj5MVFuYJ8xpFO00
	DzjsI9UW1ck=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 68A7097161;
	Fri,  5 Feb 2010 16:14:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA42D97160; Fri,  5 Feb
 2010 16:14:38 -0500 (EST)
In-Reply-To: <1265403462-20572-6-git-send-email-spearce@spearce.org> (Shawn
 O. Pearce's message of "Fri\,  5 Feb 2010 12\:57\:41 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 799CFC86-129B-11DF-A7B1-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139095>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If the client requests the side-band-64k protocol capability we
> now wrap the status report data inside of packets sent to band #1.
> This permits us to later send additional progress or informational
> messages down band #2.
>
> If side-band-64k was enabled, we always send a final flush packet
> to let the client know we are done transmitting.

Two questions.

 - Why does use_sideband, the variable with the same name as a boolean
   variable used by other parts of the system to decide whether we should
   or should not use the sideband communiocation, get a value other than 0
   or 1?  What is the benefit of using it to keep an actual value?  Does
   the benefit outweigh the confusion factor?

 - What happens if client wants only side-band, not 64k?  This is just
   theoretical and "we don't bother" is a perfectly acceptable answer.  I
   am just curious ;-).
