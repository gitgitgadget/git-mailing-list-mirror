X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Subprojects tasks
Date: Sun, 17 Dec 2006 08:48:10 +0000
Message-ID: <200612170848.10092.alan@chandlerfamily.org.uk>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 09:17:38 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Martin Waitz <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1752 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 04:17:25 EST
User-Agent: KMail/1.9.5
In-Reply-To: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34681>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvs9B-0007YS-Qs for gcvg-git@gmane.org; Sun, 17 Dec
 2006 10:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752288AbWLQJR0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 04:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbWLQJR0
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 04:17:26 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:40613 "EHLO home.chandlerfamily.org.uk"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1752288AbWLQJRZ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 04:17:25 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1Gvrgq-0006BZ-4D; Sun, 17 Dec 2006 08:48:12 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Saturday 16 December 2006 18:32, Junio C Hamano wrote:
> Because I am primarily a plumber, I was thinking about the
> changes that need to be done at the plumbing level.  I only
> looked at the prototype when it was announced, and I do not know
> the progress you made since then.  Could you tell us the current
> status?
>
> I am assuming that the overall design is based on what Linus
> proposed long time ago with his "gitlink" object.  That is,
>
>  * the index and the tree object for the superproject has a
>    "link" object that tells there is a directory and the
>    corresponding commit object name from the subproject.  Unlike
>    my previous "bind commit" based prototype, index does not
>    have any blobs nor trees from the subproject.
>
>  * the subproject is on its own, and can exist unaware of the
>    existence of its superproject (there is no back-link at the
>    object layer).

I have been following the submodules (subprojects - is there any 
difference?) discussion from afar, getting lost quite frequently in 
what is actually being discussed and why.  I don't think the idea I 
express below has been mentioned, but apologies if it has.

One element I felt has been missing is a vigorous discussion of what 
submodules are for and what are their use cases.  The "submodule is on 
its own" issue seems to have crept into the discussion - but there was 
one use case that was discussed, where some actually help by the 
submodule could be useful.

The use case was when the supermodule wanted to make use of the header 
files of the submodule because it was using the submodule as a library.

This did make me wonder if the submodule should not export some form 
of "approved" set of content (or files - and I do think care is needed 
here as to which it is when we think about renames) which is both

a) a subset of the full tree that is stored at commit time, and
b) does itself have a commit history 

(I am clearly thinking that would be the standard "include" files, but 
not the actual source of the library - (but it might include the 
library it self as a prebuilt binary library?)

This does suggest it is a tree object stored in the repository - and 
that it is linked in time via a set of commit objects - I'll call them 
the "export commits".  I am not sure whether a new commit should be 
made everytime there is any change (via a normal commit) to this 
content, or (and I slightly favour this) there is a new commit made 
which is somewhat akin to a tag when the project wants to release a new 
version of its interface. 

Supermodules, which then made use of that library would, the do some 
form of shallow clone, shallow in the sense that it only pulled in the 
exported commit content and also (possibly) shallow in the sense that 
it does not need to go back in time to get old versions of the exported 
commit.


-- 
Alan Chandler
