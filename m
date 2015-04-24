From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] refs.c: enable large transactions
Date: Thu, 23 Apr 2015 18:37:47 -0700
Message-ID: <xmqq8udi2tn8.fsf@gitster.dls.corp.google.com>
References: <1429738227-2985-1-git-send-email-sbeller@google.com>
	<xmqqzj5y3f0a.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYO9NifvWQ7nWHP6==ZFmrMj47-94rEHOhWooR5Nh7EUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 03:37:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlSZ2-0008F2-4o
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 03:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbbDXBhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 21:37:50 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752457AbbDXBhu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 21:37:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E5084C459;
	Thu, 23 Apr 2015 21:37:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IQrzKzPzCKDtSGo5VIPwqMkZFxk=; b=Vt4yoH
	VdQb2tHjFD/o8Qia3xIAVhbKKSulF8fPmv2628+C1SuK4HI0tAYt5mScrxzDTHIS
	ebccmJb31kXypaN7scCcWi9yxFhyT86sVUsI6bM1GuUXLqgZMTFqEIVx5f+2iGlZ
	DiAxphYkgbQbM9MzgLvSbm7n9FvNASWtASsDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ndrbOyDzogIccJ1m+Sb5LlcUIKGFjVtV
	wXOED/2NZXOg9AnGUEyNv5eV2pRs+gN0wpTNf9nU/1NtY/x/gbLEYaLfsQmfSwol
	MSCDmrNud1Ji77YuBfjEp2NFfVHiSCmev+zbqvSp3VBalUTzCcdTqvGffEU6cUWe
	6WRgekMO9x0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 06C7B4C458;
	Thu, 23 Apr 2015 21:37:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 842EE4C455;
	Thu, 23 Apr 2015 21:37:48 -0400 (EDT)
In-Reply-To: <CAGZ79kYO9NifvWQ7nWHP6==ZFmrMj47-94rEHOhWooR5Nh7EUw@mail.gmail.com>
	(Stefan Beller's message of "Thu, 23 Apr 2015 17:21:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 839862A2-EA22-11E4-932C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267717>

Stefan Beller <sbeller@google.com> writes:

> On Thu, Apr 23, 2015 at 10:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> +             int save_errno = errno;
>>> +             error("Couldn't reopen %s", lock->lk->filename.buf);
>>
>> No need to change this line, but I noticed that we might want to do
>> something about the first one of the following two:
>
> I personally like to have each error(...) to have a unique string, such
> that when you run into trouble (most likely reported by a user),
> you can easily pinpoint where the exact error is.

I was hoping that the "grep" patterns were strong enough hint, but
let me be explicit.  I was commenting on "Could" not being spelled
as "could".

>>     $ git grep -e '[    ]error(_*"[A-Z]' | wc -l
>>     146
>>     $ git grep -e '[    ]error(_*"[a-z]' | wc -l
>>     390
