From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] push: require force for refs under refs/tags/
Date: Tue, 27 Nov 2012 09:12:45 -0800
Message-ID: <7v7gp7nf5e.fsf@alter.siamese.dyndns.org>
References: <1353644515-17349-1-git-send-email-chris@rorvick.com>
 <1353644515-17349-6-git-send-email-chris@rorvick.com>
 <7vfw3wry4d.fsf@alter.siamese.dyndns.org>
 <CAEUsAPZTycJS_USj-tYNN2Bpwn8XvYDTd4c7wFMFDYfNeSCUtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:13:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdOiV-0002Wg-JI
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:13:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833Ab2K0RMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:12:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526Ab2K0RMr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 12:12:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5365D912A;
	Tue, 27 Nov 2012 12:12:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P8nllWOPUETj6cBR5FlwijFEeTw=; b=kabOQO
	keInd/kboKflmK9kE2Q3eY544myyOFp/PouDgxgINn2LBZ2npTz2QBbnEEQmuHhB
	uYfBL/oFW/QZODd1yEOqlWjlFVKyKGd8nTCDwlVDwGOMz43pu8uYzWe65K7WSrwv
	NTyty8QzjVy2jVaDYG0rE66DsqQ6M7++twsTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g2ZMJHtgnQ4SJjCVp93y4nNpsi05xFZj
	cYXK7rqp+mgVcHTqeB/fwAVi5Zy8kfld0W7Z75UMhj4DabyW998YFan3rqaH3v/i
	Pe3pYJXFwFVJdWP7EAvVB3E9y3lkKOK+70xyM0gdwVLs/raF+JyFPJhnn9ru1ggF
	w3GrLU2Z9aA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F7929129;
	Tue, 27 Nov 2012 12:12:47 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A72F59128; Tue, 27 Nov 2012
 12:12:46 -0500 (EST)
In-Reply-To: <CAEUsAPZTycJS_USj-tYNN2Bpwn8XvYDTd4c7wFMFDYfNeSCUtw@mail.gmail.com> (Chris
 Rorvick's message of "Mon, 26 Nov 2012 22:17:49 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA050BC8-38B5-11E2-B037-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210566>

Chris Rorvick <chris@rorvick.com> writes:

> On Mon, Nov 26, 2012 at 12:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Chris Rorvick <chris@rorvick.com> writes:
>>
>>> diff --git a/remote.c b/remote.c
>>> index 4a6f822..012b52f 100644
>>> --- a/remote.c
>>> +++ b/remote.c
>>> @@ -1315,14 +1315,18 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>>>                *
>>>                * (1) if the old thing does not exist, it is OK.
>>>                *
>>> -              * (2) if you do not have the old thing, you are not allowed
>>> +              * (2) if the destination is under refs/tags/ you are
>>> +              *     not allowed to overwrite it; tags are expected
>>> +              *     to be static once created
>>> +              *
>>> +              * (3) if you do not have the old thing, you are not allowed
>>>                *     to overwrite it; you would not know what you are losing
>>>                *     otherwise.
>>>                *
>>> -              * (3) if both new and old are commit-ish, and new is a
>>> +              * (4) if both new and old are commit-ish, and new is a
>>>                *     descendant of old, it is OK.
>>>                *
>>> -              * (4) regardless of all of the above, removing :B is
>>> +              * (5) regardless of all of the above, removing :B is
>>>                *     always allowed.
>>>                */
>>
>> We may want to reword (0) to make it clear that --force
>> (and +A:B) can be used to defeat all the other rules.
>
> On that note, having (5) be "regardless of all of the above ..." seems
> a little awkward.  That would seem to fit better towards the top.

Sure.  (0) you can always force; (1) you can always delete; and then
other requirements.  That may indeed read better.

Thanks.
