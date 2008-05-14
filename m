From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] builtin-apply: check for empty files when detecting
 creation patch
Date: Tue, 13 May 2008 18:14:32 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805131811540.3019@woody.linux-foundation.org>
References: <1210257579-30975-1-git-send-email-imre.deak@gmail.com> <7vlk2h8t4d.fsf@gitster.siamese.dyndns.org> <500f3d130805131316m59898392l46e0dbf7cb352981@mail.gmail.com> <7vprrpswof.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0805131514300.3019@woody.linux-foundation.org>
 <7vlk2dsujm.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0805131552410.3019@woody.linux-foundation.org> <7vve1hrbct.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 03:15:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw5am-00057k-4s
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 03:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758046AbYENBOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 21:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757960AbYENBOu
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 21:14:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54477 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757871AbYENBOt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2008 21:14:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4E1EYKA000744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 13 May 2008 18:14:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4E1EWq8009672;
	Tue, 13 May 2008 18:14:33 -0700
In-Reply-To: <7vve1hrbct.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.419 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82059>



On Tue, 13 May 2008, Junio C Hamano wrote:
> 
> With the change to remove the whole block, all tests still passes, and a
> limited test with this:
> 
>         --- empty	2008-05-13 16:56:57.000000000 -0700
>         +++ empty.1	2008-05-13 16:57:07.000000000 -0700
>         @@ -0,0 +1 @@
>         +foo
> 
> to update an originally empty file "empty" also seems to work.
> 
> However, with this change, it no longer allows you to accept such a patch
> and treat it as a creation of "empty".  Instead we barf with "error:
> empty: No such file or directory", if you do not have an empty "empty"
> file in the work tree when you run "git apply" on the above patch.

Ok, that's a bug. It should *not* require that existing empty file, since 
"is_new" is -1. That's what -1 means: we don't know if it is new or not.

So I think your patch is correct, but we need to fix the thing that barfs 
to not barf if we don't know the status of "is_new"

		Linus
