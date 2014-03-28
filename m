From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 03/12] Move lower case functions into wrapper.c
Date: Fri, 28 Mar 2014 10:12:15 -0700
Message-ID: <xmqqzjkab634.fsf@gitster.dls.corp.google.com>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
	<20140326221531.11352.86408.chriscool@tuxfamily.org>
	<xmqqppl8ftjd.fsf@gitster.dls.corp.google.com>
	<20140327.084745.2069840957131666658.chriscool@tuxfamily.org>
	<xmqq4n2jfva5.fsf@gitster.dls.corp.google.com>
	<xmqqlhvvcmnj.fsf@gitster.dls.corp.google.com>
	<20140327223406.GA32434@sigill.intra.peff.net>
	<xmqqha6jcl96.fsf@gitster.dls.corp.google.com>
	<20140327225658.GC32434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	johan@herland.net, josh@joshtriplett.org, tr@thomasrast.ch,
	mhagger@alum.mit.edu, dan.carpenter@oracle.com, greg@kroah.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 18:12:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTaKN-000163-Es
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 18:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbaC1RMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 13:12:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714AbaC1RMS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 13:12:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20EB07773E;
	Fri, 28 Mar 2014 13:12:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pK5kO2o67QT3pVyaxJV2WnJkc3Q=; b=wP4nsU
	Ho7SKHPB29KpiStgVmuGOcyFs2weBTmqbvnQOrhtmS3CjCn30i7c864q5Lj1FmOq
	GKM4f72OYQJuLY67p673MJJWswVHZkchBUmjt9bTMZmDBs1QyPE3nFUkwdRKPTrE
	siHvDQvlAUBG17DdAxYeWL4UBedsxmwLYojO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ayXuAWAVloFR/3ncB562vLz5NX9B1nvL
	Gj6056MGHys5yGSMvxMfai0IqKADisVuIbiKt7DO0XQ3x0rysi6QxUfwlxfHqENi
	nWOc0+dIGAIOCoMhd7BspDEZW8Zw29me93rDqH9tdU+jTWZTJ3x/RpbqgmBEjqEE
	Rax0hBaExDI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 109237773D;
	Fri, 28 Mar 2014 13:12:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5688D7773A;
	Fri, 28 Mar 2014 13:12:17 -0400 (EDT)
In-Reply-To: <20140327225658.GC32434@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 27 Mar 2014 18:56:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1D51F590-B69C-11E3-9502-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245400>

Jeff King <peff@peff.net> writes:

> But I also do not overly care. Literally zero people have complained
> that "[log]date = RFC822" is not accepted, so it is probably not a big
> deal either way.

That is most likely because we do not advertise these enum values
spelled in random cases in our documentation and people do not even
attempt to upcase the examples they see.  So you are right to say
that it does not hurt anybody in practice if the code does not
strcasecmp() input from them.  We do not know if using strcasecmp()
there and allowing them to feed the enums spelled in random cases
would invite confusions in the longer run, so let's not risk it.
There is no upside in using strcasecmp() here.

By the way, that is "rfc2822"---do we want "rfc822" as its synonym
as well as "rfc", I wonder ;-)
