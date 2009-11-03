From: Junio C Hamano <gitster@pobox.com>
Subject: Re: determine if the tree is dirty
Date: Tue, 03 Nov 2009 11:19:08 -0800
Message-ID: <7v3a4vs9g3.fsf@alter.siamese.dyndns.org>
References: <799406d60911031057l5dcb4d4fi3705cc66997ff7f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 20:19:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Oub-0008I1-Uj
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 20:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbZKCTTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 14:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbZKCTTN
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 14:19:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbZKCTTM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 14:19:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D74677204A;
	Tue,  3 Nov 2009 14:19:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a6A5FKN7GJD36BRr/FyTYw+zZMA=; b=sETYqw
	ueObudxdpoNTkjCwft8SmkgWqarieWs1O6GXXvs85DBWHkGaY7aVS++J7r2LgDOb
	Z05oBJpnrm+7XS7PtHKJ3uWxLayytzs7U2/QjvFVJ8gXjB+wMI3KBakzvr+tXRQn
	AR+4K+Jy8rgjut6+BzTLUGX28tJ5AS59mnt5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GuXo2FNu0jxkAup59PPj1faxFsyaxKIG
	YkDWs6G+AR8rzdqp41GiQP+mzLoH6T1vL+VOwswVVZ91HpIEdzdjWtpUI8RcNlOp
	Ad5Ba/68BV8QxF8ZPrwrDsWDfhLTVFHXLi4sNjZW7IdFgyysBS1QgWZXHBOnIfp3
	fenHCmAIe2s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B3F3A72044;
	Tue,  3 Nov 2009 14:19:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05D6F72041; Tue,  3 Nov
 2009 14:19:09 -0500 (EST)
In-Reply-To: <799406d60911031057l5dcb4d4fi3705cc66997ff7f7@mail.gmail.com>
 (Adam Mercer's message of "Tue\, 3 Nov 2009 12\:57\:37 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C4F60BB0-C8AD-11DE-A0AE-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131989>

Adam Mercer <ramercer@gmail.com> writes:

> As part of a python script I need to determine if a tree has any
> uncommitted changes, so far I am been using:
>
>   # determine tree status
>   status_cmd = 'git status'
>   status_output = run_external_command(status_cmd,
> honour_ret_code=False)[1].strip()
>   if status_output.endswith('no changes added to commit (use "git add"
> and/or "git commit -a")'):
>     git_status = 'UNCLEAN: Some modifications not committed'
>   else:
>     git_status = 'CLEAN: All modifications committed'
>
> but I feel that this relies to heavily on the porcelain and that there
> should be a better way to accomplish this without relying on parsing
> the output of git-status.
>
> Does anyone know of a better way to accomplish this?

Use plumbing commands.

"git diff-files" will show changes you have in the work tree compared to
the index.

"git diff-index HEAD" will show changes you have in the work tree compared
to the HEAD.

"git diff-index --cached HEAD" will show changes you have in the index
compared to the HEAD.
