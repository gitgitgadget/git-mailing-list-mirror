From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: RFC: adding xdelta compression to git
Date: Mon, 2 May 2005 22:30:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505022215110.21733@bigblue.dev.mdolabs.com>
References: <200505030657.38309.alonz@nolaviz.org>
 <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alon Ziv <alonz@nolaviz.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 07:25:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSptm-0000BJ-LS
	for gcvg-git@gmane.org; Tue, 03 May 2005 07:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVECFam (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 01:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVECFam
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 01:30:42 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:9161 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261394AbVECFah
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 01:30:37 -0400
X-AuthUser: davidel@xmailserver.org
Received: from bigblue.dev.mdolabs.com
	by xmailserver.org with [XMail 1.21 ESMTP Server]
	id <S17B6BE> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 2 May 2005 22:32:51 -0700
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2 May 2005, Linus Torvalds wrote:

> Yes. EXCEPT for one thing. fsck. I'd _really_ like fsck to be able to know
> something about any xdelta objects, if only because if/when things go
> wrong, it's really nasty to suddenly see a million "blob" objects not work
> any more, with no indication of _why_ they don't work. The core reason may
> be that one original object (that just got used as a base for tons of
> other objects through deltas) is corrupt or missing. And then you want to
> show that _one_ object.

Linus, xdelta-based algorithms already stores informations regarding the 
object that originated the diff. Since they have no context (like 
text-based diffs) and are simply based on offset-driven copy/insert 
operations, this is a requirement. Libxdiff uses an adler32+size of the 
original object, but you can get as fancy as you like in your own 
implementation. Before a delta patching, the stored information are cross 
checked with the input base object, and the delta patch will fail in the 
eventuality of mismatch. So an fsck is simply a walk backward (or forward, 
depending on your metadata model) of the whole delta chain.



- Davide

