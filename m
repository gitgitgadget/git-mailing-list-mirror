From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 08 Jan 2013 00:05:43 -0800
Message-ID: <7vvcb8f6aw.fsf@alter.siamese.dyndns.org>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
 <20130108062811.GA3131@elie.Belkin> <7vip78go6b.fsf@alter.siamese.dyndns.org>
 <CACsJy8D9+KHT=YfU0+rPCbs+AwxQOpfKzPChDhk8d-MMkRzZug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 09:06:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsUCD-0002xM-Ne
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 09:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066Ab3AHIFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 03:05:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61637 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab3AHIFq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 03:05:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2B3372D2;
	Tue,  8 Jan 2013 03:05:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UlFUkMUThyBuPE7pUlR+ed2yq1I=; b=oZa+5l
	dY//AsZYnmzRpzLxlBxNPJ/8a6qcya82kDRsGJ7n/LbS3MMGfqL/hX5EoxhQ/mDM
	9Ir3EJy/pnPTaTF4NF93WYJEC0RKh1VB5eil/fymqGR/kVPHv6QV3fLid6Gu75Xy
	7dMx+fufMhU4SyjITd9MIX8/ayijYIOZAz7/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Si37HAwht+qWn8gaALtlj4r8N139HTaC
	XDjsszK2wK+M8Y8A0MV8e80T0VwbuXvTzmaycf3jMJGpmFdOwpYOb0/7hQPJJGRx
	CcLgLdJLNNcHY7EDQUNkyVVUz2Ru8CrqOFo59JtF5MxbsoiN4PnEK7vRIP7lYwXz
	2WahSXq6Q24=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 948D272D1;
	Tue,  8 Jan 2013 03:05:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E831172CE; Tue,  8 Jan 2013
 03:05:44 -0500 (EST)
In-Reply-To: <CACsJy8D9+KHT=YfU0+rPCbs+AwxQOpfKzPChDhk8d-MMkRzZug@mail.gmail.com> (Duy
 Nguyen's message of "Tue, 8 Jan 2013 14:38:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3412F562-596A-11E2-9E55-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212945>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Jan 8, 2013 at 1:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Sounds buggy.  Would anything break if we were to make --depth=1 mean
>>> "1 deep, including the tip commit"?
>>
>> As long as we do not change the meaning of the "shallow" count going
>> over the wire (i.e. the number we receive from the user will be
>> fudged, so that user's "depth 1" that used to mean "the tip and one
>> behind it" is expressed as "depth 2" at the end-user level, and we
>> send over the wire the number that corresponded to the old "depth
>> 1"), I do not think anything will break, and then --depth=0 may
>> magically start meaning "only the tip; its immediate parents will
>> not be transferred and recorded as the shallow boundary in the
>> receiving repository".
>
> I'd rather we reserve 0 for unlimited fetch, something we haven't done
> so far [1]. And because "unlimited clone" with --depth does not make
> sense, --depth=0 should be rejected by git-clone.

I actually was thinking about changing --depth=1 to mean "the tip,
with zero commits behind it" (and that was consistent with my
description of "fudging"), but ended up saying "--depth=0" by
mistake.  I too think "--depth=0" or "--depth<0" does not make
sense, so we are in agreement.

Thanks for a sanity check.
