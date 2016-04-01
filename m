From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] format-patch: add '--base' option to record base tree info
Date: Fri, 01 Apr 2016 09:00:20 -0700
Message-ID: <xmqqpou9jp4b.fsf@gitster.mtv.corp.google.com>
References: <1459388776-18066-1-git-send-email-xiaolong.ye@intel.com>
	<1459388776-18066-3-git-send-email-xiaolong.ye@intel.com>
	<xmqqy48yo8eb.fsf@gitster.mtv.corp.google.com>
	<20160401133801.GA2915@yexl-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Ye Xiaolong <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 18:00:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am1Uq-0003hK-M2
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 18:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbcDAQAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 12:00:24 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751281AbcDAQAX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 12:00:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A0714E349;
	Fri,  1 Apr 2016 12:00:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Od00JhZ4mFZFDtgPqE9Cof5VJbI=; b=RKjb8t
	SWGH2siusrPCkmVgKznZ1g14+qpnumA3Qzt2swaW73Hjv1G21O6q3tf67Ipk97By
	XkGjGl/4TWuRtQjNZSQzZHiG7Febp7CLFymB06eiucWu9TISZg8oZONuNjz5orRn
	+knb/nnipEis3BeZxuklg/UT3VTj2SM7zsMNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D0Qv6wzU76MDdLbzq9hciS89zFMlLsd2
	nVmRo0WMFOzcT2rJnl/PNUOS/dkB9FIBeyV1a9WSk7CWGcTLVBI0S15ztPlo8yD8
	hQmEmosZRc7kXIv3V1fJwWLmsimBKddc54aDz8W2CL1KEkjY8w00AoVBW3v5QKpR
	Cr05yFGywGg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F8044E348;
	Fri,  1 Apr 2016 12:00:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 443C94E347;
	Fri,  1 Apr 2016 12:00:21 -0400 (EDT)
In-Reply-To: <20160401133801.GA2915@yexl-desktop> (Ye Xiaolong's message of
	"Fri, 1 Apr 2016 21:38:01 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D65D0786-F822-11E5-A7C7-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290547>

Ye Xiaolong <xiaolong.ye@intel.com> writes:

> On Thu, Mar 31, 2016 at 10:38:04AM -0700, Junio C Hamano wrote:
>
>>The contents of this look OK, but does it format correctly via
>>AsciiDoc?  I suspect that only the first paragraph up to "of this
>>shape:" would appear correctly and all the rest would become funny.
>
> Sorry, just heard of AsciiDoc, I will try to use it to do the right format work.

Please make sure "make -C Documentation" produces sensible output
for *.1 (manpage) and *.html.

>>> +	init_revisions(&revs, NULL);
>>> +	revs.max_parents = 1;
>>> +	base->object.flags |= UNINTERESTING;
>>> +	add_pending_object(&revs, &base->object, "base");
>>> +	for (i = 0; i < total; i++) {
>>> +		list[i]->object.flags |= 0;
>>
>>What does this statement do, exactly?  Are you clearing some bits
>>but not others, and if so which ones?
>
> My mistake, it's useless and should be removed.

It probably make sense to do "&= ~UNINTERESTING" there, though.  You
are adding one UNINTERESTING object (i.e. the base) and adding
objects that are on the list[] as interesting.

>>This shows the patches in the order discovered by the revision
>>traversal, which typically is newer to older.  Is that intended?
>>Is it assumed that the order of the patches does not matter?
>
> The prerequisite patches should show in topological order, thus robot
> could parse them one by one and apply the patches in reverse order.

If you have history where base is B, with three prerequisites 1-2-3,
before the patch series A-B-C, i.e.

	B---1---2---3---A---B---C

if you are showing "base-commit: B" as the first line in the base
tree information block, it would be natural to expect that the
prerequisite patch ids are listed for 1 and then 2 and then finally
3, i.e.

	base-commit: B
        prerequisite-patch-id: 1
        prerequisite-patch-id: 2
        prerequisite-patch-id: 3

no?

Also I know _you_ intend to consume this by robot, but it makes me
wonder if with a minimum update you can make the output also more
useful for bystander humans.  A mailing list participant may

 - see an early round of a series that interests her,
 - try to apply them to her tree,
 - find that the series does not apply, but
 - sees that a block to help identify to what tree the series is
   meant to apply.

With a list of 40-hex alone, she may not be able to figure out the
prerequisites, but if there is some other clue that helps her to
identify the base commit and these patches, she may be able to
construct a tree that is close enough.  Maybe you can help her by
appending the title of the commit and patches at the end of these
lines?

This is not a strong suggestion (yet); I am thinking aloud at this
point, without knowing how much it would help in practice to do so.
