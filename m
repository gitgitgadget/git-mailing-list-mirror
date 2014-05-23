From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Plumbing to rename a ref?
Date: Fri, 23 May 2014 10:10:05 -0700
Message-ID: <xmqqvbswjuaa.fsf@gitster.dls.corp.google.com>
References: <87ha4golck.fsf@osv.gnss.ru> <20140523105047.GA2249@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 23 19:10:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnsz7-0006TY-EC
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 19:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbaEWRKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 13:10:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65454 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252AbaEWRKN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 13:10:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E003818719;
	Fri, 23 May 2014 13:10:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NSYVawUhSlQHUEUVI5Pm3G+lqkU=; b=f8KDuq
	CxmMRILLpnbTznUm3g3AVc4j1MTyblBK6mf4bBOIptaY2BiXbDpoepr5LRinK9ne
	lu27rqDMlXxLxbmoQHOyuaduk3UMaySio8tcu9w2nq5HeLUpQimuMJgckhTkOqC4
	JgAVUmkySCLq1pdVwavSoUrBzp+eV00lNwBOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JJHAgatv+3yK1si2POsiBrU6du5YSgtZ
	fVUjK1HY5E/eKbQEEnfVaNA30kt/2TdKcpAnNA2p695dasExF4bCOjNFuUhDCZ7g
	UkXrv8FVVPJlj6oSHztprlUB09y/WroYVwWo2AkcQbfFzTWO8CMMEBahKXGm7/fn
	dL0Ee0HBVtU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE2F018718;
	Fri, 23 May 2014 13:10:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 302D218708;
	Fri, 23 May 2014 13:10:07 -0400 (EDT)
In-Reply-To: <20140523105047.GA2249@serenity.lan> (John Keeping's message of
	"Fri, 23 May 2014 11:50:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 16D5C9D0-E29D-11E3-8014-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250002>

John Keeping <john@keeping.me.uk> writes:

> On Fri, May 23, 2014 at 02:11:55PM +0400, Sergei Organov wrote:
>> Hello,
>> 
>> After convertion of a project from CVS to git, I'd like to rename some
>> references in the created git repository (before it's published, so no
>> problems here). Is there a plumbing that would do:
>> 
>> git rename-ref <old_name> <new_name>
>> 
>> for me?
>
> I think the best you can get is two invocations of `git update-ref`:
>
> 	git update-ref <new_name> <old_name> &&
> 	git update-ref -d <old_name>
>
> Although if you're scripting it the `--stdin` mode may be easier:
>
> 	git update-ref --stdin <<-\EOF
> 	create <new_name> <old_name>
> 	delete <old_name>
> 	EOF
>
> Note that "<new_name>" must be a fully-qualified ref (that is, it must
> start with "refs/", so "refs/heads/new_name" for a branch or
> "refs/tags/new_name" for a tag).

Shouldn't <old_name> also be a full ref?
