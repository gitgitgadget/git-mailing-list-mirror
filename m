From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible regression in master? (submodules without a "master" branch)
Date: Thu, 27 Mar 2014 11:30:51 -0700
Message-ID: <xmqq8urvebok.fsf@gitster.dls.corp.google.com>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
	<20140327155208.GM4008@odin.tremily.us> <53345E85.7070205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 27 19:31:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTF4x-0007Oi-80
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 19:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157AbaC0Sa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 14:30:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44562 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756822AbaC0Say (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 14:30:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDDAE7754B;
	Thu, 27 Mar 2014 14:30:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PYViWyhOa1EEJ6sCuVpA8W5koqo=; b=ExKWPg
	/Ik6dcj2BXp3na26H6QyODYE6u91YzD27Vx/jtSzdYf3fqiRJ+ipeCwg0WCdPHvn
	Q2O4BplPKTMHpTrhPStNiGHE8k6sulpaKMdhgbmXFA6aQfS2YZ/K3zP4ufPE2GzT
	P6DQIeAlmeuLdD+uMnCHjNlv+jMmcm8pEOz2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U41KVWvwGxOtRkwRhK/t9AGA5nPB/GrV
	Lk4a8f3Mql6ubVe8Nvkc711LfJkLgoals9Rre/225D3XRmVJxKag4WoPl7jfrJjC
	eeY/NDBidKHjeYSOidDTTjIvXgKIsRfrsLFxkKOSwRCRNnZv/6eUZ+gBja73Ern9
	woEPyBZZfBs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D82A37754A;
	Thu, 27 Mar 2014 14:30:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E450E77542;
	Thu, 27 Mar 2014 14:30:52 -0400 (EDT)
In-Reply-To: <53345E85.7070205@web.de> (Jens Lehmann's message of "Thu, 27 Mar
	2014 18:23:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ED928A36-B5DD-11E3-9625-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245303>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 27.03.2014 16:52, schrieb W. Trevor King:
>> On Thu, Mar 27, 2014 at 03:21:49PM +0100, Johan Herland wrote:
>>> I just found a failure to checkout a project with submodules where
>>> there is no explicit submodule branch configuration, and the
>>> submodules happen to not have a "master" branch:
>> 
>> The docs say [1]:
>> 
>>   A remote branch name for tracking updates in the upstream submodule.
>>   If the option is not specified, it defaults to 'master'.
>
> But the "branch" setting isn't configured for Qt, the .gitmodules
> file contains only this:
>
> [submodule "qtbase"]
> 	path = qtbase
> 	url = ../qtbase.git
> ...
>
>> which is what we do now.  Working around that to default to the
>> upstream submodule's HEAD is possible (you can just use --branch
>> HEAD), but I think it's easier to just explicitly specify your
>> preferred branch.
>
> That is *not* easier, as Johan did not have to do that before.
>
> I think your patch 23d25e48f5ead73c9ce233986f90791abec9f1e8 does
> not do what the commit message promised:
>
>     With this change, folks cloning submodules for the first time via:
>
>       $ git submodule update ...
>
>     will get a local branch instead of a detached HEAD, unless they are
>     using the default checkout-mode updates.
>
> And Qt uses the "default checkout-mode updates" and doesn't have
> "branch" configured either. So we are facing a serious regression
> here.

There are two potential issues (and a half) then:

 - When cloning with the "default checkout-mode updates", the new
   feature to avoid detaching the HEAD should not kick in at all.

 - For a repository that does not have that "branch" thing
   configured, the doc says that it will default to 'master'.

   I do not think this was brought up during the review, but is it a
   sensible default if the project does not even have that branch?

   What are viable alternatives?

   - use 'master' and fail just the way Johan saw?

   - use any random branch that happens to be at the same commit as
     what is being checked out?

   - use the branch "clone" for the submodule repository saw the
     upstream was pointing at with its HEAD?

   - something else?

 - Johan's set-up was apparently not covered in the addition to t/
   in 23d25e48 (submodule: explicit local branch creation in
   module_clone, 2014-01-26)---otherwise we would have caught this
   regression.  Are there other conditions that are not covered?
