From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] relative_path should honor DOS and UNC paths
Date: Wed, 18 Sep 2013 09:00:53 -0700
Message-ID: <xmqq4n9iw24q.fsf@gitster.dls.corp.google.com>
References: <1c0d845aca9a9ca65a7e1d481a75a0f6f4220a89.1379406453.git.worldhello.net@gmail.com>
	<2c56935842ceef4d5933c299dd2d55286eb0ba3a.1379406453.git.worldhello.net@gmail.com>
	<xmqqli2v1l7f.fsf@gitster.dls.corp.google.com>
	<CANYiYbF1XwKbD13AMZhE1c4hGMqVzpH9hZ-J8Gk-8AVFUCnn0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 18 18:01:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMKBb-0002Qa-HX
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 18:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995Ab3IRQA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 12:00:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752804Ab3IRQA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 12:00:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41479422DB;
	Wed, 18 Sep 2013 16:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dHeU07UGJa2PURbftivEtYbUH/4=; b=hQAEFh
	zziFBQjHD2qVWUdVfpuls+Oa9tuECi59nLjeTpb7KqIx9iSpY645syOEddSjPjj9
	VKbeoDgWD/WHZgJZitJEBVyhCGU3QFgnpmjGAJPuCq5fjrJnIJhMl8M1s2y+GKPC
	cj+GMNnU9r6ObMiyGIMgFLrArcz6/hARbdeJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NWTrl+vzBTWaGrK3W5L90lsPGYReFh2G
	xGZmnrgAbPBTUnw7GPWYF5XmIZX09G6NfO+VNkLPXHBRlvtBrH5tJ4pDi8qCpReK
	SURIQZA3hh/ME96h5Y7cmlehEKgAGvGJIPaEKz4c67dNHZRHHnCpb0zB2tG2myBV
	Tu5pM0c1zHA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34359422D8;
	Wed, 18 Sep 2013 16:00:57 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 748F0422D4;
	Wed, 18 Sep 2013 16:00:56 +0000 (UTC)
In-Reply-To: <CANYiYbF1XwKbD13AMZhE1c4hGMqVzpH9hZ-J8Gk-8AVFUCnn0g@mail.gmail.com>
	(Jiang Xin's message of "Wed, 18 Sep 2013 17:02:12 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 80CCF4CE-207B-11E3-B123-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234971>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2013/9/18 Junio C Hamano <gitster@pobox.com>:
>>> +     if (!is_dir_sep(*path) || !is_dir_sep(*(path+1)) || is_dir_sep(*(path+2)))
>>> +             return 0;
>> If path[1] == '\0', it would be !is_dir_sep() and we end up
>> inspecting past the end of the string?
>
> The funciton "is_unc_path" will return false (0), if path is
> "", "/", "//", "///three/slashes/", or "/usr/local".
> So the problem is ?

If path[1] == '\0' (e.g. path="/"), !is_dir_sep(path[1]) is true,
not false (as I misread earlier), so we hit an early return and will
not peek path[2].  So no problem.  Sorry for the noise.

But I agree with J6t and Torsten in near-by thread that the simpler
one that does not worry about // should be done as a separate patch
and //, if we decide to do it, should build on top.

Thanks.
