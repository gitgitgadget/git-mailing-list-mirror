From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 10:42:53 -0700
Message-ID: <7vr5t17w82.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <m49nq6-uk5.ln1@burns.bruehl.pontohonk.de>
 <7vr5t2h3do.fsf@alter.siamese.dyndns.org>
 <20091017081901.GB5474@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christoph Bartoschek <bartoschek@gmx.de>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 17 19:44:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzDJC-0008WI-Jq
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 19:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbZJQRnE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2009 13:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbZJQRnD
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 13:43:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbZJQRnC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Oct 2009 13:43:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 383337B1E6;
	Sat, 17 Oct 2009 13:43:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=W4DcQryD4q+dorNmgChLCUs4r
	aU=; b=o+IYMmxXTql1Sfc21WtkaAnd8m2DiqnrdoliKKeIwkGbKNog4uGh9UdlU
	FnRysWWa1K+9vuNIBDTiqZ845cq5tVFBj1f2vkySSDZnoKRhSePUvUnaR+aaAfzy
	4DjXNJV1ryIi1xxD+TDFLFDmLggiOtwlCtrcnlwxlW5sftUxWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=htc6xRhXk0bFNzjYeoi
	/rw5VXnli7lQhgpRKEN2j7Xn6fO7vN53CVm4fQthDIsrxbj+bJLSN68/AxJQWBhP
	rpl49XU5GW+oXtXtWbhYHQGITc5TWmOZaZSgEBuUppRhK5ZOrI+l/S9eNZLQBaK3
	dirR7PbnX3f1i9ILpadcWDvE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 02A9E7B1E5;
	Sat, 17 Oct 2009 13:43:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EE4CA7B1E4; Sat, 17 Oct 2009
 13:42:54 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 844FC86A-BB44-11DE-84B0-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130571>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> On 2009.10.17 00:43:31 -0700, Junio C Hamano wrote:
>> Christoph Bartoschek <bartoschek@gmx.de> writes:
>> > Daniel Barkalow wrote:
>> >
>> >> The upshot of the messages should be:
>> >>=20
>> >>  $ git checkout origin/master
>> >>  Since you can't actually change "origin/master" yourself, you'll=
 just
>> >>  be sightseeing unless you create a local branch to hold new loca=
l work.
>> >>=20
>> >>  $ git branch
>> >>  * (not a local branch, but "origin/master")
>> >>=20
>> >>  $ git commit
>> >>  You've been sightseeing "origin/master". The commit can't change=
 that
>> >>  value, so your commit isn't held in any branch. If you want to c=
reate
>> >>  a branch to hold it, here's how.
>
> [...]
>
>> The second item in the Daniel's transcript above may be an improveme=
nt but
>> I think it is a wrong economy to record and show 'but "origin/master=
"'
>> (which cannot be correct forever and has to be invalidated once the =
user
>> starts committing or resetting) in the message.
>
> I don't think it's entirely wrong to record that information, git jus=
t
> has to know when to invalidate it, possibly requiring the user to rea=
lly
> detach HEAD.

Isn't it redundant information to begin with?  See $gmane/130527

> git checkout origin/master
> git checkout origin/master~3
> git checkout HEAD^2~5
> git reset --hard HEAD~2
>
> Those commands are all about walking the ancestry of origin/master in
> some way. So it seems reasonable to assume that HEAD is still weakly
> bound to origin/master.

But as "walking" gets longer, the information will become less and less
relevant and at some point it becomes misleading.  I cannot explain why
"let's take pains to maintain and carefully invalidate an extra piece o=
f
redundant information so that we can show information the end user
shouldn't be trained to trust to begin with because it is unreliable" i=
s a
good idea.
