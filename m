From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Mon, 07 Jan 2013 22:54:20 -0800
Message-ID: <7vip78go6b.fsf@alter.siamese.dyndns.org>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
 <20130108062811.GA3131@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 07:54:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsT59-0007U6-QO
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 07:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662Ab3AHGyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 01:54:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468Ab3AHGyX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 01:54:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 629EDAAB1;
	Tue,  8 Jan 2013 01:54:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rDrUaC+61vj7Fcv+29pMBRa0zeE=; b=bzemQp
	e6r6uIv8xUURb0xdSri/i8pFlH/nIErrRWL3oCJlOiUJ8Hi8lfMrvfAwylLPaqvm
	lSNoOaKZjV85qC0s9s44ejnOcuuiJcfaQCOShdZcJrnFSIRA3pG++itQ59VEYmSC
	GP05mgZ8QcGaohfBjALf9RlCo4YGVmNRBmtS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NHeHKO1zCdSKXAqA/eiItif1dQZwlrFH
	Dgb57VyrijVxnVDlMZfgD9jQ2IDewmKvJtqOMnzzIwcsedI9PriN6B0jwnas5Wjv
	TZSgqqMyujNF4IGklIrjZ2m4oPUEHhkcJpfGVFBv8PkRgwmYOfg6/Tx7+z3QO8WH
	dHUSwG/REFI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50CCBAAB0;
	Tue,  8 Jan 2013 01:54:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8A21AAAF; Tue,  8 Jan 2013
 01:54:21 -0500 (EST)
In-Reply-To: <20130108062811.GA3131@elie.Belkin> (Jonathan Nieder's message
 of "Mon, 7 Jan 2013 22:28:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B174110-5960-11E2-A616-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212936>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>
>> Currently it is not possible to have a shallow depth of
>> just 0, i.e. only one commit in that repository after cloning.
>> The minimum number of commits is 2, caused by depth=1.
>
> Sounds buggy.  Would anything break if we were to make --depth=1 mean
> "1 deep, including the tip commit"?

As long as we do not change the meaning of the "shallow" count going
over the wire (i.e. the number we receive from the user will be
fudged, so that user's "depth 1" that used to mean "the tip and one
behind it" is expressed as "depth 2" at the end-user level, and we
send over the wire the number that corresponded to the old "depth
1"), I do not think anything will break, and then --depth=0 may
magically start meaning "only the tip; its immediate parents will
not be transferred and recorded as the shallow boundary in the
receiving repository".

I do not mind carrying such a (technially) backward incompatible
change in jn/clone-2.0-depth-off-by-one branch, keep it cooking in
'next' for a while and push it out together with other "2.0" topics
in a future release ;-).
