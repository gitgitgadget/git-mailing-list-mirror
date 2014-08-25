From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Mon, 25 Aug 2014 10:54:40 -0700
Message-ID: <xmqqha10mp3z.fsf@gitster.dls.corp.google.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<53F7A119.7070704@gmail.com>
	<xmqqiolknvfz.fsf@gitster.dls.corp.google.com>
	<53F7A68D.2000109@gmail.com>
	<xmqqegw8nu1g.fsf@gitster.dls.corp.google.com>
	<53F7AA48.3000601@gmail.com>
	<xmqqa96wnoj1.fsf@gitster.dls.corp.google.com>
	<53F7C971.7080100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 20:05:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLydQ-00044K-V6
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 20:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933170AbaHYSEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 14:04:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62318 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933320AbaHYSBw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 14:01:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C018A33AF5;
	Mon, 25 Aug 2014 14:01:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IavHhkvoI6erB0e8rtJsIRB6LWA=; b=RqKNcU
	MgByahmhLSq7I6xVNARnZ9ytHzSty2/FmHaVfxkuj6RICudm+pJUkaGQwVTG/2kt
	S2siZffoooW4Qw6WUS7VvwiHQSg9ovxfyvxoxcl8P22zyyM839urp1iAJdaC90QV
	gnBLh3v1Lm8DdcyGrryPkroFOJjt3Yb6/4xG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oyaBd3/t1TGNIbfPmXiziYn1azW21zkg
	u+Sa+vOpePwqqf68E2asc99piraQwXq8JZCQQPGWnnk4mF4jkzb+55gg9S2BIWGs
	A8/psxijFdoUIUHVl+Q7FwmsQHugjI5qdhU3BDLYTgc6u64WM7Fr6RwnzJTb6I7E
	UmCam56gZts=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B6E7E33AF4;
	Mon, 25 Aug 2014 14:01:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BC69F33802;
	Mon, 25 Aug 2014 13:54:42 -0400 (EDT)
In-Reply-To: <53F7C971.7080100@gmail.com> (Stefan Beller's message of "Sat, 23
	Aug 2014 00:51:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E4708254-2C80-11E4-9F85-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255846>

Stefan Beller <stefanbeller@gmail.com> writes:

>> "burden" is not an issue, as I'll be signing the push certificate
>> anyway when I push.  A signed tag or a signed commit and signed push
>> certificate solves two completely separate and orthogonal issues.
>> 
>> What happens if you break into GitHub or k.org and did
>> 
>>     $ git tag maint_2014_08_22 master_2014_08_22
>
> Ok, I personally haven't used tags a lot.
> I just tried to
> 	git tag -s testbreaktag v2.1.0
> 	git show testbreaktag
> 	# However it would still read:
> tag v2.1.0
> Tagger: Junio C Hamano <gitster@pobox.com>
> Date:   Fri Aug 15 15:09:28 2014 -0700
>
> So as I do not posess your private key I could not create signed tags
> even if I were to break into github/k.org

The point was that after I push to 'maint', you break into the site
and copy or move that tag as if I pushed to 'master'.

You could argue that I could create a signed tag 'maint-2014-08-25',
push it, and if you moved it to tags/master-2014-08-25 as an
attacker, the refname would not match the "tag " line in the signed
tag object.  While that is true, nobody other thaan fsck checks the
contents on the "tag " line in practice.

But more importantly.

I may deem a commit a sensible version for the 'master' branch of
one repository but it would not be sensible for another repository's
'master' branch.  Imagine a world just like the kernel development
during 2.6 era used to be, where there was a separate tree 2.4
maintained with its own 'master' branch.  What is appropriate for
the tip of 'master' to one repository is not good for the other one,
and your timestamped "tag " line may say for which branch the push
was for but does not say for which repository.  The exact problem is
also shared with the desire to have a "branch" object expressed
elsewhere; as there is no identity for a "branch" in a distributed
world, trying to name "branch" as if it is a global entity without
mentioning what repository will lead to tears.

Besides, these tags/maint-2014-08-25 tags will be interesting only
for those who are auditing and not for general public, and we do not
have a good way to "hide" uninteresting refs until those with narrow
niche interest ask yet, which is something we may want to add soon,
but I do not want "auditable push" taken hostage to that unrelated
feature.
