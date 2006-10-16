From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 11:03:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610161100070.3962@g5.osdl.org>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org> <87mz7wp6ek.fsf@rho.meyering.net>
 <Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
 <87ejt8p5l9.fsf@rho.meyering.net> <Pine.LNX.4.64.0610161038200.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 20:04:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZWoX-00017I-Et
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 20:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422697AbWJPSDq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 14:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWJPSDq
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 14:03:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27562 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422697AbWJPSDp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 14:03:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9GI3gaX011946
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Oct 2006 11:03:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9GI3fLh022136;
	Mon, 16 Oct 2006 11:03:41 -0700
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <Pine.LNX.4.64.0610161038200.3962@g5.osdl.org>
X-Spam-Status: No, hits=-0.471 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28978>



On Mon, 16 Oct 2006, Linus Torvalds wrote:
> 
> So just making GR_PRIME be a bigger value on a 64-bit architecture would 
> not have fixed it.

Side note: in _practice_ I think it would have fixed it. The "not mixing 
in high bits" is not a real problem if the original hash-value has a good 
distribution of bits, which I think we do have. So it's unclear whether we 
even need any mixing in of bits at all, and it's possible that it would be 
fine to just have

	#define XDL_HASHLONG(v,b) ((unsigned long)(v) & ((1ul << (b))-1))

which is simpler than my patch.

I prefer the mixing in of high bits just because it can help if the 
original hash was bad (or had a tendency to have patterns in the low bits, 
which could be the case). But I'm not sure xdiff actually needs it in this 
case.

			Linus
