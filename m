From: Maciej Pasternacki <maciej@pasternacki.net>
Subject: Re: [PATCH v2] Add command line option --chdir/-C to allow setting git process work directory.
Date: Mon, 20 Oct 2008 01:13:49 +0200
Message-ID: <4BBD811A-F750-43F5-A0F0-EBB186E54AEE@pasternacki.net>
References: <0B4A1BD5-5FC3-4B29-B0BB-77A85AEDF5B2@pasternacki.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 10:41:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrhUI-0006AG-NM
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 01:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbYJSXNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 19:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbYJSXNy
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 19:13:54 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:58647 "EHLO
	jankymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751906AbYJSXNx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Oct 2008 19:13:53 -0400
Received: from [192.168.11.248] (vide-sat.pl [213.192.64.46])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jankymail-a4.g.dreamhost.com (Postfix) with ESMTP id 1E9D31810D0;
	Sun, 19 Oct 2008 16:13:51 -0700 (PDT)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98626>

On 2008-10-19, at 23:02, Jeff King wrote:

> I took a closer look at this. I'm not sure that there is actually a
> problem with moving the cd_to_toplevel before require_work_tree.
> cd_to_toplevel makes sure there is actually something to cdup to. In  
> my
> test without a work-tree, "git rev-parse --show-cdup" simply printed
> nothing, causing no "cd" to occur.

I won't speculate on whether moving cd_to_toplevel up will introduce  
problem or not.  I am not familiar with git internals, and I just  
repeat an opinion gathered on #git.  However, -C seem to be better  
suited for simple cases, conceptually cleaner, and may make the  
learning curve a bit less steep.  There is no need for consdering all  
possible --work-tree/--git-dir combinations and their implications, it  
is possible just to say "cd there, and act as usual".

> So:
>
> 1. I think we can fix this breakage by swapping the two.

I can prepare a patch if that's expected, but probably I won't  
understand what it exactly does and what are implications of this  
change.

> 2. There is still breakage in other scripts, some of which may need
>    quite in-depth fixes (e.g., git-bisect requires a work tree but
>    does not chdir at all. For the require_work_tree test to work, it
>    needs to be inside the work tree, and the script will need a
>    careful looking over to see what ramifications that has).

I really don't think I'm competent enough to fix more complex cases  
without breaking twice as many things; I don't feel confident even  
with a simple swap in git-pull at the moment

> 3. I think your -C option has some merit independent of this, since
>    it allows you to chdir and still use the usual lookup rules (e.g.,
>    see if it is bare vs a regular repository). But I don't feel
>    strongly about it one way or the other.

In my use case, it definitely has merits as it makes git behave  
exactly as if user himself wrote "git pull" inside the work tree, and  
I am still not sure wheter expected --work-tree/--git-dir combinations  
would behave the same.  Probably I'll need to add more commands and  
more complex use cases as I develop cl-librarian, and -C would make  
this job way easier.

Regards,
Maciej.

-- 
-><- Maciej Pasternacki -><- http://www.pasternacki.net/ -><-
