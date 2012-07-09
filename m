From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] rm: don't fail when removing populated
 submodules
Date: Sun, 08 Jul 2012 22:02:39 -0700
Message-ID: <7vtxxhle6o.fsf@alter.siamese.dyndns.org>
References: <4FF4AAE7.40604@web.de> <4FF4AB1B.60805@web.de>
 <7v1ukppear.fsf@alter.siamese.dyndns.org> <4FF830D6.7080708@web.de>
 <7vsjd2n1wt.fsf@alter.siamese.dyndns.org> <4FF9A261.3040907@web.de>
 <7vhathn0f4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 09 07:02:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1So67S-0001uq-IK
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 07:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333Ab2GIFCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 01:02:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40977 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030Ab2GIFCl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 01:02:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AF52873D;
	Mon,  9 Jul 2012 01:02:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b0x6vM+e2ftwcDEiwf264xSjAdA=; b=cMnusk
	AES48rIySdZJQcE7AzlV7SSPstsZHTM9mOeQARpfAaCouWO2RyZfaFmxHGmp6y6R
	ClE+rNQ5xzYYSECuJ75/ZHR2EDLBpBy3hy69VoIhCaZf7K0YQDk0pB3lf6PGOKrY
	AtUs77NS5glmZdUaf0d0j1M0yIUWcnWiX4p80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oIlNcLS6QoHGdMzfPkUOfNKoUpXs9hnj
	KvPNNDK2H7cJ5hfK0O498X9gEeRivVdRI62HiNqpVY+3Z2lqlttBZF3ys7tkG0ci
	aVf56ULRFWKFWWbKaLRxOseKiyTpvxLFFf1jwwxwxvxTG6g+Wn6gku0iS9CCfimx
	YYeV8qX4ggs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3263E873C;
	Mon,  9 Jul 2012 01:02:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7B5F873B; Mon,  9 Jul 2012
 01:02:40 -0400 (EDT)
In-Reply-To: <7vhathn0f4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 08 Jul 2012 19:17:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F636F58-C983-11E1-A0C5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201193>

Junio C Hamano <gitster@pobox.com> writes:

>> Nope. Only the "--recursive" option to the git submodule script
>> works like that (and almost everyone seems to use that option by
>> default anyway). But for all commands that understand the
>> "--recurse-submodule" option (currently these are clone, fetch,
>> merge, pull and push) that means "include submodules in what you
>> do and don't stop at the first level but recurse all the way down".
>> Without this option they won't even touch the first level of
>> submodules.
>
> OK, but what does "rm --no-recurse-submodules path" could possibly
> mean in that case?  If you remove "path" by definition anything
> underneath "path" cannot be remain, so in the context of "rm", once
> you decide to remove submodule at "path", not recursing is an option.

Yikes, I hate myself after making silly typoes.  Of course the above
needs s/cannot .. remain/cannot remain/; and more importantly, not
recursing is _not_ an option once you decide to remove it.
