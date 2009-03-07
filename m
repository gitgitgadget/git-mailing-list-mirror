From: Charles Bailey <charles@hashpling.org>
Subject: Re: git-mergetool changes file rights?
Date: Sat, 7 Mar 2009 19:48:21 +0000
Message-ID: <20090307194821.GA29312@hashpling.org>
References: <49B298FA.2050803@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Grzegorz Kossakowski <grek@tuffmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 20:49:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg2Ww-000153-2W
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 20:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964AbZCGTs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 14:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755936AbZCGTs0
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 14:48:26 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:33097 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753815AbZCGTs0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2009 14:48:26 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAHtesknUnw6R/2dsb2JhbADSbYQFBg
Received: from ptb-relay01.plus.net ([212.159.14.145])
  by relay.ptn-ipout02.plus.net with ESMTP; 07 Mar 2009 19:48:22 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1Lg2VS-0004uF-6P; Sat, 07 Mar 2009 19:48:22 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n27JmLa1003991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 7 Mar 2009 19:48:21 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n27JmLqx003990;
	Sat, 7 Mar 2009 19:48:21 GMT
Content-Disposition: inline
In-Reply-To: <49B298FA.2050803@tuffmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 2a67485e841b94bfcad73290577906c5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112567>

On Sat, Mar 07, 2009 at 04:55:38PM +0100, Grzegorz Kossakowski wrote:
> grek@linux-p3yg:~/asf/git/infrastructure/apache-git-mirrors/bin> git mergetool
> merge tool candidates: kdiff3 kdiff3 tkdiff xxdiff meld gvimdiff opendiff emerge vimdiff
> Merging the files: email-update.sh
> 
> Normal merge conflict for 'email-update.sh':
>   {local}: modified
>   {remote}: modified
> Hit return to start merge resolution tool (kdiff3):
> error: open("bin/email-update.sh"): Permission denied
> error: unable to index file bin/email-update.sh
> fatal: updating files failed

Looking at this sequence of error messages it looks like mergetool ran
kdiff3 and this 'succeeded', but when mergetool came to 'git add' the
result of the merge it fell over in a heap because it couldn't read
the file because of the strange ---x------ permissions.

mergetool just uses mv to create a backup of the to-be-merged path and
then uses cp to recreate the original path before invoking kdiff3. I
haven't managed to get cp to do anything other that use the same mode
as the source file for a copied file.

What version of kdiff3 are you using? I ask because this fix looks
like it may be relevant:

http://kdiff3.svn.sourceforge.net/viewvc/kdiff3/trunk/kdiff3/src-QT4/fileaccess.cpp?r1=84&r2=96

The changelog for 0.9.95 includes this:

- Fixed permissions when writing executable file. (Un*x only)

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
