From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 04 Feb 2014 13:41:49 -0800
Message-ID: <xmqqvbwu7dya.fsf@gitster.dls.corp.google.com>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
	<87ha8ewqfv.fsf@fencepost.gnu.org>
	<xmqqzjm67fpu.fsf@gitster.dls.corp.google.com>
	<878utqwpkx.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 04 22:42:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAnkm-0000ef-HK
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 22:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934819AbaBDVl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 16:41:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933785AbaBDVly (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 16:41:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 469FF67B0F;
	Tue,  4 Feb 2014 16:41:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PPTYvpQ1il5sL/dCZfVJ7rX+DtU=; b=C8dImU
	Y6QvAoY0ynBAYFwlPCzfkIpuCtG673aqrWWg27MVn6IZ/entSwV6P/u0rQEZRhfs
	NnvI4/KWQoaUuV/rcQWmAEXF55S7hgCR0rnsYT29jH4q/1pLdqXA9bI9TXalnLkK
	M8HW4TWLA2Qcj+VmkuXdKvMn4A2yhMrImY7f0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IKoQIjlK5ofRt988yW8RTQZzO1Mp6a4I
	RV3cvWpJt9NnsTF71uYCQHx560SScj/bGNBOzt9XsJ/LXXd2opD6+yYMjH5N3M9X
	cs/WAx2e7cdSn3ekglbS4EVMWo6Dvn2H8oQ6rDG5AF8EW6ufCUYbwUoYXm0ulMwE
	LX5ZaAcGy2Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30FA867B0E;
	Tue,  4 Feb 2014 16:41:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D19567B0D;
	Tue,  4 Feb 2014 16:41:52 -0500 (EST)
In-Reply-To: <878utqwpkx.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Tue, 04 Feb 2014 22:11:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 28DE0D0C-8DE5-11E3-8D13-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241559>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> David Kastrup <dak@gnu.org> writes:
>>
>>> Anybody know offhand what I should be including here?  It looks like Git
>>> has some fallback definitions of its own, so it's probably not just
>>> <string.h> I should include?
>>
>> In general, no *.c files outside the compatibility layer should
>> include anything "#include <system-header.h>", as there seem to be
>> finicky systems that care about order of inclusion and feature macro
>> definitions, all of which are meant to be handled by including
>> git-compat-util.h as the very first thing.
>
> Ok, and that one's not yet in blame.c.  Will include, thanks.

No, don't.  Some well-known *.h files of ourse, most notably
cache.h, are known to include compat-util as the first thing, and
that is what *.c files typically include.
