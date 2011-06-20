From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] branch: add optional parameter to -r to specify
 remote
Date: Mon, 20 Jun 2011 08:49:09 -0700
Message-ID: <7vwrggcxl6.fsf@alter.siamese.dyndns.org>
References: <1308511149-10933-1-git-send-email-billiob@gmail.com>
 <1308511149-10933-2-git-send-email-billiob@gmail.com>
 <7vtyble9k8.fsf@alter.siamese.dyndns.org> <4DFEEB60.5000005@viscovery.net>
 <20110620070316.GA15246@sigill.intra.peff.net>
 <4DFF2A1D.3060206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Boris Faure <billiob@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 17:49:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYgj0-0001yr-Oo
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 17:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314Ab1FTPtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 11:49:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786Ab1FTPtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 11:49:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 01FC0553C;
	Mon, 20 Jun 2011 11:51:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=okfLh6CM0aZloTpVP+Ys/rz2Th4=; b=R4aiPH
	JYEYfZfMWijzyfuq3sNZu15ddjZUifnoTluxCXCCn7MGqS0TBYaa6o4TTcE8Leqg
	lJZ1Akm5qT/ncBgrQQLJpX8Caew/S3XZqyw8Yl7kPN85XBOj2dN3w7simIosO69G
	Fdu2LkN5WEJMjxIh4MhadRrN3+oO/ML9wB/c0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ejep5KKWcg9fHvK3J2pADGNjI759Q49+
	51FYKJlAB8NNyY2YJkLcsFWoO6pHWVstTWJPdd5P1XniTrZeJTJcAenJveQ5Afg0
	AhUJj26nxDVUrOFvF5EyVa7LZiHC3m+//zGUXMfb1wiuqacm6RoGdEz17GbEtGof
	TrjQ+pNMJCY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EE5F3553B;
	Mon, 20 Jun 2011 11:51:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 493F35536; Mon, 20 Jun 2011
 11:51:22 -0400 (EDT)
In-Reply-To: <4DFF2A1D.3060206@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 20 Jun 2011 13:08:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25665B3C-9B55-11E0-9687-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176074>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> For that matter, --match should be spelled "--glob", as we already have:
>> 
>>   $ git log --glob='jk/*'
>> 
>> I think having the ref-selection for "git branch" match that of the
>> revision walker makes sense.
>> 
>> -Peff
>
> Well, "branch" is about refs, and "log" about revs.

Not really. What "log" output by traversing is about revisions, but we are
discussing how the command line argument discover the set of refs to feed
into the underlying machinery that does different things in each of the
command (branch just lists them without any traversal, log shows history
leading to the commits). So I do not see any difference and I think it
would be appropriate if we can use the same notation to specify both "I
want to see all branches that match this pattern" and "I want to see
history leading to all refs that match this pattern".

> I'd rather have
> "branch" similar to "tag" in that respect (i.e. '-l').

And "tag --glob='*'" also falls into the same class from that point of
view: "I want to see all tags that match this pattern".

Thanks.
