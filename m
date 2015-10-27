From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's the ".git/gitdir" file?
Date: Tue, 27 Oct 2015 15:54:07 -0700
Message-ID: <xmqqpozzncs0.fsf@gitster.mtv.corp.google.com>
References: <87a8r4ary9.fsf@kyleam.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Kyle Meyer <kyle@kyleam.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 23:54:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrD8D-0004NY-8l
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 23:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbbJ0WyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 18:54:11 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754521AbbJ0WyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 18:54:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22E2D25FC6;
	Tue, 27 Oct 2015 18:54:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2fQiaWy/xYW5OrR7LbKnMh4FdMs=; b=aEH3oS
	dEUP8GnDLNY4NI+D8UqCEaAcomZcEhmnfMwMB4kgUySmM22WVwdy26XBwoErem5R
	OogrOG2prNiBXe5m0dkHVCMQKSCARAAKzgthUDzOhPvZq2ZxYPEjRGBXAnH06HgV
	oHh1elY0iKiip69uUMz9w3c/vcMhJuw2KEQOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O5YsSXjZUDiKF2xsaZT2qM4ICaUVqZqi
	3FsP1VF8rnYfGBV61BoFQqg9pjCflpqrzmHG/ivTM0/iaKkcDqBstFuaTNcQ4LGv
	2LNL1sFEMNSlcIPpN+INI2vg7XOAMs2M435nYtTPhUp9S/Uhvb3kw+flRwgGtN9G
	vhVV+54Kdao=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19EEB25FC5;
	Tue, 27 Oct 2015 18:54:09 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 93D8025FC4;
	Tue, 27 Oct 2015 18:54:08 -0400 (EDT)
In-Reply-To: <87a8r4ary9.fsf@kyleam.com> (Kyle Meyer's message of "Tue, 27 Oct
	2015 18:04:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A1B3BF2A-7CFD-11E5-AC0D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280313>

Kyle Meyer <kyle@kyleam.com> writes:

> When a ".git" file points to another repo, a ".git/gitdir" file is
> created in that repo.
>
> For example, running
>
>     $ mkdir repo-a repo-b
>     $ cd repo-a
>     $ git init
>     $ cd ../repo-b
>     $ echo "gitdir: ../repo-a/.git" > .git
>     $ git status
>
> results in a file "repo-a/.git/gitdir" that contains
>
>     $ cat repo-a/.git/gitdir
>     .git

Sounds like a bug in the recently added "worktree" stuff.  Perhaps
update_linked_gitdir() tweaked by 82fde87f (setup: update the right
file in multiple checkouts, 2015-08-25) is misbehaving?
