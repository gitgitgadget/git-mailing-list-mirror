From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git fetch --all --tags doesn't fetch remote branches, only
 tags
Date: Mon, 31 Dec 2012 17:15:03 -0800
Message-ID: <7vbod9d7qg.fsf@alter.siamese.dyndns.org>
References: <50E2311D.8080707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: Dennis Heidsiek <dennis.heidsiek@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 02:15:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpqSC-000751-HT
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 02:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294Ab3AABPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 20:15:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50224 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876Ab3AABPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 20:15:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C862A5AE;
	Mon, 31 Dec 2012 20:15:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LaxqDyEXwA2KxQGRu9de7QdTrAk=; b=gdtAF/
	nYKNlCk8xvUY7FmGA6iW+ETZFqqzgnEWWeH5MEliMt1U82b+33nw6/KC39YKvKQ6
	udG3kaLWzOt3ecPtSiMNEGK+h3ID2Mpev2AZf8mZkgmKBO3Ax5BhdSV2KpuoLKHb
	afzYgkK6uzncNEeQMqQz+qJNFzTATQyALyNgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QCcLkHPKXiomqd41AUnotgZjSxhWTd6E
	gigKsscd/H8BHt4OXH1QKusBWY5AAqldncOvznFetNDu9ETmduO54DtpNGWDUHhH
	DRD+Ta/8x6NnjRavDaJ0NGLgBt1dSs/YE2dDs75SENzWkvKZTkiKrsDQ9S9T3hSS
	hR9XuJaF7PQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2E48A5AD;
	Mon, 31 Dec 2012 20:15:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FF42A5AB; Mon, 31 Dec 2012
 20:15:06 -0500 (EST)
In-Reply-To: <50E2311D.8080707@gmail.com> (Dennis Heidsiek's message of "Tue,
 01 Jan 2013 01:43:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD7ED912-53B0-11E2-9A98-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212374>

Dennis Heidsiek <dennis.heidsiek@gmail.com> writes:

> i think there may be a bug in the fetch command: The command
>
>> $ git fetch --all --tags
>> Fetching origin
>
> doesn’t fetch new commits from origin/master, while i see via the
> web browser of my remote repository that they exist.

The "--all" option asks to fetch from all remotes, and "--tags"
option asks to disable the configured fetch refspecs and instead
grab only the tags.  It appears that what you observed is exactly
what should happen and in line with the documentation:

$ git help fetch | sed -ne '/^ .*-t.*--tags/,/^$/p'
 -t, --tags
     This is a short-hand for giving "refs/tags/:refs/tags/" refspec
     from the command line, to ask all tags to be fetched and stored
     locally. Because this acts as an explicit refspec, the default
     refspecs (configured with the remote.$name.fetch variable) are
     overridden and not used.
