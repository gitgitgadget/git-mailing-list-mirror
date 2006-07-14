From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Error writing loose object on Cygwin
Date: Thu, 13 Jul 2006 22:26:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607132217360.5623@g5.osdl.org>
References: <20060712035746.GA7863@spearce.org> <7vr70r1ms5.fsf@assigned-by-dhcp.cox.net>
 <20060713055127.GA15960@trixie.casa.cgf.cx> <20060714033435.GA1508@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christopher Faylor <me@cgf.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 07:26:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1GCK-0005WP-F5
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 07:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161041AbWGNF0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 01:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWGNF0k
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 01:26:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41937 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964795AbWGNF0j (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 01:26:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6E5QYnW024462
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Jul 2006 22:26:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6E5QX26030327;
	Thu, 13 Jul 2006 22:26:33 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060714033435.GA1508@spearce.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23874>



On Thu, 13 Jul 2006, Shawn Pearce wrote:
> 
> I thought about that but Windows 2000 talking to the same samba
> server issues back the correct errno.  Running the exact same Cygwin
> and GIT binaries (we've at least standardized on that).  So it
> seems weird that a samba server is issuing the correct error code
> to a Windows 2000 client but the wrong one to a Windows XP client.

The samba connection protocol is fairly involved, and it will, as far as I 
know, do a variety of "negotiation" of capabilities of both ends. What a 
W2000 client does can very possibly be very different from what a WXP 
client does, which in turn is certainly going to be different from a W98 
client. It will simply talk a different version of the protocol.

I am also told that the error codes actually differ between different 
versions of the samba protocol - not in the sense that different events 
generate different error codes, but that the _same_ error (say "ENOENT") 
is actually represented wioth different numbering in "old Windows SMB" and 
"new windows SMB".

I don't know the details, and may have gotten them wrong, but the point 
it, is't not at all impossible that the exact same version of Samba on the 
server will negotiate a different protocol because the client OS is 
different, and even though the Cygwin libraries and git binaries are the 
exact same libraries/binaries, they might get different error codes from 
the same system call.

(This may also explain why there are two "samba clients" in the kernel: 
the CONFIG_SMB and CONFIG_CIFS. CIFS is the "new version SMB", and the 
CIFS client currently doesn't even understand the old version - so you 
might use SMB for old servers, and CIFS for new servers)

That said, I thought W2000 and WXP both negotiated the "new" protocol, but 
there are probably config details even within that one..

		Linus
