From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t4255: test am submodule with diff.submodule
Date: Wed, 07 Jan 2015 12:20:21 -0800
Message-ID: <xmqq387mjqbe.fsf@gitster.dls.corp.google.com>
References: <1419635506-5045-1-git-send-email-dougk.ff7@gmail.com>
	<1419635506-5045-2-git-send-email-dougk.ff7@gmail.com>
	<CAPig+cT3gA2YpiT2Vr=F5-hB+Zy4ask-kz8DtpL3eFvz9PJb5Q@mail.gmail.com>
	<xmqqiogu1n06.fsf@gitster.dls.corp.google.com>
	<CAEtYS8SiP8bU=82H+XxXZqa47hQ7hOAsZChCr94DwgPNft9L=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Doug Kelly <dougk.ff7@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 21:21:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8x5i-0006yV-W5
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 21:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbbAGUU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 15:20:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751819AbbAGUU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 15:20:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6F612D6C2;
	Wed,  7 Jan 2015 15:20:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IVSYoMRIkv2UlKaJKQFDRLYbS5o=; b=b0Fofa
	r/Lc/JUvn1zECDli9df3jxrZdq9XsFklubEQ46sYYPbLdg0to3trLHuX3CbBZF2k
	hUak4et7xJFpQhsNSCy7YE/6T+K9j7/qImVFthh+qEGhgtSsGtdH8+MUn8e4+Ics
	R8KShMWl5U1CPe3/UP9YcQj3fSCd0fQyvrcQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DaMaGIArWjTboXi7z9OLG5g9rjFbz7kQ
	5rcygw8v7XFMvRPc1dqcYp7jvhUT+7I48KGsp2qSI53E3Wyv5UlKcVFCB2ji+vEN
	Ez2Tl/yrwVQkhCZwDstM0xW7bmP4QqX82f20oGqSCEi2mNN6Ip3z5zRos+Wng9Cb
	iy7WTM6uFSM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCBE02D6C1;
	Wed,  7 Jan 2015 15:20:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 386F12D6C0;
	Wed,  7 Jan 2015 15:20:23 -0500 (EST)
In-Reply-To: <CAEtYS8SiP8bU=82H+XxXZqa47hQ7hOAsZChCr94DwgPNft9L=g@mail.gmail.com>
	(Doug Kelly's message of "Wed, 7 Jan 2015 13:34:23 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9BEAD310-96AA-11E4-B822-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262151>

Doug Kelly <dougk.ff7@gmail.com> writes:

> On Mon, Dec 29, 2014 at 9:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>>> +       (git am --abort || true) &&
>>
>> Why (x || y)?  Is 'x' so unreliable that we do not know how should exit?
>> Should this be "test_must_fail git am --abort"?
>>
> Updated to test_might_fail -- we don't know if a merge is in progress or not.
> We still need to clean up, but disregard failure if a merge isn't in progress.

Ah, OK.  But even with "test_might_fail", it may not be clear why it
might fail, so it would be easier to maintain if we can read "we
don't know if a merge is in progress" next to the "test_might_fail".

For now we can add a comment, but in the longer term it might not be
a bad idea to change test_might_fail to require two args, one is a
command to run and the other is a text that explains why the outcome
is unknown.

Thanks for clarifying.
