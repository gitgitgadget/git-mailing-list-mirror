From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: another packed-refs race
Date: Mon, 06 May 2013 14:12:29 +0200
Message-ID: <51879E2D.8060506@alum.mit.edu>
References: <20130503083847.GA16542@sigill.intra.peff.net> <CALKQrgdHudF1fDLSXzaKfb2kne0B3rC5mM95CJGsLqL_2xemnA@mail.gmail.com> <20130503172853.GB21715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 06 14:12:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZKHV-0002pR-UH
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 14:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923Ab3EFMMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 08:12:33 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:48518 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751525Ab3EFMMc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 May 2013 08:12:32 -0400
X-AuditID: 12074412-b7f216d0000008d4-dc-51879e2f3c1f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 22.4A.02260.F2E97815; Mon,  6 May 2013 08:12:31 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r46CCTGD005545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 6 May 2013 08:12:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130503172853.GB21715@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqKs/rz3QYNl2E4uuK91MFvPu7mKy
	+NHSw+zA7HHp5Xc2j2e9exg9Pm+SC2CO4rZJSiwpC85Mz9O3S+DOWP9xAlPBVaGKCY92MzUw
	/uHrYuTkkBAwkWh41MMEYYtJXLi3nq2LkYtDSOAyo8TeGfOhnGNMEi/X3WQGqeIV0JZY9fo9
	I4jNIqAqcXh7BwuIzSagK7GopxlskqhAmMSq9cug6gUlTs58AlYjIiAr8f3wRrBeZgEriXt3
	e1lBbGGgOROXTWCHWLaOUWLS+j1Agzg4OAWsJbrul4GYzALqEuvnCUG0yktsfzuHeQKjwCwk
	G2YhVM1CUrWAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6ZXm5miV5qSukmRkjoCu1gXH9S
	7hCjAAejEg9v4ZO2QCHWxLLiytxDjJIcTEqivP5z2gOF+JLyUyozEosz4otKc1KLDzFKcDAr
	ifD67AUq501JrKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoEk5Xh4FCS4OWdCzRUsCg1
	PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSn8cXASAVJ8QDt/QJyE29xQWIuUBSi9RSj
	LsfKK09eMwqx5OXnpUqJ874BKRIAKcoozYNbAUtUrxjFgT4W5lUEuYQHmOTgJr0CWsIEtCSB
	D2xJSSJCSqqBUZRZuKXx6ZpCE4EXgU+ss3Wu20aJtu792VSccHzZs5zFTas1a+b4CfyaJN53
	r9xKLGrTjRInrtfBkxgNCh6KRLJEbJDqtnr7886T3rtruY0XNd6s7p1WsnnyRfPy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223443>

On 05/03/2013 07:28 PM, Jeff King wrote:
> On Fri, May 03, 2013 at 11:26:11AM +0200, Johan Herland wrote:
> 
>> You don't really need to be sure that packed-refs is up-to-date. You
>> only need to make sure that don't rely on lazily loading loose refs
>> _after_ you have loaded packed-refs.
> 
> True. As long as you load them both together, and always make sure you
> do loose first, you'd be fine. But I think there will be corner cases
> where you have loaded _part_ of the loose ref namespace. I think part of
> the point of Michael's ref work is that if you call "for_each_tag_ref",
> we would not waste time loading refs/remotes/ at all. If you then follow
> that with a call to "for_each_ref", you would want to re-use the cached
> work from traversing refs/tags/, and then traverse refs/remotes/. You
> know that your cached packed-refs is good with respect to refs/tags/,
> but you don't with respect to refs/remotes.

Correct.

[I wonder if there really are a lot of iterations over overlapping parts
of the reference namespace within a single git process...]

>> The following solution might work in both the resolve-a-single-ref and
>> enumerating-refs case:
>>
>> 0. Look for ref already cached in memory. If found, OK.
>>
>> 1. Look for loose ref. If found, OK.
>>
>> 2. If not found, load all loose refs and packed-refs from disk (in
>> that order), and store in memory for remainder of this process. Never
>> reload packed-refs from disk (unless you also reload all loose refs
>> first).
> 
> I think that would be correct (modulo that step 1 cannot happen for
> enumeration). But we would like to avoid loading all loose refs if we
> can. Especially on a cold cache, it can be quite slow, and you may not
> even care about those refs for the current operation (I do not recall
> the exact original motivation for the lazy loading, but it was something
> along those lines).

Lazy loading was first inspired by the observation that effectively
every git invocation was loading *all* loose references to do an
iteration over refs/replace/ (which I've never even used!)  This was
absolutely killing the performance of filter-branch, which creates a lot
of loose references and invokes git many times--even though the cache
was warm.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
