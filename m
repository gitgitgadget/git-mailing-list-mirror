From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git add -p and unresolved conflicts
Date: Wed, 28 Mar 2012 13:50:44 -0700
Message-ID: <7vvclotpp7.fsf@alter.siamese.dyndns.org>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
 <7vbongyd67.fsf@alter.siamese.dyndns.org> <vpqvclozr7e.fsf@bauges.imag.fr>
 <4F73632E.1060408@ira.uka.de> <vpqk424zfb1.fsf@bauges.imag.fr>
 <4F737027.5020503@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:50:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzpV-0006ht-EL
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501Ab2C1Uur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 16:50:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37761 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758014Ab2C1Uuq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 16:50:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ACA96770;
	Wed, 28 Mar 2012 16:50:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rd63x9ij5WOhF9jOZ7qEEDc+i5Q=; b=pgI1uH
	yScuRPpVOJk916U6TNaWbwtYp//M+cH9TOpB210wKVd3P1CmHsgxMcw4juvb1JFd
	EFnaD9+dI1G4Zcrv6LHy1DmnfngfBDes/2vVV6LjZr2b5kQZadlTl+r7jadchMER
	u+HM3WJjqsLoIWqyeLqL+NNNFVJBocWYw5dfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G69iaehecBsse5+H9PLPDVhvDqiHGiit
	0aV8WUkYFvC/bpEFhRD8RWFiDCpGXVLSLqwNwd3zGhDAcQ3AFObxIwgAbmoFkugF
	m5lgpeJvV5Igpu2uHbYklHMGxxmONFEzSr+YgmFYCIB0w/PnjF3uqiuuTEKp7nI9
	4yEHh2KhfuM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1121E676F;
	Wed, 28 Mar 2012 16:50:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 927B9676E; Wed, 28 Mar 2012
 16:50:45 -0400 (EDT)
In-Reply-To: <4F737027.5020503@ira.uka.de> (Holger Hellmuth's message of
 "Wed, 28 Mar 2012 22:10:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0DCACB6-7917-11E1-AF51-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194192>

Holger Hellmuth <hellmuth@ira.uka.de> writes:

> But the conflicted chunks are of the form "<<<< our ... ||||||||||
> theirs >>>>>>" in your work tree. So there are two cases:
>
> a) You have removed the markers thereby removing the conflict -> this
> means the chunk will not be offered to you as a conflicting chunk
>
> b) You haven't removed the markers. Then there is a choice between
> base, our and their version.
> If you had edited one of the versions between the conflict markers in
> your working tree without removing the markers (which wouldn't be a
> sensible thing) then it depends on whether the chunk in the working
> tree or the versions in the index are used as a basis for the
> choosing, but I suspect using the working tree version is easier to
> do.

I think Matthieu is not thinking about the "resolve conflicted merge (or
rebase, am) and make a single commit" use case, for which your "pick one
of the sides" makes sense.  His is more about "I like some change in that
unrelated commit---while I have no intention to replay that change as a
whole, I want to use "cherry-pick --no-commit" and pick only the bits out
of the change that are useful for what I am doing" use case.

In such a context, after resolving conflicts in the working tree, "add -p"
would be a good tool to pick hunks in the diff between the HEAD and the
working tree.

I tend to think that use case, while valid, may be a minority case and
giving a version of "add -p" to make that mode too easy to use by mistake
during a true conflict resolution is inviting trouble for newbies.  As I
said, "reset $path" followed by regular "add -p $path" would be a usable
workaround for Matthieu's workflow.
