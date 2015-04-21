From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: adjust prefixlen after striping trailing slash
Date: Tue, 21 Apr 2015 14:08:37 -0700
Message-ID: <xmqq8udlgpey.fsf@gitster.dls.corp.google.com>
References: <55300D2C.9030903@web.de>
	<1429319946-19890-1-git-send-email-pclouds@gmail.com>
	<5533A567.7070301@web.de>
	<CACsJy8A7+rQhn5ry6Z86SbeYHoDw=w7tB73Ls2V05E8F-JMnhA@mail.gmail.com>
	<xmqqy4lnmkbv.fsf@gitster.dls.corp.google.com>
	<CACsJy8B1QWzehAEtjnQeRJ8uehcFFDbdHSViwk_JtrtYehV8ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 23:08:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkfPS-0001wz-6Z
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 23:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932888AbbDUVIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 17:08:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932316AbbDUVIj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 17:08:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFAA34B172;
	Tue, 21 Apr 2015 17:08:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9hICPVMseLbFp1Bsn59l81lqalI=; b=iSJaha
	w96DyvVQ6QnNyOuXHbMHh/DDiuA8RW1cHDc9p3wJ0zB2oLCqee/342A9qZk1W4/w
	3nK6QYqi/8i20KkZBKtX8XtoxdOjvmoqsYagJMg5wV2iX0/wHyemMKM3bgRvkJc4
	+MlYcZvG6H6+JGf+47Lzx5a8DbKZ9/ho3l2Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kJzMCsE7qB70WxOvjfVawjKu03BX6eae
	xkUtnB4i1+zSFSt2Sx+7Z14idgclzhIIs++DENSgHhjYsmQnNjk3A0Ew5dcXIEI+
	z5sekHmy5PRLIzgZa8Rpk+uXp/NG/FH0cJPIcPsSPJxxPm3mnZevn0T48kV0JpGd
	jYr1iU8uGAk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B80FE4B171;
	Tue, 21 Apr 2015 17:08:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B40B4B170;
	Tue, 21 Apr 2015 17:08:38 -0400 (EDT)
In-Reply-To: <CACsJy8B1QWzehAEtjnQeRJ8uehcFFDbdHSViwk_JtrtYehV8ZQ@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 20 Apr 2015 12:52:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9470C664-E86A-11E4-AEB7-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267553>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Apr 20, 2015 at 12:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> But if you look at it another way, "cd subrepo; git add ." should be
>>> the same as "git add subrepo" ...
>>
>> Once you cd into "subrepo", you are in a different world, a world
>> different from the toplevel project.  "git add ." over there should
>> mean "add everything in subproject's working tree to subproject's
>> index", shouldn't it?  On the other hand, "git add subrepo" without
>> leavingin the working tree of the superproject is about binding the
>> submodule to the superproject's index.
>>
>> I do not think these two should be the same.  Where am I mistaken?

> I think I wrote this sentence and deleted it: I didn't say which way
> was right.

OK.

I looked at the test script update.  The new test does (I am
rephrasing to make it clearer):

    mkdir -p dir/ectory
    git init dir/ectory ;# a new directory inside top-level project
    (
        cd dir/ectory &&
        >test && git add test && git commit -m test
    )
    git add dir/ectory

to set it up.  At this point, the top-level index knows dir/ectory
is a submodule.

Then the test goes on to turn it a non submodule by

    mv dir/ectory/.git dir/ectory/dotgit

At this point, I think there are two valid things that can happen.

 (1) "git add test" inside dir/ectory removes the submodule entry
     "dir/ectory" and then adds dir/ectory/test as an individual
     entry.  After all that is what happens when you replace a file
     with a directory, e.g.

       >folder && git add folder
       rm folder
       mkdir folder && >folder/file &&
       git -C folder add file

     will first register a regular file "folder" and then replace
     that with paths underneath.

     It would be the same if you did any of the following:

       git -C . add dir/ectory/test
       git -C dir add ectory/test
       git -C dir/ectory add test

 (2) "git add test" inside "dir/ectory" would barf, saying
     "dir/ectory is supposed to be a submodule and you have to first
     remove it".  Again, it would be the same if you did so from any
     directory with relative paths.

I think (2) is less optimal than (1), but it could be the best we
could do if the submodule infrastracture around .gitmodules and
links to $GIT_DIR/modules/$name may have to get involved in an
operation like this (I didn't check).

In my quick test, it appeared that the behaviour with this patch
applied was neither of the two and instead to silently do nothing,
and if that is the case I think it is quite wrong.
