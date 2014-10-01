From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-prompt.sh: shorter equal upstream branch name
Date: Wed, 01 Oct 2014 10:49:56 -0700
Message-ID: <xmqqppebptmj.fsf@gitster.dls.corp.google.com>
References: <1412091370-11727-1-git-send-email-jcarsique@nuxeo.com>
	<542B1623.2070109@bbn.com>
	<xmqq7g0krb2p.fsf@gitster.dls.corp.google.com>
	<542B7AF8.6080501@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Julien Carsique <julien.carsique@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 19:50:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZO2W-0006TN-Mj
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 19:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbaJARuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 13:50:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55652 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728AbaJARuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 13:50:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA9003DDDB;
	Wed,  1 Oct 2014 13:49:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mpJjuZrAV5eUw8e7ALmigamA3gk=; b=h3zn3O
	ktyin4TwQadps7xIGRTQN0fHctQCTo4FF6f5KSJGmFx8p8f5KB0jR9Syta2ukpWd
	8Rg+d4I6s7KIDlD25dNCulJ0mUr42nlYYxGFLS4GUQxSLy7fcU8ZwPPQe2ZzR2/W
	bfBHCOvShvl5jdd92D/6iw0uqxthUoOL4Ikuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MmsWgWu1f/DA8A/PiMnf16A/hyycAXKG
	nvelznTUphaYovODLVARfqO3smNzsLJSBw1YRoPGvwYnHFwY6SIY7XPjcf/VFH1f
	Yuy/Y+6zrRoKcCrSS6WTvgXzGRC1RYQjNom71WK/ZphDyW+DJurPofYOUcRArv5K
	xMtygFFy7Ss=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C7AB53DDDA;
	Wed,  1 Oct 2014 13:49:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2BC073DDD9;
	Wed,  1 Oct 2014 13:49:58 -0400 (EDT)
In-Reply-To: <542B7AF8.6080501@bbn.com> (Richard Hansen's message of "Tue, 30
	Sep 2014 23:54:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C205B88-4993-11E4-8142-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257761>

Richard Hansen <rhansen@bbn.com> writes:

>> and there is no hope to "fix" them to stick to
>> the bare-minimum POSIX,
>
> I don't think it'd be hard to convert it to pure POSIX if there was a
> desire to do so.

Not necessarily; if you make it so slow to be usable as a prompt
script, that is not a "conversion".  Bash-isms in the script is
allowed for a reason, unfortunately.

> It would be unwise to go to great lengths to avoid Bashisms, but I think
> it would be smart to use POSIX syntax when it is easy to do so.  

In general, I agree with you. People who know only bash tend to
overuse bash-isms where they are not necessary, leaving an
unreadable mess.

For the specific purpose of Julien's "if the tail part of this
string matches the other string, replace that with an equal sign",
${parameter/pattern/string} is a wrong bash-ism to use.  But the
right solution to count the length of the other string and take a
substring of this string from its beginning would require other
bash-isms ${#parameter} and ${parameter:offset:length}.

And that's fine.
