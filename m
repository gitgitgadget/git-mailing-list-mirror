From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Unresolved issues
Date: Wed, 21 Feb 2007 12:05:39 -0500
Message-ID: <20070221170539.GI25559@spearce.org>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702200934270.20368@woody.linux-foundation.org> <7vfy90v729.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702201621050.4043@woody.linux-foundation.org> <Pine.LNX.4.63.0702210136050.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070221104209.GM21842@admingilde.org> <Pine.LNX.4.63.0702211348060.22628@wbgn013.biozentrum.uni-wuerzburg.de> <09D527A1-43E2-41A1-AC46-71F64BC409C2@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Waitz <tali@admingilde.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Feb 21 18:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJuui-0005zK-9J
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 18:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbXBURFx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 12:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422698AbXBURFx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 12:05:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42872 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422696AbXBURFw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 12:05:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJuuN-00088h-OD; Wed, 21 Feb 2007 12:05:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 01FBD20FBAE; Wed, 21 Feb 2007 12:05:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <09D527A1-43E2-41A1-AC46-71F64BC409C2@silverinsanity.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40306>

Brian Gernhardt <benji@silverinsanity.com> wrote:
> It seems to me that a tracked .gitattributes file should have things  
> like
> 
> *.txt: text
> *.gif: binary
> *.[ch]: text
> 
> And the .git/config should have
> 
> [attribute "text"]
>    mangle = crlf
> 
> [attribute "binary"]
>    merge = none
> 
> The type of each file should be tracked, but what to do with each  
> type is a local issue.  Trying to merge the two is madness.

Yes, exactly.  :-)

I would also recommend that we encourage use of standard MIME types
to define the file types, but don't enforce it.  Thus I can setup
something like:

  cat >.gitattributes <<EOF
  *.txt: text/plain
  *.java: text/java-source
  *.xml: text/xml
  *.bin: mycompany-binary
  EOF

  cat >>.git/config <<EOF
  [attribute "text/*"]
    mangle = crlf
  [attribute "text/xml"]
    merge = better-xml-mergething
  [attribute "mycompany-binary"]
    mangle = no
    merge = mycompany-binarymerge
  EOF

And have all three classes of files be mangled with CRLF, but
XML files are also merged with the external merge process, and the
special type mycompany-binary might be a local file format that comes
with its own merge tools, but is not exactly a registered MIME type.

One advantage here is we can setup attribute.text/*.mangle=crlf on
Windows platforms by default for users, as we can reasonably assume
all text content falls into this MIME type...

-- 
Shawn.
