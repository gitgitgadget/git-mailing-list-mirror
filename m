From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/describe.c: ignore untracked changes in
 submodules
Date: Sat, 11 Sep 2010 12:13:39 -0700
Message-ID: <7v39tgf5zw.fsf@alter.siamese.dyndns.org>
References: <CC-1wlyJRzGfkPwn1Ra8d4Ot7mMnUGxYChGZHdqp-lQ5URlUFhNp4Ilyrh4bGk1dWF6drZXvim0@cipher.nrlssc.navy.mil> <7vy6bajvnd.fsf@alter.siamese.dyndns.org> <1464835923.7527323.1284144028047.JavaMail.fmail@mwmweb047> <1529126586.2758911.1284228699341.JavaMail.fmail@mwmweb045>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, Brandon Casey <drafnel@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 11 21:14:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuVWS-0004wz-8D
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 21:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476Ab0IKTNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 15:13:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab0IKTNx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 15:13:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 63C4DD595A;
	Sat, 11 Sep 2010 15:13:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cGWHgmQxvgeysF2HFti7hTwswrE=; b=pkWu2b
	Jbnd5igSpFLysxANTLUIj7FPrJlechSsIbeXD9kmRGvj+nmNN9UxPvwCwPYNqBtr
	BrloR56sOpd5AF6oZTwLz0Yjri35xrfVDl+NZ0XuTcMia3ku27EbB95966fpTGXW
	eneeWoLz56DNYpyPrK67vcajlivN70ohGazdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kt8WFOUQB+DXLNfPvbqPb0zK0w1GKKG5
	yklvgrvA34eB3pAFpRZRATZl0pgFEBwOPEK2KPIVNEVdrW/q4OeTS+DGcR9UUPPG
	RtrdiK1oBMnbzxBSud91s8dcGbZGndDDEXgSPMbrn1m+cvAAH3IcB8dT7jlpw0fQ
	cFqaelgPA84=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D3A4D5951;
	Sat, 11 Sep 2010 15:13:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D48BD5950; Sat, 11 Sep
 2010 15:13:40 -0400 (EDT)
In-Reply-To: <1529126586.2758911.1284228699341.JavaMail.fmail@mwmweb045>
 (Jens Lehmann's message of "Sat\, 11 Sep 2010 20\:11\:39 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B3B98158-BDD8-11DF-A43E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156008>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>>So if I didn't misunderstand something here I would rather vote against this change,
>>git describe should append a '-dirty' when git status would show modifications, no?
>
> And maybe we should teach "git describe" the "--ignore-submodules" option, then
> you could tell describe what to pass to the diff-index command. Thoughts?

It is sensible to add the option, and handle_ignore_submodules_arg() call
to grab "diff.ignoresubmodules" configuration) to the command, perhaps.

Both "status" and "diff" are described in the documentation as having
"all" as the default value for --ignore-submodules option, but by default
neither ignores changes in the submodules.  So it seems consistent for the
command to take submodule changes into account by default.
