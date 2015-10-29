From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with gdb
Date: Thu, 29 Oct 2015 09:44:43 -0700
Message-ID: <xmqqpozxsjyc.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
	<CACsJy8C94gzE0CQH=f5=qeMj=DnE3bJ3EnLYbhxgrTG=W4r89A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 17:44:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrqJn-0005nj-Uf
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 17:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbbJ2Qor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 12:44:47 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965047AbbJ2Qoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 12:44:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24E9626BAC;
	Thu, 29 Oct 2015 12:44:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RyleeHU/+nNSAmuJRq9o/Yp+uXE=; b=dU6iJL
	z9LwS9WT0/WtmaHDlBQzXaWBrMf2GvcA67bO8XtUXrL7UjRPctVBc1hSWLZATaC9
	IES8pzRT4HOZ5V1+tOJOS5Het7h9BS2pPi+5GseEoq8jN99zaD6H2nzOZdw4dvJY
	hg/COzznfu7m/jq4hYek87WZCP87z8smOU16k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f7lSuGRA75CxlQjiaWFM7Ch12vBsTbP/
	J03stgRUDdQz6ODYaPQCZ32WOxaCtgHGekD1ruqPJjHAV+DR0He0lZK3wvOeW+Ob
	4kJzwtvVVDqkbQf4XphxHVjTRH1maQttb6UZlaNf/Ap1B9lw/ovtfViLGM0DCJkh
	7BqwOblW64k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1CF3626BAB;
	Thu, 29 Oct 2015 12:44:45 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 965AA26BAA;
	Thu, 29 Oct 2015 12:44:44 -0400 (EDT)
In-Reply-To: <CACsJy8C94gzE0CQH=f5=qeMj=DnE3bJ3EnLYbhxgrTG=W4r89A@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 27 Oct 2015 19:09:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5BC417A2-7E5C-11E5-BFF9-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280445>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Oct 26, 2015 at 2:15 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> When prefixing a Git call in the test suite with 'TEST_GDB_GIT=1 ', it
>> will now be run with GDB, allowing the developer to debug test failures
>> more conveniently.
>
> I'm very slowly catching up with git traffic. Apologies if it's
> already mentioned elsewhere since I have only read this mail thread.
>
> Is it more convenient to add a sh function "gdb" instead?

Changing a line of git invocation you want to debug from

	git frotz &&

to

	debug git frotz &&

indeed is slightly more pleasing to the eye than

	TEST_GDB_GIT=1 git frotz &&

I do not terribly care either way, as long as that feature is
availble ;-)

Either way these tweaks are temporary changes we make while figuring
out where things go wrong, and from that point of view, (1) the
longer and more cumbersome to type, the more cumbersome to use, but
(2) the longer and more visually identifiable, the easier to spot in
"diff" a tweak you forgot to revert before committing.

> We can even go further with supporting gdbserver function, to launch
> gdbserver, then I can debug from outside, works even without -v -i.

Yes, that may be useful, but you can do so whether you use your
shell function or TEST_GDB_GIT=1 that trigeers inside the "git"
wrapper in bin-wrappers, I would think.
