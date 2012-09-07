From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] new git check-ignore sub-command
Date: Fri, 07 Sep 2012 09:45:32 -0700
Message-ID: <7v627pzsr7.fsf@alter.siamese.dyndns.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <7v7gscgnnr.fsf@alter.siamese.dyndns.org>
 <CAOkDyE8mEQ5XkH5TBsrVkAZOqoT+DVoggeGawH=cqU6E6=hv=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 18:45:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA1ge-0005lr-LA
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 18:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639Ab2IGQpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 12:45:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173Ab2IGQpf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 12:45:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2174D725C;
	Fri,  7 Sep 2012 12:45:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HoRDAan+NA3yU/7M6KgTvFvymf4=; b=D1j96A
	cob7EzPjg6s0YteEuWyTttqt5nxAV60BKKWwvFf6TxGEGzlKV4CVr3+GAzmw7UL0
	5EWZv5/fC9Wy9RbBhTTUaK22cDlTql5hayd4za3NreAXn586oJ5VnssJbopGtYuN
	hn6NsO6i5uZhxSP9Drl3tOSNi4+ULcSlGkCIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ceFFTC8aXtON28CrpDvcFvoCRW7hxYXL
	Pa53YLgaeMcWfxN96hUMJAUftP5TnaeR6FEZcJDsvHNcRJM1r7PVjRzT098FobNN
	BZpyom8G2Lx44UzQrMyZ9RqaO/bwINmxbV9wM9mGo3Z50VmVhT3gxYda+Cdio6eQ
	kv9RaoSYSKc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F49D725B;
	Fri,  7 Sep 2012 12:45:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A628725A; Fri,  7 Sep 2012
 12:45:34 -0400 (EDT)
In-Reply-To: <CAOkDyE8mEQ5XkH5TBsrVkAZOqoT+DVoggeGawH=cqU6E6=hv=g@mail.gmail.com> (Adam
 Spiers's message of "Fri, 7 Sep 2012 11:03:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71A54A98-F90B-11E1-B8F6-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204975>

Adam Spiers <git@adamspiers.org> writes:

> On Sun, Sep 2, 2012 at 9:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  * avoid unnnecessary braces {} around single statement blocks, e.g.
>>
>>     -if (exclude) {
>>     +if (exclude)
>>         return exclude;
>>     -}
>>
>>  * else should follow close brace '}' of if clause, e.g.
>>
>>      if (...) {
>>          ...
>>     -}
>>     -else {
>>     +} else {
>>          ...
>
> What about when the if clause requires braces but the else clause
> doesn't?  Should it be
>
> 	if (...) {
> 		...;
> 		...;
> 	} else
> 		...;
>
> or
>
> 	if (...) {
> 		...;
> 		...;
> 	}
> 	else
> 		...;
>
> ?

Neither.  We try to do (but often fail ;-)

	if (...) {
        	...;
        	...;
	} else {
        	...;
	}

following the kernel style, unless there is good reason not to.
