From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] add `config_set` API for caching config files
Date: Mon, 07 Jul 2014 10:02:19 -0700
Message-ID: <xmqqwqbpdrvo.fsf@gitster.dls.corp.google.com>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>
	<1404280905-26763-2-git-send-email-tanayabh@gmail.com>
	<vpqoax8m8bh.fsf@anie.imag.fr> <53B63461.2040300@gmail.com>
	<vpq1tu1xz2g.fsf@anie.imag.fr> <53B67322.1080408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:02:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4CJD-00065W-Qh
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 19:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbaGGRC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 13:02:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50673 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669AbaGGRC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 13:02:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D4A326ED2;
	Mon,  7 Jul 2014 13:02:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JZqsJfQoyQZKg4Icrl1/z7HKY1Y=; b=SS4Olu
	L1+7MsmmyhMswqobItP4uj8VQt3aTcYNO5eDPJRp8wxOnTLXOOMeRiwq9CQGfSIy
	aDoNDFdU1XSLEfJGvG3UrGnEX8RriADoTM7xPRrWK0buBg53vNp9yU/8tUdVYhjC
	tIk4JtsPsLNEDviZoVHJonzCgdxHo2VsHtazo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xxC9uifF9q8/MRCGgSj5C6yGCM+WN9so
	lYeS0TzYQYFqZebj+N9ymoXIkX9gmUMgK2Pz+KrZ4f9XVRAYG++wdjk4bltqKSOb
	vfe7/Pg13NDkEkCa/ZDLX4WCBJeA1WDHk+mHy/puU8C8Lq+CyL80pLBbAXvNRMbW
	3p7Hnp7jnY8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4805C26ED0;
	Mon,  7 Jul 2014 13:02:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1F00C26ECD;
	Mon,  7 Jul 2014 13:02:08 -0400 (EDT)
In-Reply-To: <53B67322.1080408@gmail.com> (Tanay Abhra's message of "Fri, 04
	Jul 2014 14:55:54 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6DE064C8-05F8-11E4-9C64-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252968>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/4/2014 2:47 PM, Matthieu Moy wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> Hi,
>>>
>>> I have cooked up a single hashmap implementation. What are your
>>> thoughts about it?
>> 
>> I had a quick look, and it looks good to me. I'll make a more detailed
>> review when you send the next series.
>>
>
> One more doubt, does <filename,linenr> for every value has any use other than
> raising semantic error in typespecific API functions.
>
> For example, if we call git_config_get_int(foo.bar), we can show to the user
> "value not a int at <filename, linenr>". Other than that I cannot think of
> any other use of it. Currently `git_config_int` dies if value put for
> parsing is not an int.
>
> Junio and Karsten, both raised the point for saving <filename,linenr>, but I can't
> find any use cases for it other than what I mentioned above.

Yes, error reporting is what the pair needs to be kept for.
