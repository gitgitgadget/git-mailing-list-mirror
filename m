From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: refresh the index before running diff-files
Date: Mon, 01 Oct 2012 15:54:10 -0700
Message-ID: <7vsj9xajn1.fsf@alter.siamese.dyndns.org>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
 <20120928202330.GA5770@sigill.intra.peff.net>
 <20120928205054.GA5985@sigill.intra.peff.net>
 <20120930000527.GB4852@bloggs.ozlabs.ibm.com>
 <20120930014203.GA10664@sigill.intra.peff.net>
 <20120930203458.GA31365@elie.Belkin>
 <20121001223237.GC12496@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Scott Batchelor <scott.batchelor@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 00:54:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIosZ-0004z0-Bc
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 00:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab2JAWyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 18:54:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46863 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451Ab2JAWyN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 18:54:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 061659D09;
	Mon,  1 Oct 2012 18:54:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jXl8r4nQn6HeLFlEUnjoLffD4Bc=; b=ezUI2o
	b7g/I72Z4bVYvT+PJWZPQAayWJc52XstktMkKWCFBLn0XkEP4U61Ca2iqIc4G4jv
	bGvGJ5ncYebsfsg+j70WL/iv/naF6ySLTQCYZ0g0FFkFcuEC91cq2+sybjD9otXT
	bj4dSPRSx1+c1ppF2dhaAzlYIKaGQIfXVLgX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hjsklkw25SHyLteu9uYDUX4HEz+aMJtb
	9sAd7AzlfbPyzxzmO3HPWpaV+reHnf5nfQ54eCWQxuPK7HSTATJ4uJ1Hz2LQ7dqk
	U2FXLKq5BfBQBWwdg9N6oFeiGGiZJuJWHQHXn95mRfmZtjkH49hXk8Tn7apOA+MT
	VSJYOn9xK40=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7DC99D07;
	Mon,  1 Oct 2012 18:54:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54AEB9D06; Mon,  1 Oct 2012
 18:54:12 -0400 (EDT)
In-Reply-To: <20121001223237.GC12496@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 1 Oct 2012 18:32:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EADCCE46-0C1A-11E2-9AF2-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206777>

Jeff King <peff@peff.net> writes:

> I don't buy the "gitk should be read-only" argument from that thread. I
> think we decided a while back[1] that the stat cache is not really a
> user-visible modification; you're not updating the index in any
> meaningful way that impacts the user's workflow, but merely refreshing
> our cache of what is in the filesystem.

I think it is OK as long as a failure to "update-index --refresh"
does not lead to a user-visible error (I think we made sure that the
the opportunistic refresh "git diff" and "git status" does won't
report an error, when you are trying to help your co-worker by
visiting her repository and running these commands, only to peek).
