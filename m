From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-backend: Fix bad treatment of uintmax_t in 
 Content-Length
Date: Sun, 15 Nov 2009 01:08:09 -0800
Message-ID: <7v639crw92.fsf@alter.siamese.dyndns.org>
References: <7vzl6wz36r.fsf@alter.siamese.dyndns.org>
 <905315640911100910r5116779eh24796fa5788f4aef@mail.gmail.com>
 <20091112044240.GP11919@spearce.org>
 <905315640911141349t7121baa8vc0b2be59fa348512@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tarmigan <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 10:08:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9b5x-0001YM-Qi
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 10:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbZKOJIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 04:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbZKOJIR
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 04:08:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbZKOJIO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 04:08:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AA806991EB;
	Sun, 15 Nov 2009 04:08:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=qe+0qMqfyprnWmWd5lgl/JnpULc=; b=cos+AyTFRuS9fhcy/56asfv
	fF3cNLGRagTORtbxSxQO3oYw6RqcllCL6Qmh6jH8bvorbiT9z36sS1r5Hk6Mje9m
	uC3rof76OBlt0P7iX7pf89Gf+e+1b2BODTeLshJcQjVTx7OvQJq+OiaQBPsLqLII
	qiB2zE6wGR9MK8ESHUJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=pruujJm47QYEn+3V+6mxHyER+nFt8ALZTpNjaoEeI6XSwKJSF
	6rfU3z3ZOWu2oX4hhiWscJpZacDSOzts/qw3+FlupWgjaGqE608wT05hTcEu/RAl
	U0f9Z9dafMDhqwgTi93wRuCRDVPRYgivSuwTxYHcEyS7HPxs/2qBb3JDNc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 74B00991EA;
	Sun, 15 Nov 2009 04:08:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 105E9991E9; Sun, 15 Nov 2009
 04:08:10 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 691134F6-D1C6-11DE-833E-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132917>

Tarmigan <tarmigan+git@gmail.com> writes:

> On Wed, Nov 11, 2009 at 8:42 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> Our Content-Length needs to report an off_t, which could be larger
>> precision than size_t on this system (e.g. 32 bit binary built with
>> 64 bit large file support).
>>
>> We also shouldn't be passing a size_t parameter to printf when
>> we've used PRIuMAX as the format specifier.
>>
>> Fix both issues by using uintmax_t for the hdr_int() routine,
>> allowing strbuf's size_t to automatically upcast, and off_t to
>> always fit.
>>
>> Also fixed the copy loop we use inside of send_local_file(), we never
>> actually updated the size variable so we might as well not use it.
>>
>> Reported-by: Tarmigan <tarmigan+git@gmail.com>
>
> Tested-by: Tarmigan <tarmigan+git@gmail.com>

Thanks; care to spell your name in full (as if you are publishing say a
scientific paper)?  I am guessing that the other Tarmigan with full name
who posted a few patches is the same person as you.
