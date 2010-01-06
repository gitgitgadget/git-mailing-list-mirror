From: Junio C Hamano <gitster@pobox.com>
Subject: Re: edit Author/Date metadata as part of 'git commit' $EDITOR 
 invocation?
Date: Wed, 06 Jan 2010 09:04:08 -0800
Message-ID: <7v4omz17xz.fsf@alter.siamese.dyndns.org>
References: <xuu2fx6m4vdi.fsf@nowhere.com>
 <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com>
 <xuu2zl4tfuij.fsf@nowhere.com> <20100106073806.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 18:04:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSZJ2-0007m0-Lp
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 18:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336Ab0AFRET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 12:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754881Ab0AFRET
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 12:04:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755950Ab0AFRER (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 12:04:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 457CD8E896;
	Wed,  6 Jan 2010 12:04:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=JbMD/JXxjy23vCC5HTJqSL/p0HU=; b=ENMeqIAqiFkMvGud1Fmqhp7
	O1iJNEpmPXDJXsZyAyTuszBhqvSk9VPyiKF65xOmloYUJPK/U2DC+HGdmwGNsX6L
	6dhPu3Q083dJmVfZSYn1iFK0gjCN1id2/sEotjUeTjNbIhbNclSbi9O3KFL0KF4f
	1v/1u0PqgZXsCSGWVF7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=fpMbKb7Ll8juG4P1VfT5dQIlv7x0WULsA/pSJ3koMeoe8Aogk
	yhwZEnKtiuIYbxH3GoBPsRbB8sxtNArb1GB0VUjgEqStTAf1I4uzFhl0efrJ0yHE
	4PksBAieJa2/qF6mXLGQjw0w/RVAYg0U14GeX34oousxnIEf3fGocnfYkc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AC898E893;
	Wed,  6 Jan 2010 12:04:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D2AF8E890; Wed,  6 Jan
 2010 12:04:09 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 84325434-FAE5-11DE-AF99-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136271>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Adam Megacz <adam@megacz.com>
>
>> Perhaps a preference (off by default) demanding that they be set
>> explicitly when "git commit -m" is used?
>
> Sverre pointed out why this won't work.
>
>> Some people care more than others about the metadata; this is for the
>> folks to whom it matters a lot.
>
> So the only workable solution is to check your commits with "git show
> -s" until you become confident that you configured your new box
> correctly. Some people unfortunately don't care enough to do so, but it
> is for the people to whom it matters.

Traditionally, we've only had a minimal sanity check (e.g. to barf when
the name is empty, or something silly like that) and tried to come up with
a reasonable name/email given the available system information.

The approach may have been Ok 10 years ago, back when `whoami`@`hostname`,
at least on systems that were competently maintained, gave a reasonable
mail address for most people, but I don't think it is adequate anymore to
majority of people, especially the ones who work on Open Source projects
as individuals, whose desired public identities are often tied to their
email account at their ISPs or mailbox providers (like gmail), and there
is no way for us to guess what it is from `whoami` nor `hostname` [*1*].

So I don't think anybody minds if we refuse to work if we are going to end
up using a name that we didn't get from an explicit end user configuration
(i.e. GIT_*_EMAIL and GIT_*_NAME environment and user.* configuration
variables).


[Footnote]

*1* Inside corporate environments, `whoami`@`hostname -f` might still be a
reasonable and usable default, though.
