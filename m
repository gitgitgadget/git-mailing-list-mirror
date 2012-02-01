From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] Factor find_pack_entry()'s core out
Date: Wed, 01 Feb 2012 14:03:29 -0800
Message-ID: <7vaa522oum.fsf@alter.siamese.dyndns.org>
References: <1328010239-29669-1-git-send-email-pclouds@gmail.com>
 <1328104135-475-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.02.1202011056140.2759@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Feb 01 23:03:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsiHC-0000tl-1U
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 23:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757305Ab2BAWDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 17:03:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756983Ab2BAWDc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 17:03:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7E05633B;
	Wed,  1 Feb 2012 17:03:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5GldAdLmSUiByRsHbN4WhNQCsjE=; b=RwSOcz
	ylAqUiyvgOhXXZGYrxNv/cj2gTKnwqpKFSCsUrb7yTQA7Cl3dunov88vCU21Z3//
	uPNub3f31QE1r2Tb+5ioNsQuP6n27TURiHJT1q7VrPo98GtWQY7pj+eXKw/LAcQm
	yJMUzA71JT4ro/zI2bUNMKkXOGdVrSZIvLhXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oz05ScDh2aGevBNWUccVjn+EUSU/8Dvr
	6Am3N7brNoi8Dz2ghJNJbCOsPGbrkAHvr+C+s5zwMGabvHRWns9a4wWIDv1I/1Tu
	YeUxCAgffNr9DzTlcBknpYjAvIyzmcBmJdIxtiHkuQx2Jg6J75ZV9jAQsiNWYWQ3
	rXZW30RhHBA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFBBE633A;
	Wed,  1 Feb 2012 17:03:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4612C6339; Wed,  1 Feb 2012
 17:03:31 -0500 (EST)
In-Reply-To: <alpine.LFD.2.02.1202011056140.2759@xanadu.home> (Nicolas
 Pitre's message of "Wed, 01 Feb 2012 10:59:26 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93DF03E8-4D20-11E1-B83B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189544>

Nicolas Pitre <nico@fluxnic.net> writes:

>> +static int find_pack_entry_1(const unsigned char *sha1,
>> +			     struct packed_git *p, struct pack_entry *e)
>
> This looks all goot but the name.  Pretty please, try to find something 
> that is more descriptive than "1".  Suggestions: 
> "find_pack_entry_lookup", "find_pack_entry_inner", etc.

Perhaps "find_pack_entry_in_pack(sha1, e, p)"?
That would go well with the caller "find_pack_entry(sha1, e)".
