From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Tue, 06 Sep 2011 10:09:47 -0700
Message-ID: <7v1uvta97o.fsf@alter.siamese.dyndns.org>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 19:09:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0z9p-0001vJ-1N
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 19:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab1IFRJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 13:09:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab1IFRJu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 13:09:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F2264B85;
	Tue,  6 Sep 2011 13:09:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AfoXvVWbPkuanliqnAKiPdu57nI=; b=w0V3nA
	9snyTF1vg3BEtqkCcMZ+nRdDp811VLk9ed5iTQpaD3hGEyc7GQDfS2Qxw2L2JYGt
	GDx5ftAF6cYyc8q82srWOfrD7a2HxcOpwRPjes1I7S1ASY06QBciDpG2OC3jt+ED
	OOxsZQ+mjhUahsXsPwrQiI0VIoCoSArdfZ9to=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=on5idT8FBiSHW6Z6pRDKV0L10UIwkbL/
	wE+pr6uuHFz8pQqpLFlD2FFKBkqz90qtCkJf19ITGAYdMppS4R1IkTvCVj7P5Ij8
	k0ApxdxVDkB70TXuVUSc7w4Zut6UhXzRJL4fShd+alKOoO9jxua6Kd4Cd4hQ+Nga
	5lUr8iJCAUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 874414B84;
	Tue,  6 Sep 2011 13:09:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B2D34B83; Tue,  6 Sep 2011
 13:09:49 -0400 (EDT)
In-Reply-To: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com> (Francis
 Moreau's message of "Tue, 6 Sep 2011 18:08:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07193E04-D8AB-11E0-871D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180817>

Francis Moreau <francis.moro@gmail.com> writes:

> When rebasing my current branch onto the last master one, there're
> sometimes some commits which doesn't add anything anymore.
>
> Currently git-rebase produces the following message:
>
>     nothing added to commit but untracked files present (use "git add" to track)
>
> Would it be possible to add a new option to this command so it simply
> skip the unneeded commit ?

Our assumption has always been that it is a notable event that a patch
that does not get filtered with internal "git cherry" (which culls patches
that are textually identical to those that are already merged to the
history you are rebasing onto) becomes totally unneeded and is safe to ask
for human confirmation in the form of "rebase --skip" than to ignore it
and give potentially incorrect result silently.

Obviously you do not find it a notable event for some reason. We would
need to understand why, and if the reason is sensible, it _might_ make
sense to allow a user to say "git rebase --ignore-merged" or something
when starting the rebase.
