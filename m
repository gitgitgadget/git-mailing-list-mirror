From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf_readlink semantics update.
Date: Wed, 24 Dec 2008 23:23:58 -0800
Message-ID: <7viqp8afap.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
 <1230026749-25360-1-git-send-email-madcoder@debian.org>
 <20081223102127.GA21485@artemis.corp>
 <alpine.LFD.2.00.0812231009220.3535@localhost.localdomain>
 <20081224101146.GA10008@artemis.corp> <4952532F.5050704@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Dec 25 08:25:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFkb7-0002za-Lt
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 08:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbYLYHYL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Dec 2008 02:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbYLYHYL
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 02:24:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbYLYHYK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Dec 2008 02:24:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 584521B08D;
	Thu, 25 Dec 2008 02:24:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 136091B081; Thu,
 25 Dec 2008 02:24:01 -0500 (EST)
In-Reply-To: <4952532F.5050704@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Wed, 24 Dec 2008 16:20:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0545AC34-D255-11DD-8439-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103895>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Pierre Habouzit schrieb:
>> On Tue, Dec 23, 2008 at 06:16:01PM +0000, Linus Torvalds wrote:
>>>
>>> On Tue, 23 Dec 2008, Pierre Habouzit wrote:
>>>> when readlink fails, the strbuf shall not be destroyed. It's not h=
ow
>>>> read_file_or_gitlink works for example.
>>> I disagree.
>>>
>>> This patch just makes things worse. Just leave the "strbuf_release(=
)" in=20
>>> _one_ place.
> ...
> The "append or do nothing" rule is broken by strbuf_getline(), but I =
agree
> to your reasoning.  How about refining this rule a bit to "do your th=
ing
> and roll back changes if an error occurs"?  I think it's not worth to=
 undo
> allocation extensions, but making reverting first time allocations se=
ems
> like a good idea.  Something like this?

I think this is much better than Pierre's.  Pierre's "if it is called
strbuf_*, it should always append" is a good uniformity to have in an A=
PI,
but making the caller suffer for clean-up is going backwards.  The reas=
on
we use strbuf when we can is so that the callers do not have to worry
about memory allocation issues too much.
