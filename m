From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Sat, 23 Jan 2010 12:14:55 -0800
Message-ID: <7viqasbmtc.fsf@alter.siamese.dyndns.org>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <4B59637D.4090503@viscovery.net> <201001231240.28138.robin.rosenberg@dewire.com> <201001231409.30706.j6t@kdbg.org> <7vwrz8bnbj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 21:15:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYmO5-0007Fl-Rv
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 21:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773Ab0AWUPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 15:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912Ab0AWUPM
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 15:15:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab0AWUPK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 15:15:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A27A93B20;
	Sat, 23 Jan 2010 15:15:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1SDwZyXk1i1/8042IAy3AqwJpF8=; b=ku/TcO
	cqtiNcAMLzAujyzAxesXYh/O+U/yFHuYXSakST/Du5ir6dA+W0nZyXVNHqDozCOw
	AVQdr3JVlQnhlSbaF69BgxVdwGTfIoljkuiYT1BdD/nWzbLTxoNgBtpZH7K+hqZp
	wV0ZlB76TuehhdtwQXRtTiKOjr/Uhc6/jTCuA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RbAOGLfr9TbDjw3i4LMwtujd3mMfrZRZ
	egSAp9zCtGh2xKc8XX9TwBqhJ2Z5newG47n5Da1wMZMu/5SP4TuXv3yvJHdjbETN
	N/xKELOhEhTpeGXQ9AjI8RCKgMhF92b9nLQIJLYp5gDp/kTXDdTaQynd6vZgcITJ
	6tiYQjEnF84=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4775093B1C;
	Sat, 23 Jan 2010 15:15:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3FA6793B1A; Sat, 23 Jan
 2010 15:14:57 -0500 (EST)
In-Reply-To: <7vwrz8bnbj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 23 Jan 2010 12\:04\:00 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE1B07A4-085B-11DF-BCE7-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137861>

Junio C Hamano <gitster@pobox.com> writes:

> I think one issue is what happens when you did this:
>
>     cd //server
>     git --git-dir=//server/repo/repo.git --work-tree=repo
>
> Does msysgit implementation figures out that the work tree is located at
> "//server/repo" when get_git_work_tree() is asked to produce an absolute
> path so that it can be compared with //server/repo/repo.git with the code?
> If it does (with the leading double slash), then "doubled slahses fix" is
> a regression we should do something about it.  If it doesn't, then it
> probably doesn't matter.

Nah, I wasn't thinking straight.  What happens if you did this?

	git --git-dir=//git/repo/repo.git --work-tree=/git/repo

where "//git/repo" is on the "git server" and you are working in local
hierarchy "/git/repo"?
