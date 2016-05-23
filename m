From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 2/2] travis-ci: enable sequential test execution for t9113 and 9126
Date: Mon, 23 May 2016 14:47:35 -0700
Message-ID: <xmqqoa7w78g8.fsf@gitster.mtv.corp.google.com>
References: <1463649009-56941-1-git-send-email-larsxschneider@gmail.com>
	<1463649009-56941-3-git-send-email-larsxschneider@gmail.com>
	<20160519100658.GA20225@dcvr.yhbt.net>
	<xmqqwpmqj7m1.fsf@gitster.mtv.corp.google.com>
	<7A9DE9C1-4AC7-4FF3-B8B1-26DE84BA625B@gmail.com>
	<xmqq60u48o6v.fsf@gitster.mtv.corp.google.com>
	<20160523213254.GA11731@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Mon May 23 23:47:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4xhU-0003cG-4C
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 23:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbcEWVrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 17:47:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751904AbcEWVrj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 17:47:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A143B1D654;
	Mon, 23 May 2016 17:47:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yJ0AU3fLUtUV647La1e7V+f19Xw=; b=U/RPKV
	ytiv9HPjVWgMVzFkrdCi08kMSCkJZ5B3A2s/ikyqEczwRHp6s15kQOlslamtuHDw
	udV7nojdViHsZNquNVBHo00QblILYV1kFzhCotznlKbcGum9Hm0ay8VYdWkSWdTk
	kT52icNyw7yfuBXArr2UaNCnFmMNq4Xrm9hBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F6VRRKwSSuP1xvb0OnoP2dhdoYgGluqB
	Wj19vc8/9b3LJUx8yfzWufsfBGL7MwhEg6ipMjJ7HRoHRj9yKO2HuvyIrrCaRQ/q
	ZZkjfH81+zbXLVGEeO91eofzY9GAxldtv2CbXu7LUdUcJHeZ5O/LzUT3cMoo9kLx
	9cK2M981uF8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A3271D653;
	Mon, 23 May 2016 17:47:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 117A31D652;
	Mon, 23 May 2016 17:47:37 -0400 (EDT)
In-Reply-To: <20160523213254.GA11731@dcvr.yhbt.net> (Eric Wong's message of
	"Mon, 23 May 2016 21:32:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F6E612F0-212F-11E6-80D6-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295400>

Eric Wong <e@80x24.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Lars Schneider <larsxschneider@gmail.com> writes:
>> >> On 19 May 2016, at 19:11, Junio C Hamano <gitster@pobox.com> wrote:
>> >> Eric Wong <e@80x24.org> writes:
>> >> 
>> >>> Anyways, how about making the tests run on separate ports and
>> >>> not worry about serializing them at all?
>> >> 
>> >> Yeah, that does sound like a more sensible approach.
>> >
>> > Makes sense. However, it's not something I will tackle soon.
>> > Would you be willing to pick up $gmane/295048 (the first patch) as is 
>> > and drop $gmane/295050 (the patch discussed here)? Then the majority
>> > of Git SVN tests would run on Travis CI.
>> 
>> I am not sure if adding git-svn alone would be a good change.
>> Wouldn't it invite false failures from running these conflicting
>> tests at the same time?
>
> The problematic tests won't run unless *_PORT variables are set;
> which AFAIK they aren't, yet.

Ahh, OK that is perfect.

Thanks!
