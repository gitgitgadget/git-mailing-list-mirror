From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to pre-empt git pull merge error?
Date: Wed, 27 Nov 2013 12:09:15 -0800
Message-ID: <xmqqvbzdsj2s.fsf@gitster.dls.corp.google.com>
References: <86d2llc1rs.fsf@gmail.com>
	<20131127194240.2abaff5575961b3d73e1970f@domain007.com>
	<vpq8uw9q1r4.fsf@anie.imag.fr>
	<CALWbr2wNODeLSmQ5ztQmKVxBSguNJ1bbSbvY66sdsP09dSUUgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <tr@thomasrast.ch>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Pete Forman <petef4+usenet@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 21:09:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VllQL-0006yA-RE
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 21:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757711Ab3K0UJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 15:09:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50035 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757569Ab3K0UJT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 15:09:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC39454AAA;
	Wed, 27 Nov 2013 15:09:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4XU0zsbryyeAKlwyMQ2aBqQ+1Z4=; b=AQVnZz
	ocqBd6A1yNOFMG2UUrFGVVYWZdbrMehlsSi8GCgDTUcHBCDa823hgqvLyHnLOjfz
	dGXe6NItgGUxhOH+5fbtWEu8z0kDudLavl4P9khFq46iximMW31Nog2iiCpl7S56
	ZkpG518b2XmHEVHex3UOrzwWy+tl6Z9+wzaE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZZFTvm+FcEJLNE7D7WcdSREGicDbZagT
	s9G0SFFCiI9d5XFgMDcbbiCJZFWPJ9IlEsC/mjB5SOg0Rcpb34eHcjX+GuvLjyoC
	ZC7kAxxWVKGjdGi7Ppf3Vq9EXKgbJW6Xg2unoDFI5dOmQ0osLgGx3whz6UTeT7cS
	ZdNvg7J6lRY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9763954AA9;
	Wed, 27 Nov 2013 15:09:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E08CD54AA7;
	Wed, 27 Nov 2013 15:09:17 -0500 (EST)
In-Reply-To: <CALWbr2wNODeLSmQ5ztQmKVxBSguNJ1bbSbvY66sdsP09dSUUgA@mail.gmail.com>
	(Antoine Pelisse's message of "Wed, 27 Nov 2013 17:38:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CBA60322-579F-11E3-A74D-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238459>

Antoine Pelisse <apelisse@gmail.com> writes:

>>> On Wed, 27 Nov 2013 15:17:27 +0000
>>> Pete Forman <petef4+usenet@gmail.com> wrote:
>>>
>>>> I am looking for a way of detecting up front whether a git pull or git
>>>> merge would fail. The sort of script I want to perform is to update a
>>>> server.
>>>>
>>>>     git fetch
>>>>     git okay
>>>>     stop server
>>>>     backup data
>>>>     git merge
>>>>     start server
>>>>
>> I don't know a simple way to do the pre-merge check without actually
>> doing the merge (other than patching git merge to add a --dry-run
>> option)
>
> Wouldn't that be a nice use-case for git-recursive-merge --index-only
> ($gmane/236753) ?

As the original mentions "error: Your local changes to ...", I do
not think it would be a good fit.

I have to say that the safest and sanest way may be to:

 (1) Commit any such local change(s);

     server$ git commit -a

 (2) Pull that down to a pre-deploy repository from the "server";

     prepare$ git pull ...to grab the "local changes" above...

 (3) Merge in whatever the update you want to have on the "server";

     prepare$ git merge ...whatever...

 (4) and then stop the server, fast-forward to the result of (3),
     and then restart.

     server$ stop server
     server$ git pull --ff-only ...the prepared result of (3)...
     server$ start server
