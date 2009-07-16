From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: [PATCH] Added support for core.ignorecase when excluding gitignore
 entries
Date: Thu, 16 Jul 2009 07:15:26 -0600
Message-ID: <4A5F27EE.3070101@workspacewhiz.com>
References: <4A5EB849.1000803@workspacewhiz.com> <20090716094210.GC2800@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 16 15:15:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRQoG-0005Aw-Nb
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 15:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877AbZGPNPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 09:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755855AbZGPNPc
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 09:15:32 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:38422 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755536AbZGPNPb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 09:15:31 -0400
Received: (qmail 18343 invoked by uid 399); 16 Jul 2009 07:15:27 -0600
Received: from unknown (HELO ?192.168.1.107?) (jjensen@workspacewhiz.com@24.10.200.9)
  by hsmail.qwknetllc.com with ESMTPAM; 16 Jul 2009 07:15:27 -0600
X-Originating-IP: 24.10.200.9
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <20090716094210.GC2800@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123401>

----- Original Message -----
From: Jeff King
Date: 7/16/2009 3:42 AM
> Makes sense, though I can't help but wonder what would happen with a
> filesystem that did more than just case (like the utf8 normalization
> that happens on HFS).
>
> Should we actually be converting the filesystem names into a canonical
> format as they are read? IIRC, Linus posted some patches a few weeks ago
> about "git path" versus "filesystem path", but I didn't actually look
> too closely.
>   
I'm game for whatever.  Git actually has a lot of places where it 
doesn't pay attention to core.ignorecase, and having a standard and 
correct method of comparing filenames would make it easier to handle 
core.ignorecase=true in a more global fashion.
> If your patch is the right route, it might be nice to collapse the
> comparison into its own function. You end up cutting and pasting a lot
> of the related conditionals and returns (like above, where 2 lines
> become 9), so it might make sense to do something like:
>
>   int filename_cmp(const char *a, const char *b, int ignore_case)
>   {
>     return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
>   }
>
> and then just s/strcmp/filename_cmp/ at the appropriate callsites.
>   
I started off with this method, but it required two functions, one with 
the strcmp() and one for strncmp().  In fact, in other places in the 
code, Git uses memcmp() for comparison.  Is that, then, three filename 
comparison functions, dependent upon intent?  At that point, it felt 
like my change wasn't as self contained anymore, so I then wrote what I 
posted to the list to get feedback.

I'm hoping someone will offer the most correct method to do this, as I 
have a number of patches forthcoming to handle core.ignorecase=true in 
other areas.  The next one covers 'git status' and its reporting of 
'missing' directories due to case differences.

Thanks!

Josh
