From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 16:49:11 -0700
Message-ID: <7v63n872bs.fsf@gitster.siamese.dyndns.org>
References: <20081031170704.GU14786@spearce.org>
 <20081031174745.GA4058@artemis.corp>
 <alpine.LFD.2.00.0810311558540.13034@xanadu.home>
 <20081031213114.GA21799@artemis.corp>
 <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl>
 <20081031232829.GC14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:51:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3ll-0005bo-BL
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbYJaXt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbYJaXt4
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:49:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYJaXtz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 19:49:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8BCC077BD1;
	Fri, 31 Oct 2008 19:49:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 97FB977BC9; Fri, 31 Oct 2008 19:49:22 -0400 (EDT)
In-Reply-To: <20081031232829.GC14786@spearce.org> (Shawn O. Pearce's message
 of "Fri, 31 Oct 2008 16:28:29 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9DD86D8A-A7A6-11DD-9BD5-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99682>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> You are the end-user of the library, so it needs to suit you.  Ok,
> you aren't the only end-user, but you and other developers like
> you... :-)

I will be the end-user of the library because if we want libgit2 to be
anywhere close to successful, you should be able to port C-git to it.

I understand that the apidocs/ is a very early work-in-progress, but
still, it bothers me that it is unclear to me what lifetime rules are in
effect on the in-core objects.  For example, in C-git, commit objects are
not just parsed but are modified in place as history is traversed
(e.g. their flags smudged and their parents simplified).  You have "flags"
field in commit, which implies to me that the design shares this same
"modified by processing in-place" assumption.  It is great for processing
efficiency as long as you are a "run once and let exit(3) clean-up" type
of program, but is quite problematic otherwise.  commit.flags that C-git
uses for traversal marker purposes, together with "who are parents and
children of this commit", should probably be kept inside traversal module,
if you want to make this truly reusable.

By the way, I hate git_result_t.  That should be "int", the most natural
integral type on the platform.
