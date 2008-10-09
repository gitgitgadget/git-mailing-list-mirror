From: Alex Riesen <raa.lkml@gmail.com>
Subject: fetch fails with a short read of received pack
Date: Thu, 9 Oct 2008 21:55:18 +0200
Message-ID: <20081009195518.GA1497@blimp.localhost>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 21:59:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko1fQ-000493-BC
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 21:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbYJIT6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 15:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753770AbYJIT6N
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 15:58:13 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:34444 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbYJIT6M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 15:58:12 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8BU8ypoY=
Received: from tigra.home (Fae3f.f.strato-dslnet.de [195.4.174.63])
	by post.webmailer.de (fruni mo24) (RZmta 17.10)
	with ESMTP id v03211k99JZ4qn ; Thu, 9 Oct 2008 21:58:09 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 2498E277C8;
	Thu,  9 Oct 2008 21:58:09 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id EC7DD36D18; Thu,  9 Oct 2008 21:55:18 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97879>

Somehow I got my gnulib mirror to a strange state where I can't fetch
anything from it:

    $ cd gnulib
    $ git fetch -f ../gnulib.git 'refs/heads/*:refs/remotes/origin/*'
    remote: Counting objects: 2202, done.
    remote: Compressing objects: 100% (633/633), done.
    remote: Total 1769 (delta 1448), reused 1455 (delta 1134)
    Receiving objects: 100% (1769/1769), 404.11 KiB, done.
    fatal: premature end of pack file, 1745 bytes missing
    fatal: index-pack failed

This is with current Shawn's master (Junio's master erroneously gives
an error). Bisect points at ac0463ed44e859c84e354cd0ae47d9b5b124e112

    pack-objects: use fixup_pack_header_footer()'s validation mode

    When limiting the pack size, a new header has to be written to the
    pack and a new SHA1 computed.  Make sure that the SHA1 of what is being
    read back matches the SHA1 of what was written.

This and the diff make no sense to me (as to what could be broken).
I made both repos available at:

    The source, it unpacks in gitlib.git (as in example above)
	http://vin-soft.org/~ftp-tmp/gnulib-broken-src.tar.bz2

    The target, where the fetch in the example is run
	http://vin-soft.org/~ftp-tmp/gnulib-broken-tgt.tar.bz2

Could someone who actually understands the code please have a look?
