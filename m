From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk does not reload tag messages
Date: Thu, 06 Sep 2012 22:18:47 -0700
Message-ID: <7vligmz9zc.fsf@alter.siamese.dyndns.org>
References: <MTAwMDAxMC50aW1tYw.1346955478@quikprotect>
 <CAJDDKr7AJ4Mrw8_wsB9WSqPT8sBca8FmBGHoq2Ay_ivLyUyAGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim McCormack <cortex@brainonfire.net>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 07:19:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9qyk-0004MG-B0
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 07:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab2IGFSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 01:18:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752521Ab2IGFSw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 01:18:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AED35972E;
	Fri,  7 Sep 2012 01:18:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bXcvcdbr34AJGHCuvfPxodtgrRc=; b=NAeY6q
	IIfe5RidDTRn0/LrXaYXDUY64TLrOeTe2AAoH+lRjg18zRNL9j1VRRbxm77/yrKy
	QObKpeS5CvmOW7QjSPpkvK0aznpK33q1FADxiNkhEUlioPDRvQVRfigwMQkSC7IX
	k9OK40E2Ip9Ar3R00ATpV9iqagwOoxQj8eQbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=li/+D9ML3Nr14zl5cf3md7NU7Vl4RcGp
	J0oph8djEt+SiMDRdJkQMF+Q1Q5OWEqKW9r9jr6RZWZ1qPcPj/nhDzt0iSy9GlJX
	Nny+DzKgDR8wAzbjpc2MH1ro5Sb9yey3UkK+YUkOGrYFkpwvFEddDHAzEI9KVPps
	4rM0SyT+EUw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C9EE972D;
	Fri,  7 Sep 2012 01:18:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC055972A; Fri,  7 Sep 2012
 01:18:48 -0400 (EDT)
In-Reply-To: <CAJDDKr7AJ4Mrw8_wsB9WSqPT8sBca8FmBGHoq2Ay_ivLyUyAGg@mail.gmail.com> (David
 Aguilar's message of "Thu, 6 Sep 2012 20:08:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 813B9E22-F8AB-11E1-A570-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204946>

David Aguilar <davvid@gmail.com> writes:

> Tags in git are meant to be immutable.  You can delete them, but
> you shouldn't.  That's not really how they are intended to be
> used.
>
> gitk avoids re-reading that information because the normal,
> typical use case is that the tag messages do not change.
>
> It would probably be a performance regression to "fix" this.

The reasoning behind your argument, i.e. the first paragraph, is
correct, and I agree that it certainly easier to implement a "read
once and assume it won't change."

But wouldn't it be OK for an explicit user action to cause reload of
the contents?

I just did this in my git.git tree:

    1. Start "gitk". The branch checked out is 'master', and it
       shows the v1.7.12 tag somewhere in the recent past.

    2. Click on v1.7.12; its contents and my signature is visible.

    3. "git tag -f -m 'Fake v1.7.12' v1.7.12 master". Don't worry, I
       have backups everywhere ;-)

    4. Of course, nothing changes in "gitk".  I wouldn't expect a
       magic.

    5. File -> Reread references.  This correctly moves the flag
       labelled as v1.7.12 in the history graph.

    6. After clicking on some random commit (to view its message)
       click v1.7.12 tag.  The original contents, not the "Fake" one
       is shown.

       Would it really be too much work to run "cat-file" at this
       point?  I think the earlier "File -> Reread references" is a
       strong enough clue the user gave "gitk" that something have
       changed, and I think it currently uses this clue to purge the
       cached mapping between refname and commit.

       Perhaps it can and should purge the cached tag object
       contents as well? The worst that can happen is when the user
       clicks a tag, we would need to read the tag object.

    7. File -> Reload.  Even this does not seem to purge the cached
       tag contents, even though it seems to redraw the whole
       history.

Note that if I swap the order of step #2 and step #3, I see the
"Fake" message; I think we are reading the contents of the tag on
demand.  I think the problem is just the contents, once read, seem
to be forever cached.

It may just be the matter of something like this.

 gitk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git i/gitk w/gitk
index 22270ce..6abe240 100755
--- i/gitk
+++ w/gitk
@@ -10599,7 +10599,7 @@ proc movedhead {hid head} {
 }
 
 proc changedrefs {} {
-    global cached_dheads cached_dtags cached_atags
+    global cached_dheads cached_dtags cached_atags tagcontents
     global arctags archeads arcnos arcout idheads idtags
 
     foreach id [concat [array names idheads] [array names idtags]] {
@@ -10611,6 +10611,7 @@ proc changedrefs {} {
 	    }
 	}
     }
+    catch {unset tagcontents}
     catch {unset cached_dtags}
     catch {unset cached_atags}
     catch {unset cached_dheads}
