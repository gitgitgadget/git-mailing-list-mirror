From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Using trees for metatagging
Date: Thu, 18 Feb 2010 13:57:18 -0500
Message-ID: <32541b131002181057gf27538ybf09dbf80b8dbce8@mail.gmail.com>
References: <20100218041240.GA4127@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 19:58:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiBa8-0005WO-W4
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 19:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938Ab0BRS5n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 13:57:43 -0500
Received: from mail-yx0-f180.google.com ([209.85.210.180]:51661 "EHLO
	mail-yx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757887Ab0BRS5k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Feb 2010 13:57:40 -0500
Received: by yxe10 with SMTP id 10so1389467yxe.33
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 10:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=XxxnEE281/sBG21vQUitnZUhMH77DT9tTyvjReQMiYw=;
        b=jRfmzP6uESRGfVi4G0WFTMl8oHAKHczu3hbr2yn3Z0iQtLh6N+fmgONI+cOucJmAow
         VVFsYIXsfR7ZjO8PX2Eg8gEPfYIDD5UGMJ4Jf7X4u75WqwmpHxrPYBZ2ifSqjyGRF5hF
         5T1s45FjMqrmzFJsjSfVN3N+jI3Rs7xudgCqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=mkVzWgxKURkpqgV2oopN8/SM+W7TewDIwpwuL87s7fpAW2WlPMaJUEf8B4h/RrPgXS
         L84qmBb3xiXOBoIvD84vjdEMyOO70Lo/pptlOw6bYtA6P5UvtlreRB/4oRO8rKRFMsj4
         d/pZUOSwjOh+7/GYx5joW9sHaJKnZzW9Tvddo=
Received: by 10.151.29.19 with SMTP id g19mr806024ybj.201.1266519458139; Thu, 
	18 Feb 2010 10:57:38 -0800 (PST)
In-Reply-To: <20100218041240.GA4127@lapse.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140361>

On Wed, Feb 17, 2010 at 11:12 PM, martin f krafft <madduck@madduck.net>=
 wrote:
> Git's object store uses trees mainly to represent a hierarchical
> filesystem. It occurs to me that you could layer additional
> hierarchies on top =97 specifically, you could use it to track subset=
s
> of files, i.e. "tagging".

I think what you *really* want here is to create a branch containing a
single file, which is the list of all the files you want to review.
Then when you're done reviewing a file, delete it from your list and
commit it.  Then just check out that file list branch in another clone
of your repository and manipulate it however you like.

Sorry to be boring.

> 1. Does Git provide plumbing for me to find out which trees
> =A0 reference a given blob? If not, I will have to iterate all trees
> =A0 and record which ones have a given message as a child.

No, you will have to iterate.  Also, if *other* people have trees
referencing that blob in *their* repositories, you won't know, so you
can never be sure that you've successfully found all objects in the
universe that refer to a particular blob.

> 2. Is there a way you can fathom by which unlinking a blob from the
> =A0 main hierarchy also causes it to be unlinked from this meta tree
> =A0 I am speaking of as well? Similarly, if a blob is rewritten, how
> =A0 could I make sure it replaces the old blob in all referencing
> =A0 trees?

blobs cannot replace other blobs.  And a tree that contains a
particular blob (indexed by sha1) will never *not* contain that blob,
because the identity of that tree is based on the identitity of the
blobs it contains.  You can create a new tree that doesn't contain the
blob, but the commit that contained the old tree will never contain
the new tree.  You would have to create a new commit that contains the
new tree, but any commits based on your old commit will never be based
on your new commit.  And so on.

That's just the way content-addressed storage works.  Sounds like you
need to read more about it.

Have fun,

Avery
