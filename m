From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range
 completion
Date: Sun, 13 Jul 2008 22:38:30 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807132210430.3305@woody.linux-foundation.org>
References: <20080713111847.29801.8969.stgit@localhost> <7vskudpiqq.fsf@gitster.siamese.dyndns.org> <20080713230724.GJ10151@machine.or.cz> <7vhcatnz80.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org>
 <20080714000021.GB13066@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 07:39:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIGmo-0008Lz-Ng
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 07:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbYGNFis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 01:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbYGNFis
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 01:38:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33660 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752189AbYGNFis (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jul 2008 01:38:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6E5cVUF012388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 Jul 2008 22:38:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6E5cUP1024596;
	Sun, 13 Jul 2008 22:38:30 -0700
In-Reply-To: <20080714000021.GB13066@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.399 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88377>



On Mon, 14 Jul 2008, Shawn O. Pearce wrote:
> > 
> > Does it fix this one too:
> > 
> > 	git show origin/pu:Makef<tab>
> > 
> > which totally screws up and becomes
> > 
> > 	git show Makefile
> > 
> > dropping the version specifier?
> 
> Its unrelated to the issue you described above.  But I just tested
> your Makefile completion case and it worked as expected, though
> I just found out it doesn't add a trailing space once there is a
> unique completion made.  I'll look at another patch to fix that.

What version of bash do you have?

It definitely doesn't work for me with 

	GNU bash, version 3.2.33(1)-release (x86_64-redhat-linux-gnu)

and quite frankly, I don't see how it _can_ work.

Something like this seems to be totally missing, and definitely required. 
How can you say that it works for you? I don't see how that is possible 
even in theory? Did you actually test it?

		Linus

---
 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 27332ed..0a87337 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -290,7 +290,7 @@ __git_complete_file ()
 			ls="$ref"
 			;;
 	    esac
-		COMPREPLY=($(compgen -P "$pfx" \
+		COMPREPLY=($(compgen -P "$ref:$pfx" \
 			-W "$(git --git-dir="$(__gitdir)" ls-tree "$ls" \
 				| sed '/^100... blob /s,^.*	,,
 				       /^040000 tree /{
