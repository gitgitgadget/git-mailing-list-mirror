From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Wed, 11 Mar 2015 14:31:33 -0700
Message-ID: <xmqq7fun5ih6.fsf@gitster.dls.corp.google.com>
References: <54F88684.3020905@alum.mit.edu>
	<xmqqwq2v14iv.fsf@gitster.dls.corp.google.com>
	<54F9422D.2020800@web.de> <54F9E907.4040703@alum.mit.edu>
	<54FA1C7B.3040906@web.de> <54FF450F.7040506@alum.mit.edu>
	<xmqq385c1v13.fsf@gitster.dls.corp.google.com>
	<54FF6D23.4060301@alum.mit.edu>
	<xmqqsidcxy2q.fsf@gitster.dls.corp.google.com>
	<5500A5F7.1000503@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Torsten =?utf-8?Q?B=C3=B6ger?= =?utf-8?Q?shausen?= 
	<tboegi@web.de>, git discussion list <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 22:31:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVoE8-00051l-Vg
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 22:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbbCKVbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 17:31:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752104AbbCKVbf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 17:31:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E59733FF66;
	Wed, 11 Mar 2015 17:31:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UCnBMravlO0KMVollcvLnjxJiRo=; b=BMqwUH
	rUVLCrKv/v7k/S45ccyNWyYyyXHtz/vyYLaoOHHnr3yGeGXuDOnmaOeaLbkirPbb
	O8BR4dvRDHMy1YzAnYXi274CGIaYPNWJOV8ybkwIXl0HtI4imLXEnSllZ0e3LbG1
	jODUzO4NmVRKd3VABWwrM8gWvsnoYv4+Cn2Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nagB9eKyUUegCviBQUGyQUnpZWGZ6pA5
	gkdnJROzAowEJw9s+vHjjW0DDWA+yDM5y1SClDyBANhUS9CZEEMXuzMYZQsAHYdU
	7i59glN0X0G95kR545I5IV/R7gdSwigHpPvYFagiSn0K7slLk0e3KVCVN7ANJtgY
	RESZZsIbcoM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD6973FF65;
	Wed, 11 Mar 2015 17:31:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 568C03FF64;
	Wed, 11 Mar 2015 17:31:34 -0400 (EDT)
In-Reply-To: <5500A5F7.1000503@kdbg.org> (Johannes Sixt's message of "Wed, 11
	Mar 2015 21:30:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FDBB2844-C835-11E4-BA3A-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265340>

Johannes Sixt <j6t@kdbg.org> writes:

>> I would say former.  You find out what attributes apply to a path
>> and then consider the collective effect of these attributes that
>> survived.
>>
>> So the second "No it is not text" which is overruled by the "oops,
>> no that is text" later should not get in the picture, I would say.
>>
>> As binary is not just -text and turns other things off, those other
>> things will be off after these three.
>
> Is that how attribute lookup works? I.e., given a path, all attributes
> are collected?
>
> Isn't it more like: Here we are interested in the "eol" attribute of
> this file named "a.foo". And the lookup would find the first line that
> says "eol=crlf". Elsewhere, we are interested in the "binary"
> attribute of the file named "a.foo", and lookup would find the second
> line that sets the "binary" attribute. And again elsewhere, we ask for
> the "text" attribute, and we find the last line that sets the "text"
> property.
>
> Am I totally off track?

In the codepath in question, we say "we are interested in text and
eol attributes", grab the values (set/unset/set-to-value/unspecified)
for these two for the path we are interested in from all the
applicable gitattributes file and then act on the result.
