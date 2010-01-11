From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Display author and committer after "git commit"
Date: Sun, 10 Jan 2010 23:28:23 -0800
Message-ID: <7vzl4lw160.fsf@alter.siamese.dyndns.org>
References: <xuu2fx6m4vdi.fsf@nowhere.com>
 <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com>
 <xuu2zl4tfuij.fsf@nowhere.com> <20100106073806.6117@nanako3.lavabit.com>
 <7v4omz17xz.fsf@alter.siamese.dyndns.org> <xuu28wc9xd42.fsf@nowhere.com>
 <7vskagh9fg.fsf@alter.siamese.dyndns.org> <xuu2fx6d9rzb.fsf_-_@nowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Megacz <adam@megacz.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 08:28:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUEhY-0007jQ-0u
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 08:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317Ab0AKH2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 02:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247Ab0AKH2b
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 02:28:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab0AKH2a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 02:28:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E86438F9CF;
	Mon, 11 Jan 2010 02:28:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BAAj2mZ2cdys65Ngws6TPhy4MfM=; b=JTqTfK
	bdju+iNAVd2t6iy+vXApPxTyWyuH4VXozJTw/oilxO7C6YVv1tC3r8hz/5aweRkw
	5N0NJCRYPEOClXbUCwKssKFv/5ZhUcIFwLT7ZNyEqDxLUlrv0Bepeju7DZuiCknD
	9Df4YqMqmjWQiti4d/AVsyd0rBj/zbN2uKi5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jRN9BqrEeKcPI9LcDQH80/4obzFEHXoA
	o7MpPaPjQU7QSdTAtuRaMzCMWSqjJvGBuliOcIfYdH0cQcKiEfV7BDdBGyp/yzc+
	wdtRiMGwRs0+qp2drE3AkxVZdKFo7P8dYvJIlqUy0ePoNtlbY1DkMBC07kiTQUJm
	28eV9jt06gY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C4B518F9CE;
	Mon, 11 Jan 2010 02:28:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 181FB8F9CC; Mon, 11 Jan
 2010 02:28:24 -0500 (EST)
In-Reply-To: <xuu2fx6d9rzb.fsf_-_@nowhere.com> (Adam Megacz's message of
 "Mon\, 11 Jan 2010 04\:37\:44 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E91AD84E-FE82-11DE-911A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136610>

Adam Megacz <adam@megacz.com> writes:

> Display author (name, email, date) and committer (name, email, date)
> after creating a new commit to ensure that the user is alerted in the
> event that they are set in an undesirable manner.

Too much clutter for too little gain, except for a very first few commits
in the repository.

Why isn't the "# Author:" and "# Committer:" information you see along
with "git status" output in the editor "git commit" gives you sufficient
if it is to avoid unconfigured/misconfigured names and e-mail addresses?

> This patch is not necessarily meant for inclusion verbatim;
> ...
> diff --git a/pretty.c b/pretty.c
> index 8f5bd1a..2458509 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1028,16 +1028,26 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
>  	int need_8bit_cte = context->need_8bit_cte;
>  
>  	if (fmt == CMIT_FMT_USERFORMAT) {
> -		format_commit_message(commit, user_format, sb, context);
> +                format_commit_message(commit, user_format, sb, context);

Of course it isn't, with a change like this ;-)

Indentation damages aside, there is a lot more serious issue with this.
You added this cruft *unconditionally* to show_log().  Doesn't it mean
that you made format-patch *unusable*?  Try:

	git am your_patch.mbox
        make install
	for i in 1 2 3 4 5
        do
                git format-patch -1 --stdout >patch.mbox
                git reset --hard HEAD^
                git am patch.mbox
	done        
	git show -s

and weep.

Have you checked --pretty=fuller, by the way?
