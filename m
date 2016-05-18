From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: do not truncate exported marks file
Date: Tue, 17 May 2016 22:02:04 -0700
Message-ID: <xmqqoa84t0vn.fsf@gitster.mtv.corp.google.com>
References: <1463521223-14565-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq1t50uxy1.fsf@gitster.mtv.corp.google.com>
	<CAMP44s1WDzRAFV8iNj_RYiiRwJdBcuUDVR-Ew5FF37qdpEO5Mg@mail.gmail.com>
	<CAPc5daVJCfnEfA1sHrAGsXaA-80kFV4_4Hd0tLOMocE+qVV=-Q@mail.gmail.com>
	<CAMP44s06+V8_PvYA=wsqZ625hrMPLKuZ6v5eOmLBO97kTqwxvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git-fc <git-fc@googlegroups.com>, Git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 07:02:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2tcd-00088c-1y
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 07:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbcERFCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 01:02:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751403AbcERFCI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 01:02:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 189B31DEB5;
	Wed, 18 May 2016 01:02:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A5M4dSqJvmLo++LPKslX4laRTHc=; b=Q/EhLo
	XG1YXU5ES1j6Hn3OgWu8d3j75ejD2Ot1zdkmhC1xxMwxhURbmKoxkWj60Sc0+l1I
	dylprGVFiUF3yEcKTTtkMrdAA/HGsQZ2sWEB0M24rUB0io39lD6QZykWE9Um74lz
	SQkWjtsBJs4NN+sCHRb5nBHNsaLnkB/zIZPU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fUnBFPUrr1thGWWmGHIyhRNkWNg+bPfP
	hM1dviGtCweFf9xnSxSvwSmbfzXQSgmtnQRaPEy8suO/C9q/BNYsA/0Tz1nr3BwE
	Lr+Dichkz6eWa0Ss1WyksL/ITGSh2DGly+qY+stdjR0mN8sA2DXQFUjuj6SfKz7I
	OVhUlzQJEHY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EEB11DEB4;
	Wed, 18 May 2016 01:02:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7716F1DEB3;
	Wed, 18 May 2016 01:02:06 -0400 (EDT)
In-Reply-To: <CAMP44s06+V8_PvYA=wsqZ625hrMPLKuZ6v5eOmLBO97kTqwxvw@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 17 May 2016 23:03:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AB0116BA-1CB5-11E6-8916-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294933>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, May 17, 2016 at 10:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Tue, May 17, 2016 at 8:31 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Tue, May 17, 2016 at 5:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>>>  - Even if we did not read from any existing marks file, if we are
>>>>    given export_marks_file that names an existing file, wouldn't we
>>>>    want to avoid corrupting it with a dump from this aborted run?
>>>
>>> If we don't run from an existing marks file, this patch has no effect.
>>
>> Yes, that is exactly what I was wondering if we may want to improve
>> while at it.
>
> This doesn't make much sense. Corrupted from where? This patch is
> tackling the issue where the imported marks file is "corrupted".

s/corrupted/overwritten by garbage/ is what I really meant, but in
any case, I do not think there is any valid use case that relied on
the current behaviour that will be broken by this update.  I do not
think a script that used separate import and export marks files (and
used mv to rename the exported one to the import used by the next
round, only after seeing fast-import successfully exits) would be
harmed, as a non-zero status is still a non-exit status and it
wouldn't have moved a corrupt export file to the next import, for
example.  Other people and real users of fast-import might find
cases I couldn't think of that this change negatively affects, but
that's expected for any change and that's why we cook any changes in
'pu' and then 'next'.

So let's queue this as a strict improvement.

Thanks.
