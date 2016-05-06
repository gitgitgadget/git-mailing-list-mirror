From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] test-parse-options: --expect=<string> option to simplify tests
Date: Fri, 06 May 2016 00:18:12 -0700
Message-ID: <xmqqwpn764ej.fsf@gitster.mtv.corp.google.com>
References: <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
	<20160505215056.28224-1-gitster@pobox.com>
	<20160505215056.28224-4-gitster@pobox.com>
	<CAGZ79kY+9BUjcbpSA8sAqd=qZ5niZ2CDsPeGuXhK+yqZY4hL9Q@mail.gmail.com>
	<xmqqeg9f7v1l.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZ59K5BoSVsbt4YM-Try9Q1CVdFeBW8GE5E1dJpSBWzVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 06 09:18:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aya1l-0005z3-13
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 09:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbcEFHSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 03:18:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54998 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751171AbcEFHSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 03:18:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 29D9010CF5;
	Fri,  6 May 2016 03:18:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i37Z76iOI3M4S8ZxcipqiBacZHk=; b=Y/ZX2b
	zKxYMvXVR5HytppOjYaK1wV1wOZBiiEqnqsnwltm4WxeHVfjfyPUd8cDTiY2wR0m
	X9w3e4i9yMI0GXABrOO46h9gUT13R965+ZiG63Su6ucwqpagjEp8FnMoeGkMRkBd
	ugbDTUiz+zb8sVOZ53gtNv7R5GwViz35mVl4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=crP8nwyF7jWxMAgBbzOCioFC9Hp4mnHH
	6Q5OUgUz4ZXSN9nf/xC2ie9K9EnxDGO1WKDMPM1AE+qqoT5OX3gP4/zT0HW5U0eU
	IQIToxVxBhoM+gfhMZHr20bwi7A64JZM+x9LY0FwoG9/wy8H81FdzPXq5CxqJe73
	Z+C2F3R4IqY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 20AD910CF3;
	Fri,  6 May 2016 03:18:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8BAF510CF1;
	Fri,  6 May 2016 03:18:14 -0400 (EDT)
In-Reply-To: <CAGZ79kZ59K5BoSVsbt4YM-Try9Q1CVdFeBW8GE5E1dJpSBWzVA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 5 May 2016 22:51:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B29AC010-135A-11E6-A9D5-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293749>

Stefan Beller <sbeller@google.com> writes:

>> +               *colon = '\0';
>> +               item = string_list_lookup(expect, buf.buf);
>> +               *colon = ':';
>
> I have been staring at this for a good couple of minutes and wondered if this
> low level string manipulation is really the best way to do it.

It just shows that string_list API was not designed as richly as
others, compared to say the more complete API like strbuf.  If it
had a <ptr,len> variant, I wouldn't have needed the "temporary
termination to get a string" hack.
