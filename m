From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] build: do not automatically reconfigure unless
 configure.ac changed
Date: Wed, 02 Jan 2013 12:25:09 -0800
Message-ID: <7vbod72uze.fsf@alter.siamese.dyndns.org>
References: <CANiSa6jt7_ixi7L6U9sfpV2mvT_7zgYV+m+sLiXjkDsFehAuwA@mail.gmail.com>
 <20130102072141.GB18974@elie.Belkin>
 <CANiSa6iMea95ELqS3-w01bL=LTgE9Cx6+8sXK=s-pPPFwjGCCA@mail.gmail.com>
 <20130102082544.GD18974@elie.Belkin>
 <20130102083837.GA9328@sigill.intra.peff.net>
 <20130102084807.GB22919@elie.Belkin> <50E4409B.4070203@gmail.com>
 <7va9sr4jgu.fsf@alter.siamese.dyndns.org> <50E48BF6.2020900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	git <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 21:25:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqUsW-0003vN-JK
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 21:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab3ABUZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 15:25:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51597 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631Ab3ABUZM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 15:25:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7EBFB0F2;
	Wed,  2 Jan 2013 15:25:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vmZmeRHOni4vr0mn72cQolsp0fA=; b=kFEMWE
	0X0ZrRXnMEiD13+j9Sl8ahEvIZZzuLG8NGuX6Zq/cxkuZapCFANx3JkJlEXDszqt
	Efe1TROKa83f4y86a4Kka9LQZz1YUScpKu3fRIF7EZbeyNFW8bWrYEajipA7HfXu
	K/e1XROTSIjEv68uwJaRKY6kgpKhUwJdUWIR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eFf4FgRran7goX65HTyqNakBf7YyxbhT
	A67kNfOYp+D4BnVBXBGtCAJ7RrkzB0BcSa19F0AVmp9pBYQ/tl5+44tvCsBjYBVE
	Jq3s6wa6yUUAXb5z4VEHKmNdoRRPuk2IIByhFuF84QdverjryVY5hFx1aOzWt+dR
	1GLG7CCfNxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7873B0F1;
	Wed,  2 Jan 2013 15:25:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 418C5B0F0; Wed,  2 Jan 2013
 15:25:11 -0500 (EST)
In-Reply-To: <50E48BF6.2020900@gmail.com> (Stefano Lattarini's message of
 "Wed, 02 Jan 2013 20:35:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81FB2050-551A-11E2-9D01-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212537>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

>>  ifdef AUTOCONFIGURED
>> -config.status: configure
>> -	$(QUIET_GEN)if test -f config.status; then \
>> +# We avoid depending on 'configure' here, because it gets rebuilt
>> +# every time GIT-VERSION-FILE is modified, only to update the embedded
>> +# version number string, which config.status does not care about.
>>
> Alas, config.status *do* care about it, in that the '@PACKAGE_VERSION@',
> '@PACKAGE_STRING@' and '@DEFS@' substitutions are affected by what is
> hard-coded in configure as the version number [1].  But if we do not
> use those substitutions in any of our files (and I believe we don't),
> then *we* can happily not care about the configure embedded version
> number string, and thus avoid the extra configure runs.  Phew.
>
>  [1] Yes, this is a mess.  We know.  Sorry!

Heh.  Should we warn against the use of these symbols somewhere in
configure.ac, perhaps, then?
