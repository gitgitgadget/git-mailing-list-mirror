From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] connect: uniformize and group CONNECT_DIAG_URL handling code
Date: Mon, 02 May 2016 15:05:31 -0700
Message-ID: <xmqqfuu0qfo4.fsf@gitster.mtv.corp.google.com>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
	<1462082573-17992-3-git-send-email-mh@glandium.org>
	<5726DE16.3030402@web.de> <20160502083133.GA20929@glandium.org>
	<57273A0B.5050409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue May 03 00:05:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axLyF-0006FN-L3
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 00:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236AbcEBWFf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2016 18:05:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755209AbcEBWFf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2016 18:05:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EF96819503;
	Mon,  2 May 2016 18:05:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0XKTb2hKepy0
	Cms3LDwyBVmXngg=; b=nrSkkTwOGSwO//3wKwEAm9QhlGMjPSufGl3R345hI17/
	/mOMAu7M4KGB0ywpvVTBg05665X2L2Ge00VGEbRFU/8JAQslPohD9CM0kiT4cfKm
	mncpE/uGRlM2YQuBWI0z8fElLhFMUMJKVjI+hF5qwv7hLFw7wiKo0Kt6x+5uCMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sp3YUC
	gVLmfuiCEmTZ8j5a0DdQfMhP9pEgckP6I/LghzYhFhJo/ZeDlrFVjnB8vosV5Qhq
	GXBg92EIDf5oNLmmKJ9tU2jD6d765aQS5l2u6TFRRxmbVWXWkeMsFIBiz7m9ePFe
	5U9R/yApqAUIOefDS+pYpx5NtI7eP4Am3ls14=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E682F19502;
	Mon,  2 May 2016 18:05:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 53E2319501;
	Mon,  2 May 2016 18:05:33 -0400 (EDT)
In-Reply-To: <57273A0B.5050409@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Mon, 2 May 2016 13:29:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FDBBBB9A-10B1-11E6-B13B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293294>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> git://host:[port]/path/to/repo
> Knowing that, the "@" will be feed into the name resolver,
> and that's OK.

Is it OK?  It is plausible that our client side may even want to
accept git://user:pass@host:port/local/part, and as an anonymous
service, allow it to go to git://host:port/local/part without
sending user:pass part over the wire.  Or with the same knowledge
that git:// is an anonymous service, it is also a plausible policy
to error such a request out.  To implement either needs a robust
parsing of the URL, doesn't it?
