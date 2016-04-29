From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 24/29] ref_transaction_update(): check refname_is_safe() at a minimum
Date: Fri, 29 Apr 2016 01:53:38 -0700
Message-ID: <xmqqr3do23u5.fsf@gitster.mtv.corp.google.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	<a67a1b745d0a14111c774f13a5776d3756cbf2f2.1461768690.git.mhagger@alum.mit.edu>
	<xmqqtwim95cm.fsf@gitster.mtv.corp.google.com>
	<57231082.50806@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twopensource.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 29 10:53:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw4BM-0006Fu-MZ
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 10:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbcD2Ixn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 04:53:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751663AbcD2Ixl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 04:53:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 74E12106C2;
	Fri, 29 Apr 2016 04:53:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9dc+95o/4pJIC/Vl0FUlayibN7Q=; b=VQIlgT
	KkrCdAobR8B5H772B7dUOUCITq1SKM2Kg+ENURyVfJkyv2I30yopYOpEfjcJrjNG
	SnnumXdrVa5RNIWzhzC0TNdm79qbTYgriM/6+XUHLk8RPJk0bhdxUuhEsQ9oQxdJ
	GIdjlqGv3GXbNDEKcY9D0zyfKcMNcaiwbDAoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JfelgwfQXUzlfrr51vqucxF4iJtKrXTx
	eDpSuSgYLUp9KLNBQgkwLY04RNgJnAbmYRgu9HaAQf3BJoGhc90jL5+3lPmFsIF6
	dp5Wf3wjZmnm024QUIUXF9ddAnLcFL2k6ePDLE8A95MdDyOU05KyzosMZlBYPTfp
	7C16GEez/4E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D35F106C1;
	Fri, 29 Apr 2016 04:53:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6998106C0;
	Fri, 29 Apr 2016 04:53:39 -0400 (EDT)
In-Reply-To: <57231082.50806@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 29 Apr 2016 09:42:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DE4354D4-0DE7-11E6-862A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292982>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 04/27/2016 10:14 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> If the user has asked that a new value be set for a reference, we use
>>> check_refname_format() to verify that the reference name satisfies all
>>> of the rules. But in other cases, at least check that refname_is_safe().
>> 
>> It isn't clear to me what "in other cases" exactly refers to.  A
>> request to delete a ref would obviously one of those that do not
>> "ask that a new value be set", but are there other cases?
>
> The other case is `verify`, which can be used to check the old value of
> a reference without modifying it. `verify` is exposed via `git
> update-ref --stdin`

Thanks.
