From: Andy Parkins <andyparkins@gmail.com>
Subject: Rebasing a branch that contains merges
Date: Mon, 19 Feb 2007 09:12:22 +0000
Message-ID: <200702190912.24067.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 10:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ4ZZ-0002Eh-HT
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 10:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbXBSJMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 04:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbXBSJMb
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 04:12:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:10808 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbXBSJMb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 04:12:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2366429nfa
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 01:12:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=g0NF66HALQMEveeI44K/gFBUm8nTJH/1+VpIG0+Lp3WpttY7m422vX5ta6NwGnUJbFFQO+pY0Q+lo9kBtT4XensqqXOGKShDad/tj4XySsZkGXwXllinvJ7ux6R4mg2vPquCMerrlfre5H/cbEfp1me4LxXnjneJce/VaVIGofg=
Received: by 10.48.216.7 with SMTP id o7mr5509082nfg.1171876349840;
        Mon, 19 Feb 2007 01:12:29 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id a23sm25771583nfc.2007.02.19.01.12.27;
        Mon, 19 Feb 2007 01:12:27 -0800 (PST)
User-Agent: KMail/1.9.5
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40106>

Hello,

I've done some little experiments with rebasing a branch with merges on it.  I 
wanted to check that what I found is what is intended.

I made a repository like this:

 * -- * -- * (master)
      |\
      | A (branch1) -- M (merge)
       \              /
        B (branch2) --

It's a horribly unfair thing to do, but while on merge I did

 git rebase master

I had been hoping that both branches would rebase, but only one did.  I got:

 * -- * -- * (master) -- B -- M (merge)
      |\
      | A (branch1)
       \              
        B (branch2)

"M" effectively now contains all of branch1's changes.  If I hadn't referenced 
the merge head separately from the two branch heads, all the history in 
branch1 would now be represented by "M".

I don't think this is the right result.  Either
 * git should refuse to rebase because it would lose history
 * git should rebase both branches

The ideal result (perhaps unrealisticly) would have been

 * -- * -- * (master)
           |\
           | A (branch1) -- M (merge)
            \              /
             B (branch2) --

This is an unreasonable thing to expect a version control system to be able to 
do - it's a nasty, complicated wish.  git is its own worst enemy for things 
like this; it's getting to be so good at nasty unreasonable things that they 
don't seem like fantasy-land wishes.

A perfectly valid answer is "don't be so ridiculous Andy, go away". :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
