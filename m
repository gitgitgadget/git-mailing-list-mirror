From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/11] pack-objects: create pack v4 tables
Date: Mon, 09 Sep 2013 08:21:30 -0700
Message-ID: <xmqqioya58cl.fsf@gitster.dls.corp.google.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
	<1378652660-6731-1-git-send-email-pclouds@gmail.com>
	<1378652660-6731-9-git-send-email-pclouds@gmail.com>
	<CACsJy8DbMnr9Y8NyGTNd6r8hSg3zbgaLa1h-e1X7FFVHHahwpg@mail.gmail.com>
	<alpine.LFD.2.03.1309090900210.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 17:21:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ3Hb-0000zL-6k
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 17:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334Ab3IIPVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 11:21:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49895 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319Ab3IIPVg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 11:21:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D55123FCCF;
	Mon,  9 Sep 2013 15:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4RxWfktmEPQN7VMzpRIPxj9umJw=; b=M7uJ3W
	Jq/+ohhK/KgGVsP4OqI529e0b3kOZWwnDsGB38YysJbDhLgaA96pVVbpYwhFTKoR
	KY4Q7+K90j6/FS/mvi1HJSqLugmv0s12fEGCms98s6tA7vf+U0/j7jgjhhn3wmX4
	ZsjhDH/I/g1TENpeQobjMAZp3K1bP6VdVxCeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XTkk3Q76AW4RVbi8TLIOiaw5cB2cCPx+
	faDF36inWr89dv9SMGxujy5/RqmJXIjzH1ufkcDuRTzOgonkyjCzbL/dZoPYIBkJ
	WIz4FjrlrS6eVf/B3CjXMDF6shZZueHn+Oeh+Mrjfro47lV3kn5ZoiKrHk/WVs/J
	bX5DQqrCo9U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89BD53FCCA;
	Mon,  9 Sep 2013 15:21:33 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34A763FCC0;
	Mon,  9 Sep 2013 15:21:32 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1309090900210.20709@syhkavp.arg> (Nicolas
	Pitre's message of "Mon, 09 Sep 2013 09:07:08 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 81EAEC54-1963-11E3-81D1-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234347>

Nicolas Pitre <nico@fluxnic.net> writes:

> Is anyone still using --max-pack-size ?
>
> I'm wondering if producing multiple packs from pack-objects is really 
> useful these days.  If I remember correctly, this was created to allow 
> the archiving of large packs onto CDROMs or the like.

I thought this was more about using a packfile on smaller
(e.g. 32-bit) systems, but I may be mistaken.  2b84b5a8 (Introduce
the config variable pack.packSizeLimit, 2008-02-05) mentions
"filesystem constraints":

    Introduce the config variable pack.packSizeLimit
    
    "git pack-objects" has the option --max-pack-size to limit the
    file size of the packs to a certain amount of bytes.  On
    platforms where the pack file size is limited by filesystem
    constraints, it is easy to forget this option, and this option
    does not exist for "git gc" to begin with.
