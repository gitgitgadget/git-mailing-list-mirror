From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 6/7] correct blame for files commited with CRLF
Date: Tue, 29 Mar 2016 13:25:42 -0700
Message-ID: <xmqqio05vxo9.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1459257938-17389-1-git-send-email-tboegi@web.de>
	<xmqqa8lhyzbq.fsf@gitster.mtv.corp.google.com>
	<56FADCAB.1010201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:25:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al0D1-0003wx-J4
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758001AbcC2UZq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 16:25:46 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756524AbcC2UZp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 16:25:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 525385032A;
	Tue, 29 Mar 2016 16:25:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=39ykOEXRP9u1
	epCXgUb+aziDZRs=; b=sM5+ofttr0MhtYjJyAZqb+CGaDNYSOVj6Z9SaF1siY62
	LEHFuTJZMbXKOlLl61LMbjF5S2fXSCKxdAwrMVkawWuhhOFF+pVE/U748DV5gWqe
	d+mmP03nqBM4DpLuy+TGnkcTaHrdOsWIY+MT5QUgtZcrL74kyEgh5KA1ZpDQkvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mBBwlK
	csHVfGnUdyhGQPevu2hOps5HL1A5L/Ai0hYK1YeDcl8DS1qjaOiy9VoF8sBavx+t
	0tkQJTqGlylxlaE9CKEsC2X6rzGt9hMTWyntXCYZcLrKUrQcum5iwkvYfdh6OlsM
	lBBiA69U+OQqYXhE/9RI1sVha5tMnNkLSTiD4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 491CC50329;
	Tue, 29 Mar 2016 16:25:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9F78450328;
	Tue, 29 Mar 2016 16:25:43 -0400 (EDT)
In-Reply-To: <56FADCAB.1010201@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 29 Mar 2016 21:51:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 698E0B60-F5EC-11E5-BE91-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290187>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> If we had made the CRLF -> LF conversion, yes. But we don't do that.
> crlf_to_git() returns without touching the line endings.

That sounds quite broken.  How would a user ever fix broken data in
the index then?  I know the commit that often appears in these
discussions claims to give us "safer CRLF" handling, but I have a
suspicion that perhaps we should rethink if that claim is really
true.  Isn't it giving us more problems than it is worth?
