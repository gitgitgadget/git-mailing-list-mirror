X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Subprojects tasks
Date: Sun, 17 Dec 2006 11:01:10 +0100
Organization: At home
Message-ID: <em34cd$ni8$1@sea.gmane.org>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <200612170848.10092.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sun, 17 Dec 2006 09:59:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 44
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34682>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvsnY-0002CZ-91 for gcvg-git@gmane.org; Sun, 17 Dec
 2006 10:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752334AbWLQJ7E (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 04:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbWLQJ7E
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 04:59:04 -0500
Received: from main.gmane.org ([80.91.229.2]:59725 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1752335AbWLQJ7D
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 04:59:03 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gvsn9-0006fq-JB for git@vger.kernel.org; Sun, 17 Dec 2006 10:58:47 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 17 Dec 2006 10:58:47 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 17 Dec 2006
 10:58:47 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Alan Chandler wrote:

> The use case was when the supermodule wanted to make use of the header 
> files of the submodule because it was using the submodule as a library.
> 
> This did make me wonder if the submodule should not export some form 
> of "approved" set of content (or files - and I do think care is needed 
> here as to which it is when we think about renames) which is both
> 
> a) a subset of the full tree that is stored at commit time, and
> b) does itself have a commit history 
> 
> (I am clearly thinking that would be the standard "include" files, but 
> not the actual source of the library - (but it might include the 
> library it self as a prebuilt binary library?)
> 
> This does suggest it is a tree object stored in the repository - and 
> that it is linked in time via a set of commit objects - I'll call them 
> the "export commits".  I am not sure whether a new commit should be 
> made everytime there is any change (via a normal commit) to this 
> content, or (and I slightly favour this) there is a new commit made 
> which is somewhat akin to a tag when the project wants to release a new 
> version of its interface. 

In the absence of sparse/partial checkout, and it's use in submodule
support, this can be solvd purely on porcelain level.

You would have to simply maintain separate 'includes' branch, similarly
to how 'html' and 'man' (and 'todo') branches are maintained in git.git
repository -- it would be your 'set of commit objects'. Then the only
think that would be needed is some commit / post-commit hook which would
examine if commit touches "include" files and if it does, make a commit
in the 'includes' ('inc' for short) branch.

Suportmodule would then use either 'master' branch for full sources,
or 'includes' branch for headers only.

P.S. Cc: Alan Chandler <alan@chandlerfamily.org.uk>, 
Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

