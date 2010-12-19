From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: Allow passing exclude and include args to apply
Date: Sun, 19 Dec 2010 12:13:16 -0800
Message-ID: <7v4oa9frmr.fsf@alter.siamese.dyndns.org>
References: <1292775461-26762-1-git-send-email-max@stro.at>
 <AANLkTik5-oJYsfEoeYjy8E9v4T4_7VBsoGnqg7oXwnbC@mail.gmail.com>
 <20101219171313.GI17034@vostochny.stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org,
	klibc@zytor.com
To: maximilian attems <max@stro.at>
X-From: git-owner@vger.kernel.org Sun Dec 19 21:15:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUPfY-0004A8-AM
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 21:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757210Ab0LSUNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 15:13:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43792 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757194Ab0LSUNa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 15:13:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4C98634EA;
	Sun, 19 Dec 2010 15:13:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rmFzL2Mom1jJ7pW9kGZ2bJzZ0Mw=; b=fMGj62
	4zTeoyNm+v5H7+CRcEVOj60zBJCANYTJseZukR+7U5QeM/04qd9pN+eZ7ZkucacS
	RxnFKphuPVV9JgwxEU1MGEQaiamJmgN87FduJSVEEvXOUt8HQomuilijDr1dG0nv
	rUOUFQrxk0Y6iJ3d8RusgBNDfXSzOe3EDxZuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=scWJ143+APaYF/YJBSo3wnl7CXTJ80oZ
	ONQC+RwxuXtTaFpwZyyHBHi0mjQKbY4L2rHjncmkZqXe7SDilIgPmFE/BjBmaZ01
	8KZCXZGX0Q8c0F9hYOQyUICrjAotmVAVommVgXLv4YBRJNsVpYnV7NihNbBlT0vO
	uflt9dTJ15o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 099EF34E9;
	Sun, 19 Dec 2010 15:13:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8C24134E1; Sun, 19 Dec 2010
 15:13:47 -0500 (EST)
In-Reply-To: <20101219171313.GI17034@vostochny.stro.at> (maximilian attems's
 message of "Sun\, 19 Dec 2010 17\:13\:13 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7FF28154-0BAC-11E0-819B-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163967>

maximilian attems <max@stro.at> writes:

> On Sun, Dec 19, 2010 at 02:56:58PM -0200, Thiago Farina wrote:
>> On Sun, Dec 19, 2010 at 2:17 PM, maximilian attems <max@stro.at> wrote:
>> > When porting patches from dash git to klibc git,
>> > where dash has a different directory structure those
>> > switches are handy:
>> > Exported with format-patch on dash side and used am
>> > as import for klibc side.
>> >
> ...
> when one wants to promote a specific new feature, it is much better to
> come up with it's use case, as burden is on Maintainer to keep it working.

You need to do that with test suite, not with the log message.  Otherwise
you are adding undue burden on the Maintainer to download klibc and dash
just to run regression testing whenever somebody else makes changes to
"am/apply" callchain down the road.

While I love patches that are backed by a strong "here is a real-world
problem we needed to solve, and this change made our life much easier by
doing so-and-so" statement, I also tend to think twice before considering
a change that could potentially encourage a bad version control
discipline.

Your use case description in the log message however lacks crucial
information to be useful when judging that aspect.  You said that the
directory structure is "different", but didn't say they are different in
what way.  In order to skip one mail exchange turnaround, I'd speculate.

If dash repository keeps (perhaps slightly stale version of) the same
files as klibc repository in its libc/ subdirectory, a patch to dash that
fixes its libc part may all have its pathnames prefixed with libc/.  In
order to apply such a patch to the klibc tree, you would need to give -p2
to strip one extra level (if you are going the other way, you would
instead give --directory=libc/ to deepen it).  But then I do not see a
need for --exclude to remove parts from the patch that touch outside of
libc/ tree.

If the dash patch you needed to deal with touched both inside libc/ and
outside, and if you are taking only libc/ part and discarding everything
else, I see two issues with respect to promoting pottentially bad version
control disciplines.

 - Should you be reusing the information in the commit without editing?  I
   am not worried about Signed-off-by which is about asserting the origin,
   and origin of the libc/ part is the same as the origin of the whole.
   But what about reviewers' and tester's assertion at the end?  Also the
   description of the change itself may need to be adjusted to the new
   context you are reusing the change for.

 - Why does the patch touch two unrelated parts in the first place, if its
   libc/ part can stand on its own?  This is not about the discipline of
   the user of "am", but of the originating project.

Another thing that came to my mind around the vague "different directory
structure" is this question: what if directory A/ in "dash" corresponded
to directory B/ in "klibc" and you saw a patch to A/ (and some others) for
"dash" that you wanted to reuse in "klibc"?  Do we need more changes to
make it work, or do we already have enough support for this combination?

I would imagine that "git am --directory=B/ -p2 --exclude=\* --include=A/"
or something like that should work, but I didn't think it through nor I
didn't check the command line syntax, either.
