From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 08/10] revert: Introduce HEAD, TODO files to persist
 state, plan
Date: Thu, 2 Jun 2011 18:23:03 +0530
Message-ID: <BANLkTinc=9aW_y6s-Zb578QsMawnxFD55Q@mail.gmail.com>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com> <1306425233-504-9-git-send-email-artagnon@gmail.com>
 <20110526161102.GC24931@elie> <BANLkTino5gmfXjeOVih7+LHcMu1usPWAoQ@mail.gmail.com>
 <20110601193126.GC9730@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 14:53:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS7P0-0007dF-50
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 14:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933411Ab1FBMxZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2011 08:53:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58436 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758408Ab1FBMxY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 08:53:24 -0400
Received: by wya21 with SMTP id 21so574047wya.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 05:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=C7Vnd7AfAcJ7NhPqnlWA5nqjsTbrwHwQltMmjOSgoxg=;
        b=DmqS+Im2ybeA2ad07wu66kGWOXrTA2WbkwwUoMe6ODNxUM5MfeuLV6R7y+as5t6qyG
         YKjGvbvH+HjzGVrVuECyWUCUMeP8szeGvZrNSQR54OcOGEhJbOsQg/HzqD9uFzir5N3H
         pmBjBeiU8kj870CV+GqKOdc4tE5LTO9RQ/oxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=th7RM2ULuj+lOrJmUQZ3f0NIEmyX8qLOexiVd37rEal8iXGwOa7mw/fTrb3bUirN6T
         lAvbGqWOoJdAxAAcZSGLTow88ptevMpcpLPTTMFX2anq9H2jBFKPHXHZXMbTzhSjYiod
         zoYjv1smQ9DSdq4XxNHVITL7zQPg2Er1z+2OI=
Received: by 10.216.145.200 with SMTP id p50mr6084544wej.79.1307019203106;
 Thu, 02 Jun 2011 05:53:23 -0700 (PDT)
Received: by 10.216.51.68 with HTTP; Thu, 2 Jun 2011 05:53:03 -0700 (PDT)
In-Reply-To: <20110601193126.GC9730@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174945>

Hi Jonathan,

Jonathan Nieder writes:
> . If no, the "todo list" needs to be fully resolved to start out, and
> =C2=A0then the cherry-pick loop can just walk through it. =C2=A0In gi=
t API
> =C2=A0terms, that means first populating the commit_list (for example
> =C2=A0using a loop that gets revisions and inserts them at the end of=
 a
> =C2=A0commit_list, or by preparing the revision walk with "limited" f=
lag
> =C2=A0set), then walking through it with commit_list APIs.

Thanks. I picked this approach :)

On a slightly unrelated note, I just found out that the persist_todo
can't be called twice due to a lockfile API limitation* -- the
atexit(3) cleanup handler is supposed to have a linked list of
lockfiles to clean up. When one lockfile is used twice, it becomes a
circularly linked list, and the entire program hangs at exit time
since traversing a circularly linked list is never-ending. Couple of
comments:
1. By reading the lockfile implementation, I understand why this
happens -- can't it be implemented differently to remove this
limitation? If not, shouldn't this limitation be documented somewhere?
2. What can I do? It'll be inelegant to use the lockfile API while
persisting the first time, but not the second time -- is there any way
out of this?

Thanks again.

* You brought this up during one of our IRC conversations, but I
didn't understand it then. I do now.

-- Ram
