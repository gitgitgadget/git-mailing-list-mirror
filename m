From: Junio C Hamano <gitster@pobox.com>
Subject: Re: grep --no-index and pathspec
Date: Sat, 12 Feb 2011 00:26:49 -0800
Message-ID: <7vvd0py7xy.fsf@alter.siamese.dyndns.org>
References: <20110211095938.360726y1zinab9gk@webmail.df.eu>
 <4D55500B.1070603@drmicha.warpmail.net>
 <7v8vxm1l6q.fsf@alter.siamese.dyndns.org>
 <7vwrl6z20p.fsf@alter.siamese.dyndns.org>
 <AANLkTikG1C=7NRGoi+HWz8rE9RN8-pF6o0=S29GZA3eK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Lars Noschinski <lars@public.noschinski.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 09:27:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoAp4-0005EW-KE
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 09:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab1BLI1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 03:27:01 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab1BLI1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 03:27:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E8C8E288C;
	Sat, 12 Feb 2011 03:28:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MSjJzUrTAH8YxSEmKBM8xfQWRSo=; b=KZx1SS
	uGBgxqCD9zvzjD3Yemn8U0FuladuGVgFO+OBNEzo7oWihI4MPbGumTpT3I4Im7BL
	3RdMVET1DXdqxZFo9EQRY8SSL2cK9DjhrFha79jhmYfOPh+LZxpRiFcWisSgG+wM
	cUOKuKnnwtt6JTn43PNYyzsc/UREcBSXUm/EU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CoTH+JkBJxsqyHn2OgHR5t+Lm7oWzdrx
	2AE5SdNpGA9kFAOx0VbqtKF6mFlLAblx0o10C4/iYRKQAOxLmctyyLjQhQMmRsZA
	srmJZ+Q0zhZ6IALl66+s7m6acpAmTKHBn1Jf7GOkmek2ErSQVKJDUMFkf+eiT1RZ
	BvF/DKIMLfo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A379288B;
	Sat, 12 Feb 2011 03:27:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3C8C8288A; Sat, 12 Feb 2011
 03:27:52 -0500 (EST)
In-Reply-To: <AANLkTikG1C=7NRGoi+HWz8rE9RN8-pF6o0=S29GZA3eK@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Sat\, 12 Feb 2011 15\:14\:59 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FF77FC74-3681-11E0-BBDB-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166602>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2011/2/12 Junio C Hamano <gitster@pobox.com>:
>>
>> The function fill_directory() already takes a pathspec, albeit in the
>> degenerate "const char **" form. Why does its output need further
>> filtering?
>
> Because it was designed so? Quotes from 9fc42d6 (Optimize directory
> listing with pathspec limiter. - 2007-03-30), which added
> simplify_away(), the function that does pathspec filtering for
> fill_directory():
>
>     NOTE! This does *not* obviate the need for the caller to do the *exact*
>     pathspec match later. It's a first-level filter on "read_directory()", but
>     it does not do the full pathspec thing. Maybe it should. But in the
>     meantime,...

I was around back then, so I know how the code came about ;-)

The pieces used in the pathspec limiting logic have been restructured well
enough that I suspect it may now be feasible for us to revisit the "Maybe
it should" part in the above quote.  Thanks to nd/struct-pathspec topic, I
think we are already half-way there.
