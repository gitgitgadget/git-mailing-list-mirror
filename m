From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] Allow reference values to be checked in a transaction
Date: Mon, 09 Feb 2015 12:45:58 -0800
Message-ID: <xmqqbnl2bypl.fsf@gitster.dls.corp.google.com>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
	<xmqqtwyvapx7.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZmwk5=ViPdRVd+0ncMyAhGAbid6TJUznvMuK6pQ_VSRw@mail.gmail.com>
	<54D91B24.5050808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 09 21:46:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKvDd-0007Vx-1M
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 21:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759820AbbBIUqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 15:46:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759368AbbBIUqD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 15:46:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A06035060;
	Mon,  9 Feb 2015 15:46:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zeSoup01CFgsUn1hWuUk2+dIps8=; b=OjFTuo
	v3EuGSKytW6FpWs/Bui80Tiv6dvVmOszWPF7bcQIxe1laqFsB+fAo7XKc5Yggsfr
	O2CxtaeEubfwZHZcjoSSZ3XyWX3Pf6DfKIuagkVQd/wCdJvz0imdOpilf1CoK0ps
	CipEnOB3XuApSUXRIbrMQFqAX5B+BIZ2k+4Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xjICUuHjCKzrjp/GCRjVwq5AJBkAEPkj
	Scf5qDw7Qnas9P7kU07TeFZ2F/X0D0bDF9N9knQ1SWA/7D+S1DR58xA05FRH0Te9
	Y7PDk5nnokYV5j8ikNAnupq4lHPYMZskMqPF2HsmRnNPqHpM1rtiu6Zg/JhWu3N3
	G6tZ1MyG4AM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 729BB3505F;
	Mon,  9 Feb 2015 15:46:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6383C3505D;
	Mon,  9 Feb 2015 15:46:00 -0500 (EST)
In-Reply-To: <54D91B24.5050808@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 09 Feb 2015 21:40:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A7E5D140-B09C-11E4-ADD6-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263594>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/09/2015 08:05 PM, Stefan Beller wrote:
>> On Mon, Feb 9, 2015 at 10:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>>> [...]
>>>> This patch series applies on top of master merged together with
>>>> sb/atomic-push, which in turn depends on mh/reflog-expire.
>>>
>>> I am a bit puzzled by your intentions, so help me out.
>>>
>>> I see that your understanding is that Stefan will be rerolling the
>>> push atomicity thing; wouldn't we then want to have a "fix and
>>> clean" topic like this one first and build the push atomicity thing
>>> on top instead?
>> 
>> My understanding is to not reroll origin/sb/atomic-push, but
>> origin/sb/atomic-push-fix (which is worded misleading. It is not about
>> atomic pushes, but about enabling large transactions in my understanding)
>
> Yes, that is what I thought.
> ...
> Both series have to do with reflogs, but they are logically pretty
> independent. In particular, "Fix some problems with reflog expiration"
> fixes problems that existed before mh/reflog-expire. And considering
> that one topic is quite mature whereas the the other is just making its
> debut, it seemed like yoking them together would slow down the first
> topic for no good reason.
> ...
> I expected that mh/reflog-expire and sb/atomic-push would be merged
> pretty early in the 2.4 cycle (they are both in next already). Junio, is
> that not your plan?

OK, I am glad I asked for clarifications.  It was that I felt uneasy
to see many new "this cleans and fixes" while there are in-flight
topics in the same area.

Thanks.
