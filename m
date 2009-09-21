From: Junio C Hamano <gitster@pobox.com>
Subject: Re: install does not obey DESTDIR or --prefix for perl modules
Date: Mon, 21 Sep 2009 10:58:20 -0700
Message-ID: <7vskeguqmb.fsf@alter.siamese.dyndns.org>
References: <20090921160551.GD8173@gryning.com>
 <Ow6bpZou9Vi0tKlyAN-qfjlAAtXvMqpXEAiG54zZ3C8fLI_6_Bt3oA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: c@gryning.com, git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Sep 21 19:58:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mpn9t-0002Os-Ah
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 19:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbZIUR6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 13:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbZIUR6b
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 13:58:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbZIUR6a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 13:58:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A5140591C9;
	Mon, 21 Sep 2009 13:58:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h8I0Xe/A7VM/rRtBzAscC2MXk+A=; b=bHauus
	i78pKudTGylw6Jxhf5KZGYumxPTtfRXVHzmRX/sUc8dp2C27kKmCcxvx5ZJDH4oJ
	Y2M8+0QvLjWgJbPFOuWZ/aF9E4j2t2JtoCs6GpSFufyT3wt3MUhZRkvCgs+mgDdW
	Z89RVsyPHNWLhE9NN2l/ZT11C8mV8WkpJg+rY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CQB0Q8WadfLjNW9Gvi2UL6JE2+Bc+ive
	LlayViaWeL/gwB2O2Tviro40XYQSAKlCKw/f6VEG3kNtScEpYVT3GF9YjDNxQ/Kx
	riK4OeKH7/fkJ7kKvC+vOC4y2cNRCES0TBuwUlXiLPtcu2/De5gzbdMhKhyxvK5z
	I8owXFGIu/4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A826591C5;
	Mon, 21 Sep 2009 13:58:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1D143591C4; Mon, 21 Sep 2009
 13:58:24 -0400 (EDT)
In-Reply-To: <Ow6bpZou9Vi0tKlyAN-qfjlAAtXvMqpXEAiG54zZ3C8fLI_6_Bt3oA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Mon\, 21 Sep 2009 11\:58\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5EFE2AD2-A6D8-11DE-B532-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128898>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:

> Craig Taylor wrote:
>> Hi all
>> 
>> I'm compiling/installing git in a Solaris environment without root.
>> Using 'make DESTDIR=<some path> install' to stage an install to an
>> alternate location.
>> The perl module component of 'make DESTDIR=<some path> install' installs
>> into the system perl lib path without prepending the forced install
>> destination or my '--prefix'.
>> This seems counter intuitive and I would consider a bug.
>
> Try 'make prefix=<some path>'.
>
> btw, this is in the first paragraph of the INSTALL document.

But is that what Craig is trying to do?

I think he wants to build git to be installed in /usr/bin/git or whatever,
and he would say "prefix=/usr".  He however wants "make install" to write
into /var/tmp/g/usr/bin/git, not /usr/bin/git, so that he can for example
make a tarball with "cd /var/tmp/g && tar cf ../git.tar .", and extract it
as root under the real '/'.  "make DESTDIR=/var/tmp/g" is exactly for
that, and if it is not working I would say it is a bug.
