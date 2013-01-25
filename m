From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] mergetool--lib: Improve show_tool_help() output
Date: Fri, 25 Jan 2013 12:06:39 -0800
Message-ID: <7vwqv12fjk.fsf@alter.siamese.dyndns.org>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
 <1359107034-14606-8-git-send-email-davvid@gmail.com>
 <20130125195446.GA7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 25 21:07:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TypYH-0006hu-JC
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 21:07:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337Ab3AYUGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 15:06:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35641 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067Ab3AYUGn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 15:06:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4F36CB92;
	Fri, 25 Jan 2013 15:06:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8bfqfl9X4Ym6J5GQBnAeIsclOPI=; b=O4y2VV
	GdseMzvccHtk5bYIQkzsdj3QUr7Gn1tcKzlX+0oWwsNjVakQc8hO2aLvRLEbDuN/
	wA7PXwU7KormLZ1Eevj1+PvF7GojQ2gyGWaNGpcijQ4W0TYb/CIOQD0g1CGIG9u1
	YWrxSNLB/t8a7skhGPXyYPKz4d05LEF0IHfYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i7RFMgUg9vFGWQlvuP5s8809rFj46hYL
	cs/sg3Ac1F01+mOaN/7vF3GjPnYapd/gHoxn4PjKtGE7po3bKFvV8ExDccuWoaxJ
	t2js3Ja5BZIDKSmF7dHM+MZjwhEdi2voxD52PQKV5KQX3iv/RyiDYblYbruQ46Ay
	h6pwYL5Vhgg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB002CB91;
	Fri, 25 Jan 2013 15:06:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43C08CB7F; Fri, 25 Jan 2013
 15:06:41 -0500 (EST)
In-Reply-To: <20130125195446.GA7498@serenity.lan> (John Keeping's message of
 "Fri, 25 Jan 2013 19:54:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC12BE98-672A-11E2-8C54-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214574>

John Keeping <john@keeping.me.uk> writes:

>> +		tool="$(basename "$i")"
>
> Quotes are unnecessary here.

Yeah, the outer quotes aren't needed; the inner ones are.

>> +		if test "$tool" = "defaults"
>> +		then
>> +			continue
>> +		elif merge_mode && ! can_merge
>> +		then
>> +			continue
>> +		elif diff_mode && ! can_diff
>> +		then
>> +			continue
>> +		fi
>
> Would this be better as:
>
>     test "$tool" = "defaults" && continue
>
>     can_merge || ! merge_mode || continue
>     can_diff || ! diff_mode || continue
>
> or is that a bit too concise?

It is beyond "too concise"; it is unreadable, and more importantly,
the latter two lines are illogical (why do you even ask if it can be
used for merging, before asking merge_mode to see if the answer to
that question matters to you?)
