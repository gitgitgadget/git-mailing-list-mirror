From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 4 Jun 2009 17:45:40 -0700
Message-ID: <20090605004540.GU3355@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com> <200906022339.08639.jnareb@gmail.com> <200906042255.43952.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 02:45:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCNZ6-0006so-94
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 02:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbZFEApk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 20:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbZFEApj
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 20:45:39 -0400
Received: from george.spearce.org ([209.20.77.23]:52626 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbZFEApi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 20:45:38 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EE9DD381D1; Fri,  5 Jun 2009 00:45:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906042255.43952.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120730>

Jakub Narebski <jnareb@gmail.com> wrote:
> 
> Here we were talking about the following part of exchange: 
> (I have added "C:" prefix to signal that this is what client, 
> git-clone here, sends; I have added also explicit "\n" to mark LF
> characters terminating lines, and put each pkt-line on separate line)
> 
> gb>  C: 0054want 74730d410fcb6603ace96f1dc55ea6196122532d multi_ack side-band-64k ofs-delta\n
> gb>  C: 0032want 7d1665144a3a975c05f1f43902ddaf084e784dbe\n
> gb>  C: 0032want 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a\n
> gb>  C: 0032want 7e47fe2bd8d01d481f44d7af0531bd93d3b21c01\n
> gb>  C: 0032want 74730d410fcb6603ace96f1dc55ea6196122532d\n
> gb>  C: 0000
> gb>  C: 0009done\n
> 
> and where server response is (again the quote from "Git Community Book"
> was modified, removing here doublequotes and doubling of backslashes):

That should be fine.

Here's a dummy client that works against both jgit and C Git:

  perl -e '
	$h="fcfcfb1fd94829c1a1704f894fc111d14770d34e";
	$c="multi_ack side-band-64k ofs-delta";
    sub w{$_=shift;printf "%4.4x%s",4+length,$_;}
    w("git-upload-pack /.git");
    w("want $h $c\n");
    printf "0000";
    w("done")
  ' | nc localhost 9418

Are you sure you are flushing the IO buffers in the dummy client?

-- 
Shawn.
