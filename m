From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC PATCH] git-help: find library man pages again
Date: Thu, 02 Sep 2010 11:09:43 +0200
Message-ID: <4C7F69D7.9030304@drmicha.warpmail.net>
References: <0b8d803551f495e2494b43c6d95163daca82f62b.1283356852.git.git@drmicha.warpmail.net> <20100902081646.GK29713@burratino> <4C7F6354.70108@drmicha.warpmail.net> <20100902085533.GL29713@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 11:09:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or5nu-00037d-95
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 11:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670Ab0IBJJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 05:09:41 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60845 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752146Ab0IBJJk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 05:09:40 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1081D369;
	Thu,  2 Sep 2010 05:09:40 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 02 Sep 2010 05:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=saRk9jXJtUP9QKhGKA+GSEXPAgk=; b=OkxskB820ehO6c3/bOmBJ0JEpcxelVCymjET4/ik87mO5cwGYpDVLyfH9+CMfoyvndDoao3UKS4mYflwCsxCJBWd42tZ5JOH+4xaUmGzlHDzmRI6KHE4hwm/TdWYSU2+lDNAWHEMcYcvQCe+D30neO3896xTNbw+4UshxyCfOgY=
X-Sasl-enc: 7M9XaVx9uPpjdHA1a73mTrD3faPBs700OQbkukUpEo6P 1283418579
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6FC494078BE;
	Thu,  2 Sep 2010 05:09:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <20100902085533.GL29713@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155118>

Jonathan Nieder venit, vidit, dixit 02.09.2010 10:55:
> Michael J Gruber wrote:
>> Jonathan Nieder venit, vidit, dixit 02.09.2010 10:16:
> 
>>> Therefore this seems wrong to me (except as a backward-compatibility
>>> measure).
> [...]
>> One heuristic, which I would have left for a later patch because of its
>> radicality (and I think we're in some phase of some rc something), is to
>> simply not do any checks when calling the viewers. This requires that
>> everything is prepended with "git-", which I see you have done in
>> builtin/help.c.
> 
> Yep, I agree with you in all respects, including the need to do
> something else (like the patch you sent) for v1.7.3.
> 
>> Still, none-command help pages will not show up with
>> "git help -a". So it's not a complete solution.
> 
> I think of "git --help -a" as a more complete version of the list
> from "git --help" --- that is, it is explaining what subcommands are
> available for git.
> 
> On the other hand, on platforms where "man -k git" is not available,
> as you mention it is the index to the manual.  Maybe "git help" should
> check GIT_HTML_PATH to provide a more complete index on such platforms.
> 
> Just musing.
> 
>> Alternatively, load_command_list() etc. could simply fill up a third
>> list "other_pages" (with non-executables) so that "git help -a" could
>> list "other help pages" in addition to the commands. I don't think this
>> would require any renaming nor Documentation updates.
> 
> Looks like you had a similar thought.
> 
>> ??? I guess this patch makes sense only after a patch which renames all
>> gitfoo.txt to git-foo.txt.
> 
> Well, there were ulterior motives to that patch: I keep on mistyping
> half-hyphenated manpage names like gitcvs-migration.

That's exactly why I use "git help foo" rather than "man git[-]?foo" and
want it to Just Work (TM);)

> I should have included some appropriate Makefile magic for
> compatibility symlinks for the old names.  Hopefully at least the idea
> was clear.

I was just wondering what this patch applies to - you must have
all-dashed documentation to begin with. And I actually think this would
be fine, unless we want to differentiate between command man pages and
other man pages by that. It's just that the shell libraries are half way
in between, and "git-remote-helpers.txt" is misnamed by that convention.

Michael
