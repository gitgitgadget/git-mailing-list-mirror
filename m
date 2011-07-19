From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5403.1 and adding a file that belongs to a submodule
Date: Tue, 19 Jul 2011 09:31:29 -0700
Message-ID: <7vk4be9qqm.fsf@alter.siamese.dyndns.org>
References: <CACsJy8AKMQa2u6Y5qQHGujbjqq0qnM5D1+aEvcfk7POxQBqsVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 18:31:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDCr-0005yr-Vo
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 18:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240Ab1GSQbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 12:31:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47307 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005Ab1GSQbc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 12:31:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95C1E40E5;
	Tue, 19 Jul 2011 12:31:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ovEaKpJaVmauiOGsa7Or1W1ooQg=; b=oe6Nkd
	CRsChvkuzPcZ1IRSnKlPMVwu1uK04KprDgvqycwbCkWJx6jIKEdADPVkVzX9XnDd
	Ot15E7LH9pU4w4LvEtLtsIKSV4+cHLuYxAOjvbGGn6zF1VoV2J/xZzs9pIJrRT07
	6IHOR5puZXHNvJckZUSkrrCICFin55sYiPso4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CWHS6bRt5fAMdFbjrUZqQjBQ406fUSXD
	qPFSWWzb53IT8jbajeejKj7jVdV4/gnwHo+Nn3/lSuz6cdKOnuyaRiiv7EuMjwI0
	furGGZqUNOuGXpA7JAtgww55jIuiCiZkLzMAnSOp5KYwihfiBIAQDsnVMIf2a6XH
	6ucXBJUHtj4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D16440E4;
	Tue, 19 Jul 2011 12:31:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F025440E3; Tue, 19 Jul 2011
 12:31:30 -0400 (EDT)
In-Reply-To: <CACsJy8AKMQa2u6Y5qQHGujbjqq0qnM5D1+aEvcfk7POxQBqsVg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 19 Jul 2011 20:57:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F10FBC4-B224-11E0-9137-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177460>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> touch a b; git commit -am1
> git clone ./. clone2
> GIT_DIR=clone2/.git git add clone2/b

The last one has _always_ meant:

    I am telling with GIT_DIR the directory that contains the repository
    metadata, which is at clone2/.git directory.  I am not saying where
    the working tree is (i.e. no GIT_WORK_TREE and no core.worktree in
    clone2/.git/config) so take my $(pwd) as the root of the working tree,
    and add the contents of clone2/b to the index at the same path,
    i.e. "clone2/b".

It should not add contents of the said file at "b", as there is _nothing_
on the command line that tells us "clone2" is the root of the working
tree.

If the test means to do that, it should be more explicit and do something
like:

	( cd clone2 && git add b )

instead.
