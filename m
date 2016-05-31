From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] worktree: add "unlock" command
Date: Tue, 31 May 2016 11:12:59 -0700
Message-ID: <xmqqzir63xlg.fsf@gitster.mtv.corp.google.com>
References: <20160522104341.656-1-pclouds@gmail.com>
	<20160530104939.28407-1-pclouds@gmail.com>
	<20160530104939.28407-7-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	rethab.ch@gmail.com, rappazzo@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 20:13:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7oAA-0000pJ-OQ
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 20:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807AbcEaSNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 14:13:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755398AbcEaSND convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 14:13:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EE2D1E83A;
	Tue, 31 May 2016 14:13:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lS4FDY86Mwj7
	J1NR6oMt48oDOsY=; b=pgTi3aCZsxnRVg+4abDYBmBuJfyH+UFsWOCOXjiL1fI/
	S+eJLkGhZoFAz+opO5nKW7e9mcx9ht4LccCy7z1ompTL/Onm5xMkB+Q8Thq6ltv4
	5V5VZtcs1dFl0kJZdU1KLJSADsfRkKcL3VsH6SxLAMJUEArpfsneoGaE+kXrkCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rySZFK
	wcLeDJMyMn16IrX8I37SW9ABfHnRGpuZRsOwNds4u6px7BIrCP2m4Ap1QDiOIA/V
	Ur/3gds7D14C/Z8QPoeYj6afNg52sREyyWJs22lcd4zz76NRHOQs4h8zWqGck0Bb
	yTOLD1oFkOFJlSEiPzi4HkgYxwgzYCMtJsW+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 471F31E838;
	Tue, 31 May 2016 14:13:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C54DD1E837;
	Tue, 31 May 2016 14:13:01 -0400 (EDT)
In-Reply-To: <20160530104939.28407-7-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Mon, 30 May 2016 17:49:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4FF2EFAE-275B-11E6-A151-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296004>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +	if (is_main_worktree(wt))
> +		die(_("'%s' is a main working directory"), av[0]);
> +	if (!wt->lock_reason)
> +		die(_("'%s' is not locked"), av[0]);

Exactly the same comment about the lack of need for lock_reason
field as 5/6 appiles here.  Also, as "lock" does not allow you to
lock the primary tree, do you even need is_main_worktree() check?

That is:

	if (!worktree_is_locked(wt, &reason))
        	die(_("'%s' is not locked), av[0]);

should be sufficient, no?
