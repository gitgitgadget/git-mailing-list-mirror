From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: a few beginner git questions
Date: Sun, 7 Mar 2010 11:50:02 +0300
Message-ID: <20100307085002.GA31105@dpotapov.dyndns.org>
References: <15b345f1003052242r7d812fe4q6ade253283696304@mail.gmail.com>
 <20100306070533.GL2480@ece.pdx.edu>
 <15b345f1003062102l22ac2d2fn3ed5b73221bf4216@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tait <git.git@t41t.com>, git@vger.kernel.org
To: Thomas Anderson <zelnaga@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 09:50:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoCBj-0003rG-Fy
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 09:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab0CGIuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 03:50:07 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:59566 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab0CGIuG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 03:50:06 -0500
Received: by fxm19 with SMTP id 19so5437593fxm.21
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 00:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=D+agtQYF+r7a0ctD5ZH8uCauQleVlks72ndICUoZPvg=;
        b=kKSPUWItNMYeDf7Ql77rnASObVEfBcyWGOQxjbkWgmN6ZLy+ZNtlgEojXDtcfLNJce
         VeQpM1MxTgwWHTDQ/WFr57feUAkapeWtNgWUqTJ//oA+OnBq960yajmNOmvZNAa5DCjF
         u0O7DpTb5wc41vP7vJB881C/Ij/jD/Zb72+hY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Cmtd2tSrApC+tOYJsDDjDZvHNNf1813C9DGGkx5EuaT2yJZtergb8c7Mx6+rfoZM9c
         nx1xkMAi2oddmb6qg6G7zsuulS0vOgavJ/YYVe21oQBnL0QobiKkmZ8Q62LPspMBFgp8
         HRl7BXSGECPV4hGNq0j9DleUWu8GQemJ8pxOY=
Received: by 10.223.17.23 with SMTP id q23mr3761190faa.65.1267951804743;
        Sun, 07 Mar 2010 00:50:04 -0800 (PST)
Received: from localhost (ppp91-77-225-63.pppoe.mtu-net.ru [91.77.225.63])
        by mx.google.com with ESMTPS id 21sm6527756fkx.10.2010.03.07.00.50.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 00:50:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <15b345f1003062102l22ac2d2fn3ed5b73221bf4216@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141673>

On Sat, Mar 06, 2010 at 11:02:20PM -0600, Thomas Anderson wrote:
> 
> How, then, do I update code?  ie. I perform my initial clone, make
> some changes and commit / push them.  Someone else then comes along,
> makes some changes and commits them.  The next day, I do Remote ->
> Fetch from -> origin to update my code to the latest in Git but
> c:\git\test\clone\README is exactly the same as it was before.  How do
> I update the initial clone such that I can edit the updated files?

There are a few ways to do that. It depends on what you actually wants.

First of all, you can merge 'origin/master' (or whatever its name).
If you do not have any local commit then merge will just fast-forward
your branch to the same point. However, if you do have changes, then
it will create a new merge commit. If you have many such merge commits,
it can make the upstream unhappy, because your changes are intervene
with merges, so it is more difficult to inspect your actual changes.

Another option is to rebase your changes on top of the 'origin/master'.
Rebasing your changes on top origin/master is more close to what happens
when you do 'cvs update' does, except that in git you rebase committed
changes, so if something goes wrong during this process, you can abort
and redo it again. So, all your work will not be lost. The advantage of
'rebase' is that you have a clean and linear history. The disadvantage
is that you re-write all your commits, so you should not do that on
"published" history. Also, re-writing may introduce a problem even if
rebased had no conflict. While merge may also produced a non-working
result, 'merge' preserves the original history while rebase produces a
new one, which is not tested. So, I would not recommend to rebase any
long series of patches or anything non-trivial unless it is absolutely
necessary.

Finally, a typical workflow with Git is to use feature branches. You
create a new branch to implement some feature, do all your work on it
(without any "update") and then merge it to the upstream (either you
merge and push the result or send a pull request to the maintainer).
After your changes have been merged, you just delete this branch. For
each new work, you start a new branch from the current origin/master.


Dmitry
