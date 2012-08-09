From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] rebase -i: use full onto sha1 in reflog
Date: Thu, 09 Aug 2012 10:48:29 -0700
Message-ID: <7vwr18nehe.fsf@alter.siamese.dyndns.org>
References: <89f79049a5fd737716ad51630a8c1ee4a27d747e.1344528082.git.git@drmicha.warpmail.net> <CAOeW2eESQyT0xzy8KjAdhgr45MGosY86cQOy2VsN6TtJqeEYjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 19:48:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzWqa-000156-KS
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 19:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758660Ab2HIRsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 13:48:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61043 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758719Ab2HIRsc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 13:48:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDE6480B8;
	Thu,  9 Aug 2012 13:48:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R/666kECdgdsSLtYYOllH+6waPk=; b=s3koYi
	rj/GekwXE6kyEJZ/oddOTZ49JeJIEiBEddN5qLMMWPjXe3bmnVe2dWFR4fpsLB6n
	k504PMLuA518AruiUI4mC5LoccjDh8ynHNQMpdO+OsK9xS/LabVOqkzsIXMGAnrr
	DkcNt1v2zQEGWmUtOSMP7W8CIxX8BvU3MXni8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iXLINTnFMnrg1mlAvVA68UVDpJbbmegg
	iYe9+n/dOoEJT2kiS4av+7IKEvBA6P/HctpL1CXZkHvrypSN3TrHArFSLbDHZDep
	xqAUF38RFQL5thxll9nOlvZ9lDwM/KlqD/ZREFHys3oNHXDnWGLwqtgynmxuQrk5
	HVhhSMwPvxY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB57B80AF;
	Thu,  9 Aug 2012 13:48:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42D3280AE; Thu,  9 Aug 2012
 13:48:31 -0400 (EDT)
In-Reply-To: <CAOeW2eESQyT0xzy8KjAdhgr45MGosY86cQOy2VsN6TtJqeEYjA@mail.gmail.com> (Martin
 von Zweigbergk's message of "Thu, 9 Aug 2012 10:04:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6ED637C8-E24A-11E1-A75B-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203172>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> On Thu, Aug 9, 2012 at 9:05 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 0d2056f..dbc9de6 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -573,7 +573,7 @@ do_next () {
>>         newhead=$(git rev-parse HEAD) &&
>>         case $head_name in
>>         refs/*)
>> -               message="$GIT_REFLOG_ACTION: $head_name onto $shortonto" &&
>> +               message="$GIT_REFLOG_ACTION: $head_name onto $onto" &&
>
> After this patch, is there any point in the
>
>  shortonto=$(git rev-parse --short $onto) &&
>
> line just before the context? (I can't see any.)

Good point; the function always exits after reaching this point, so
it should be safe to omit it.
