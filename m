From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in
 .git/info/exclude
Date: Wed, 23 Nov 2011 21:17:23 -0800
Message-ID: <7vlir69k0s.fsf@alter.siamese.dyndns.org>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 <7vehx2ijf8.fsf@alter.siamese.dyndns.org>
 <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx>
 <7vzkfqgn91.fsf@alter.siamese.dyndns.org> <4EC9FC81.3080306@viscovery.net>
 <20111121081701.GA7985@do> <7vk46th5bz.fsf@alter.siamese.dyndns.org>
 <CACsJy8A7HVe8kLR5j9Ej0tJhpkxigCXRqpg9DvE9qJsfengi1Q@mail.gmail.com>
 <7vy5v6bvy4.fsf@alter.siamese.dyndns.org>
 <CACsJy8BYN-nu6a92dk-qpF5_jR_frKwg+DD1EThr2kMPGHV5kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Taylor Hedberg <tmhedberg@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 24 06:19:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTRiL-0002uZ-Fg
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 06:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762Ab1KXFR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 00:17:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62627 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735Ab1KXFRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 00:17:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAC566B66;
	Thu, 24 Nov 2011 00:17:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fCMa71MKhoDqrLv0vv1HP5AxcKk=; b=mT9bXa
	sQw1qc/7x6CNU6BA8iDu0rNlDf2Wwm4/iLMq9WPUAJckp0Cceap7cux+h603C2aP
	FM/rt6wViC8XGJ5+wK1bZuqZA9BjysTHXC2igEzZPOUKnYne7Czd86xqlRIg6+Wt
	4Mtyr7wNoRZHMBTCO0qR5RR0GzdzF75XNXOq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Do/LGiHZKWpfQUejDWbLBwE/q/bXreaF
	wbm1EggutGNBiz66p1rMZGu1Z4AygDy+h6ilExtDKfEDKc1wK0k8wbqzeoV+8f5c
	NRZIzD45505Q061xdHdBE+JAj4lIInX1xhPo2G4wwYga6id7tIUI1d164mZt1H71
	QTmmSz0FL+o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2E8A6B65;
	Thu, 24 Nov 2011 00:17:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75EE26B64; Thu, 24 Nov 2011
 00:17:24 -0500 (EST)
In-Reply-To: <CACsJy8BYN-nu6a92dk-qpF5_jR_frKwg+DD1EThr2kMPGHV5kQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 24 Nov 2011 08:35:48 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97F3061A-165B-11E1-B031-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185889>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> ...
>>> I think we should do this regardless precious being added or not.
>>
>> Because (see below)?
>
> Because it may potentially lose user's changes. Assume file "A" is
> tracked and also ignored. Users may make some changes in A, then move
> HEAD away without touching worktree, now HEAD does not see "A" as
> tracked any more.

Huh? "A" is initially tracked and the user modifies it. Moving HEAD away
how?  "git checkout" would refuse to check out a branch that has different
contents at "A", or is missing "A". So how can "now HEAD does not see 'A'
as tracked any more" happen?
