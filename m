From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] strbuf: allow to use preallocated memory
Date: Tue, 31 May 2016 05:05:25 +0200
Message-ID: <574CFF75.3090805@alum.mit.edu>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160530103642.7213-3-william.duclot@ensimag.grenoble-inp.fr>
 <alpine.DEB.2.20.1605301326530.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr, matthieu.moy@grenoble-inp.fr
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 31 05:05:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7Zzr-00033C-Ep
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 05:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162723AbcEaDFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 23:05:31 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:58099 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161631AbcEaDFa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 23:05:30 -0400
X-AuditID: 1207440f-8bbff700000008e4-b7-574cff78e6aa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 4E.A7.02276.87FFC475; Mon, 30 May 2016 23:05:28 -0400 (EDT)
Received: from [192.168.69.130] (p508EABD0.dip0.t-ipconnect.de [80.142.171.208])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4V35Pm9021461
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2016 23:05:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <alpine.DEB.2.20.1605301326530.4449@virtualbox>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqFvx3yfcYOkJXYvJG+6xWtxtyrDo
	utLNZNG/vIvN4tLn9awWV7feZLTYPfkSowO7x9XmAI8PH+M8Jn45zurxeZNcAEsUt01SYklZ
	cGZ6nr5dAnfGvM2pBctEKv5N0GtgXC3QxcjJISFgIvGto4m5i5GLQ0hgK6PEkYNvmCCcC0wS
	F/4cZQKpEhZwlDh36zAbiC0iUCZx+uhssLiQwF5GibYLxiANzAL7GCUa7lwBK2IT0JVY1NMM
	VsQroC3xZckMRhCbRUBVYuW9X2A1ogIhEufXbWWFqBGUODnzCQuIzSlgI3H97gawemYBPYkd
	13+xQtjyEtvfzmGewMg/C0nLLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6KX
	m1mil5pSuokREtD8Oxi71sscYhTgYFTi4Y3o9gkXYk0sK67MPcQoycGkJMpr9RsoxJeUn1KZ
	kVicEV9UmpNafIhRgoNZSYR39T+gHG9KYmVValE+TEqag0VJnFd9ibqfkEB6YklqdmpqQWoR
	TFaGg0NJgvcmSKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KCLji4ExCZLiAdr7
	EWxvcUFiLlAUovUUoy7Hkf331jIJseTl56VKifOGgRQJgBRllObBrYClr1eM4kAfC/OWglTx
	AFMf3KRXQEuYgJbEZ4AtKUlESEk1MFZX32fMj7rzpML8uMd95zKbNvOUm7k7VG/ocf16Ma+2
	R+WW4tlkvQN8bjML9jvfiXi5pM88/rOPpqKhnPY9X4nD7Y2p0XkRijMfl/9qDWM1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295946>

On 05/30/2016 02:13 PM, Johannes Schindelin wrote:
> [...]
>> @@ -38,7 +67,11 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
>>  {
>>  	char *res;
>>  	strbuf_grow(sb, 0);
>> -	res = sb->buf;
>> +	if (sb->flags & STRBUF_OWNS_MEMORY)
>> +		res = sb->buf;
>> +	else
>> +		res = xmemdupz(sb->buf, sb->alloc - 1);
> 
> This looks like a usage to be avoided: if we plan to detach the buffer,
> anyway, there is no good reason to allocate it on the heap first. I would
> at least issue a warning here.

I think this last case should be changed to

    res = xmemdupz(sb->buf, sb->len);

Johannes, if this change is made then I think that there is a reasonable
use case for calling `strbuf_detach()` on a strbuf that wraps a
stack-allocated string, so I don't think that a warning is needed.

I think this change makes sense. After all, once a caller detaches a
string, it is probably not planning on growing/shrinking it anymore, so
any more space than that would probably be wasted. In fact, since the
caller has no way to ask how much extra space the detached string has
allocated, it is almost guaranteed that the space would be wasted.

Actually, that is not 100% certain. Theoretically, a caller might read
`sb->alloc` *before* calling `strbuf_detach()`, and assume that the
detached string has that allocated size. Or the caller might call
`strbuf_grow()` then assume that the detached string has at least that
much free space.

I sure hope that no callers actually do that. The docstring for
`strbuf_detach()` doesn't promise that it will work, and there is a
pretty stern warning [1] that should hopefully have dissuaded developers
from such a usage. But how could it be checked for sure?

* Audit the callers of strbuf_detach(). But given that there are nearly
200 callers, that would be a huge amount of work.

* On a test branch, change the existing implementation of
strbuf_detach() to return newly-allocated memory of size `sb->len + 1`
and free `sb->buf`, then run the test suite under valgrind. This would
flush out examples of this antipattern in the test suite.

It might seem like we don't have to worry about this, because existing
callers only deal with strbufs that wrap heap-allocated strings. But
such a caller might get a strbuf passed to it from a caller, and that
caller might someday be modified to use stack-allocated strings. So I
think that at least the valgrind test suggested above would be prudent.

Michael

[1]
https://github.com/git/git/blob/f3913c2d03abc660140678a9e14dac399f847647/strbuf.h#L20-L23
