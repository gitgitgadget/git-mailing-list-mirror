From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-commit bug
Date: Tue, 26 Jun 2012 11:08:10 -0700
Message-ID: <7vy5naaqut.fsf@alter.siamese.dyndns.org>
References: <20120619091657.GA28005@arachsys.com>
 <7vy5nj1uld.fsf@alter.siamese.dyndns.org>
 <20120619111709.GC10692@arachsys.com> <20120620093205.GB10579@arachsys.com>
 <7vy5nhvo0z.fsf@alter.siamese.dyndns.org>
 <20120620192938.GC31520@sigill.intra.peff.net>
 <20120620193922.GB3192@arachsys.com>
 <20120620194824.GA32228@sigill.intra.peff.net>
 <20120622205026.GI32205@arachsys.com> <20120626150436.GU9682@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 20:08:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjaBp-0004D2-I9
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 20:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758886Ab2FZSIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 14:08:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33889 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758916Ab2FZSIO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 14:08:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A9849EFE;
	Tue, 26 Jun 2012 14:08:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=isuP53l+zxxNykvH7BSZz1HNM3I=; b=NhJ+FK
	pQ/98YwpQs51BwCan54nhVmrWWFz5f7fwiNSZV/5NXqEuq60UkcCmPfr8Scug67C
	gIY/gSCrj0MFTKBTamVLmK/vA8CJhqFj2wRzHs3wIDfrx4b7njW4aL0lZxl0mWEX
	c+pKaIjBDU0UaWmKHjnVX7kYbyP+JEKcuu2OU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B8BGu1LvewNlCQFksL0qqhi1ND46s1ut
	Y+kDcGDCOb/sp118DStpbqyJuCcGbpfB/ole9yJm/VuLHrEF1rI/8CM3Gc2ukvEp
	bKjJnqaOw6yGoD/UHSeyxuLCqA2bpd3k0eSElNRCZ51rpbEoV0kwcR2dxbILRbpd
	TKIYwPyieA0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F2859EFD;
	Tue, 26 Jun 2012 14:08:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 245C79EFC; Tue, 26 Jun 2012
 14:08:12 -0400 (EDT)
In-Reply-To: <20120626150436.GU9682@arachsys.com> (Chris Webb's message of
 "Tue, 26 Jun 2012 16:04:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E51D91B4-BFB9-11E1-8857-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200664>

Chris Webb <chris@arachsys.com> writes:

> Chris Webb <chris@arachsys.com> writes:
>
>> PS Whilst experimenting, I also noticed a (presumably unintentional)
>> behaviour:
>> 
>>   $ git init .
>>   Initialized empty Git repository in /tmp/foo/.git/
>>   $ git checkout --detach
>>   $ touch bar
>>   $ git add bar
>>   $ git commit -m test
>>   [(null) (root-commit) 17b5bf9] test
>>    0 files changed
>>    create mode 100644 bar
>>   $ ls .git/refs/heads/
>>   (null)
>>   $
>> 
>> Here we've created a branch with the strange name '(null)' instead of
>> actually detaching, or refusing to detach because we're on an unborn
>> branch.
>
> This was introduced by abe199808c, which is intended to allow
>
>   git init . && git checkout --orphan newbranch
>
> but presumably wasn't also meant to enable
>
>   git checkout --orphan foo
>   git checkout --detach

Correct.

On days like this, I really regret accepting that --orphan crap in
the first place.

Thanks for fixing things up.

> This leads to a printf("%s", NULL) and thus
>
>   $ git symbolic-ref HEAD
>   refs/heads/(null)
>
> I've followed up to this message with a patch including a test to catch this
> in future.
>
> Best wishes,
>
> Chris.
