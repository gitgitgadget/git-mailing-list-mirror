From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] status: show more info than "currently not on any
 branch"
Date: Fri, 08 Mar 2013 13:46:46 -0800
Message-ID: <7vtxolfttl.fsf@alter.siamese.dyndns.org>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
 <1362572482-20570-1-git-send-email-pclouds@gmail.com>
 <1362572482-20570-4-git-send-email-pclouds@gmail.com>
 <7vzjygpcd5.fsf@alter.siamese.dyndns.org>
 <CACsJy8CnDoMRzR5ifH3+0AKRLfzrNpkc3-NOxoA85SiRUb40ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 22:47:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE58P-0000V3-J5
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 22:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933437Ab3CHVqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 16:46:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756372Ab3CHVqs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 16:46:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 726EDBF90;
	Fri,  8 Mar 2013 16:46:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iQq7AwYQ5K6YWPrrtjMkZVHhIxo=; b=Qe6Qzb
	bH7DmfYLskXcKo1TwAZbRQlUQB5nGuei+v8EVcMVWiApWfe4bUG0KnmA29rS7lHW
	V9ysghsJLvgP0vvgojAA15/WQn57xRaLTI24rFEq7ATbzhcSMfcVJgAI56/A0EH1
	p2xjW1o1wjUQzK9ZnTQ9Nv2J734WTvFUEf0uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PqZ/60WJvBbOyr2al5nQlXG+7KO66rtC
	oSamrUAmGbni5m+LmhVXZKG+7XJi2P9CVXLApztTfdR5IpBanf3qUyjQX4qxXTQg
	qY2Vyvv1Kmbxbw6QK+QFCrheXqKPsvewgKbaH3crHnoPItdMB6joXyoVKxFjVEqi
	q/sn/yQEBNM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6777BBF8F;
	Fri,  8 Mar 2013 16:46:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD8C5BF8D; Fri,  8 Mar 2013
 16:46:47 -0500 (EST)
In-Reply-To: <CACsJy8CnDoMRzR5ifH3+0AKRLfzrNpkc3-NOxoA85SiRUb40ng@mail.gmail.com> (Duy
 Nguyen's message of "Fri, 8 Mar 2013 18:04:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD74D616-8839-11E2-B2DD-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217685>

Duy Nguyen <pclouds@gmail.com> writes:

>> It should be more like this, I would think:
>>
>>         for_each_recent_reflog_ent();
>>         if (!found)
>>                 for_each_reflog_ent();
>>         if (!found)
>>                 return;
>
> Yes. This "recent" optimization is tricky.

Not really.  What is tricky is that reflog is an append-only file
and we only have an API to let us read it in the oldest to newer
order, which is natural for the file format, but unsuited for the
purpose of finding out nth most recent anything.

See the other thread I am going to send out soon on this.
