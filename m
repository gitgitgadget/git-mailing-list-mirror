From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to ignore instead?
Date: Tue, 27 Oct 2015 12:04:48 -0700
Message-ID: <xmqqk2q8p1yn.fsf@gitster.mtv.corp.google.com>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
	<CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
	<xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
	<CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
	<CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
	<xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
	<20151026215016.GA17419@sigill.intra.peff.net>
	<CAM-tV--80xt_Ro_vQdgRmRxfy+2k2Ca13gVsjDHK+1pdsB_hqQ@mail.gmail.com>
	<20151027184151.GA12717@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Noam Postavsky <npostavs@users.sourceforge.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 27 20:05:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr9YL-0007Vd-Ru
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 20:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbbJ0TE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 15:04:57 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58689 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965079AbbJ0TE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 15:04:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BBF8F25A8B;
	Tue, 27 Oct 2015 15:04:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5hok+buzgHhrL9hlDgHc0jH03Hk=; b=QZIO1w
	kw4gNOZHvKDt08zEI0vJzyzRilALCRlpgnOkgyBzmUsmiJp5mWTZtVU0cgb2HmAl
	214Mhq4k7wqXnx3KftdjdTqPlhFkq3if34IA5Qu5GgviKy6nJ0DQvXAXtvLvD8Bg
	20jU9uR3SAjSslY7gaoNe+3NfxItC5NIDzbAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nGrYFkIDcSv3aIkvXdBFOgsw++TuE8vY
	7eRP8OrAmqxcBdsBq5frG1+URPKxkHfegrHJEbRelMwd+ii+Zu728V3e1v30nA9L
	Xuys+YqOwGXgjzkmYFOiqvyhFg9KibGp2p2OOKPr++D6w4/XS5LUL9dOnhd/8ATV
	A60GWN8lkxU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B41FE25A8A;
	Tue, 27 Oct 2015 15:04:49 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3B6E025A87;
	Tue, 27 Oct 2015 15:04:49 -0400 (EDT)
In-Reply-To: <20151027184151.GA12717@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 27 Oct 2015 14:41:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 987C5A90-7CDD-11E5-AF39-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280290>

Jeff King <peff@peff.net> writes:

> So I dunno. I think it would be reasonable to provide a config option to
> tell the cache-daemon to just ignore SIGHUP (or alternatively, a general
> option to try harder to dissociate itself from the caller). But I'm not
> sure I'd agree with making it the default. I'd want to know if anybody
> is actually _using_ the SIGHUP-exits-daemon feature. Clearly neither of
> us is, but I wouldn't be surprised if other setups are.

That also is a very good summary of what I think.  I agree it is a
good thing to have an option between "keep the die-on-HUP for those
who have a working set-up that rely on it" and "daemonize fully and
require the user to explicitly kill it with 'credential-cache
exit'".

Thanks.
