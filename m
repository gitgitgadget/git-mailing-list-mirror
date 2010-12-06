From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: Add commit_list prefix to reduce_heads function.
Date: Sun, 05 Dec 2010 19:58:12 -0800
Message-ID: <7vbp4ztuwb.fsf@alter.siamese.dyndns.org>
References: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
 <20101205021837.GA24614@burratino>
 <AANLkTinAT3kotKQTS6eS1SLigNzSp6grAU7WNRbHf3N=@mail.gmail.com>
 <20101205170919.GA7913@burratino>
 <AANLkTikL4BWtzNgx1+MBYxRRdfL=Gu71KPjaiKXprvnb@mail.gmail.com>
 <AANLkTinjJpGW2OiXM3edWYaNhS+w4qNLrvg-0aBwsL=x@mail.gmail.com>
 <7vk4joszcj.fsf@alter.siamese.dyndns.org>
 <AANLkTi=QK=N+_iGR9-47JKFs_SDKujJ8c4mtnnM0yo94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 04:58:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPSDc-0007mf-PM
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 04:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454Ab0LFD6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 22:58:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab0LFD6W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 22:58:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B7A8625AB;
	Sun,  5 Dec 2010 22:58:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PGUPuxSUXREXLqB7TyOYTz8EJgs=; b=ruZZml
	ANJ6GihEiB9p0YkYliGokDrIow/3w1SYJKbjoQXVzbIHBSZWLBLDAtBMezJQDxeB
	b442hgeZWvk9az3dl9L4GIZKCko1GBi3PWPOdTNENLVH5umf7JXxle5DALEPB5dQ
	JB4GlxgIJapK62aDJ3IfaQBxgAwyLUurcuIF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w6LAFTW6jmwVBA1o7+BW8xBNddHFv2RE
	S/AYLSAVJtJrxXc9oS1wN0CvdMGmbfgGBFBM94q1PTIYDWD+ULVwgDwzvtYSmC+C
	lni3OT4PUcHtVgqa5wsP1QqeALam+K51ySpubZ8Bi2F2RFQ8yNCattO25oU9rGhk
	91Dp245Ww/M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8738325AA;
	Sun,  5 Dec 2010 22:58:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4B57A25A3; Sun,  5 Dec 2010
 22:58:35 -0500 (EST)
In-Reply-To: <AANLkTi=QK=N+_iGR9-47JKFs_SDKujJ8c4mtnnM0yo94@mail.gmail.com>
 (Thiago Farina's message of "Sun\, 5 Dec 2010 19\:29\:12 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1C6B1872-00ED-11E0-8757-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162971>

Thiago Farina <tfransosi@gmail.com> writes:

> Would these be a candidates for adding commit_list_ prefix?
>
> free_commit_list -> commit_list_free

I think free_commit_list is a reasonable name for a function to free a
commit-list already.

> contains

Historically I think we had two functions with this name, and both were
named perfectly fine in the context they were introduced in.

One is "does this haystack contain the needle we are looking for?", which
is a private helper in diffcore-pickaxe.c and considering what that module
does, it is crystal clear that it is about "needle in haystack" without
anything else tucked to its name.

The other is in 'pu' that came from Peff's "How about this" patch to
compute something similar to is-descendant-of more efficiently, while
sacrificing the ability to be usable as a general helper function.

As I already said in the review of that stalled series, the particular
implementation of that function is good enough within the scope of the
command it is used for (namely "tag --contains"); its implementation needs
to be cleaned up, moved from commit.c to builtin/tag.c and made static to
the file, but as long as that happens, it is named appropriately.

> pop_most_recent_commit -> I'm not sure about this because of the
> length of it, as Jonathan pointed in this thread.
> pop_commit

These two do not sound wrong---pop/push implies queue/list-ness and is
quite clear that we are removing the topmost element from it.
