From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] push: deny policy to prevent pushes to unwanted remotes.
Date: Mon, 06 Jun 2016 09:13:38 -0700
Message-ID: <xmqq7fe2z45p.fsf@gitster.mtv.corp.google.com>
References: <20160604145101.21928-1-Antoine.Queru@grenoble-inp.org>
	<vpq37oqjqgn.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Queru <Antoine.Queru@grenoble-inp.org>,
	git@vger.kernel.org, william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, larsxschneider@gmail.com,
	rsbecker@nexbridge.com, aaron@schrab.com, peff@peff.net
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:13:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9x9u-0003tm-OC
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 18:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbcFFQNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 12:13:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751791AbcFFQNm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 12:13:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 60AC123481;
	Mon,  6 Jun 2016 12:13:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pTlVHG6fLnYmTHznkNHvrN2NYOM=; b=Zy9oPh
	BVmsf+eujB7gfhtmvPcNDo2FqIrouHY9gF9eRolKacgC17qAHmhj5gI27ABhWymI
	ObteEBaiDaJZUjnElQTIexSVKdhlmAk5yEeHaz939WXS3pHbVAsESvV3om4fIcz8
	RejD8/76c1yE9ggspzpjI8A2hvLrmbmNPR9pQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z6nKfyGKHm1vBi9SmRSEdZ5T+t2mqrvC
	cNknOOknvX0zILJ7mva5+PT6O3MqQiY9KsmkBMp6jlk4uYAu7HaZiI1EewD9wRZz
	vAeVZsWmLAeBFziFN6TQbS1JJdldgOwOuKw5lCEHmrdDMeTJoE0KAUZANt9RvqzY
	DNjvHdQ/f8g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5922623480;
	Mon,  6 Jun 2016 12:13:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D50412347F;
	Mon,  6 Jun 2016 12:13:39 -0400 (EDT)
In-Reply-To: <vpq37oqjqgn.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	06 Jun 2016 17:18:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A19E9F92-2C01-11E6-A78E-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296525>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Antoine Queru <Antoine.Queru@grenoble-inp.org> writes:
>
>> Currently, a user wanting to prevent accidental pushes to the wrong
>> remote has to create a pre-push hook.  The feature
>
> It's not clear what "The feature" refers to. Given the context, I read
> it as "pre-push hook", but I think this is not what you meant.
>
>> User, password and port are not treated. Should it be ?
>
> Please elaborate on "not treated". What happens if github.com is
> blacklisted by the user pushes to http://me@github.com ?
> ...
>> +remote.pushBlacklist::
>> +	The list of remotes the user is forbidden to push to.
>> +	See linkgit:git-push[1]
>
> This is only true when remote.pushDefaultPolicy is "allow". It makes
> sense to say it explicitly here, if only to have a pointer to
> pushDefaultPolicy.
> ...

All good comments and suggestions, but I am bothered a lot more by
this being called "Policy" and uses words like "Prevent" and
"Forbidden" as if there is a real enforcement mechanism, when in
reality what is proposed is only advisory.

It is a good design balance to leave such a client-side mechanism
advisory and go no further than that; a truly draconian client side
mechanism has no value, as the Git protocol is open, well documented
and you can write and use a more liberal client to work around such
a mechanism.  I do not think selling such an advisory mechanism as
if it is a policy enforcement feature.

"user wanting to avoid accidental pushes" the log message mentions
sets the expectation at the right level, I would think.  I do not
think this is about a "Policy enforcement"; where its value lies in
is accident prevention (and possibly self discipline enforcement).
