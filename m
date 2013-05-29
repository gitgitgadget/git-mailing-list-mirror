From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: zsh: improve bash script loading
Date: Wed, 29 May 2013 12:58:10 -0700
Message-ID: <7vbo7tsgml.fsf@alter.siamese.dyndns.org>
References: <1369797840-3103-1-git-send-email-felipe.contreras@gmail.com>
	<51A59D8E.1040502@viscovery.net>
	<CAMP44s1UwYxS_sZSKTyEj5rhmrJ4gFkPc9z+eCL6WAaHXkY8eQ@mail.gmail.com>
	<7vr4gpu15c.fsf@alter.siamese.dyndns.org>
	<CAMP44s0VjXwOXhUvniui+yVJiH4Dwxtx=0431G2KrEdHtrGTDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 21:58:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhmVm-000565-0q
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 21:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966407Ab3E2T6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 15:58:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41677 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934455Ab3E2T6M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 15:58:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F2532362C;
	Wed, 29 May 2013 19:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c4RDAnH/E3RdoWCmlzHy39B91Kc=; b=dN62l5
	Qkg2/sq/dweezX4Ag/fn4h0xnR4jqFdOKdHjWTXSGFMGk6yEpygPmrM1L0Hjkk0B
	A6rbjHt6NChTDa56XPzX7pBu5AAWzGdDcZQJPJk06JqFYdFMipSt/gB5hsjgSqd3
	dbx5XkiqTf8v+MJbrC+PfYno2cMQT3IEQvYO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ExhBJQ5qHY9dCCpf9E43ED4BuKIF8r9I
	zK031nKxCKHD+YfuyaojvwsWBZopD72mD4FyGy1bCkwMv3kLrkPYZ6Id+HBe80lZ
	0EV5oZ89eYEN8AYm5pkHo1TrG+RlZsFAhFWktab4+ci8xZpdF5IhJ0agjl+2bDkF
	ZWpU9xJFs8c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 424642362B;
	Wed, 29 May 2013 19:58:12 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7A1823626;
	Wed, 29 May 2013 19:58:11 +0000 (UTC)
In-Reply-To: <CAMP44s0VjXwOXhUvniui+yVJiH4Dwxtx=0431G2KrEdHtrGTDw@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 29 May 2013 14:30:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1766289A-C89A-11E2-8754-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225880>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Has this changed since 0a04e187e669 (completion: zsh: improve bash
>> script loading, 2013-05-24) which I have on 'pu'?
>
> Other than this change, nope.
>
>> If not, I can do this locally to save a roundtrip, if you want.
>
> Great, let's do that.

Done.  The diff from 0a04e187e669 looks like this:

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 9555cf8..fac5e71 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -28,6 +28,7 @@ zstyle -T ':completion:*:*:git:*' tag-order && \
 zstyle -s ":completion:*:*:git:*" script script
 if [ -z "$script" ]; then
 	local -a locations
+	local e
 	locations=(
 		'/etc/bash_completion.d/git' # fedora, old debian
 		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
