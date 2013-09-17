From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git checkout $commit -- somedir doesn't drop files
Date: Tue, 17 Sep 2013 15:14:39 -0700
Message-ID: <xmqqd2o7w0xc.fsf@gitster.dls.corp.google.com>
References: <20130917190659.GA15588@pengutronix.de>
	<xmqqeh8nxltc.fsf@gitster.dls.corp.google.com>
	<20130917201259.GB16860@sigill.intra.peff.net>
	<xmqq61tzxkgz.fsf@gitster.dls.corp.google.com>
	<20130917202917.GA20020@sigill.intra.peff.net>
	<xmqq1u4nxjv2.fsf@gitster.dls.corp.google.com>
	<20130917212106.GB20178@sigill.intra.peff.net>
	<xmqqk3ifw1km.fsf@gitster.dls.corp.google.com>
	<20130917220345.GA22914@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 18 00:14:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM3Xl-0006W5-AY
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 00:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371Ab3IQWOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 18:14:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab3IQWOm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 18:14:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7CF04322C;
	Tue, 17 Sep 2013 22:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bqK7QK7ZjvQUCx/NMQCN6weCy/c=; b=Km08CM
	2qIva3pKOig7dTSzxBweeftFFCY0AVQtjWrwbQcr95RkDqSae+KjXmF4LWDqEI3B
	xlEUDEgoZ7K3DwmZCWzjarZSdZc4BDLsxt4Fk6bNqXxyZG82V9FCd4VckXVriWNF
	VnjSX8ezVJro94mrtUauHw2oCSQOU+BMTF9wI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QnPswnTi1StEiSyjIsFws63wGfyLCt8i
	fNKov78apcFjJqbZf68Tptk+x9yXLO+MG+UZE79WLr09FcrT5ZM1/gmDXVNRyCts
	pmkSMXeFqJSHjt7VHHiol+b6ly0gkezXTkaJ28xR0Y12pajl3xJrG4Dl15JnIRhi
	MMypoDPcM64=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD3A64322B;
	Tue, 17 Sep 2013 22:14:41 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2DF1543228;
	Tue, 17 Sep 2013 22:14:41 +0000 (UTC)
In-Reply-To: <20130917220345.GA22914@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 17 Sep 2013 18:03:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8C88D2A0-1FE6-11E3-9B35-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234937>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 17, 2013 at 03:00:41PM -0700, Junio C Hamano wrote:
>
>> > So given that, is it fair to say that a one-way "go here" merge, limited
>> > by pathspec, is the closest equivalent?
>> 
>> Sorry, but it is unclear to me what you mean by one-way "go here"
>> merge.  Do you mean oneway_merge() in unpack-trees.c?
>
> Yes, that is what I meant.

Yeah, then I agree that "git checkout HEAD^ -- subdir" should be a
one-way "go HEAD^" merge limited only to the paths that match
subdir/.

If implemented in a straight-forward way, I suspect that we may end
up not removing subdir/b in Uwe's sample transcript. I am not sure
if that is a good thing or not, though.  If the index originally
tracked and then "going to" tree does not, I think removing it would
match "ignore local modifications" rule, as subdir/a that is tracked
in the index and also in "going to" tree does get overwritten to
match the state recorded in the tree.
