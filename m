From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 12:53:10 -0700
Message-ID: <7vd2stibix.fsf@alter.siamese.dyndns.org>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
	<CABURp0r808KeSRwhgPw98vUC+JSErvSYHFyAvn-=8JhQzn8e1Q@mail.gmail.com>
	<CALkWK0nR1=Pgv0AY78p7n17C-VVvbc6BfJ4y_Df1ciZoc-xR-Q@mail.gmail.com>
	<7vppwtid3n.fsf@alter.siamese.dyndns.org>
	<CALkWK0=U8hySDc=OhQu6PjDNJ_fk3UBW8tmNowntghHS2-VbmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 21:53:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcLHi-00041a-WF
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 21:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757626Ab3ENTxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 15:53:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49475 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755358Ab3ENTxO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 15:53:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CE7D1E9ED;
	Tue, 14 May 2013 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5iF23rtpXYW8w+wsOJ7vz7hfclw=; b=twEAKA
	zFyRzgg5f3uS/mW6zmwEndeDEVNoitC0pfj7cBgqBtqaZcJPfuZl1h+lwx8WXxPW
	7vzkT6ZX0Ty4HWvb66NTwEEjrwiJOWKSSpNFePezwgt8CIn/f/HaTlQvr1dxSaRS
	ykOntf9S4UkZzID93YDU6YqJT3iwYVyl8/mos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UrAGEbfvxDdAZp6Ph2qTegUc+ORtRvVK
	WfCxiydDkd1nw3FxtQcoebPUCqYbsiKsXAdtk8xFC6TLvAl0ljlXsyory639HvaB
	08ljv5MRzx58hXrWGVG1jYZphzNPTSvyDLSpfQlHdwtVsYgUi2zWbjZmatE44fPm
	JbkGFTgrAxM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8445E1E9EC;
	Tue, 14 May 2013 19:53:12 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E35EE1E9E7;
	Tue, 14 May 2013 19:53:11 +0000 (UTC)
In-Reply-To: <CALkWK0=U8hySDc=OhQu6PjDNJ_fk3UBW8tmNowntghHS2-VbmQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Wed, 15 May 2013 01:16:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E87E9416-BCCF-11E2-A8BF-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224328>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> What I was trying to say is that it's an accidental feature

There is nothing accidental about it.  It was a very conscious
design decision.

When a commit moves a file wholesale without affecting the block of
code you are interested in, you know that whole block came from the
file in the old tree at pre-rename location without looking at
anywhere else.  That is why renamed but pickaxe-uninteresting
filepairs are dropped.

When a commit moves (some lines of) the block of code you are
interested in from one file to another, it may have been a single
instance moving to another place, but it may well have been multiple
copies consolidated into one (the new copy, pickaxe digging from
future to past may see "disappearing").  That is a significant event
worth digging into further by first stopping there and then
inspecting the whole change with --pickaxe-all to see what changes
that are similar to the change in question exist in the other parts
(notice the multiple) of the tree.

If you do not understand it, then you really should re-read
$gmane/217 and then its explanation I wrote 4 years ago (both of
which I already gave you URLs to in this thread).
