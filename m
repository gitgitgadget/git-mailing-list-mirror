From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] dir: test_one_path: fix inconsistent behavior due to missing '/'
Date: Sun, 25 Aug 2013 22:38:29 -0700
Message-ID: <xmqqsixxj9ka.fsf@gitster.dls.corp.google.com>
References: <1377232155-7300-1-git-send-email-sunshine@sunshineco.com>
	<1377232155-7300-3-git-send-email-sunshine@sunshineco.com>
	<20130825060045.GP2882@elie.Belkin>
	<CAPig+cSY8oMeAaS2GRaPhwCkfO=eLa6-UPcJGRe98c0uUFbm8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 07:38:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDpVd-0001a1-Fr
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 07:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756530Ab3HZFid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 01:38:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36169 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755604Ab3HZFic (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 01:38:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A73538305;
	Mon, 26 Aug 2013 05:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bti/E+nUiwCl7S41l96fTdQ8atw=; b=CEGP+0
	/WUv/hP1MULW/cT/vQEptw2TLq1rBOWrqtp5nTJEefpPL0rxgB3a+ap9Y9TVuLHr
	OZyP5qyHK/zlOiQukzfGVi/2fZuxpKjny+v/R9xSIH75UEPlDdprj5BS1SYIhQpT
	I4/u5XPA+sC+JJ1l+SP8pKnYuFQVWXzW8ixPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G+UT6DnQR0nDmT5QdbQ29TjsgsG0qg6k
	CQzJb3uob8eMPEv+f5M3laKIuatkTNmmZHOmSoU1oiyp1uRLJxiZusuWZdp+sd7k
	ygLK1IPSDRy9u4zO6Lk/58KyqfZeWsV33pbA3iC6VhkL+95jhb56d5pKbmUwucLj
	vNB5s24JoFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D6EE38304;
	Mon, 26 Aug 2013 05:38:31 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1EEC38302;
	Mon, 26 Aug 2013 05:38:30 +0000 (UTC)
In-Reply-To: <CAPig+cSY8oMeAaS2GRaPhwCkfO=eLa6-UPcJGRe98c0uUFbm8Q@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 25 Aug 2013 04:05:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BDA59418-0E11-11E3-870F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232974>

Eric Sunshine <sunshine@sunshineco.com> writes:

> ... A
> follow-up series [2] fixes both directory_exists_in_index() and
> directory_exists_in_index_icase() to be more liberal in what they
> accept, relieving the caller of the burden. By the time that series
> was posted, however, Junio and Peff had decided that a fix at a more
> fundamental level would be better (a conclusion with which I agree,

Thanks for a summary; the last "would be better" is a qualified one,
though.

My understanding is that we agreed that it would be better *if* we
can fix it at a more fundamental level. I looked at the codepaths
involved just enough to make that off the cuff suggestion and no
deeper than that, and I suspect neither did Peff.

If any of us looked at the problem deep enough, we may realize that
it would affect too many things, and $gmane/232833/focus=232835
(your second round) may turn out to be a better solution.  I think
none of us know yet.
