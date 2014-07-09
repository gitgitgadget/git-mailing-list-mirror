From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/2] add `config_set` API for caching config-like files
Date: Wed, 09 Jul 2014 08:17:22 -0700
Message-ID: <xmqqmwci7e9p.fsf@gitster.dls.corp.google.com>
References: <1404903454-10154-1-git-send-email-tanayabh@gmail.com>
	<1404903454-10154-2-git-send-email-tanayabh@gmail.com>
	<vpq61j6d92z.fsf@anie.imag.fr> <53BD3805.40504@gmail.com>
	<vpqion68viq.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 09 17:17:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4td6-00022g-DA
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 17:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250AbaGIPRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 11:17:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65080 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756258AbaGIPRb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 11:17:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 56B5625F9A;
	Wed,  9 Jul 2014 11:17:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TbqfB0NBppSxTUbGO40YIsVwdxE=; b=edCwuF
	BnXVWOuEFcUEzndygae4OIFzvpJ6A8Uzg63fKLF1eSCXejKuWqAlsv6Fw6kosUim
	hmUk8Zm1cVOwFnTGNnDRCxBuhz5fk9arwXVE49ukv7QE0HeqHYt6tw2kovrFSBt+
	vKfSAtfnitKuhcQrvxNu4/rN1PvbjN/M30pUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JghKsuOHOSlTF6t/aZ94vmAa4ksuQpQP
	+SfLvs4hgEXvuoWeAegV2zhZeitMSQn1yJj5dAywf0F5fzGJe/x+lugw9rHMgT2y
	rII62RFqjMDQ7xev2ZxKu0R0Gw2O6K5pFduMDUTTA5pAi3QUm/zHsH6kn2JHS7tQ
	yhbqHwwjpVU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C66D625F98;
	Wed,  9 Jul 2014 11:17:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 22F4A25F90;
	Wed,  9 Jul 2014 11:17:09 -0400 (EDT)
In-Reply-To: <vpqion68viq.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	09 Jul 2014 16:19:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1837F8E4-077C-11E4-A99F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253129>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> My opinion on this:
>
> * It's low priority. I think the order of priority should be (high to
>   low)
>
>   1) Finish and get the current series into pu (we're almost there, it's
>      not time to back off and restart something new).
>
>   2) Work on the other series that uses the new API. We don't need to
>      change _all_ the uses, but we do need a few tens of them to
>      validate the fact that the new API is nice and convenient to use.
>
>   3) Get new actual features for the user (tidy up config files, give
>      error messages based on numbers).
>
>   You probably won't finish everything, so just think: if the GSoC ends
>   between 1) and 2), how serious is it? if it ends between 2) and 3),
>   how serious? If reverse the order, then the risk of having nothing
>   finished and mergeable at the end is high. If it happens, the
>   community may or may not take over and finish it ...
>
> * Still, making sure that the (file, line) is doable later without too
>   much change is good. So, if indeed, moving all code to another file is
>   required, then it may make sense to do it now to avoid code move
>   later.

Good thinking.  As long as the code is prepared, it is a good idea
to start small and bite off only we can chew at once, do things
incrementally.

>> 1. config-hash.c had to be shifted to config.c entirely.
>
> Why? I guess one reason is the use of struct cf (are there others?), but
> moving just
>
> config_hash_callback
> config_hash_add_value
> git_configset_add_file
>
> to config.c should do it. Then, config.c could use config-hash.c.

I am not sure why you guys needed a new file config-hash.c to begin
with, actually.  Besides, "hash" in its name is an implementation
detail (what it gives us is a way to grab values for configuration
variables from a config set) which we would rather not want to see.
