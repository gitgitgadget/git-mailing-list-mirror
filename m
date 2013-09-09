From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/16] index-pack: use nr_objects_final as sha1_table size
Date: Mon, 09 Sep 2013 12:30:23 -0700
Message-ID: <xmqqob813i9c.fsf@gitster.dls.corp.google.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
	<1378735087-4813-1-git-send-email-pclouds@gmail.com>
	<1378735087-4813-16-git-send-email-pclouds@gmail.com>
	<alpine.LFD.2.03.1309091047510.20709@syhkavp.arg>
	<xmqq61u94zew.fsf@gitster.dls.corp.google.com>
	<alpine.LFD.2.03.1309091441540.20709@syhkavp.arg>
	<xmqqwqmp3jtj.fsf@gitster.dls.corp.google.com>
	<alpine.LFD.2.03.1309091507290.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 21:30:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ7AT-0004TK-GU
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 21:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755328Ab3IITae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 15:30:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54053 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754466Ab3IITad (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 15:30:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 539DB3E4BD;
	Mon,  9 Sep 2013 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+pBUVZO76+JLLIB9FHXAN6AXOsE=; b=TQ70ki
	/x9aGjPPfMv/O6HGEwxNvnXA59Gcwia6FBzk5o+2JOzDoRqIWgrw1c9dqbNy4htG
	Eh9b7qxOFLCTOwtrR966315B0TVXGzargyV18z1wnRNaAbbO8Z6CjhPL3yyY8KsL
	zVmd5Ik7hSdYO46ZVr+ChgBgjZ1ketap00KVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=buJmvhnCrZnCMBRW1j+/tLjjOlMJowC1
	ad5QBCBQbnnlEQGgwSyVbn0l2wRTjn1XIuP5wu56s7fKyf7wqJgFBcQ5jzYrNxgV
	ybrqL8/MtmF5lm0U8AZEKaF4wg8a32mLy3cg7f+32zTn2ow+lGJzsn8ySWIu/5FB
	XdXIutNmdWM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21DAF3E4BB;
	Mon,  9 Sep 2013 19:30:30 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 977093E4B4;
	Mon,  9 Sep 2013 19:30:27 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1309091507290.20709@syhkavp.arg> (Nicolas
	Pitre's message of "Mon, 09 Sep 2013 15:11:38 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 480C016C-1986-11E3-AE39-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234363>

Nicolas Pitre <nico@fluxnic.net> writes:

> Do we know the actual number of objects to send during the capability 
> negociation?

No, and that is not what I meant.  We know upfront after capability
negotiation (by seeing a request to give them a thin-pack) that we
will send, in addition to the usual packfile, the prefix that
carries that information and that is the important part.  That lets
the receiver decide whether to _expect_ to see the prefix or no
prefix.  Without such, there needs some clue in the prefix part
itself if there are prefixes that carry information computed after
capability negotiation finished (i.e. after "object enumeration").

Sorry if I was unclear.
