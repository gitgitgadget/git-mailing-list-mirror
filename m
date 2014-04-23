From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 3/3] Add 'update-branch' hook
Date: Wed, 23 Apr 2014 14:22:16 -0700
Message-ID: <xmqq8uqvyc53.fsf@gitster.dls.corp.google.com>
References: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
	<1398282160-26151-4-git-send-email-felipe.contreras@gmail.com>
	<xmqqsip3yemg.fsf@gitster.dls.corp.google.com>
	<53582bb6ceb64_24448772ecaf@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilya Bobyr <ilya.bobyr@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 23:22:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd4d2-0006sF-Go
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 23:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbaDWVWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 17:22:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36729 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbaDWVWo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 17:22:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEB127E22C;
	Wed, 23 Apr 2014 17:22:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xC+fgkhJrSC1toSJ1pdtkETU25Q=; b=i0X3sE
	rOd0YpeiyyI9663w/wpMrDbzuNh6gSQ5Zn1atR3gjgdNVxpeGJ6Oku97gBYP/tYr
	XmyAwpUu2NOOqMAgMAh6s34/MJJNp2B9tXCLIPzm173Qblkfjgck0Z1oaIpo5nAY
	ffWvXl+gJbC+AEZVrhJaBoGB7wny4kTFMVu9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yEP8ZFmfK0x2apBpjSu7MhHr/8AbCwUG
	8RjD6qheS1kKxN8gz/swhEVQQGjC5x/ajQF4pvT94QcAjHuHn693YmQ/eq6AHwFY
	465HaCv38/nvVzi0OJAU5/qYM+Ps4oRcFhdqK7ngluev2YNYCA+NT/lJeVzU+4qa
	vXzBuuk2eNc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C90AB7E22B;
	Wed, 23 Apr 2014 17:22:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28D767E1D2;
	Wed, 23 Apr 2014 17:22:18 -0400 (EDT)
In-Reply-To: <53582bb6ceb64_24448772ecaf@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 23 Apr 2014 16:08:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5936DDC8-CB2D-11E3-904D-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246900>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > This hook is invoked before a branch is updated, either when a branch is
>> > created or updated with 'git branch', or when it's rebased with 'git
>> > rebase'.  It receives three parameters; the name of the branch, the
>> > SHA-1 of the latest commit, and the SHA-1 of the first commit of the
>> > branch.
>> >
>> > When a branch is created the first and last commits of the branch are
>> > the same, however when a branch is rebased they are not. If the SHA-1 of
>> > the first commit of the branch is not available (e.g. git reset) a null
>> > SHA-1 (40 zeroes) would be passed.
>> >
>> > The hook exit status can be used to deny the branch update.
>> >
>> > It can be used to verify the validity of branch names, and also to keep
>> > track of the origin point of a branch, which is otherwise not possible
>> > to find out [1].
>> 
>> Please call it pre-update-branch at least,
>
> I will do so when I see a good argument for it.

If you choose to ignore "a user cannot tell from the name
update-branch when it will be called, we cannot introduce
post-update-branch later without making things more inconsistent if
we do not name it pre-something" and label them not "a good
argument", then I do not have anything to say to you.
