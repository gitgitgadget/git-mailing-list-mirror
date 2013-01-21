From: John Keeping <john@keeping.me.uk>
Subject: Re: git-cvsimport-3 and incremental imports
Date: Mon, 21 Jan 2013 13:27:06 +0000
Message-ID: <20130121132706.GF7498@serenity.lan>
References: <20130120200922.GC7498@serenity.lan>
 <20130120232008.GA25001@thyrsus.com>
 <20130121093658.GD7498@serenity.lan>
 <20130121112853.GA31693@thyrsus.com>
 <20130121120010.GE7498@serenity.lan>
 <20130121124340.GA32219@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 14:27:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxHPW-00018Y-8V
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 14:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263Ab3AUN1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 08:27:17 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:43993 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab3AUN1R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 08:27:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 4450C606594;
	Mon, 21 Jan 2013 13:27:16 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IAXPIrPo4xRn; Mon, 21 Jan 2013 13:27:15 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id D86C4606565;
	Mon, 21 Jan 2013 13:27:15 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id CF3B3161E3E9;
	Mon, 21 Jan 2013 13:27:15 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v4ts8r9awcJ3; Mon, 21 Jan 2013 13:27:15 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 18965161E25D;
	Mon, 21 Jan 2013 13:27:10 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130121124340.GA32219@thyrsus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214117>

On Mon, Jan 21, 2013 at 07:43:40AM -0500, Eric S. Raymond wrote:
> John Keeping <john@keeping.me.uk>:
>> I also disagree that cvsps outputs commits *newer* than T since it will
>> also output commits *at* T, which is what I changed with the patch in my
>> previous message.
> 
> Ah.  OK, that is yet another bug inherited from 2.x - the code doesn't
> match the documented (and correct) behavior.  Please send me a patch
> against the cvsps repo, I'll merge it.

Should now be in your inbox.

> > Perhaps it is simplest to just save a CVS_LAST_IMPORT_TIME file in
> > $GIT_DIR and not worry about it any more.
> 
> Yes, I think you're right. Trying to carry that information in-band would
> probably doom us to all sorts of bug-prone complications.

I think the only way to do it without needing to save local state in the
Git repository would be to teach cvsps to read a table of refs and times
from its stdin so that we could do something like:

    git for-each-ref --format='%(refname)%09%(*authordate:raw)' refs/heads/ |
    cvsps -i --branch-times-from-stdin |
    git fast-import

Then cvsps could create a hash table from this and use that to decide
whether a patch set is interesting or not.


John
