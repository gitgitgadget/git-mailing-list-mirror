From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Tue, 15 Jul 2014 11:34:11 -0700
Message-ID: <xmqqtx6iv5cs.fsf@gitster.dls.corp.google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-44-git-send-email-sahlberg@google.com>
	<53BC07FC.8080601@alum.mit.edu> <20140715180424.GJ12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 20:34:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X77YW-0006CX-HU
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 20:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799AbaGOSeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 14:34:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59902 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932786AbaGOSeT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 14:34:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C3822910E;
	Tue, 15 Jul 2014 14:34:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yj4uh7uh1ZrkAEWOwoxx5Ulxnl4=; b=q+qzwn
	u//4G6U/6TIhSk40bqPr1+Yle/bjaAjNi3bXOLHBvgp4Fp5QSirvnRnQRPki0eEF
	EumMPHEBRC/oqxc+tMDIrTYfcHUvOqUMc0w++2lilQUGGJAdZjo9fDdh+jdm2qf1
	yZo67RbK3i7iUUEBdn+7Z4/OAQBub2+mhilqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TZCsVHyLVojN+SOrk59dIOkJKklKYHvw
	+ZUOobz6Xd6YZ8HQPl6N03PgUb9Z2dplVMCzuxFg5izCJbcm0QHXBOKI3JOvCImb
	CoU7Ti8Li0f3o2oPo8JLN+7aJ/XhZHGgdCZXo+eRZyIBZQ5MBuDBvbtD3okg3yLf
	QrQRdHBGEc0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 418062910D;
	Tue, 15 Jul 2014 14:34:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2503D29106;
	Tue, 15 Jul 2014 14:33:55 -0400 (EDT)
In-Reply-To: <20140715180424.GJ12427@google.com> (Jonathan Nieder's message of
	"Tue, 15 Jul 2014 11:04:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 939F1630-0C4E-11E4-989C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253582>

Jonathan Nieder <jrnieder@gmail.com> writes:

> How to take care of the recovery use case is another question.  FWIW I
> also would prefer if "git update-ref -d" or "git branch -D" could be
> used to delete corrupt refs instead of having to use fsck (since a
> fsck run can take a while), but that's a question for a later series.

Good thinking.

> In an ideal world, the low-level functions would allow *reading* and
> *deleting* poorly named refs (even without any special flag) but not
> creating them.  Is that doable?  The main complication I can see is
> iteration: would iteration skip poorly named refs and warn, or would
> something more complicated be needed?

I somehow thought that was what we have always designed for, which
DO_FOR_EACH_INCLUDE_BROKEN was a part of.
