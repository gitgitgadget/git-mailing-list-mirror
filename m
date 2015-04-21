From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 0/4] Improving performance of git clean
Date: Tue, 21 Apr 2015 12:02:37 -0700
Message-ID: <xmqqlhhlgv8y.fsf@gitster.dls.corp.google.com>
References: <1429389672-30209-1-git-send-email-erik.elfstrom@gmail.com>
	<20150420221414.GA13813@hank>
	<CAMpP7NaUv10Ox0gNsE8cg4hUnNNiFi8NZSLw6F6SW+SLrt0VwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <t.gummerer@gmail.com>,
	Git List <git@vger.kernel.org>
To: erik =?utf-8?Q?elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 21:02:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkdRV-0001pu-Cc
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 21:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545AbbDUTCl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2015 15:02:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755286AbbDUTCk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2015 15:02:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C5804AB6A;
	Tue, 21 Apr 2015 15:02:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AkIt71Nh8pvP
	7B0pUDr11TsSyxE=; b=ZqHNAhwAIxkHK6py3mZ7QS+HmpV2Vf0I4b3WpA50KO78
	vFB3hMX3QXATA80g3uki7mwy/pU9zw/fcVCvs7uQPdox1Ej+fLonuaBM0G6n+Jq+
	JbVc/54Y+0MmxU4GKA2HAHm3pXPF1NvQIzZAfFcppojWP1MNlz7a5u94YyBjKJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nJX78w
	GgSqU+4RjvyvbdNC1T6y01gtUdUpkcyPHW2u8dVjuI/tHEMN6XIoHPuuJrweGK9q
	0u9dfrDhYl6HWKWCpi+OWwckGOg0SUwSLLZ1ZH5ccK9+uVHWO8r7G+M6UKEeanlr
	WPnGAHcFCzsLvAe7+rC/0cfN2fXuNuzX+A2Ac=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 210A74AB69;
	Tue, 21 Apr 2015 15:02:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F3734AB67;
	Tue, 21 Apr 2015 15:02:38 -0400 (EDT)
In-Reply-To: <CAMpP7NaUv10Ox0gNsE8cg4hUnNNiFi8NZSLw6F6SW+SLrt0VwQ@mail.gmail.com>
	("erik =?utf-8?Q?elfstr=C3=B6m=22's?= message of "Tue, 21 Apr 2015 20:21:37
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA88EF9C-E858-11E4-8343-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267547>

erik elfstr=C3=B6m <erik.elfstrom@gmail.com> writes:

> Ok, thanks for looking into this.
>
> I have no well founded opinions on the implementation but I do
> think the performance tests would be more meaningful if the
> setup/cleanup code could be removed from the timed section.
> If the community agrees on an implementation I would be happy
> to convert the new tests, either directly in this series or as a foll=
ow
> up if that is preferred.

Let's not delay the fix and do the perf thing as a follow-up series,
possibly an even independent one.

In other words, let's keep the topics small.

>
> /Erik
>
> On Tue, Apr 21, 2015 at 12:14 AM, Thomas Gummerer <t.gummerer@gmail.c=
om> wrote:
>> On 04/18, Erik Elfstr=C3=B6m wrote:
>>> * Still have issues in the performance tests, see comments
>>>   from Thomas Gummerer on v2
>>
>> I've looked at the "modern" style tests again, and I don't the code
>> churn is worth it just for using them for the performance tests.  If
>> anyone wants to take a look at the code, it's at
>> github.com/tgummerer/git tg/perf-lib.
>>
>> I think adding the test_perf_setup_cleanup command would make more
>> sense in this case.  If you want I can send a patch for that.
