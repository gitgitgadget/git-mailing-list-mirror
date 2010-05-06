From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: Any way to get complete diff up to a tag?
Date: Thu, 6 May 2010 10:08:39 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005060955000.901@i5.linux-foundation.org>
References: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com> <20100506094212.GB9921@atjola.homenet> <A612847CFE53224C91B23E3A5B48BAC74482E50DE7@xmail3.se.axis.com> <4BE2BE2C.8050403@viscovery.net>
 <A612847CFE53224C91B23E3A5B48BAC74482E50F03@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu May 06 19:10:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA4ay-0006fK-VQ
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 19:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757613Ab0EFRKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 13:10:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44521 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756138Ab0EFRKj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 13:10:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o46HAQ0Y022122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 May 2010 10:10:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o46HAPwZ002981;
	Thu, 6 May 2010 10:10:25 -0700
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74482E50F03@xmail3.se.axis.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.446 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146484>



On Thu, 6 May 2010, Peter Kjellerstedt wrote:
> 
> Since the 4b825dc642cb6eb9a060e54bf8d69288fbee4904 SHA1 is somewhat
> cumbersome to remember, wouldn't it be an idea to give it some kind 
> of alias or mnemonic? E.g., something like @~ (or some other mix of 
> odd characters which do not clash with all the other similar 
> constructs already used for references).

Well, you don't strictly speaking have to "remember" it, you can always 
just re-generate it. The most straightforward way to do that is probably

	git hash-object -t tree --stdin < /dev/null

although I admit that maybe we could have some syntax for "git diff" that 
would do the "diff against empty tree" automatically. It does seem to be 
conceptually a reasonable thing to do.

For example, right now if you give "git diff" a single SHA1, it will work 
against the working tree. Except if you add "--cached", to say that you 
want the diff against the index. I don't think it would be in any way 
_wrong_ to make "--root" mean that you want it against an empty tree.

[ We already accept "--root", but it has no meaning for "git diff" with a 
  single SHA1. It matters for showing the root commit for 'git-diff-tree'.

  And means something totally different for git-format-patch ]

So we certainly _could_ do something like

	git diff --root <treeish>

and make it do what you want. That said, the "empty tree" thing works for 
all versions of git (well, some older versions of git need the actual 
object, but you could always use "-w" on that git-hash-object command 
line, and then it really should work for every git version).

			Linus
