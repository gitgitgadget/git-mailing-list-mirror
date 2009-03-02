From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Refspec patterns with * in the middle
Date: Mon, 02 Mar 2009 14:39:24 -0800
Message-ID: <7v1vtfmtwj.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0903011820590.19665@iabervon.org>
 <7viqmrn98i.fsf@gitster.siamese.dyndns.org>
 <76718490903021001h16009570p7ac8c66a8e8e1f90@mail.gmail.com>
 <alpine.LNX.1.00.0903021323180.19665@iabervon.org>
 <76718490903021407u215fb769g656a8fdc20e622e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 23:41:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeGon-0006br-M5
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 23:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbZCBWje convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 17:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbZCBWjd
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 17:39:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57264 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbZCBWjd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 17:39:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C9D5E207C;
	Mon,  2 Mar 2009 17:39:30 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1D4262076; Mon, 
 2 Mar 2009 17:39:26 -0500 (EST)
In-Reply-To: <76718490903021407u215fb769g656a8fdc20e622e5@mail.gmail.com>
 (Jay Soffian's message of "Mon, 2 Mar 2009 17:07:31 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FEB1ED78-077A-11DE-8785-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111969>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Mon, Mar 2, 2009 at 1:25 PM, Daniel Barkalow <barkalow@iabervon.or=
g> wrote:
>>> But the following is not:
>>>
>>> =C2=A0- foo/bar*/baz
>>>
>>> IOW, '*' can only appear as a non-terminating symbol if it is bound=
ed
>>> by '/' on each side.
>>
>> You have my criterion right, but I want that to be valid, but only m=
atch
>> things like "foo/bar-something/baz", not "foo/bar-a/b/baz".
>
> Ah, that makes sense. Perhaps use "**" to mean matching across path
> components which is what rsync does:
>
>  o  a '*' matches any non-empty path component (it stops at slashes).
>  o  use '**' to match anything, including slashes.
>
> ?

I personally do not think that makes much sense (and I find ** ugly, to=
o).

We traditionally supported '*' only at the end, and it always has meant
"match through the end, including slashes".

Requiring 'match including slashes' to be spelled as '**' only when it =
is
not at the end is unnecessarily confusing.

Is there a valid use case when * wants to match across directory
boundaries when it is not at the end?  I offhand do not think of a sane
one.

So, it might make it easiest to understand if we say * usually does not
match slash, except when it is used at the end immediately after a slas=
h,
in which case it means "match through the end".
