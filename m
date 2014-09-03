From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-options: detect attempt to add a duplicate short option name
Date: Wed, 03 Sep 2014 15:16:29 -0700
Message-ID: <xmqqbnqwwds2.fsf@gitster.dls.corp.google.com>
References: <1409753034-9459-1-git-send-email-johan@herland.net>
	<1409753034-9459-3-git-send-email-johan@herland.net>
	<xmqq7g1kxzxi.fsf@gitster.dls.corp.google.com>
	<xmqq1trsxzgy.fsf_-_@gitster.dls.corp.google.com>
	<54077A3E.20703@web.de> <xmqqoauwwh2c.fsf@gitster.dls.corp.google.com>
	<54078C2C.5020503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 04 00:16:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPIr5-0004IF-Ri
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 00:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757196AbaICWQe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2014 18:16:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58838 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283AbaICWQc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Sep 2014 18:16:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA73637646;
	Wed,  3 Sep 2014 18:16:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8NitnI08dncy
	4Mi8a3iv1/Y3qKk=; b=sA3XgCTdcZhptRGRBapDqviWzRWMu6B61MRUAC7GyJed
	/vLacBbQsMZ4lgtmExbR/BZahie+NkKrKZ2fLSVobtU0xkZd1BPL5jIICAA2LRhk
	V1R/C92dmM3yawyPOeR2hz6l6jwP1b3lKye1UC9Ar9JBjcOqTTVChfpW2tbT9T8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Na3lEF
	dFhEwAPDz9ify3xMGyWa8zumKFcFx2bUnFX/4mLichjEq/wc2E1GoaIjoTsvjH1w
	EqLIFXMDPptyHSnx+q3Ls36ReH/vZ/tJQbYQxa/vfs2VtQNcpLwPpT8rrItuENb/
	K78Fi/492kaWr/jujNWDFuKdUpVbI4AwhZ0Ms=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D14EE37645;
	Wed,  3 Sep 2014 18:16:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 57C4837644;
	Wed,  3 Sep 2014 18:16:31 -0400 (EDT)
In-Reply-To: <54078C2C.5020503@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Wed, 03
	Sep 2014 23:46:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F53251EC-33B7-11E4-86B4-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256423>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> It bugged me enough that we didn't identify which short option
>> letter we were complaining about
>
> The old code did report the short option.  E.g. for t1502 it said:
>
> 	error: BUG: switch 'b' short name already used
>
> You can leave that to optbug(), no need for the strbuf.

Not quite, as an opt with long name is reported with the long name
only, which is not very nice when the problem we are reporting is
about its short variant.

> Space is allowed as a short option by the code; intentionally?

I didn't think of a strong reason to declare either way, so, yes it
was deliberate that I didn't tighten to disallow.
