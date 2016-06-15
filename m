From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature "git tag -r" to show tags and commits they are pointing 
 to
Date: Thu, 22 Oct 2009 22:58:33 -0700
Message-ID: <7v8wf2ejna.fsf@alter.siamese.dyndns.org>
References: <76c5b8580910221424n220449b9vda26f032174b6fa7@mail.gmail.com>
 <7vr5svf6x9.fsf@alter.siamese.dyndns.org>
 <76c5b8580910221930s4b31b180t8298c262d9d9f421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 07:58:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1DAq-0007pF-DX
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 07:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbZJWF6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 01:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbZJWF6k
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 01:58:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbZJWF6j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 01:58:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E7EE582C6E;
	Fri, 23 Oct 2009 01:58:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bRJp459ZyuKS7raa+zX7Lwz+1SI=; b=fv7CCK
	l/VjbgbSZOttZ+d2KLiONm+q90bxjpQ4CmZJLADyDbZH8fYBw+HTcld+fAcM7V1L
	IDnjNik94xJ3td7ZwUqTpofW9IJPzPCeAEYFNTr0bbX5i9ZQI3hOm3bdwhyyVGSg
	7AG+nPD6kootZG0ikXE9wuH6HST4lN5cx9CQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hZvNisXZarSt39mXhjcsThGr2JiCjPU1
	HYAKFIOLORtGDn0A9987ucqcdMBDdtWiZlWWzzawWtCSKblWWgQeEoXlrVD45feK
	k+ZDApeSpSo9jpLmPxp4xJ7WKNlYOkeCJ2317dFhMNccrluOvq7ZIKud7RoiK/9Q
	6ngAR5qdaYI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C3F3682C6D;
	Fri, 23 Oct 2009 01:58:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 561EB82C6C; Fri, 23 Oct 2009
 01:58:35 -0400 (EDT)
In-Reply-To: <76c5b8580910221930s4b31b180t8298c262d9d9f421@mail.gmail.com>
 (Eugene Sajine's message of "Thu\, 22 Oct 2009 22\:30\:37 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1DBB0CAA-BF99-11DE-B3D2-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131089>

Eugene Sajine <euguess@gmail.com> writes:

> I was looking for this info in order to create second tag for the same
> commit. For example if the first tag created by somebody or
> automatically (CI, release system), so i could add a verbose tag.
>
> But i just realized that i don't need commit id for that - just tag
> the tag, stupid...

You do not have to live with a tag that points at another tag that points
at a commit.

You can still tag the commit directly with your new tag, and you do not
need to have the exact commit object name to do so.  You just tell the
tool to follow the tag chain to get to the pointed-to object, like this:

    $ git tag -a -m "my message" newtag oldtag^0

This assumes [*1*] that the old tag points at (strictly speaking, "might
point at") a commit object, and uses "^0" (zeroth parent of) operator to
make sure that the object the newtag points at (the last argument to the
"git tag" command, i.e. "oldtag^0" in this example) is a commit object,
not an annotated tag "oldtag" itself.

That is what I meant by "just as usable as hexadecimal to the tools".

>> ... "v0.1" is
>> much more useful than 8794hke to humans, and these tag names are just as
>> usable as the hexadecimal commit object names to the tools.  You can say
>> "git show v0.1^0" and "git show 8794hke" and get the same thing.

[Footnote]

*1* A tag can point at any object, not necessarily a commit.  If oldtag
points at a tree object (or a blob object), oldtag^0 will fail, because
the operator "^0" is "zeroth parent of", and is applicable only to a
commit.  In general, you can write

    $ git tag -a -m "my message" newtag oldtag^{}

The "^{}" operator is a special case of "^{type}" operator; the former
means "dereference the tag repeatedly until it becomes something that is
not a tag", and the latter means "dereference the tag repeatedly until it
becomes something of that type".  I.e. "oldtag^0" is "oldtag^{commit}".
