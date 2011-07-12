From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Tue, 12 Jul 2011 11:41:27 -0700
Message-ID: <7v62n78hpk.fsf@alter.siamese.dyndns.org>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <201107121241.40242.jnareb@gmail.com>
 <20110712175739.GA17031@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Eric Wong <normalperson@yhbt.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 12 20:41:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qghtn-0008NS-GW
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 20:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202Ab1GLSlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 14:41:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab1GLSla (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 14:41:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A550A4E9B;
	Tue, 12 Jul 2011 14:41:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ks06FNcfOQ9sYIgssLXd2a7X+PI=; b=VRkm61
	2F/stoazwyCDAMdaXCX5nnTdPdR+nOHpSiHyjYIBJRIKVvrhZYvgQYIYOafD4bns
	3/llrqwbwPDf8W6Gdi9bHRa9ND3hPW8PhV6zjnuaqADyUtZ8A7cbYWvn9qVmjk5r
	4GezJ3iwFK+TuzJs3Vwf1UCFSFGa3vNSkbeaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cz2beREBypO/Z2wUlqtXFnjhkKfmFXWj
	1jzsGtsx+URhYAJ90/hL2xs+K4t76tSuNoIfBXf2lbiSTJa0ztvRsPz17ndlSn1n
	4TcJWna1zFrdofZDzLUAh6La9ywfQapol+qBs5SGdz8//vQgUG3LToPkteJt0dJZ
	dB9uyVKbPZI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DD054E9A;
	Tue, 12 Jul 2011 14:41:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E934E4E99; Tue, 12 Jul 2011
 14:41:28 -0400 (EDT)
In-Reply-To: <20110712175739.GA17031@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 12 Jul 2011 13:57:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E25F9A8-ACB6-11E0-9F13-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176966>

Jeff King <peff@peff.net> writes:

>   2. The disk store uses a binary search over a sorted list of sha1s.
>      Generalizing this to "a sequence of bytes" would not be hard. But
>      we currently have the option of using the uniform distribution of
>      sha1 to make better guesses about our "middle" (see the comments in
>      sha1-lookup.c). That assumption does not hold over arbitrary bytes.

A side note. I notice that the "comment" you refer to appears twice in the
file, and the sha1_pos() function that comes earlier in the file does not
protect itself from overshoot penalty like the sha1_entry_pos() function
does.

Perhaps we should think about unifying them somehow.
