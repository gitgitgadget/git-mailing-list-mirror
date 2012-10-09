From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: teach "foreach" command a --revision
 <tree-ish> option
Date: Tue, 09 Oct 2012 11:24:17 -0700
Message-ID: <7vr4p7fqr2.fsf@alter.siamese.dyndns.org>
References: <1349743810-10753-1-git-send-email-jaysoffian@gmail.com>
 <7v8vbgi3yz.fsf@alter.siamese.dyndns.org>
 <7v4nm4i37u.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dw1iXJfgkmA2V-L11xCOOxO57U4Dh7=h7AzkFUqLc55=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 20:24:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLeTn-0007dY-Gj
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 20:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148Ab2JISYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 14:24:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40692 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876Ab2JISYT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 14:24:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69F81814D;
	Tue,  9 Oct 2012 14:24:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sKgrsyc0ZH209SfH9zRZg767MP0=; b=TgDYC7
	o5nLHypESySiythUsVoFdandEXj+urTOfB/8OOEYMD1weHZ7OnuLoLqClvehViPP
	GSHH7GCWXs7cQul8UKw/dWh1++/QUo/sKhOjdTgdZvDEyXGIxEzj6ZfXC1fXgMsV
	5/ed1lIeuQJPNTh0l1o3MoqlL4mrg3nV1I6Ng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eCBYUu0jKw2wNIE/ICGkUOgUIVsvOq0H
	0354UI9NwjAGQ2626VflJs5nTHfUGs5oE1PaNUFn3jvRWvF1ychzs/N5ags/STSa
	QG5GlJoYoQZ7Sn+eGEJnovre6ukCfxjIn9nM/591X4fzGI8mDgX8QUFqQ2cGDIOH
	uvDYxRCebWY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57420814C;
	Tue,  9 Oct 2012 14:24:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C6AD8147; Tue,  9 Oct 2012
 14:24:18 -0400 (EDT)
In-Reply-To: <CAG+J_Dw1iXJfgkmA2V-L11xCOOxO57U4Dh7=h7AzkFUqLc55=w@mail.gmail.com> (Jay
 Soffian's message of "Tue, 9 Oct 2012 02:50:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89F749EC-123E-11E2-BC20-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207336>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Tue, Oct 9, 2012 at 2:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Assuming that the above guess is correct (which is a huge
>>> assumption, given the lack of clarity in the description), I think
>>> the feature might make sense.  The example would have been a lot
>>> easier to follow if it were something like this:
>>>
>>>     $ git submodule foreach --revision v1.0 'git grep -e frotz $sha1'
>>
>> Imagine you have a checkout of v2.0 of the superproject in your
>> working tree, and you run "git submodule foreach --revision v1.0".
>> Further imagine a submodule S that used to exist back when the
>> superproject was at v1.0 no longer exists in the current codebase
>> (hence there is no such submodule in the working tree).
>>
>> Shouldn't the above "foreach ... grep" still try to find 'frotz' in
>> the submodule S that was bound to v1.0 of the superproject?
>>
>> Given that your patch does not touch the part of cmd_foreach where
>> it decides which submodule to descend into, it still will base its
>> decision solely on the set of submodules that are bound to and have
>> been "git submodule init"ed in the version of the superproject that
>> is _currently_ checked out, no?
>
> That's a good observation. My use-case for this (poorly explained in
> ...
> As you previously stated, I need to improve the documentation that
> goes along with this patch, so I'll call-out this limitation. I'm not
> sure what else can be done. You can't descend into a submodule that
> isn't there.

As recent "submodule rm" work by Jens indicates, since 501770e (Move
git-dir for submodules, 2011-08-15), you should be able to peek into
submodules that have been "git submodule init"ed but do not exist in
the current checkout of the superproject.

I think the right approach to implement this "recurse foreach in the
superproject tree that is not checkout out to the working tree"
feature should be:

 - Advertise it so that it is crystal clear that the command run by
   "foreach" may have to run in a bare repository of submodule to
   look at submodule's commit bound to the historical tree of the
   superproject;

 - Anytime you look at .gitmodules in the superproject, read from
   the historical tree's .gitmodules instead of from the working
   tree (I think this is necessary in order to get the $sm_name vs
   $sm_path mapping right); and

 - Locate submodule's $GIT_DIR in $GIT_DIR/modules/$sm_name of the
   superproject that corresponds to the submodule found in the
   historical tree in the superproject (or if it is the same
   repository as that is currently checked out, use $sm_path/.git),
   and error out when it is not available.

An implementation that works only when all the submodules necessary
in the historical tree in the superproject are still in the current
checkout of the superproject may be fine as a quick throw-away hack,
and it may even be acceptable as a good first step towards the real
feature, but at least it needs to be protected by an error checking
upfront (perhaps running "diff-tree -r" between the index and the
historical tree to make sure there are no removed submodules that
existed in the historical tree), if it does not bother to check with
$GIT_DIR/modules/$sm_name in the superproject.

Jens, anything I missed?
