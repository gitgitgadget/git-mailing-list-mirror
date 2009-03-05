From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More git bisect modes
Date: Thu, 05 Mar 2009 02:31:22 -0800
Message-ID: <7vvdqo1csl.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650903050149u4ca98444w28efceb9084efa68@mail.gmail.com>
 <20090305190542.6117@nanako3.lavabit.com>
 <43d8ce650903050217m2885692dkcef08ab2a5f60082@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 11:33:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfAst-0006zS-R4
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 11:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231AbZCEKbd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 05:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756218AbZCEKbc
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 05:31:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849AbZCEKbb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 05:31:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E6BD13B91;
	Thu,  5 Mar 2009 05:31:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 33A353B90; Thu, 
 5 Mar 2009 05:31:25 -0500 (EST)
In-Reply-To: <43d8ce650903050217m2885692dkcef08ab2a5f60082@mail.gmail.com>
 (John Tapsell's message of "Thu, 5 Mar 2009 10:17:22 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CA199A32-0970-11DE-B1AB-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112289>

John Tapsell <johnflux@gmail.com> writes:

> 2009/3/5 Nanako Shiraishi <nanako3@lavabit.com>:
>> Quoting John Tapsell <johnflux@gmail.com>:
>>
>>> * An exponential back-off. =C2=A0Typically I know that HEAD is brok=
en, and
>>> I don't know when it used to work.
>>
>> I thought 'git bisect' already worked with only bad commit(s) withou=
t any good commit for a long time?
>
> I believe this makes it start from the very first commit.  This
> probably much further back than most people would actually want to
> start from.
> (Also there seems to be a bug here, in that  'git bisect run' require=
s
> you to have both a good and a bad commit.  Also the man page doesn't
> document this)

Hmm, interesting.  I am sure we will soon hear from Christian, but
personally I never felt the need for "run" to work without any bad one,=
 as
the first few rounds would almost always end up to be a debugging sessi=
on
of the run script for me, as in:

	... oh, somebody broke this somewhere ...
	... write a validate script ...
	$ edit runme ; chmod +x runme
        $ ./runme
        ... yeah, it is broken and runme script detects breakage
        $ git checkout HEAD~200
        $ ./runme
        ... ok, it used to work here and runme exits Ok
        $ git bisect good
        $ git bisect bad @{-1}
        $ ./runme
        ... ok, runme script appears to be ok
        $ git bisect run ./runme
