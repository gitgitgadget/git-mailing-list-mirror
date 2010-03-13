From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git status: ignoring untracked files must apply to
 submodules too
Date: Sat, 13 Mar 2010 14:24:02 -0800
Message-ID: <7vhboj6et9.fsf@alter.siamese.dyndns.org>
References: <4B9C0AFB.1050306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Sergio Callegari <sergio.callegari@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Mar 13 23:24:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqZks-0005pN-89
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 23:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759351Ab0CMWYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 17:24:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab0CMWYM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 17:24:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1774AA1519;
	Sat, 13 Mar 2010 17:24:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JeP8CNhcIuZWXZUoWXNOI4Joewc=; b=ns0nwN
	uz1VgdXK627EBak4u2UUhzV5LSsHKfREEFEXeGy+SwE5EgfGaSI8DDAeWZvBTPUb
	ynvZcuq0R0Uf2RY3x65w7jFtIQ+sCpcNE28SzG+SqY82DiKE0WN32ycGsvYAyNaR
	rQR4TUnKWIDTbLE1bp6nkgtA2eOj93ZgcQhfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oX65XqBijjmNndYk6yo++HRxZtt84poZ
	ye5m8AVSNaRJbGWPjTRTcJb/8lSKjY8IiJahYVnq6YS3VMYi5V3jA5KuJLn0FRkj
	X3UxbeBQso3YOPiLcULcq8wzfiLuTEFeiO0g5YkhCtuWI9IxMySdrMU2uP+hQk7M
	tcue8QCRvWc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9BA6A1517;
	Sat, 13 Mar 2010 17:24:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40540A1516; Sat, 13 Mar
 2010 17:24:04 -0500 (EST)
In-Reply-To: <4B9C0AFB.1050306@web.de> (Jens Lehmann's message of "Sat\, 13
 Mar 2010 23\:00\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 23E4227C-2EEF-11DF-9E68-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142116>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Since 1.7.0 submodules are considered dirty when they contain untracked
> files. But when git status is called with the "-uno" option, the user
> asked to ignore untracked files, so they must be ignored in submodules
> too. To achieve this, the new flag DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES
> is introduced.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
> This patch applies on top of current pu.
>
> I'm open to suggestions for a shorter name for the new diff option
> IGNORE_UNTRACKED_IN_SUBMODULES; I did not manage to come up with a
> shorter yet still descriptive enough name.

Why do you even need that flag?  Isn't it the matter of deciding to ignore
or pay attention to the DIRTY_SUBMODULE_UNTRACKED bit in the return value
of is_submodule_modified(), depending on whether the toplevel wt_status
was called with -uno?
