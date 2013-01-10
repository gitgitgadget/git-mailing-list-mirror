From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/19] reset.c: pass pathspec around instead of (prefix,
 argv) pair
Date: Thu, 10 Jan 2013 15:09:24 -0800
Message-ID: <7vfw28eiu3.fsf@alter.siamese.dyndns.org>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
 <1357719376-16406-4-git-send-email-martinvonz@gmail.com>
 <7vy5g25f9b.fsf@alter.siamese.dyndns.org>
 <CACsJy8Apu1BJ2t+vpbzpQ4Wni==Azzmp99a+TmBzR3h8qpx=8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 00:09:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtRFq-0004d3-Ne
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 00:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733Ab3AJXJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 18:09:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58996 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271Ab3AJXJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 18:09:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87B9FB878;
	Thu, 10 Jan 2013 18:09:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hCZyRGZ+wU1xlp0z+YPTPa+sX68=; b=EperWs
	Es0acyP1xKj9Y8rAAKAdBSZgbkrKRIOYQW+xhpUqpcxU1XhkFMEBQq2eQ082kKXz
	FOUaMBaqIJMn21TvIk7znWFd8/97tNn3RQ5K89VZXX7jqKFs9syjefokeBTwYUbx
	+4PRSCya4QOiVk7+l3LiyChQ2hdGVAEGSObYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CGf7NeLqVKj+7Npzn55ErDlKqLM9O4su
	Tr4UWHO9OlJrcQhylzo4dsRfx1ggrOWMAxRmRWqb75RkVAU4K/lDnXdciqTEMpt0
	A34JXdrPyNbq3U9KcSGwIRMSsaDapK66WbdJSp+E8QWbrwSWF4NnseohvCcB2e/F
	Omu0S2Nn3OY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C28FB877;
	Thu, 10 Jan 2013 18:09:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3775B876; Thu, 10 Jan 2013
 18:09:25 -0500 (EST)
In-Reply-To: <CACsJy8Apu1BJ2t+vpbzpQ4Wni==Azzmp99a+TmBzR3h8qpx=8g@mail.gmail.com> (Duy
 Nguyen's message of "Thu, 10 Jan 2013 18:05:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7157012-5B7A-11E2-8DBD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213160>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jan 10, 2013 at 2:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>>
>>> We use the path arguments in two places in reset.c: in
>>> interactive_reset() and read_from_tree(). Both of these call
>>> get_pathspec(), so we pass the (prefix, arv) pair to both
>>> functions. Move the call to get_pathspec() out of these methods, for
>>> two reasons: 1) One argument is simpler than two. 2) It lets us use
>>> the (arguably clearer) "if (pathspec)" in place of "if (i < argc)".
>>> ---
>>> If I understand correctly, this should be rebased on top of
>>> nd/parse-pathspec. Please let me know.
>>
>> Yeah, this will conflict with the get_pathspec-to-parse_pathspec
>> conversion Duy has been working on.
>
> Or I could hold off nd/parse-pathspec if this series has a better
> chance of graduation first. Decision?

I am greedy and want to have both ;-)

Before deciding that, I'd appreciate a second set of eyes giving
Martin's series an independent review, to see if it is going in the
right direction.  I think I didn't spot anything questionable in it
myself, but second opinion always helps.

There is no textual conflict between the two topics at the moment,
but because the ultimate goal of your series is to remove all uses
of the pathspec.raw[] field outside the implementation of pathspec
matching, it might help to rename the field to _private_raw (or
remove it), and either make get_pathspec() private or disappear, to
ensure that the compiler will help us catching semantic conflicts
with new users of it at a late stage of your series.
