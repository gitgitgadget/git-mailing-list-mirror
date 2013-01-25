From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] mergetool--lib: Improve show_tool_help() output
Date: Fri, 25 Jan 2013 12:16:42 -0800
Message-ID: <7vpq0t2f2t.fsf@alter.siamese.dyndns.org>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
 <1359107034-14606-8-git-send-email-davvid@gmail.com>
 <20130125195446.GA7498@serenity.lan> <20130125200807.GB7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 25 21:17:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Typhz-0002w8-Cv
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 21:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab3AYUQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 15:16:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57503 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab3AYUQp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 15:16:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB475B148;
	Fri, 25 Jan 2013 15:16:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EMD5gLSgPq/oQDOENqm0yssTQ+0=; b=uGzClR
	e/jXvYC7/qx9QpNUSI+tNQAVf04A27yXWbwuKIbnE4oS6wcqOo2IelkiPAgo8BWY
	CHm4lGyleLcI0pjSxaI7oPrMFk0yvhbGf6Q68H4j6b8M/uOscdAR3BWSH+kWU9qI
	LXYy81BvZ4mJquWMwS2T5spSkTwdkWosudupA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xHWDrHxjfbpbOah16k/61Xtfi3sPgxhb
	V9MqKqr1K5ugTNOUPwYD4Oqd58YTJC5FUjgtnq6p0ZBlvKEUWzvbRLhFPHZ4/uv0
	3M7XmC8UiPoa8I/kSv6jG9DsAoqY5wOaWd+z2ZLJbhiX3a+TkMaljHF8E/XXbsrD
	0FpTfp3YNlQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AECAAB146;
	Fri, 25 Jan 2013 15:16:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E80CB140; Fri, 25 Jan 2013
 15:16:44 -0500 (EST)
In-Reply-To: <20130125200807.GB7498@serenity.lan> (John Keeping's message of
 "Fri, 25 Jan 2013 20:08:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23338DCC-672C-11E2-AA0E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214576>

John Keeping <john@keeping.me.uk> writes:

> Actually, can we just change all of the above part of the loop to:
>
> 	test "$tool" = defaults && continue
>
> 	merge_tool_path=$(
> 		setup_tool "$tool" >/dev/null 2>&1 &&
> 		translate_merge_tool_path "$tool"
> 	) || continue

Meaning "setup_tool ought to know which mode we are in and should
fail if we are in merge mode and it does not support merging"?  That
line of reasoning makes tons of sense to me, compared to this script
implementing that logic for these scriptlets.

How/when does translate_merge_tool_path fail?

>
>> >  		if type "$merge_tool_path" >/dev/null 2>&1
>> >  		then
>> > -			available="$available$i$LF"
>> > +			available="$available$tool$LF"
>> >  		else
>> > -			unavailable="$unavailable$i$LF"
>> > +			unavailable="$unavailable$tool$LF"
>> >  		fi
>> >  	done
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
