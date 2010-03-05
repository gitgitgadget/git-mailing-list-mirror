From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2010, #01; Wed, 03)
Date: Thu, 04 Mar 2010 16:49:21 -0800
Message-ID: <7vk4trlhim.fsf@alter.siamese.dyndns.org>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
 <7vmxynydac.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 05 02:29:23 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnLwN-0007fL-NB
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 02:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047Ab0CEAtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 19:49:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab0CEAtc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 19:49:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BCEAF9F8DF;
	Thu,  4 Mar 2010 19:49:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nfh3REm4CQ+qa/X8bMebeUJUumU=; b=Es6V4k
	N4Zjqou4TeYF//fQbDJwbU14l139LJkSybsHMsK9gFTb+j+sldVvQ8xfKvIDbxiu
	2pfdiY6Ht3sEfVL5k1OenYZUHNfeNTKveYnqBqpHbrnVWHDOwjUw/qLp/ENAKxkQ
	+IwxsfiYlCBfSXu8TMZ/Hf6lZChvc0zoOiMno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dRUtYvO7gf2yWNWArz56lJ3xj3dxO4hQ
	84WG2n2zO/pHia4FsgzrFJiYj5Q5RVHA+RhanQtvy1N+UKVDa1DwaDrTzS0udQ+a
	kUS6pORgm5lvRnoptcFswfUOl8mN5ddlj53gxsfZrLFw6dHnN2IOwVO1VwKkUgok
	MZ/4cTdfOa0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 942429F8DE;
	Thu,  4 Mar 2010 19:49:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E45F29F8DD; Thu,  4 Mar
 2010 19:49:22 -0500 (EST)
In-Reply-To: <7vmxynydac.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 04 Mar 2010 13\:42\:19 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F2556FE0-27F0-11DF-B3D3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141548>

Junio C Hamano <gitster@pobox.com> writes:

>     $ git branch branch2                        <2>
>
> I take it that this is supposed to be "checkout -b branch2".
>
>     $ git reset --keep start                    <3>
>     ------------
>
>     <1> This commits your first edits in branch1.
>     <2> This creates branch2, but unfortunately it contains the previous
>     commit that you don't want in this branch.
>     <3> This removes the unwanted previous commit, but this keeps the
>     changes in your working tree.
>
> The above sequence is not very convincing.  After you edited the second
> time, you create branch2 and that is presumably because you realized that
> the change in the work tree belongs to a separate topic.  It would be a
> lot more natural to do this:
>
>     $ git tag start ;# we do not have to tag, but just to make the
>                        remainder of the illustration easier to read...
>     $ git checkout -b branch1
>     $ edit	    ;# do the work for the first topic
>     $ git commit    ;# and commit
>     $ edit          ;# start working more and then realize that the
>     		       change belongs to a separate topic, and the previous
>                        commit is unrelated to that new topic
>     $ git checkout -b branch2 start 
>     $ edit          ;# continue working
>     $ git commit    ;# and conclude it
>
> so the example makes the use of "reset --keep" look artificial.

Nah, what was I thinking.  If I rephrase your side note <2> and <3> a
little bit, everything makes sense.  Perhaps like so:

    <2> In the ideal world, you could have realized that the earlier
    commit did not belong to the new topic when you created and switched
    to branch2 (i.e. "git checkout -b branch2 start"), but nobody is
    perfect.

    <3> But you can use "reset --keep" to remove the unwanted commit after
    you switched to "branch2".

And it becomes very clear that "reset --keep" is a sensible way to recover
from this mistake.  No need to do "read-tree -m -u" followed by "reset"
anymore.

Do you think I finally understood what "reset --keep" is about?
