From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] mergetools: Fix difftool/mergetool --tool-help
 listing for vim
Date: Fri, 25 Jan 2013 11:11:23 -0800
Message-ID: <7vd2wt3wo4.fsf@alter.siamese.dyndns.org>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
 <1359107034-14606-7-git-send-email-davvid@gmail.com>
 <20130125103845.GX7498@serenity.lan>
 <CAJDDKr5ZsqO+PFoUabsZObgvG8jUBfTKL1HmVsn77ZhzsRZk-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 20:11:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyogr-0006mL-T9
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 20:11:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757032Ab3AYTLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 14:11:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756547Ab3AYTL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 14:11:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD399C6EE;
	Fri, 25 Jan 2013 14:11:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zulcX85lU1jNOf7cdg43AhEZcRo=; b=CJQtjF
	biv7ydAonZ/IkHDwMKYOsUWlDli8RQHBPT8BIoRN7XzXmrGOLFuDFh8h619vOBSZ
	lz/CWwgy8YdZWMFmslpAsK08DuzPZybjnS0WvUEEF0mSGyeozgArWivpjcUZ5r5y
	f/bfU4vjVp8DO7rL10hqFr+3k0U59IP8rQHCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QhJsa7WUGRMf4RZXHEREOga4AxxXZcWQ
	GYlKJM9ZWkQMGVKMWGTu+zYIQMowCYGrF5lCETks/MY9Jl4KUfryNqBWRskMSUpZ
	64VtwanMQgcN/k7poD2eoC7n/4CH+Rxl3U6sj+/pBsa6hPWZp9hhNAsG6Ms00INB
	EoeUE/11Ges=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1E4BC6ED;
	Fri, 25 Jan 2013 14:11:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 550C9C6EC; Fri, 25 Jan 2013
 14:11:25 -0500 (EST)
In-Reply-To: <CAJDDKr5ZsqO+PFoUabsZObgvG8jUBfTKL1HmVsn77ZhzsRZk-Q@mail.gmail.com> (David
 Aguilar's message of "Fri, 25 Jan 2013 02:40:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 036D7A10-6723-11E2-9ED6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214570>

David Aguilar <davvid@gmail.com> writes:

> On Fri, Jan 25, 2013 at 2:38 AM, John Keeping <john@keeping.me.uk> wrote:
>> On Fri, Jan 25, 2013 at 01:43:53AM -0800, David Aguilar wrote:
>>> "git difftool --tool-help" and "git mergetool --tool-help" incorreclty
>>> list "vim" as being an unavailable tool.  This is because they attempt
>>> to find a tool named according to the mergetool scriptlet instead of the Git-
>>> recognized tool name.
>>
>> Actually, after my patches both git-difftool and git-mergetool get this
>> right since list_merge_tool_candidates lists vimdiff and gvimdiff.
>>
>>> vimdiff, vimdiff2, gvimdiff, and gvimdiff2 are all provided by the "vim"
>>> scriptlet.  This required git-mergetool--lib to special-case it when
>>> setting up the tool.
>>>
>>> Remove the exception for "vim" and allow the scriptlets to be found
>>> naturally by using symlinks to a single "vimdiff" scriptlet.
>>
>> I wonder if it would be better to make these single-line scripts instead
>> of symlinks:
>>
>>     . "$MERGE_TOOLS_DIR"/vimdiff
>>
>> where we make git-mergetool--lib.sh export:
>>
>>     MERGE_TOOLS_DIR=$(git --exec-path)/mergetools
>
> That sounds like the way to go.

Yup, I'll expect a reroll of this one and possibly the next one (I
haven't read yet).

1-5/7 looked all very sensible.

Thanks.
