From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/8] git_remote_helpers: fix input when running under
 Python 3
Date: Mon, 14 Jan 2013 09:47:21 +0000
Message-ID: <20130114094721.GQ4574@serenity.lan>
References: <cover.1358018078.git.john@keeping.me.uk>
 <a8c3aabfab64f49fa0cbb2d45bda79997a875ee8.1358018078.git.john@keeping.me.uk>
 <50F2296F.8030909@alum.mit.edu>
 <20130113161724.GK4574@serenity.lan>
 <50F38E12.6090207@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 14 10:48:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuge3-0000JH-K2
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 10:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721Ab3ANJre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 04:47:34 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:35318 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986Ab3ANJrd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 04:47:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 07D2222F0A;
	Mon, 14 Jan 2013 09:47:33 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NITuIQ5LGcd7; Mon, 14 Jan 2013 09:47:32 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 17A3322F62;
	Mon, 14 Jan 2013 09:47:31 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id CDC2A161E554;
	Mon, 14 Jan 2013 09:47:31 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T4PzSNQoeF2M; Mon, 14 Jan 2013 09:47:31 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 187DA161E276;
	Mon, 14 Jan 2013 09:47:23 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <50F38E12.6090207@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213480>

On Mon, Jan 14, 2013 at 05:48:18AM +0100, Michael Haggerty wrote:
> On 01/13/2013 05:17 PM, John Keeping wrote:
>> On Sun, Jan 13, 2013 at 04:26:39AM +0100, Michael Haggerty wrote:
>>> On 01/12/2013 08:23 PM, John Keeping wrote:
>>>> Although 2to3 will fix most issues in Python 2 code to make it run under
>>>> Python 3, it does not handle the new strict separation between byte
>>>> strings and unicode strings.  There is one instance in
>>>> git_remote_helpers where we are caught by this.
>>>>
>>>> Fix it by explicitly decoding the incoming byte string into a unicode
>>>> string.  In this instance, use the locale under which the application is
>>>> running.
>>>>
>>>> Signed-off-by: John Keeping <john@keeping.me.uk>
>>>> ---
>>>>  git_remote_helpers/git/importer.py | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
>>>> index e28cc8f..6814003 100644
>>>> --- a/git_remote_helpers/git/importer.py
>>>> +++ b/git_remote_helpers/git/importer.py
>>>> @@ -20,7 +20,7 @@ class GitImporter(object):
>>>>          """Returns a dictionary with refs.
>>>>          """
>>>>          args = ["git", "--git-dir=" + gitdir, "for-each-ref", "refs/heads"]
>>>> -        lines = check_output(args).strip().split('\n')
>>>> +        lines = check_output(args).decode().strip().split('\n')
>>>>          refs = {}
>>>>          for line in lines:
>>>>              value, name = line.split(' ')
>>>>
>>>
>>> Won't this change cause an exception if the branch names are not all
>>> valid strings in the current locale's encoding?  I don't see how this
>>> assumption is justified (e.g., see git-check-ref-format(1) for the rules
>>> governing reference names).
>> 
>> Yes it will.  The problem is that for Python 3 we need to decode the
>> byte string into a unicode string, which means we need to know what
>> encoding it is.
>> 
>> I don't think we can just say "git-for-each-ref will print refs in
>> UTF-8" since AFAIK git doesn't care what encoding the refs are in - I
>> suspect that's determined by the filesystem which in the end probably
>> maps to whatever bytes the shell fed git when the ref was created.
>> 
>> That's why I chose the current locale in this case.  I'm hoping someone
>> here will correct me if we can do better, but I don't see any way of
>> avoiding choosing some encoding here if we want to support Python 3
>> (which I think we will, even if we don't right now).
> 
> I'm not just trying to be a nuisance here;

You're not being - I think this is a difficult issue and I don't know
myself what the right answer is.

>                                            I'm struggling myself to
> understand how a program that cares about strings-vs-bytes (e.g., a
> Python3 script) should coexist with a program that doesn't (e.g., git
> [1]).  I think this will become a big issue if my Python version of the
> commit email script ever gets integrated and then made compatible with
> Python3.
> 
> You claim "for Python 3 we need to decode the byte string into a unicode
> string".  I understand that Python 3 strings are Unicode, but why/when
> is it necessary to decode data into a Unicode string as opposed to
> leaving it as a byte sequence?
> 
> In this particular case (from a cursory look over the code) it seems to
> me that (1) decoding to Unicode will sometimes fail for data that git
> considers valid and (2) there is no obvious reason that the data cannot
> be processed as byte sequences.

I've been thinking about this overnight and I think you're right that
treating them as byte strings in Python is most correct.  Having said
that, when I'm programming in Python I would find it quite surprising
that I had to treat ref strings specially - and as soon as I want to use
one in a string context (e.g. printing it as part of a message to the
user) I'm back to the same problem.

So I think we should try to solve the problem once rather than forcing
everyone who wants to use the library to solve it individually.  I just
wish it was obvious what we should do!


John
