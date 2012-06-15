From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: exit(1) if 'diff --quiet <repo file> <external
 file>' finds changes
Date: Fri, 15 Jun 2012 13:08:32 -0700
Message-ID: <7vmx449w3j.fsf@alter.siamese.dyndns.org>
References: <1339781463-13536-1-git-send-email-tim.henigan@gmail.com>
 <7vzk849zxg.fsf@alter.siamese.dyndns.org>
 <20120615193724.GB26473@sigill.intra.peff.net>
 <CAFoueth2Hfcv0p0SZmichi_6e5--SNkemrSsSivnU73bdFOB4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 22:08:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sfcox-0000O1-UZ
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 22:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756308Ab2FOUIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 16:08:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37727 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752247Ab2FOUIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 16:08:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F99B827D;
	Fri, 15 Jun 2012 16:08:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ZG0aOXu0Ov19aabBoj3tZJb3ls=; b=CU5s5s
	MtZdpk0es2PB0s6D+fFFb7dEwXZ/QJEG6XygOzNYKYA5+IpF3xpNv7hgzgxjTmNa
	vysJp2gloUBQ4zoj/PTQ2GnuHJ3FCnnnPzb6hHQi4gZaBjpVPwwA6C9IuiQAH60Q
	gQ6zdqbhYZGzu8rYz8d6ik38yknBWNaz2Ccg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AvTrKpnSTFOieEIeUA9n7V7HdjDcJF0l
	sC/n5mtvd+k2mLbQ9dx+ZWwD/06w8sYB0/a6svzlmb5JoEo1IvLMsNxVvgOmdRAX
	myKT7PFz/Bj9jmNzuBDy2Mi3kEzl96XbrPxApcTSe+/2AkvgOLTQjFOgm4DA8veQ
	sCgb9eT9dU8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26FBA827C;
	Fri, 15 Jun 2012 16:08:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A99F827B; Fri, 15 Jun 2012
 16:08:34 -0400 (EDT)
In-Reply-To: <CAFoueth2Hfcv0p0SZmichi_6e5--SNkemrSsSivnU73bdFOB4g@mail.gmail.com> (Tim
 Henigan's message of "Fri, 15 Jun 2012 15:56:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2C14FE2-B725-11E1-AA84-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200089>

Tim Henigan <tim.henigan@gmail.com> writes:

>>> @@ -273,5 +273,6 @@ void diff_no_index(struct rev_info *revs,
>>>        * The return code for --no-index imitates diff(1):
>>>        * 0 = no changes, 1 = changes, else error
>>>        */
>>> -     exit(revs->diffopt.found_changes);
>>> +     result = !!diff_result_code(&revs->diffopt, 0);
>>> +     exit(result);
>
> I assume the '!!' before 'diff_result_code' is a typo.

Not a typo.  I meant to use that idiom to turn 0 or not into
boolean, as diff_result_code() can return values other than 0 or 1.
