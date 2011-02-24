From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] trace: refactor to support multiple env variables
Date: Thu, 24 Feb 2011 12:50:57 -0800
Message-ID: <7v39nd17im.fsf@alter.siamese.dyndns.org>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224142841.GD15477@sigill.intra.peff.net>
 <7vsjvd1e9r.fsf@alter.siamese.dyndns.org>
 <20110224190258.GA4318@sigill.intra.peff.net>
 <7vbp211alu.fsf@alter.siamese.dyndns.org>
 <20110224194828.GA5616@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 21:51:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psi9b-00083l-Qr
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 21:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338Ab1BXUvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 15:51:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab1BXUvK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 15:51:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6E04737E0;
	Thu, 24 Feb 2011 15:52:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ime9QbIWbrNIiIjzzpwufh5lbrA=; b=EmXM/I
	Yt6p/Ttnx2I6pk+6dAE/Jmt7zgJHDS0CN/0B0o+rW2fA4jMMU7ceOiCVEAEa3Nhh
	FFLA/IZE+f/QsOsIiJXO1Kr4RvNvmOdTgbEgXc4b5cM9VePGnXuDcwVwmtcxdfND
	Rx96FVVY4iFxbv0k20cCX/rv1tHCAqW2Y8raM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M0jxMAReSXAA7u7cEDq9gNoUnLFGAedO
	yjHIMjh7y9q9REoiEc3Ab2H4AtyFlxIzHnF5c59w/HnEbysjXS+ag0LxBzCyBKCI
	SSdOKlhExYHNom+W3mqIYXZ4AodSR5k4dtBuBLEBRr6/3d1sqr5Vo5II9HmRyj1m
	PVZIUBYPzg4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2AA6537DD;
	Thu, 24 Feb 2011 15:52:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BC20B37D9; Thu, 24 Feb 2011
 15:52:13 -0500 (EST)
In-Reply-To: <20110224194828.GA5616@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 24 Feb 2011 14\:48\:28 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F8301476-4057-11E0-A275-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167860>

Jeff King <peff@peff.net> writes:

>> > I think I covered that pretty well above, but you lose the flexibility
>> > of pushing different trace types to different places if you want to.
>> 
>> That statement illustrates the inflexibility that all packet traces going
>> to a same place rather clearly, doesn't it, though?  That "two-tier" thing
>> was my primary concern.
>
> Sorry, I don't quite understand what you're saying here.

I was contrasting these two and called that "two-tier thing":

 - GIT_TRACE_SETUP and GIT_TRACE_PACKET can be used to give you
   flexibility of sending their output to the same location or to
   different destination.  Nice and flexibile.

 - Even though the trace identities like "clone", "fetch-pack", etc. are
   clearly marked in the code, you cannot take advantage of the marking
   and send the output from these packet sources to different destination,
   because GIT_TRACE_PACKET is just one and single variable.

Clearer?

Not that I think the same flexibility in the latter is absolutely
necessary, but it somewhat feels inconsistent to have these two classes.
