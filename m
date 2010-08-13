From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: BUG: git log: fatal: internal error in diff-resolve-rename-copy
Date: Fri, 13 Aug 2010 10:53:25 -0700
Message-ID: <AANLkTinSUy9pDtsJizmQTTOsMOVEQ=7+U5Ri4=-RZmB-@mail.gmail.com>
References: <AANLkTikPhWgeeLBV3dbLZ5UM3UDmkOmpqrmwqPmGfn7Z@mail.gmail.com> <7vhbiyl8ji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 19:54:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjySs-0002cP-0o
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 19:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761997Ab0HMRya convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 13:54:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42085 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761966Ab0HMRyS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 13:54:18 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o7DHrjRh006779
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 13 Aug 2010 10:53:45 -0700
Received: by iwn7 with SMTP id 7so85844iwn.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 10:53:45 -0700 (PDT)
Received: by 10.231.149.12 with SMTP id r12mr1775847ibv.185.1281722025401;
 Fri, 13 Aug 2010 10:53:45 -0700 (PDT)
Received: by 10.231.172.67 with HTTP; Fri, 13 Aug 2010 10:53:25 -0700 (PDT)
In-Reply-To: <7vhbiyl8ji.fsf@alter.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.917 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153483>

On Fri, Aug 13, 2010 at 10:36 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> Another potential "funny" is this (unrelated to the reported issue).
>
> The "--follow" logic is called from diff_tree_sha1() function, but th=
e
> input trees to diff_tree_sha1() are not necessarily the top-level tre=
es
> (compare_tree_entry() calls it while it recursively descends into
> subtrees). =A0For example, with the example Constantine gave us, the =
first
> "try-to-follow-renames" call happens with the "base" set to "platform=
/"
> but the rename source is actually "lang-api/src/com/intellij/..."
> hierarchy, so it is a wasted call. =A0I think we only want to run the=
 rename
> following at the very top level, i.e. like the attached patch.
>
> Linus, what do you think? =A0Am I missing something obvious?

I think you're right. You're certainly not missing anythng _obvious_.
Iirc the only reason I put that 'follow' hack in diff_tree_sha1() was
because that way I didn't need to worry about all the callers, but I
didn't even think about the whole recursion issue.

So ack on that.

                Linus
