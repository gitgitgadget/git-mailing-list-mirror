From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git ate my home directory :-(
Date: Mon, 25 Mar 2013 15:15:34 -0700
Message-ID: <7v7gkvw2gp.fsf@alter.siamese.dyndns.org>
References: <5150C3EC.6010608@nod.at> <20130325214343.GF1414@google.com>
 <7vfvzjw334.fsf@alter.siamese.dyndns.org> <20130325220822.GG1414@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Weinberger <richard@nod.at>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 23:16:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFgT-0007GU-4u
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 23:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759000Ab3CYWPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 18:15:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37849 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758655Ab3CYWPh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 18:15:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99150BBE9;
	Mon, 25 Mar 2013 18:15:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+zAFWks6HGHpCkAa4ivPmcLD9No=; b=gAhQX6
	batZsC305Bx3j++6TeQ65PcAVOGW6jBoCAVUdOf2XWodyHF/glDzsYd3Txk/XoTt
	YBB9kTqiEd7IzxgJ+E4ltf9+Pek3fphSzYkD14mIOXSzF6KgS+QKXIt0dDGFXN8j
	WOf5PIwFu9gbHTFbatWHn+7OOlXh87jSzJXIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a+86B0jU3jfFpUEeQ+QzlByGP1RTqovn
	F+dgBDghiDZWasm3zLw/FqRldAJigL9uQHoiJQHLgeP9F22n+N7Jrrr25lWw+ZiN
	xAq3rFfq1vVUOrXGnpXpkjlK2sRLCuIYnTSJQmEV2/QWuL/iGKKCQ29J0ypkCV88
	kxHawIbnVVU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CAC3BBE8;
	Mon, 25 Mar 2013 18:15:36 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC1C6BBE2; Mon, 25 Mar 2013
 18:15:35 -0400 (EDT)
In-Reply-To: <20130325220822.GG1414@google.com> (Jonathan Nieder's message of
 "Mon, 25 Mar 2013 15:08:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84717D60-9599-11E2-9798-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219110>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> In git versions including the patch 2cd83d10bb6b (setup: suppress
>>> implicit "." work-tree for bare repos, 2013-03-08, currently in "next"
>>> but not "master"), you can set GIT_IMPLICIT_WORK_TREE=0 to avoid this
>>> behavior.
>>
>> WAT?
>
> Is that false?
>
> If I understand the history correctly, the ability to set the GIT_DIR
> envvar was meant to allow a person to keep their .git directory outside
> the worktree.  So you can do:
>
> 	git init my-favorite-repo
> 	cd my-favorite-repo
> 	...work as usual...
>
> 	# cleaning time!
> 	mv .git ~/my-favorite-repo-metadata.git
> 	GIT_DIR=$HOME/my-favorite-repo-metadata.git; export GIT_DIR
> 	... work as usual...

... as usual except that you have to be at the top.

And that is why GIT_WORK_TREE was invented, so that you can anchor
where the top of the tree is with that variable and then chdir
around into its subdirectories.

Also later we added core.worktree so that $GIT_DIR/config can say
where its associated working tree is.

> This is of course unsafe because it ties your usage to a specific
> version of git.  And the variable is not advertised in the
> documentation.

We decided not to advitise it exactly because we do not intend to
guarantee that will be the way that variable will work.  It is an
implementation detail of that "alias" stuff in the topic it
addresses.

The documented way is to point at the tip with GIT_WORK_TREE.
