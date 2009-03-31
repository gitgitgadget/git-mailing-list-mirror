From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git reflog expire --all" very slow
Date: Mon, 30 Mar 2009 22:09:25 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903302154000.4093@localhost.localdomain>
References: <alpine.LFD.2.00.0903301803190.4093@localhost.localdomain> <7vk5668g55.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:14:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoWIr-0002TC-47
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 07:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761639AbZCaFMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 01:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759903AbZCaFMA
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 01:12:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36369 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752326AbZCaFMA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 01:12:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2V59QWo002019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Mar 2009 22:10:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2V59Pdo013290;
	Mon, 30 Mar 2009 22:09:26 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vk5668g55.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.441 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115212>



On Mon, 30 Mar 2009, Junio C Hamano wrote:
> 
> Most of your reflog entries are expected to be reachable from the tip, so
> one optimization would be to mark all commits reachable from the tip
> upfront, and omit the in_merge_bases() computation for the ones that are
> already marked.  Perhaps something like this...

This if anything makes things just go slower.

Not much, but some. It went from 36.566s to 38.070s. That may be in the 
noise, I've not done any sensitivity analysis.

I thought you perhaps had a missing "parse_commit()" making the 
reachability thing not work (look_up_gently parses the object, but if it's 
a tag deref_tag() will dereference it until it hits a commit, but never 
parse the commit). But that wasn't it.

			Linus
