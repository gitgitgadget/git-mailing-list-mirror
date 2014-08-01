From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: format-patch: don't use origin as a branch name
Date: Fri, 01 Aug 2014 13:08:30 -0700
Message-ID: <xmqq8un8ug5d.fsf@gitster.dls.corp.google.com>
References: <1406920826-4680-1-git-send-email-philipoakley@iee.org>
	<20140801193614.GR12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:08:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDJ8D-0000Vn-7o
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 22:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933AbaHAUIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 16:08:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53363 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754842AbaHAUIo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 16:08:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DAD02C28D;
	Fri,  1 Aug 2014 16:08:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=EKhuXD7vI3blwEdEaXZ7JnWYD5g=; b=glJ4WK
	i+nibz4xdniKAGX4Ylh6ziKJG5EYPCsItyON+smdZS8aG2HzXFn8KCTUUNKVQiFc
	x9Of4yjEHSJaCL7AwPe9QrfLbwQG/77X/cLsSh4uv/evBQUbF4OsxK/uN/fdD5Nw
	QYGR7HLnWwZTFiVqz7ZqlsbP88uLYlzPO7sW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fNKk8B+EgOS/lknewyULjbO69CjGkj8Q
	1dwYEa0NqTitG2ZbrlVdosL0QJ+aUnKTGQiUsI4NkPiLc3XzJ73FpdVnmMA/gxiK
	ofgw2H1fEpGGdwxEJ9HfpDJkklWus+9MHrl4xg42j5LMSBihHu9igvnK/DyJtA/n
	12YbUmzyoOg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8310F2C28B;
	Fri,  1 Aug 2014 16:08:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 17FDB2C287;
	Fri,  1 Aug 2014 16:08:32 -0400 (EDT)
In-Reply-To: <20140801193614.GR12427@google.com> (Jonathan Nieder's message of
	"Fri, 1 Aug 2014 12:36:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9C5E24D4-19B7-11E4-A0D3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254659>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Philip Oakley wrote:
>
>> Historically (5 Nov 2005 v0.99.9-46-g28ffb89) the git-format-patch used
>> 'origin' as the upstream branch name. This is now used to name the remote.
>> Use the more modern 'master' as the branch name.
>
> Would 'origin/master' make sense?

It would make a lot more sense than 'master', I think.

The 'origin' will be DWIMmed to whatever the remote designated as
its primary branch, i.e. refs/remotes/origin/HEAD, and the
assumption the examples in question makes is that the user is
following along the simplest workflow to fork from it and upstream
her changes.  Between 'origin' and 'origin/master', there isn't much
difference because of it.  In the same spirit of following the
simplest workflow, that primary branch is likely to be their
'master', so 'origin/master' is OK but longer than 'origin' [*1*].

On the other hand, 'master' names the local 'master', which may be
very stale with respect to 'origin/master', or may have tons of
unrelated things that are not in origin/master, some of which may
have come from the branch the user is running format-patch to grab
patches to upstream.  For this reason, changing 'origin' to 'master'
is not an improvement at all, I would have to say.

We could further adjust the underlying assumption to more modern
"checkout -t -b" era, and use "format-patch @{u}", but I suspect
that the readers of these examples are not yet ready for magic
before the basics to spell out things more explicitly is covered.


[Footnote]

*1* Also using 'origin' will cover the case when the primary branch
at the remote were not named 'master', so in that sense it is
slightly better and more generally applicable.
