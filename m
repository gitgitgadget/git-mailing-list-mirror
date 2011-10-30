From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 03/11] t5403: avoid doing "git add foo/bar" where
 foo/.git exists
Date: Sun, 30 Oct 2011 16:47:05 -0700
Message-ID: <7vvcr6qbye.fsf@alter.siamese.dyndns.org>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-4-git-send-email-pclouds@gmail.com>
 <7vd3dk516p.fsf@alter.siamese.dyndns.org>
 <CACsJy8CjJnO6rDVTV1tC9rWXP51LHBtUvNsgVWNfwC+HuNQ-6Q@mail.gmail.com>
 <7vr51z3bqx.fsf@alter.siamese.dyndns.org>
 <CACsJy8C2nUJkN5=E7p2u_wjHqWy7EC_BS3Sr4+_QgunWHDdtKg@mail.gmail.com>
 <7vobx2z60w.fsf@alter.siamese.dyndns.org>
 <CACsJy8DdQXXoYT2gB2L5z6pdCNU_vL2w7c8eJvKRGX2T9iAC3Q@mail.gmail.com>
 <7vaa8jrm6a.fsf@alter.siamese.dyndns.org>
 <CACsJy8Ae1MPYzjoouZoFCU6Ltr9UznukfuTrJb=OUJYr9VTYSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 00:47:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKf5u-0007a6-6q
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 00:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198Ab1J3XrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 19:47:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753070Ab1J3XrI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 19:47:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56D0F60BF;
	Sun, 30 Oct 2011 19:47:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jshOjSJ5iOK8QzLJrcNozl7ju6c=; b=Y7SaSv
	AILM2WHLl3PZtgKQ9YpLxXS/v3CmlyrQTB+T7qzQ+BaugG6ABkpWhcR0aybTKaE9
	5viVv2gCGRdjE48k+NefdEL+Dc+3E3Q59Hm5a3Dlzu74mL9ACUXT/JCtnrFnNNoS
	ZSI67zC3jWw1cr6b/R5RDIeWWJdudUNJpllCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qy6xpq8HNtYHqPF3iJxYcrv4kduo55OM
	JPIkxfSMRr4cMAvTlp46HfAeG5n00bgGVIInErECgmfvEQpNVaU79UQ0K0nnK2l1
	S+pHmr92rD5Bn6LuWgM6HEzbMyn3ojZSbfSOEyFz8EhyPHcvVZSz/qcKLmwoW98f
	BhM4YaBkbBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FDFF60BE;
	Sun, 30 Oct 2011 19:47:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCC1360BC; Sun, 30 Oct 2011
 19:47:06 -0400 (EDT)
In-Reply-To: <CACsJy8Ae1MPYzjoouZoFCU6Ltr9UznukfuTrJb=OUJYr9VTYSg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 30 Oct 2011 16:55:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79CC3B74-0351-11E1-9FD0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184488>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> We however *do* know that our working tree is our current directory, so
>> it would be wrong to do this:
>>
>>    $ GIT_DIR=clone2/.git git add clone2/2 3; echo $?
>>    error: 3 is outside our repository, possibly goverened by .git
>>    1
>>
>> The command should just add clone2/2 and 3 as it was told to.
>
> I am concerned about clone2/2 in this case, not 3. ...

Hmm... If that is the case, I am afraid that I failed to convey my point
in the previous message.

You are concerned about clone2/2 because you think GIT_DIR=clone2/.git
somehow implies that clone2/2 is a file at the toplevel of some repository
that should appear at "2" not at "clone2/2" in the index, no?

If that is the case, it means you are somehow getting the notion that
GIT_WORK_TREE is set to clone2 even though in the example we are
discussing it is _not_. Which in turn would mean "3" that is outside of
that directory should not even get into the picture.

In other words, the wish to register clone2/2 at "2" in the index by
stripping clone2/ and the wish to reject "3" as outside because it is
impossible to strip clone2/ from it are the same thing. You either should
be worrying about _both_ paths, or neither of them.

And I am saying that you should be worried about neither of them in this
case.  GIT_DIR=<some where> without GIT_WORK_TREE set has treated the
current directory as the top of the working tree from the beginning of
time, and both clone2/2 and 3 _should_ appear in the index in this
example, which is $GIT_DIR/index, which happens to be at a confusing
location that is clone2/.git/index.

> ... I guess we can
> check if clone2/.git is the repo we are using. If it is, skip it.
