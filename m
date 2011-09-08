From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] remove prefix argument from pathspec_prefix
Date: Thu, 08 Sep 2011 09:51:53 -0700
Message-ID: <7vmxefx9hy.fsf@alter.siamese.dyndns.org>
References: <7vbow7ebzw.fsf@alter.siamese.dyndns.org>
 <1315132921-26949-1-git-send-email-drizzd@aon.at>
 <1315132921-26949-2-git-send-email-drizzd@aon.at>
 <7vmxeh8pf4.fsf@alter.siamese.dyndns.org>
 <7vaaah8muf.fsf@alter.siamese.dyndns.org> <20110908071237.GA4408@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:06:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1ngE-0000qX-PL
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166Ab1IHXGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:06:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44798 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130Ab1IHXGj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:06:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 564885EFE;
	Thu,  8 Sep 2011 12:51:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qodp4ZR0OL6ia0h26qPgHqb+qvA=; b=J508OY
	MUucGEoabxMf4xwNjWpPZQiGgU+bQ+B/RHkPxI4F4cW4vJeUq1k5LAJSn/EUMf85
	uDVAw9aw25cK0xo3IkEAoreWPBUiiKqdAdm4HMzJqA9RhdZfpFeXNaFRcS1VoJvc
	3Ce8TBie4bvNYZ0GitoBkuRx+LedRBeGNXrjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xb1zPUgS7R6T4Ms1Zk5UPb7i67RM6Ul9
	GpRmhND1eRJiJtiyr3Ogf0dNt+OMlIZ7h8AulC9pKreAw+TkkusYbreRAT/PHhOS
	erI0v0plVvA5IOwqnsu08MVe+qRUKRZNujJVh7VzDweU5A7YUPW7/RFrHCWggqW2
	I/haGbCJTUA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D1D75EFD;
	Thu,  8 Sep 2011 12:51:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD9415EFB; Thu,  8 Sep 2011
 12:51:54 -0400 (EDT)
In-Reply-To: <20110908071237.GA4408@ecki> (Clemens Buchacher's message of
 "Thu, 8 Sep 2011 09:12:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB9C43FC-DA3A-11E0-A769-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180996>

Clemens Buchacher <drizzd@aon.at> writes:

>> > We also didn't free() in the earlier code (because we do not know if it
>> > can be freed) and leaking xmemdupz() if the function didn't return the
>> > "prefix", but now you plugged the small leak. Isn't it something you
>> > should advertise?
>> 
>> Nah, the leak is not necessarily plugged in all callers anyway, so scratch
>> that part. I've rewritten it like this:
>
> Ok.
>
> The only other caller, though, is cmd_ls_files(). And it would be
> trivial to plug that leak as well.
>
> But is it considered a leak, if the program is going to terminate
> right after the function returns?

it not a big deal to leak immediately before exit, and a patch whose sole
purpose is to plug them is of little value.

But if you are already in the vicinity, updating a function that happens
to have such a leak, the cost to decide not plugging the leak would be
about the same as plugging it, so it would be worth doing in such a case.
