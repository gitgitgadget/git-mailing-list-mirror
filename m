From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] diff: turn skip_stat_unmatch on selectively
Date: Fri, 31 Jan 2014 08:17:12 -0800
Message-ID: <xmqqbnysi0s7.fsf@gitster.dls.corp.google.com>
References: <1390632411-3596-3-git-send-email-pclouds@gmail.com>
	<1390863568-22656-1-git-send-email-pclouds@gmail.com>
	<xmqqd2jdm1jj.fsf@gitster.dls.corp.google.com>
	<xmqq7g9jlny6.fsf@gitster.dls.corp.google.com>
	<20140128235203.GA7788@lanh>
	<xmqq61p2k2u5.fsf@gitster.dls.corp.google.com>
	<CACsJy8Dd+baRUi0YjnqDXFi-Fv=K9NxwO=YbYuVEfQkdEXWWWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 31 17:17:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9GmQ-0007n7-HS
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 17:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbaAaQRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 11:17:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60159 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976AbaAaQRS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 11:17:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E7B066F8D;
	Fri, 31 Jan 2014 11:17:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nh4CZdz8bhOUXA5TxYhW8O2zW1o=; b=qLtEmA
	p2uX8CzgGdyQahpoZzNbhhc8e4SHMED2SIFHSqhaO3wIAQ5nhv/XBPrFhEqQ6E6x
	BOdLw8LzIUHgFOFEOX1tZaVSfaodFd9jyhrWYTROyUi+saCm671hXd24kBMSbRPh
	2v+6htt0behZwI8Y6fc9jNDEqt02tBwFbvRo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yJXuuz+UPgFlqLxrktClOyNRMOxF2gjB
	yLJUfb48D1FIpFeR+mWs0sKEj/TJQmbhMqB+DAUjU0nX16vzgFONM6NIrfBXDksr
	VW6B77HO1crjWvSZiy8QJIAckzEaYdV6EJc2x6/BPeIfXGik5yz9EDpSQvIrELp0
	3xIW9DDe8Lw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C08DC66F8C;
	Fri, 31 Jan 2014 11:17:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A99D466F8A;
	Fri, 31 Jan 2014 11:17:15 -0500 (EST)
In-Reply-To: <CACsJy8Dd+baRUi0YjnqDXFi-Fv=K9NxwO=YbYuVEfQkdEXWWWQ@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 30 Jan 2014 12:36:58 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2634341E-8A93-11E3-98C6-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241301>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jan 30, 2014 at 2:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> On Tue, Jan 28, 2014 at 02:51:45PM -0800, Junio C Hamano wrote:
>> This however shows that the existing test *KNEW* that it was enough
>> to check just a few cases (especially, there is no reason to make
>> sure that blob vs file-in-working-tree case behaves sanely), because
>> the auto-refresh would kick in for all codepaths.  Now you are
>> making that assumption invalid, shouldn't the patch also split the
>> tests to cover individual cases?
>
> Drop the last patch, then. It's a "while at there" cleanup patch. If
> it's non trivial then it could be taken up later...

I am leaning towards that because...

> ... not sure I'll go through
> diff.c to identify and write tests for all cases.

... the effort to ensure the correctness of the patch itself
involves the same identification of the cases.

We know the single place skip-stat-unmatch was assigned used to
cover all cases, and the patch was to stop covering cases the
unnecessary assignments are made while making sure the resulting
code still covers cases that assignments are necessary.
