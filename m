From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] install-webdoc: quell diff output on stdout
Date: Mon, 06 Sep 2010 00:07:46 -0700
Message-ID: <7v7hizuz7h.fsf@alter.siamese.dyndns.org>
References: <7vhbi842gx.fsf@alter.siamese.dyndns.org>
 <52f347f82734e5d75d0b93a67edca9941efaa5a9.1283612149.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 06 09:08:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsVoE-0000T2-GX
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 09:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908Ab0IFHH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 03:07:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab0IFHH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 03:07:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 27545D3EA2;
	Mon,  6 Sep 2010 03:07:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f8mSe+welUWrkqj0iCv3jDjHiBA=; b=rUqm/3
	iu8NfyJcAU06MZbvhOu0TgwSCgWV5HMtEd556i8k7uTvTlVjKybJjkncijSEYbhH
	RcVb7a5k8fc/X44D5oxlBYgxyuOe3uUVBU1M7UGiIpsi6zpMUMyJS42HPimT3Ms5
	rfiF62/h+QVupfkg948TRjEFrlszwmz/E7kFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LBNHRaNZtHIcxrDnH2tWGJ+E2S99SYRw
	15eQ30r8qPUK4NQULaZMz62eKRsP+dhBG10cfzJvqz06zzEnnp6K/QU4KfKaX4M5
	MT+rKWBSRAxp5sRfwhYvf9CRO6pQFcT7O/cX/Zl5LFN5rxtYptmfFnxOBZX6pTPD
	D49dQwGxmbY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 056AFD3E9F;
	Mon,  6 Sep 2010 03:07:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F89BD3E9C; Mon,  6 Sep
 2010 03:07:48 -0400 (EDT)
In-Reply-To: <52f347f82734e5d75d0b93a67edca9941efaa5a9.1283612149.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\,  6 Sep 2010 08\:18\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 763D991A-B985-11DF-AE0B-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155539>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> When installing html-doc, install-webdoc.sh compares the installed html
> with the version to be installed using diff. Currently, the diff output
> fills up stdout.
>
> install-webdoc.sh actually uses $DIFF, and is the only user.

I think you broke "tNNNN-X.sh -v"; isn't $DIFF used in t/ scripts
everywhere?

Even if install-webdoc.sh were the sole user (which is not), please don't
do it this way.  Instead, introduce "SHOW_PATCH_WHILE_INSTALLING_WEBDOC"
or something, and run "$DIFF" with "-q" when it is not set.

Otherwise you would forbid people from using $DIFF for its intended
purpose: name a diff binary that can be used that is different from a
crappy diff your platform gives you by default.
