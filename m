From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #05; Thu, 12)
Date: Mon, 16 Apr 2012 23:32:18 +0200
Message-ID: <20120416233218.54daa2f6@gmail.com>
References: <20120416082641.5d239ef6@mkiedrowicz.ivo.pl>
	<CA+55aFwkf2bOLmUCU+_pSg0OzGyfQ1x-Cy_CiczpJN3zsThNWg@mail.gmail.com>
	<7v7gxfwpc8.fsf@alter.siamese.dyndns.org>
	<CA+55aFwPrjtAttsH75tTGHO=14g_2GbyOtUt4eY9LPHbtcXvcQ@mail.gmail.com>
	<CA+55aFyAsF4jNvNMKC6divzAfyVmgrHvxJtnX0fjkpp_bLHkPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 23:32:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJtXE-00065K-Ol
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 23:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113Ab2DPVc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 17:32:27 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:63148 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab2DPVc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 17:32:26 -0400
Received: by wejx9 with SMTP id x9so3633685wej.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 14:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=da7/+swOqVB0WpBORcLcJWe7X41QX4QotdCyYmAzyPw=;
        b=RiYyYJzW9bEtosAPJ1JhiEEu2622yCLBup7UProcyiTSgFW+1W0xHEWtqeBMwdZwwX
         HBhb3jzfo21wW6EQ5i6rtngNaI+/50yp4vpe9yRw3ZQeg22dicIa6Ta8fApxKSCQWeQJ
         HhWu/cBlawmu0Sa+N1kVbnAItlteQvolmXxi8Bvnd/5/YCE1G6YHkClK1oX5j1E+Y0FI
         Vm2mjRVsgMBUQ6U4wfUcbvM7s6frGOruQd9VpOkI0jA5m7OOxyATfu+Yfe998UIcdReu
         VZUUmRKTGE99WlmcTh0Nk6ueZsySs6zpw3e1prf7YIuFIU+98KR8JDvikv3ACuRZ5ByU
         xYQg==
Received: by 10.216.133.234 with SMTP id q84mr7795621wei.102.1334611945440;
        Mon, 16 Apr 2012 14:32:25 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id u9sm22309997wix.0.2012.04.16.14.32.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 14:32:24 -0700 (PDT)
In-Reply-To: <CA+55aFyAsF4jNvNMKC6divzAfyVmgrHvxJtnX0fjkpp_bLHkPQ@mail.gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195697>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 16, 2012 at 11:02 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Oddly, running that test in verbose mode seems to imply that it's the
> > *rebase* that succeeds, not the merges in that test. Maybe I'm reading
> > the test results wrong, I didn't really try to understand the test
> > itself ;(
> 
> Yes, it's the rebase that succeeds. "git log -g" in the trash
> directory shows that we ended up successfully rebasing J2:
> 
>   commit 5fc34ec1a8ed96664198fefc74121cd052b10861
>   Reflog: HEAD@{1} (C O Mitter <committer@example.com>)
>   Reflog message: rebase -i (pick): Merge made by the 'recursive' strategy.
>   Author: A U Thor <author@example.com>
>   Date:   Thu Apr 7 15:28:13 2005 -0700
> 
>       J2
> 
> while a successful test will fail that.
> 
> However, I don't actually see what changed.
> 
> Oh - one thing to note is that the *patch* of that successful rebase
> is empty. That may be the big clue: we successfully finish the merge
> without noticing that it didn't change any state, and we should have
> failed it as an empty commit. Hmm?
> 
>                    Linus

So, the difference is that `git merge --no-ff HEAD^` used to work, now
it doesn't because we reduce_heads() only if we allow fast-forward (and
even though there is just one remote we merge with, parents contains
two commits). So what about that trivial patch instead (discarding our
previous patches)?
---
diff --git a/builtin/merge.c b/builtin/merge.c
index 08e01e8..27e0026 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1346,6 +1346,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			allow_trivial = 0;
 	}
 
+	remoteheads = reduce_heads(remoteheads);
+
 	if (!remoteheads->next)
 		common = get_merge_bases(head_commit, remoteheads->item, 1);
 	else {
