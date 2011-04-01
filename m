From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] builtin/show: do not prune by pathspec
Date: Fri, 01 Apr 2011 14:50:53 -0700
Message-ID: <7vwrjdej42.fsf@alter.siamese.dyndns.org>
References: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
 <cover.1301649372.git.git@drmicha.warpmail.net>
 <6509d23c538dfabd4fac8870d29a69b1dd11a516.1301649372.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
	<pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 23:51:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5mFO-0005VF-Pe
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 23:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758007Ab1DAVvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 17:51:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757904Ab1DAVvG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 17:51:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4C17C441B;
	Fri,  1 Apr 2011 17:52:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8wlJ8++QqEX2MHzA0iPmJhZzAow=; b=mJjZxc
	MSN1TZORMqbDlzDXbmAKBX1XAu/NBPTc3ThRsQX0eMFvGzmv0IbGrAbsDHp2alnG
	M5yLFWa2/6mtKmOWwJz96XerCLVIFz9auvy/taUsw0t8fN5PL5C3dBe5UqrihHg2
	UwSLkDBo7fHVYQZX/59oqio44NbJReipm6/b4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uZ5rrT9Q1JkhGUQY1xqrx3fWsJ+Pq4Vq
	n+3L7scjd0yrfAJt9JWQXfAKFd42rrnuz/5FunNMYNtjHvWmyRgYPNEg51GgA/Tr
	zAl7XEJqFcLu/u83sMWpNGhg3mD7nThw5odKbQeB8JK0MpuRAsQcjSoDOByTKvIC
	ejZ9afcFJoM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0910A440C;
	Fri,  1 Apr 2011 17:52:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9DC84440B; Fri,  1 Apr 2011
 17:52:45 -0400 (EDT)
In-Reply-To: <6509d23c538dfabd4fac8870d29a69b1dd11a516.1301649372.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 1 Apr 2011 11:20:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63CABBB4-5CAA-11E0-8D8A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170629>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> By design, "git show commit -- path" is not "git show commit:path", and
> there is no reason to change that. But "git show commit -- path" simply
> returns nothing at all "most of the time" because it prunes by pathspec
> even though it does not walk commits. This is pretty useless.

Hmm, I'm very tempted to suggest throwing it into the "don't do it then"
basket.

> As an intended side effect, users mistaking "git show commit -- path"
> for "git show commit:path" are automatically reminded that they asked
> git to show a commit, not a blob.
>
> In case the user has specified "--do-walk", assume they want the old
> behaviour (prune by default).

Compared to "--do-walk", "git show HEAD~5.." would be a much more common
way to trigger it, and is a more appropriate justification why you made
the non-pruning conditional.

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin/log.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 916019c..474a76d 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -420,6 +420,8 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  	opt.def = "HEAD";
>  	opt.tweak = show_rev_tweak_rev;
>  	cmd_log_init(argc, argv, prefix, &rev, &opt);
> +	if (rev.no_walk)
> +		rev.prune = 0;
>  
>  	count = rev.pending.nr;
>  	objects = rev.pending.objects;
