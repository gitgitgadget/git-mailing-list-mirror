From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/7] invalidate_ref_cache(): take the submodule as
 parameter
Date: Thu, 03 Nov 2011 11:57:01 -0700
Message-ID: <7vr51pf30i.fsf@alter.siamese.dyndns.org>
References: <7vty7ggzum.fsf@alter.siamese.dyndns.org>
 <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
 <1318445067-19279-3-git-send-email-mhagger@alum.mit.edu>
 <7vwrca81c7.fsf@alter.siamese.dyndns.org> <4E960F91.5020103@alum.mit.edu>
 <7vmxczmrb0.fsf@alter.siamese.dyndns.org> <4EB26BA0.9030609@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Nov 03 19:57:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM2TT-0007RX-6W
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 19:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478Ab1KCS5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 14:57:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756455Ab1KCS5E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 14:57:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 049256132;
	Thu,  3 Nov 2011 14:57:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rvrwHnhh95KUBD2qberaC0yw8lo=; b=XhJ7+K
	hdk7UwWRja+jvPdFSzq00EKUTQEDpKbKxGPTD35/jCvZpF69YQsGAQw+758M46+Z
	/739guXLI21co1nU/q4IWyuJd7gODs4PMJiwhiwow8un+E22k8fdoK+o/pvvg/2L
	l4MFOKiH638DJXWsuD/nRWsqYW1VDO/1ovXYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LD2jCiIpZjXi8wWSqj6QQKiDW3sAsZ0R
	IO3FYlYklELa+ZfRBIH4PV0fQQ2Mm/Gs7MrosayCWLFSQKQcDUUo0A5QopVtH655
	YynSyW1GOtrrMVVCKfJtkumtUZN+gOTnupnGWQYvW95I1NJyNsledtpRjsemW0hy
	O2yIxjctQ9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFA026131;
	Thu,  3 Nov 2011 14:57:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B7E0612F; Thu,  3 Nov 2011
 14:57:03 -0400 (EDT)
In-Reply-To: <4EB26BA0.9030609@alum.mit.edu> (Michael Haggerty's message of
 "Thu, 03 Nov 2011 11:23:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E13A3B0-064D-11E1-8431-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184736>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Sorry I didn't respond to this earlier.
>
> The public API convention (which predates my changes) is that "char
> *submodule" arguments either point at the relative path to the submodule
> or are NULL to denote the main module.  But since these are stored
> internally in a name[FLEX_ARRAY] field, I have been using "" internally
> to denote the main module.  I believe that everything is done correctly,
> but I admit that the use of different conventions internally and
> externally is a potential source of programming errors.

Yes, it would have been better if the original also used "". After all,
that would make it more consistent---"sub/" means the repository goverend
by "sub/.git", and "" would mean the repository governed by ".git".

Is it hard to change to do so now, given that we won't be rushing this for
the upcoming release and we have plenty of time?
