From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] Add a REFNAME_ALLOW_UNNORMALIZED flag to
 check_ref_format()
Date: Fri, 09 Sep 2011 16:30:50 -0700
Message-ID: <7vpqj9s385.fsf@alter.siamese.dyndns.org>
References: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
 <1315568778-3592-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cmn@elego.de
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 10 01:31:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2AXE-0003L1-Na
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 01:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab1IIXay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 19:30:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148Ab1IIXax (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 19:30:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B83B45B66;
	Fri,  9 Sep 2011 19:30:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=QChsuAhqD+kl7+ixtkXkRG0XTsg=; b=DS9tzNauqLGpj32Z+SXg
	m3sx80wbzLjiKDIkC6woMb6H8D+o3QcilV7TTtGx+bKu8ShmbxsTpPOnz+DLwaGg
	4jN1vjHaEAK7y1Gg440duREXATDu6geMeV33xaM16A9PPx+wJx+HnotEVomUXrmE
	fL8gGcGO3TVCDP67FT5SDKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=wo3PDBGMWNzPNlvs+vpgT6a8LUoPjZbHpKdmq0/uOMGfK/
	RAhLw5YSVaRh5di5zl/Ytqrt7fmWkdhkTuTbbbQOlRzfXeDqql9Y6CJOIbXMu4Xq
	3zPBHsEX8WU85aDAncd95gWj/1S6rhrVfaLeMdEqpOmafWxgxPmedVsMtORUw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B00C95B65;
	Fri,  9 Sep 2011 19:30:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 394185B63; Fri,  9 Sep 2011
 19:30:52 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1D254D2-DB3B-11E0-A921-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181131>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Let the callers of check_ref_format() (and normalize_refname()) decide
> whether to accept unnormalized refnames via a new
> REFNAME_ALLOW_UNNORMALIZED flag.  Change callers to set this flag,
> which preserves their current behavior.  (There are likely places
> where this flag can be removed.)

Hmm, is it just me who finds --no-allow-unnormalized backwards?

More importantly, shouldn't every caller be required to normalize refnames
by default, unless it can justify why it does not have to with a compelling
reason?

In other words, I would be Ok if "--no-require-normalized" was the default
for "git check-ref-format" for scripts' use, and I also would be perfectly
fine if callers feed un-normalized strings that came from the command line
argument and other end user input to normalize_refname(), but once such a
string is normalized, shouldn't the rest of the callchain be passing the
normalized refname all the way?

To put it another way, my knee jerk reaction is that we shouldn't need
such a "flag". Shouldn't it be sufficient for normalize_refname() and
nothing else to allow unnormalized input, and everybody else should barf
when they see an un-normalized input?
