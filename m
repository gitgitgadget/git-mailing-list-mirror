From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] pretty: support "mboxrd" output format
Date: Fri, 03 Jun 2016 16:42:37 -0700
Message-ID: <xmqqzir1zvo2.fsf@gitster.mtv.corp.google.com>
References: <20160530232142.21098-1-e@80x24.org>
	<20160530232142.21098-2-e@80x24.org>
	<CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
	<20160531074506.GA8911@dcvr.yhbt.net>
	<CAPig+cQrQfxWrGhpvtb-GKYfK0tMLsx9JJ+eWRRx00F8mNXrLg@mail.gmail.com>
	<20160531182932.GA27021@dcvr.yhbt.net>
	<20160602075125.GA19551@dcvr.yhbt.net>
	<CAPig+cTLVXJBn00aco0vC9oFvZuchTgtNXtGGjpLPx1LwRZz4Q@mail.gmail.com>
	<xmqqlh2loq6p.fsf@gitster.mtv.corp.google.com>
	<CAPig+cQXA3mgYC3rCTx2h93rB6djdKvYJ+oCXUP24-xk2PqW=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <e@80x24.org>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 01:42:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8yjl-0007Qq-2R
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 01:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbcFCXmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 19:42:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53967 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750811AbcFCXmk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 19:42:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8907A1FC79;
	Fri,  3 Jun 2016 19:42:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o67Hw/4CHm15/7pZ5aL5XEhKPO4=; b=Lw4WlK
	BUWL7D1keV8PlyHGX6rkA3ajXBGIik5dIhgqCy82Khqef1+4BmyApam1Qm96bsjK
	AJ/Otq1ibACVuh82XnNJtaAtQoOQ4MQaVZxSp9hlPGUPtDwJnltaGF3h9bga69bp
	xraFEgp0VHDaxnE+nNuBiVNiNDkcdSATbE3MI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D9TLRRkW/+fAqPwhSHyfiBFBCZd3CsYt
	4b7++49hRsQ2pUcjZNDNXYNZvf7g40PgCgZjWW1QE2TBRywBWlu1DCUF8fO4AZBm
	SREoT7W92x2rtUGfOmADeiUUBiQpeYLHH/DlDrjygDNARY0dcZC0Oy6Wc/r0loTU
	zTHFVzJnHYU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 81F8F1FC78;
	Fri,  3 Jun 2016 19:42:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07ED71FC77;
	Fri,  3 Jun 2016 19:42:38 -0400 (EDT)
In-Reply-To: <CAPig+cQXA3mgYC3rCTx2h93rB6djdKvYJ+oCXUP24-xk2PqW=Q@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 3 Jun 2016 18:59:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DB54D4C8-29E4-11E6-9FA3-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296430>

Eric Sunshine <sunshine@sunshineco.com> writes:

>>         static int is_mboxrd_from(const char *line) {
>>                 return starts_with(line + strspn(line, ">"), "From ");
>>         }
>>
>> is sufficiently high-level that no longer is scary, hopefully?
>
> That's nice and concise but unfortunately not useful for this case
> where we must respect the logical end-of-line (within the larger
> buffer), represented by line+linelen.

Hmph, none of ">", "F", "r", "o", "m", or " " is "\n"; would eol
still be an issue?
