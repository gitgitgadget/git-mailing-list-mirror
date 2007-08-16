From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Fix an unitialized pointer in merge-recursive.c
Date: Thu, 16 Aug 2007 11:07:24 +0200
Message-ID: <86643f4zlf.fsf@lola.quinscape.zz>
References: <e5bfff550708160100t5aa93430x6cbe83e6e7a61d73@mail.gmail.com> <7vsl6jkila.fsf@gitster.siamese.dyndns.org> <e5bfff550708160111n66b5ea94k26cf2fecc06fd84c@mail.gmail.com> <7vodh7khuo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 11:07:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILbKM-0002Xd-RC
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 11:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756407AbXHPJHf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 05:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756294AbXHPJHf
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 05:07:35 -0400
Received: from main.gmane.org ([80.91.229.2]:40826 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756136AbXHPJHe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 05:07:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ILbKG-0005Sx-RS
	for git@vger.kernel.org; Thu, 16 Aug 2007 11:07:32 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 11:07:32 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 11:07:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:11/GsbnabtWff5dJUhzmRWZa7iI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55997>

Junio C Hamano <gitster@pobox.com> writes:

> "Marco Costalba" <mcostalba@gmail.com> writes:
>
>> On 8/16/07, Junio C Hamano <gitster@pobox.com> wrote:
>>> "Marco Costalba" <mcostalba@gmail.com> writes:
>>>
>>> > Indeed &mrtree is passed to merge_trees() that not always
>>> > seems to set the value, so on some paths mrtree could
>>> > return uninitialized.
>>> >
>>> > Spotted by a gcc 4.2.1 warning
>>>
>>> Are you sure that gcc is correctly seeing the codeflow?
>>>
>>> In merge(), mrtree is used only under index_only, and
>>> merge_trees() always sets *result under index_only.
>>
>> Ok ;-)
>>
>> Now two options:
>>
>> - discard the patch
>>
>> - change the title in 'silence a gcc bougus warning'
>
> Third option.  Change the assignment from "mrtree = NULL" to
> "mrtree = mtree".  It is a standard idiom to work around stupid
> gcc warnings.

I think it is more efficient to write mrtree = NULL: For the computer,
it makes a minuscule difference, and it can save programmers a bit of
confusion and worrying times.  Time that may be better spent improving
things elsewhere.

I don't think that we have a contest running for least redundancy in
code layout, have we?  Why then require the programmer to do a
complete call trace analysis before he can feel comfortable about the
code?  And what if callers change at some point of time?

-- 
David Kastrup
