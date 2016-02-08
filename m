From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] On the --depth argument when fetching with submodules
Date: Mon, 08 Feb 2016 12:18:10 -0800
Message-ID: <xmqq8u2v7y7x.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kbt2-Vm94eTQY0PmJrNwqyTa36FJy5Q+2YBsxu6uYdTmQ@mail.gmail.com>
	<xmqqoabubt5e.fsf@gitster.mtv.corp.google.com>
	<FA2DA97F-D944-4784-8297-E2885F197AC0@gmail.com>
	<CAGZ79kYT8EWv6T=3bW_fH+_Q8p74p=JyzbErB+TOPO2VtVQHgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 21:18:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSsGT-0004pa-E9
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 21:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbcBHUSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 15:18:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58766 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752699AbcBHUSN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 15:18:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D94EA4200E;
	Mon,  8 Feb 2016 15:18:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RPq2/dBx4ORuaJIg7kcQ7tXSmi0=; b=GXiOO2
	H5Cqjm/zgpmTFNsXDxVmzqv2kMBMjKJsYWMM7mEokBowza2nACkE5LLKcyqLfRjS
	6yCnNeCztlR+VqkSoE1HefaztSCRfdACJPIiYfIqAnviDs8Y/MwPS7tPtvidVUWr
	uyZHK/26fGv5n3QGRwg0HxEiD56tiQqkypNiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xe8nX5R95lGhuIcab5hRBU9hjd7Sk5kC
	+xBg3oY/CbDYiEFI+PJwR5rX14rx1Mf3DLzJgqDofGBSoqKTHmd7QIBkhVhveMC+
	3JIsIj+kyMBHb9izAPQzUwjEBP4k2evO14PbODn7+FlYthPFKBxSFd/zcpJ/nfl4
	AgL9uRKhdC8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D0C204200D;
	Mon,  8 Feb 2016 15:18:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 543904200C;
	Mon,  8 Feb 2016 15:18:12 -0500 (EST)
In-Reply-To: <CAGZ79kYT8EWv6T=3bW_fH+_Q8p74p=JyzbErB+TOPO2VtVQHgQ@mail.gmail.com>
	(Stefan Beller's message of "Mon, 8 Feb 2016 10:27:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 13E68510-CEA1-11E5-B8D7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285800>

Stefan Beller <sbeller@google.com> writes:

> ... Instead of the branch, you can just pass
> a sha1 to git fetch and it sometimes works (if the server permits fetching
> arbitrary or hidden sha1s. Though Jonathan noted this check may be in
> the client only and the server trusts the client on not wanting arbitrary
> sha1s?)

allowtipsha1inwant and allowreachablesha1inwant are the server side
controls that are by default off.

> So for fetching I think we need to have a "--try-to-get-commit <sha1>"
> argument for fetch, which depending on the server capabilities and
> the history obtained otherwise may try again to fetch the exact sha1.

Hmph, "try"?  t5516 seems to show how to do this.

I however have to wonder how we disambiguate a 40-hex that is an
object name and a branch whose name happens to be 40-hex.
