From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't tried Negotiate
Date: Fri, 05 Feb 2016 13:52:23 -0800
Message-ID: <xmqq60y2dduw.fsf@gitster.mtv.corp.google.com>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
	<xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
	<20160202232952.GA6503@vauxhall.crustytoothpaste.net>
	<CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
	<20160205204648.GA7403@vauxhall.crustytoothpaste.net>
	<xmqqa8nedg59.fsf@gitster.mtv.corp.google.com>
	<20160205210623.GC7403@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 22:52:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRoIs-0002vd-4d
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 22:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbcBEVw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 16:52:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751131AbcBEVw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 16:52:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 316BD40C4C;
	Fri,  5 Feb 2016 16:52:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XCwcvLYL3eJ/48W+xWxzbatY47A=; b=lW0bBE
	Wx0FwMTyRlCvQSy0xrNCS4jlf6VD9mRY4MwWPPVZxNzb02/bh8luFKvCbyA6OROW
	edTspRTjonkJmu18msvdnOX4gnpszXGfteWlWB0RQh3cxqHoV3yqwdkg02FmywAj
	Od9z0G+4a7mtEZF1QkNmCrJo5Nn66KN9TcOaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t6TV07dgdqKY14EC88vJSvNrhD7v9sVb
	IKuO3POHbE7wV/7+5qKkMcHCC9y5rTUHn9cxJCzCxbNWQAnqoTWTU1SGAl3HBBUa
	eOG4Oukif0iWYXGPXj7VP7JY2CTTNTMU6ETDwC2bMx8C7UX8USQOY1LJvQUYZ+KW
	CncpFoP1tos=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2894540C4B;
	Fri,  5 Feb 2016 16:52:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9EDF440C4A;
	Fri,  5 Feb 2016 16:52:24 -0500 (EST)
In-Reply-To: <20160205210623.GC7403@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 5 Feb 2016 21:06:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BDB2C92E-CC52-11E5-BB73-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285640>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Fri, Feb 05, 2016 at 01:02:58PM -0800, Junio C Hamano wrote:
>> Hmph, so documenting that <emptyname>:<emptypassword>@<repository>
>> as a supported way might be an ugly-looking solution to the original
>> problem.  A less ugly-looking solution might be a boolean that can
>> be set per URL (we already have urlmatch-config infrastructure to
>> help us do so) to tell us to pass the empty credential to lubCurl,
>> bypassing the step to ask the user for password that we do not use.
>> 
>> The end-result of either of these solution would strictly be better
>> than the patch we discussed in that the end user will not have to
>> interact with the prompt at all, right?
>
> Yes, that's true.  I'll try to come up with a patch this weekend that
> implements that (maybe remote.forceAuth = true or somesuch).

Thanks.

I think the configuration should live inside http.* namespace, as
there are already things like http[.<url>].sslCert and friends.

I do not have a good suggestion on the name of the leaf-level
variable.  ForceAuth sounds as if you are forcing authentication
even when the other side does not require it, though.
