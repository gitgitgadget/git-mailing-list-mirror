From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] docs: use <sha1> to mean unabbreviated ID
Date: Sat, 18 Dec 2010 10:50:45 -0800
Message-ID: <7voc8ihq4a.fsf@alter.siamese.dyndns.org>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
 <1292650725-21149-4-git-send-email-lodatom@gmail.com>
 <20101218074718.GA6187@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 19:56:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU1xS-0005fl-QQ
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 19:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757148Ab0LRSu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 13:50:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757057Ab0LRSu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 13:50:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C2526238C;
	Sat, 18 Dec 2010 13:51:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wRemD1II8nnHwPnwUNoxxfUNvQY=; b=u3+lVB
	3gi/SoVUTS5l5nzvcXiQuFAt2tFNaqPU33DdSnwoQmft21ti8RAiuWXMUTgnGiwi
	jPS986iCATtGHKTg8hQsdtqsyG4y9Kb7a0UXgCt/dynSj4pE6j9bbi1Kv2nD8djx
	D9Fvf7Q/OO0vpbUFIYqtffGF9XhXk9zJlda2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lYPZ55yRSIBHZZBBr1BWRZslEQlWpgyf
	sSwg2KCK6EeiJT7BEzgWu4wBKcECl4uEtCl+SJSpcCyWVUIdju8rBJftPTKF3kLu
	Oj4y90cjio2PqVX/dWlWk4ylu2pN5Myjp/Gr9bRhytACaBbD6YgogkIY3lDGTgI4
	TpJ3lkPjXAI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 944402389;
	Sat, 18 Dec 2010 13:51:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 653FB2385; Sat, 18 Dec 2010
 13:51:16 -0500 (EST)
In-Reply-To: <20101218074718.GA6187@burratino> (Jonathan Nieder's message of
 "Sat\, 18 Dec 2010 01\:47\:18 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CDA5C9A4-0AD7-11E0-8FE9-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163924>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Mark Lodato wrote:
>
>> There are some places that literally require a full, 40-character SHA-1
>> ID, rather than a generic revision specifier.
>
> One name I have seen for these is "object IDs", as in git get-tar-commit-id
> (to avoid putting too much emphasis on precisely how the identifiers are
> chosen).

Yes, I think I also saw "a full object name" (cf. diff --full-index) and
evan "object name" (cf. git-pack-objects(1)).  These are all deliberate
efforts to stay away from spelling SHA-1 explicitly, and I think it makes
sense to do so here.  "40-digit object ID" is a mouthful, though.

As to what this series tries to do, I think it is generally a good idea to
start allowing documents to say <tree> when a reader can plug either a
commit or a tree, rather than <tree-ish>, only because all Porcelains
automatically dereference object names to needed types these days.

But such a change needs to mark places that _must_ take the name of an
object of the specific type somehow.  It is Ok to say ls-tree takes a
tree, but then we must say you should feed commit-tree nothing but a tree.

It is a separate issue to allow plumbings to automatically dereference
when both of the following two conditions hold: (1) the intent is clear
from the context; (2) nobody sane would have been relying on the side
effect of the current typechecking.

Letting commit-tree to unwrap a tree-ish to a tree would be a good example
that clearly satisfies (1)---I am not sure about the other one.
