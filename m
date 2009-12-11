From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to selectively recreate merge state?
Date: Thu, 10 Dec 2009 16:04:28 -0800
Message-ID: <7v8wda8jg3.fsf@alter.siamese.dyndns.org>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 01:04:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIt09-0004dr-DC
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 01:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760464AbZLKAEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 19:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760083AbZLKAEe
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 19:04:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758623AbZLKAEb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 19:04:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 356411C0E;
	Thu, 10 Dec 2009 19:04:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ez9/fstBdCp9rv33LcMjMYeDRU=; b=UocDrb
	xL0q+slnB4MdNCBaGIreiHancl7zDaNdXLOQlrC6pA0WwLgixbTVGEhsH1vEcxnQ
	E+luRSpt9XHWAa8ExB6hRH8CaYUrHsH4AdAy0BbKrM7vE/hpjGNPAhWPDlHyFOhI
	V1xZhO8NHtuU9Chm+3+6orfaW1f1knT9/HFiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AxzUEU+mPuxI5h4a7T1yXy0i7fx37F3m
	cnSVKmsGryMIDUsjBlMV7XhOfRNkadTjMDU2LI5jJHYTjGTjliVSE9AS+HfOc0dK
	tg8EIZyV8jr+u3UGHE5V+GzRX7W1y5mGw1UVVPfZSS94LZsEJoeBkU7chALA6gVl
	KImHunay7Bk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 126941C0D;
	Thu, 10 Dec 2009 19:04:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F2421C0C; Thu, 10 Dec
 2009 19:04:31 -0500 (EST)
In-Reply-To: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com>
 (Jay Soffian's message of "Thu\, 10 Dec 2009 15\:56\:05 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C35B5A64-E5E8-11DE-91D0-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135060>

Jay Soffian <jaysoffian@gmail.com> writes:

> Let's say you initiate a merge:
>
> $ git merge topic
>
> And this merge results in conflicts in two files, foo and bar. You
> resolve the conflicts in both files, but then decide you don't like
> how you resolved bar.
>
> How do you set the index and working-copy back to the state it was
> immediately after doing the merge for bar, while leaving the merge
> resolution alone for foo?

Before you "git add bar", you can say "git checkout --conflict=merge bar"
(or --conflict=diff3).

After "git add bar", you can't.  Save what you have resolved so far in a
separate file (e.g. "cp foo foo.resolved"), reset to the previous state
and redo the merge.
