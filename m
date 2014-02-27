From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack: add `repack.honorpackkeep` config var
Date: Thu, 27 Feb 2014 10:04:44 -0800
Message-ID: <xmqqy50wzb2b.fsf@gitster.dls.corp.google.com>
References: <52E1A99D.6010809@fb.com> <52E1AB78.1000504@fb.com>
	<20140124022822.GC4521@sigill.intra.peff.net>
	<52E1D39B.4050103@fb.com>
	<20140128060954.GA26401@sigill.intra.peff.net>
	<xmqq8uu0mpg8.fsf@gitster.dls.corp.google.com>
	<20140224082459.GA32594@sigill.intra.peff.net>
	<xmqq1tys9vie.fsf@gitster.dls.corp.google.com>
	<20140226101353.GA25711@sigill.intra.peff.net>
	<xmqqr46p39cj.fsf@gitster.dls.corp.google.com>
	<20140227112734.GC29668@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Siddharth Agarwal <sid0@fb.com>, Vicent Marti <tanoku@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 27 19:05:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ5KN-00063P-S8
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 19:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbaB0SEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 13:04:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbaB0SEs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 13:04:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85F3A6FF06;
	Thu, 27 Feb 2014 13:04:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PsTkFK78yOgVKtRw7NJKRAeEhJk=; b=f/IhhN
	OTl0bQrU+hzG60U5q+TyBbuQYjMGwcrohlvoJ9Bmdt3LDcs8n2Nvp2DwtE/obr5S
	7AwCgNnkQTdJ+uWO0K1DNkODBk2+3xUU+8Abi5kR/YzL4G3jsZ9T22hSO/MvzuvI
	6h5QeRALrFETwpDpz1C7O6XGDeU4pwWZXXlgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AB0yPaitIwqKncm9xRwgfRcL4UXtXriS
	CiOSiRB4nueUYwMal+V6Qh+B5/s+3ER5aypTt5d+n+bMqcjE5HZ+KpmPvTLjBzHW
	HtHyEup41pZDuakCFG8Lj+G+OHACOgjC25o5gvXbNUOMXR/+cquIP4UgnPdfAWfo
	AilJQ7bXk8M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DB546FF05;
	Thu, 27 Feb 2014 13:04:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75F6E6FEFD;
	Thu, 27 Feb 2014 13:04:46 -0500 (EST)
In-Reply-To: <20140227112734.GC29668@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 27 Feb 2014 06:27:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A45449B4-9FD9-11E3-8AE2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242834>

Jeff King <peff@peff.net> writes:

> Of all of them, I think --pack-kept-objects is probably the best. And I
> think we are hitting diminishing returns in thinking too much more on
> the name. :)

True enough.

I wonder if it makes sense to link it with "pack.writebitmaps" more
tightly, without even exposing it as a seemingly orthogonal knob
that can be tweaked, though.

I think that is because I do not fully understand the ", because ..."
part of the below:

>> This patch introduces an option to disable the
>> `--honor-pack-keep` option.  It is not triggered by default,
>> even when pack.writeBitmaps is turned on, because its use
>> depends on your overall packing strategy and use of .keep
>> files.

If you ask --write-bitmap-index (or have pack.writeBitmaps on), you
do want the bitmap-index to be written, and unless you tell
pack-objects to ignore the .keep marker, it cannot do so, no?

Does the ", because ..." part above mean "you may have an overall
packing strategy to use .keep file to not ever repack some subset of
the objects, so we will not silently explode the kept objects into a
new pack"?
