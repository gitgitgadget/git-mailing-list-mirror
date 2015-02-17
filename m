From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] doc: document error handling functions and conventions (Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf)
Date: Tue, 17 Feb 2015 14:46:48 -0800
Message-ID: <xmqqr3toyx47.fsf@gitster.dls.corp.google.com>
References: <20141204234147.GF16345@google.com>
	<20141204234432.GA29953@peff.net>
	<CAPc5daW3+8xjG3z3WgOMfqzWJUiPdcN1-FVgVc0fAjH7tgCa4A@mail.gmail.com>
	<20141205000128.GA30048@peff.net>
	<xmqqfvcuq8nu.fsf@gitster.dls.corp.google.com>
	<20141207100755.GB22230@peff.net>
	<xmqqk320mzo7.fsf@gitster.dls.corp.google.com>
	<xmqqd25epw24.fsf@gitster.dls.corp.google.com>
	<54E3632F.20907@alum.mit.edu>
	<xmqq1tlo4jbf.fsf@gitster.dls.corp.google.com>
	<20150217160524.GA11186@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 23:46:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNqut-0004se-RX
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 23:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbbBQWqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 17:46:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751063AbbBQWqv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 17:46:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F4F338FC8;
	Tue, 17 Feb 2015 17:46:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wf8XMq/vqY1gwAq+x5UvVj8io3s=; b=CkFSab
	11UCgW6Lft2q6XG3XwdxJXVH24VUGmiqPTY4ew0X8QaE/MOqsebx0y1JuR5CE8Qb
	7ES1Zw3pYwnznQNQjeZSl0/mK8H1Gxu5i+PtLF9bdjYZKEkG/UyWNivt7FvqpYtq
	4cvCBU5HF0eD5ZKczLbsS3Cw8rUb7zH7Iqe64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uNad8Yoev8g/jLzpkg7akrm2lTFUrFlO
	+lgqtz2Z0MX1HR6jHF3MMsUx4kIDoXW9d/bF8grraDe4rSp7dPLAXyanGfWV8hOp
	bdG+tTU3vT56bTQWLaYcRXQMRm+hBpBK9AH4LJPXjh3JgzE05dEVXRZiOh5EZpE7
	SIdTLbU0UpQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63BB338FC7;
	Tue, 17 Feb 2015 17:46:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DAAB838FC6;
	Tue, 17 Feb 2015 17:46:49 -0500 (EST)
In-Reply-To: <20150217160524.GA11186@peff.net> (Jeff King's message of "Tue,
	17 Feb 2015 11:05:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DC1D79C6-B6F6-11E4-AF9A-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263994>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 17, 2015 at 08:03:00AM -0800, Junio C Hamano wrote:
>
>> > Whether or not we decide on a different error-handling convention in the
>> > future, it is a fact of life that a good bit of code already uses the
>> > "strbuf" convention documented by Jonathan's patch. So I think it is OK
>> > to merge it as is. If we change the preferred convention in the future,
>> > one part of the change will be to update this file.
>> 
>> I wasn't sure about "a good bit of code already", but that settles
>> it.  Let's take it as-is and see how the code evolves.
>
> I'm not convinced myself after a quick grep. But it's certainly
> non-zero, and I think I would rather have the technique documented than
> not, so I withdraw my earlier complaints.

OK.
