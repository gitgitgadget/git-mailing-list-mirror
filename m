From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding push configuration to .git/config
Date: Wed, 21 Nov 2007 17:48:22 -0800
Message-ID: <7vabp79hjt.fsf@gitster.siamese.dyndns.org>
References: <20071121105517.GA11875@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 02:48:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv1BT-0004bw-1y
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 02:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbXKVBsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 20:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbXKVBsd
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 20:48:33 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34938 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbXKVBsc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 20:48:32 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 99AB72F2;
	Wed, 21 Nov 2007 20:48:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C72A198611;
	Wed, 21 Nov 2007 20:48:50 -0500 (EST)
In-Reply-To: <20071121105517.GA11875@denkbrett.schottelius.org>
	(nico-linux-git@schottelius.org's message of "Wed, 21 Nov 2007
	11:55:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65733>

Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
writes:

> Nice would be
>
> [branch "master"]
>    remote-push          = origin
>    remote-push-merge    = another_branch
>
> And thus perhaps also changing the existing specs:
>
>    remote = ... to remote-fetch = ...
>    merge = ... to remote-fetch-merge = 

I do not think doing this is worth it, not because I think a
single branch.$name.remote should be good enough for everybody,
but because once you need a separate remote each for fetching
and pushing, there is no reason to say one per direction is
enough.

An alternative could be to split [remote "name"] url into two
variants, fetch-url and push-url.  While fetching by default
from two places without telling from which one does not make any
sense, pushing by default to two different places is quite a
normal thing to do, and we already do support more than one url
entries in [remote "name"] section used for pushing.

If we were to do this, it might also make sense to rename the
word 'origin' we use for the default remote name to 'default' or
something.  People with shared repository workflow would fetch
from one repository and push back to the same repository, so the
distinction would not matter, but for others who need something
like you suggest, the default repository for fetching and
pushing are different, and while you may still consider where
you fetch from your 'origin', where you push into is not your
'origin' anymore.
