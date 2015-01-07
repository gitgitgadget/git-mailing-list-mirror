From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t/t3308-notes-merge.sh: succeed with relaxed notes refs
Date: Wed, 07 Jan 2015 08:03:58 -0800
Message-ID: <xmqqiogilgr5.fsf@gitster.dls.corp.google.com>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c>
	<e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c>
	<xmqq8uhgqkge.fsf@gitster.dls.corp.google.com>
	<20150107011958.GA3536@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>,
	Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 07 17:04:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8t5r-00080S-5A
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 17:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbbAGQEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 11:04:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752568AbbAGQEN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 11:04:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E66C290A5;
	Wed,  7 Jan 2015 11:04:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TRgctteAINrbHSl4IiOvypCMuU8=; b=nCSZff
	C94nZRW/hCoPmtxWCiRpuHXP2ZnJo+90a714WYXWceiwgwn/7LYp1zxRx96M/pPT
	6iGZc6iOm88lj2MVGiyngo3WXzV/O9xBj6tVOmdkdZMb0MrRACTNkHbWw0ZGENDj
	Czwt85n2+wM6sqhLnzbvZeEqtMgXILlfBA8OA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eYwr23xkXOqwQxTNRoMXhwxZfn/TIHvr
	y7dwkBzZVa4tRBKIxxpPK7G6Bd5LJ0EOO6JXgmTPrO48+InKNLxy56M3G1lDSlxe
	T5IIketyNqLdy/pMgxcotCaZZf37LxzBe7aofy9PuSR0OA1P18ont8Rc0FFhJQEQ
	p2Dx6rHzVnE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 93046290A4;
	Wed,  7 Jan 2015 11:04:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F3DC2909A;
	Wed,  7 Jan 2015 11:03:59 -0500 (EST)
In-Reply-To: <20150107011958.GA3536@peff.net> (Jeff King's message of "Tue, 6
	Jan 2015 20:19:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CA983F64-9686-11E4-9DA4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262134>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 06, 2015 at 02:20:33AM -0800, Junio C Hamano wrote:
>
>> The fact that "git notes merge refs/heads/master" fails is a very
>> good prevention of end-user mistakes, and this removal of test
>> demonstrates that we are dropping a valuable safety.
>
> Is it really that valuable? If it were:
>
>   git notes merge master
>
> I could see somebody running that accidentally.
> ...
> But we are talking about
> somebody who is already fully-qualifying a ref (and anything unqualified
> continues to get looked up under refs/notes).

That (specifically 'merge') is not my real worry.  It's the other
way around, actually.

Because expand_notes_ref() makes sure that any given notes ref is
prefixed appropriately to start with refs/notes/,

    git notes --ref=refs/heads/master add ...blah...
    git notes --ref=refs/tag/v1.0 add ...blah...

would be a sensible way when somebody wants to keep a forest of
notes refs, one per real ref.  Wouldn't they have already been
trained to spell "refs/heads/master" when they want to refer to
refs/notes/refs/heads/master because of this?
