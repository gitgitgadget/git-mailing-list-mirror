From: Stephen Bash <bash@genarts.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Sat, 14 Apr 2012 23:13:34 -0400 (EDT)
Message-ID: <b2ae4143-e771-4219-8727-d1c4048b61cc@mail>
References: <4F89EDBF.9050906@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 05:14:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJFux-0001vX-RC
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 05:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776Ab2DODNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 23:13:46 -0400
Received: from hq.genarts.com ([173.9.65.1]:17347 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756733Ab2DODNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 23:13:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 6D1A1BE2615;
	Sat, 14 Apr 2012 23:13:40 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jRJfTZyuAdOw; Sat, 14 Apr 2012 23:13:34 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id A171EBE25D1;
	Sat, 14 Apr 2012 23:13:34 -0400 (EDT)
In-Reply-To: <4F89EDBF.9050906@pileofstuff.org>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC18 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195544>

----- Original Message -----
> From: "Andrew Sayers" <andrew-git@pileofstuff.org>
> Sent: Saturday, April 14, 2012 5:35:59 PM
> Subject: Re: GSOC Proposal draft: git-remote-svn
>
> ... snip ...
> 
> One solution you could look at would be storing dead branches in a
> JSON file somewhere.  If you go down that route, remember that `git
> gc` will try to garbage collect the commits once the branches have
> been dead for long enough.

I don't remember if this has already been discussed, but as I see it there are basically three approaches to closed/deleted SVN branches in the Git world:

  1) Just delete the branch, allow git gc to later cleanup the objects
  2) Just leave them be for the user to deal with at a later date
  3) Move them to another namespace

I think (3) is the only semi-tricky one.  If you read the git-gc manpage, it turns out gc will consider any object reachable from any ref under refs/ as safe.  When cloning/pushing/pulling/etc. git only looks at refs/heads and refs/tags (unless told otherwise).  So for our conversion I created refs/hidden/heads and refs/hidden/tags (other choices could be refs/svn or refs/junk, but you get the idea).  Just as a fun stat, the hidden namespace in our central repo has 280 refs in it vs 502 in the visible/normal namespace (surprisingly the hidden ones are almost perfectly split with 138 dead Subversion branches and 142 SVN tags that were later retagged/committed to).

Thanks,
Stephen
