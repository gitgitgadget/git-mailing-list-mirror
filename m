From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Thu, 15 Oct 2009 13:27:44 -0700
Message-ID: <7vfx9k4d33.fsf@alter.siamese.dyndns.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
 <20091015185253.6117@nanako3.lavabit.com>
 <20091015143340.GI10505@spearce.org> <200910151721.08352.johan@herland.net>
 <20091015154142.GL10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 22:33:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyX0d-0008Im-HL
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 22:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935493AbZJOU2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 16:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935483AbZJOU2k
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 16:28:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935482AbZJOU2j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 16:28:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6E0C878A67;
	Thu, 15 Oct 2009 16:27:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qynX98tzP6/7hf3OVcpRCtbjStY=; b=FVyDiw
	fEvEZ9m7Od5AN7nITDxpQmAvX7WbfuVHbP0TQfNVP6B6wOYr1yz8u0gZv2MSOGLR
	WFbjo6+6UhLO7X4XL//773PWrGNp5xEQZ7HEiLHW9sINlq1o38RcCbLQ1011LJkB
	4FdlovXP2iyzakMocFVSOwEb2DgO/rAj+eBPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rp6c4QhlX5a4PgsNoAuDXtcQCxGReAAs
	o1AoOjD3niaRSVkeCWhuNFE1Kn8jHw73P7MbiyqjNaF2rHCrHipVOloSo940yDbq
	cKuGeCXoWmE4YkDYAJHHpdZ1L2CLqe1kxI8yrAvtVwVCDjrcTbXGZ9sgX/o/szrZ
	yNcIiYq3tRk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 386B378A65;
	Thu, 15 Oct 2009 16:27:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9374F78A5E; Thu, 15 Oct 2009
 16:27:46 -0400 (EDT)
In-Reply-To: <20091015154142.GL10505@spearce.org> (Shawn O. Pearce's message
 of "Thu\, 15 Oct 2009 08\:41\:42 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37B1851A-B9C9-11DE-8646-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130419>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> It does.  It is caused by the disconnect_helper call inside of
> fetch_with_import.  You can't disconnect inside of the fetch method
> of a transport, the caller is going to disconnect you a second time.
> ...
> This bug isn't due to the merge, its a bug in Johan's series that
> needs to be fixed before it could merge down to next/master.

Thanks; I pushed out 'pu' with your v3 this time.

Last night I did a trial fetch merge with FETCH_HEAD into 'pu', but then
after I queued some fixes to 'maint' and 'master' to prepare for 1.6.5.1,
I rebuilt 'pu' with the still-old sp/smart-http topic, and that is what
was sitting at k.org til this morning.

I am a bit confused about your diagnosis, though.  As far as I recall,
Johan's topic itself nor 'pu' with Johan's topic but without v2 of
sp/smart-http did not have the issue.  Does that indicate that the
behaviour expected from the fetch method is different between the two
topics, and this indeed is a semantic conflict as you suspected initially?
In other words, if Johan's series is updated not to disconnect inside the
fetch method of the transport, and if it is not merged with your series,
does the caller still disconnect it properly?
