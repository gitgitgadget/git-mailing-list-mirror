From: stephen_leake@stephe-leake.org
Subject: Re: aborted 'git fetch' leaves workspace unusable
Date: Tue, 31 Dec 2013 01:19:25 -0700
Message-ID: <32eeea08963ec4438f97ff9ef6553a75@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 31 09:19:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxuY8-0007d1-I3
	for gcvg-git-2@plane.gmane.org; Tue, 31 Dec 2013 09:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060Ab3LaITa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Dec 2013 03:19:30 -0500
Received: from qproxy1-pub.mail.unifiedlayer.com ([173.254.64.10]:34411 "HELO
	qproxy1.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1751830Ab3LaIT3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Dec 2013 03:19:29 -0500
Received: (qmail 29657 invoked by uid 0); 31 Dec 2013 15:19:27 -0000
Received: from unknown (HELO host114.hostmonster.com) (74.220.207.114)
  by qproxy1.mail.unifiedlayer.com with SMTP; 31 Dec 2013 15:19:27 -0000
Received: from localhost ([127.0.0.1]:42815 helo=host114.hostmonster.com)
	by host114.hostmonster.com with esmtpa (Exim 4.80)
	(envelope-from <stephen_leake@stephe-leake.org>)
	id 1VxuXv-0004rE-F5
	for git@vger.kernel.org; Tue, 31 Dec 2013 01:19:27 -0700
X-Sender: stephen_leake@stephe-leake.org
User-Agent: Roundcube Webmail/0.8.5
X-Identified-User: {2442:host114.hostmonster.com:stephele:stephe-leake.org} {sentby:smtp auth 127.0.0.1 authed with stephen_leake@stephe-leake.org}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239835>

Junio C Hamano <gitster@pobox.com> writes:

> stephen_leake@stephe-leake.org writes:
> 
>> That left the workspace unusable:
>> 
>> - .git/FETCH_HEAD is empty
>> 
>>     that causes 'git rev-parse FETCH_HEAD' to fail with a confusing
>>     error message.
> 
> This is not limited to your Cygwin environment.  I can see that we
> leave an empty file there after a failed fetch with
> 
> 	$ git fetch ssh://no.such.place/
> 
> But I would not call it leaving "the workspace unusable".  If you
> ask "git rev-parse" "What is in FETCH_HEAD?", you would get "that is
> not even a revision", which is what you would get.

Yes, and I also discovered that FETCH_HEAD is not present after a 
clone.
So in general I need to be tolerant of an empty/missing FETCH_HEAD (I'm
actually working on an Emacs front end for git).

However, in this case, even running the fetch was a mistake; I would
have prefered that it leave FETCH_HEAD in its previous state. Is there
any way to reconstruct it? refs/heads/master was untouched, but I don't
know how to find the fetched head.

>> - 'git fetch' just hangs after outputting:
>> 
>> remote: Counting objects: 15, done.
>> remote: Compressing objects: 100% (8/8), done.
>> remote: Total 9 (delta 5), reused 0 (delta 0)
> 
> This looks more serious, but I suspect it is totally unrelated to
> your previous fetch failing and leaving FETCH_HEAD there.  Is this
> "'git fetch' hangs" reproduce in a clean clone _without_ first
> encountering the failure (due to the forgotton "ssh-add")?

no, the clone worked (so the network is up, the server is up), and a
subsequent 'git fetch' did not hang. Although there was also nothing to
fetch.

I'll have to wait until there is something to fetch, and see if I can
reproduce the bug. Or set up a git server and test branch - not high
enough on my priority list.

--
-- Stephe
