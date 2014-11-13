From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5705: Use the correct file:// URL
Date: Thu, 13 Nov 2014 08:37:48 -0800
Message-ID: <xmqqtx232h0j.fsf@gitster.dls.corp.google.com>
References: <54645F67.30008@web.de> <20141113091724.GB8329@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 17:37:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoxPB-0001SR-A8
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 17:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbaKMQhx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2014 11:37:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753969AbaKMQhw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2014 11:37:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BFFB41C0EC;
	Thu, 13 Nov 2014 11:37:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=f+jaL0+3ZpF2
	asKlnzzAz1SFwYs=; b=xM+dXVmQfdRJ+ir+udC9ikkGceOwqPKDfLs8+aYLmSLD
	nvr/Cxl8faxOjAjocVY6IlfArp8ShEdKmNsAYdnw/DbWuK6yqJxmWTtWb4hdQ6sk
	NgN50+lHi3Pt5SDcDjDQWs50zw0cqb/Ax8s3PvDxFSrzvjcIY58D6/GTZ9y2+Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oyhWLV
	K561nHvF6yMyuf8IVd4R7XCEmP1K7ZHbmGv5QesXL76Z7Wbj2DsOneGJewqVwv9G
	EcQunQwXA4Ux69NGE26ms2vwxAMJL8GhW7EAXPluJvXl/S/AVBd4V3+ZdGWENUbR
	guyKAZ+9WNLqw+3hzZ4FqnwjQqQbSHbktnTG4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AF131C0EA;
	Thu, 13 Nov 2014 11:37:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E30701C0E8;
	Thu, 13 Nov 2014 11:37:49 -0500 (EST)
In-Reply-To: <20141113091724.GB8329@peff.net> (Jeff King's message of "Thu, 13
	Nov 2014 04:17:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6802418C-6B53-11E4-BCC9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 13, 2014 at 08:36:07AM +0100, Torsten B=C3=B6gershausen w=
rote:
>
>> A URL like file;//. is (no longer) supported by Git:
>> Typically there is no host, and RFC1738 says that file:///<path>
>> should be used.
>>=20
>> Update t5705 to use a working URL.
>
> Interesting. This looks like it was unintentionally lost in c59ab2e
> (connect.c: refactor url parsing, 2013-11-28). Given RFC1738, and tha=
t
> this is the first notice of it (and that it is not even a real use ca=
se,
> but something questionable in the test script), it's probably OK to
> declare the syntax dead and not treat it like a regression.

Yeah, I tend to agree.  I do not think there is any <scheme>:// that
lets you say things relative to something that is not "root" of the
namespace, and it was a bug the old test depended on that we did not
notice it as an error when "file://." tried to refer to "the current
directory".
