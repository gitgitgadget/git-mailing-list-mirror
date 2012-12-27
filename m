From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "fatal: git-write-tree: error building trees" from `git stash`
Date: Thu, 27 Dec 2012 10:51:49 -0800
Message-ID: <7vsj6rl456.fsf@alter.siamese.dyndns.org>
References: <1356631626.13818.126.camel@umgah.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Alex Vandiver <alex@chmrr.net>
X-From: git-owner@vger.kernel.org Thu Dec 27 19:52:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToIYt-0004uU-Jb
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 19:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845Ab2L0Svx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2012 13:51:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950Ab2L0Svw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 13:51:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7350A1BC;
	Thu, 27 Dec 2012 13:51:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uW66/Z/wF/uTwRP948PFc/N3iTw=; b=pMpneQ
	WHFsaj1zETsVIhqnKxN744mQIQDQNxPa7RubzWHong198tEWMI4S+AGJKtJXIXv3
	Lgu7TODVuIi6P5BqiVgcPF4gRHQbS13o7bL+IZbZ7FynYOt2Q6g3AQt8UupwY9kc
	JcTQN1MXFlmKu75nX+wQW2b6rHMwtYLtSFxfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JMB8cK+R3fj0tNqHIAYgi3+Nnqp4pylt
	PsMjaqg5J021iekfwSQJVKyuDFQ1wSUZHOcVd9CAoqmqsDuxtac0SG4ClYCOIpqW
	nA9hPLeaIz96A0ZU2fTpbq9H2nktWpvowpZ6Z7BdFu8yi46jidldzctljJ9GwKJO
	VL+c97+8iPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B42F2A1BB;
	Thu, 27 Dec 2012 13:51:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 317CAA1BA; Thu, 27 Dec 2012
 13:51:51 -0500 (EST)
In-Reply-To: <1356631626.13818.126.camel@umgah.localdomain> (Alex Vandiver's
 message of "Thu, 27 Dec 2012 13:07:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 799A5660-5056-11E2-973D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212210>

Alex Vandiver <alex@chmrr.net> writes:

> Heya,
> I just ran into the following with `git stash`.  The set-up:
> ...
> $ git stash pop
> Auto-merging foo
> CONFLICT (content): Merge conflict in foo
> Recorded preimage for 'foo'
>
> $ git stash
> foo: needs merge
> foo: needs merge
> foo: unmerged (aeaa7e5e87cf309a7368d5d92a71c1f9e6a8c9e7)
> foo: unmerged (a77fa514de2720c72c1a861de098595959a2c97a)
> foo: unmerged (4a622d2b991f1a19ba7be313a46dc6f03692cd0a)
> fatal: git-write-tree: error building trees
> Cannot save the current index state

This is totally expected, isn't it?

You do not save state in the middle of a conflict with "git stash"
(instead, you would "git stash" away your own work in progress
before you start operation that may create and leave conflicts).
