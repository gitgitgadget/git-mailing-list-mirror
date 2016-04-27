From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bisect limited to Merge Commits
Date: Wed, 27 Apr 2016 13:56:42 -0700
Message-ID: <xmqq8tzy93ed.fsf@gitster.mtv.corp.google.com>
References: <20160427204551.GB4613@virgo.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Hagen Paul Pfeifer <hagen@jauu.net>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:56:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avWVu-0002WE-6M
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbcD0U4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:56:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753375AbcD0U4p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:56:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 43D9E16380;
	Wed, 27 Apr 2016 16:56:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bD9ClUpELxflMfIf51ZQCoR0WGM=; b=c4Ca6a
	hbwhRGbhBKcKn7OW+O8BzwaFGeFPlFOPZN3AAC3/YyNnpvCZdhg4cFKVg7IFtZpQ
	tiELNB3IixUmEt6/kcp+iyEksgC7bapGe9cuHqm/Hn5UeUqSayj0yqzTgel6i7Dh
	OkqByAmKIEUT0oFkXEE6qXgla5LsVYjV+THrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qXXh1RjWnK0/LIt/5iGdi42XuPaZcWul
	YFVs5lgTZWvlKL6c61+6OOdETGk38kctF3I2qmlcgIPJRzrgGJLhQ60JDkjQcPEK
	wSTppb4vcdsxaP70u2MCm+3mRngHyibKYjIZjs5t0tvlCWEh4bDzdKadGq/u/YrX
	oAVD5Gsw1qo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BDF71637F;
	Wed, 27 Apr 2016 16:56:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A13901637E;
	Wed, 27 Apr 2016 16:56:43 -0400 (EDT)
In-Reply-To: <20160427204551.GB4613@virgo.localdomain> (Hagen Paul Pfeifer's
	message of "Wed, 27 Apr 2016 22:45:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8C2EEA2E-0CBA-11E6-B97B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292824>

Hagen Paul Pfeifer <hagen@jauu.net> writes:

> Imagine a "rebase feature branch" style of development. All features are
> developed on separate features branch which are rebased on master and
> immediately merged into the upstream master. 

I do not want to imagine such ;-)  The only semi-sensible reason why
people might want to always rebase on top of 'master' is to keep the
history completely linear, so with such a workflow, there won't be a
merge commit.

But I think "rebase" part of your description is a red herring.  If
a development goes by always doing a new feature in a side branch
and then merge the branch only after it is done to the 'master'
branch, then bisecting only the commits on first-parent chain would
often be a quick first-pass to find the topic whose merge into the
'master' branch introduced a breakage.  From there you can dig down
to each individual commit on the side branch.  And for that, it is
immaterial that the side branch gets rebased on 'master' and forced
to become a merge with "--no-ff", of the side branch was developed
on older upstream but in a careless way full of "oops, previous one
I broke the entire world and it does not even compile; this commit
fixes it" commits.

So being able to stop at only commits on the first-parent chain is a
valid and useful tool.  "git bisect --first-parent" is one of the
things that are sometimes asked for.
