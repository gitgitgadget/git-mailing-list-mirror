From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug with `export-subst' attribute
Date: Tue, 27 Jul 2010 10:35:48 -0700
Message-ID: <7vzkxc7rpn.fsf@alter.siamese.dyndns.org>
References: <19531.65276.394443.190317@winooski.ccs.neu.edu>
 <20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
 <20100725221539.GA21813@burratino> <7vbp9uaii2.fsf@alter.siamese.dyndns.org>
 <20100726190448.GA32367@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org,
	Will Palmer <wmpalmer@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 19:36:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odo4Y-0007Kh-6f
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 19:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489Ab0G0RgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 13:36:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab0G0RgC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 13:36:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20858C8A2F;
	Tue, 27 Jul 2010 13:36:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=eWjHX4p6IIsIUPqnjlRZxtBQ3Uc=; b=Q6F5pCA59kZsCWBSg12UgZ6
	OBTq4J/WoVWI7/vQbtnE6H/3XZ7yFULB8jsssnnAAr5aBXIvpH3K1SBoRF8CJxXe
	RrdvwVcvVk04RlZKyVe8ouCm7FxiVUafyVnzhHCEqJUm+FVTQ+8KeTxqYIBtsi9z
	/eThuyddx1lTGl3cTAu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QMgPrkmNxHeHPHRPBr00wb10Mmo2/W5htiQetcLJqi9+wMwQG
	fIvJ3tKgms0SsYO3iHSmMdfqDUiWZGUnA6RO3k1RnHMSEoCfEzUVUIR1PJkAHKCY
	2cQVE0V4uMpIDfuYabTLaQObDtmUHlobp0zPQeksq7F7mAO9vDby2IRDsI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4EABC8A24;
	Tue, 27 Jul 2010 13:35:55 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C9766C8A14; Tue, 27 Jul
 2010 13:35:49 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 692FDB0C-99A5-11DF-B302-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151962>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> The ones to archive and checkout I understand, but what effect does the
>> one to commit.c::print_summary() have?
>
> Currently commit.c::print_summary() does this:
> ...
> 	if (!log_tree_commit(&rev, commit)) {
> 		...
>
> In other words, it imbues rev with a format including %h and uses that
> to print a commit summary.

Sorry, but I think I understood that part.

But the thing is, we do not seem to show non-abbreviated string there with
or without your patch, because inside log_tree_diff_flush() -> show_log()
callchain we use opt->diffopt.abbrev to decide what is done for that %h
token:

	ctx.abbrev = opt->diffopt.abbrev;

so just like the confusing assignment in builtin/checkout.c, isn't
this one in builtin/commit.c also a confusing no-op?

Perhaps I am missing something obvious?
