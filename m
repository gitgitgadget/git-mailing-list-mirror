From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about git rebase --onto
Date: Tue, 02 Feb 2010 10:11:51 -0800
Message-ID: <7v636f7biw.fsf@alter.siamese.dyndns.org>
References: <4B6865A9.60603@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Tue Feb 02 19:12:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcNEO-0000vV-R0
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 19:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756385Ab0BBSMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 13:12:00 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab0BBSL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 13:11:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A8C6F96F19;
	Tue,  2 Feb 2010 13:11:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kt4bQf2FhiAHNiOzGGVxp8x1+nM=; b=FBSF3w
	WXrH080cpzad04TSsTTvoevEJchuuATOY9RhPlYVN0OYgsBpAcgM3sXUAs19ziXH
	EQJOJYbBl/mhMvASVWZTLndduDwLK2HN9QQa1G52bK53woM3hrRb5bj6vUbo49rS
	qX4pqj8bf2gVVzcatK3jir6Gj+VIp5aOE2MY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Haf28hKI7a96l9ch0F0F5CzAwTowi0T2
	6DJvFZY8LBY6wfSMfPE3UENGE7WzrWBkOgK/55jpaa+hkXzLZjevFgyOoNOfC0Ls
	9VxJJInwithhRxLOiwsB99xj+/R0Z2GtWNbxd8/syEZj0hLZjQ5k9snolmTeSstY
	2Ihx4B1+Cjc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8823596F17;
	Tue,  2 Feb 2010 13:11:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E580E96F16; Tue,  2 Feb
 2010 13:11:53 -0500 (EST)
In-Reply-To: <4B6865A9.60603@obry.net> (Pascal Obry's message of "Tue\, 02
 Feb 2010 18\:49\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 72CDC970-1026-11DF-85AF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138733>

Pascal Obry <pascal@obry.net> writes:

> It seems to me that:
>
>    $ git co topic
>    $ git rebase --onto master topic~2 topic
>
> Used to do the job and rebase the topic branch as expected. Today when I
> tried with 1.7.0.rc1.10.gb8bb after the rebase above I was left on a
> detached head.
>
> Is my recollection wrong? Has this been changed recently?

Either a recent bug or a user error, I think, as we didn't intend to
change.  My quick manual test didn't show such a bug but rebase is one
of the areas that acquired new code recently.

Possible user errors I can think of are:

 - If 'topic' is not a local branch, the result will be on a detached
   HEAD, as you are starting from a detached HEAD (i.e. 'topic' could be a
   tag);

 - Until you resolved and said "rebase --continue" (or --skip) to allow it
   to conclude the rebase when the operation conflicted, you would be on a
   detached HEAD.
