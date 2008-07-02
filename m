From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: RFC: grafts generalised
Date: Wed, 02 Jul 2008 09:35:17 -0700 (PDT)
Message-ID: <m3lk0kfdo1.fsf@localhost.localdomain>
References: <20080702143519.GA8391@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Jul 02 18:36:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE5Jf-0002G2-8i
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 18:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbYGBQfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 12:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752691AbYGBQfX
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 12:35:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:46317 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbYGBQfW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 12:35:22 -0400
Received: by ug-out-1314.google.com with SMTP id h2so564972ugf.16
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 09:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=x1dobxLc1xWiYiDogJUGf3bAmQGME9mJj17oewJWz6Y=;
        b=StiMf4S+GIea5XBczkCMBFA8At0NSeiwkyJgIAY+RqfyzWEJgct3Ti793uOvdAdqzZ
         jeNUgJCsHphuqle1hLGXby1I0Y2NeAyYd+vwAKkhzFCOaAdn8nHx8oSf2N9mZoX/FkSD
         jMLGEg76H85l6UIqt/sT6n4TcoLB627qo9a+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=KA/czuGSzUYUCRFkL+QZhZX2SXPqGS+64VZtWOVof9CHOuMlgHvgQV1R4xx+kfssQF
         2Mq+oPVVUvMFEVl8NV+yP7wkB7bWImmJGFZF3FFGrcuRJDJbZgdsvP2TE0+/aIiFfMIJ
         hHmIXTPsMHRY1UCGOLorG6Ck63DDgtkYA2nig=
Received: by 10.210.48.14 with SMTP id v14mr6766774ebv.112.1215016519911;
        Wed, 02 Jul 2008 09:35:19 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.250.156])
        by mx.google.com with ESMTPS id b30sm10579612ika.3.2008.07.02.09.35.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jul 2008 09:35:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m62GYfFF019347;
	Wed, 2 Jul 2008 18:34:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m62GYNQk019342;
	Wed, 2 Jul 2008 18:34:23 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080702143519.GA8391@cuci.nl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87158>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> I'm in the process of converting and stitching and patching vast amounts
> of initially disjunct CVS and SVN repositories into larger complete
> histories inside a single git repository.  Recreating history as
> accurately as possible.
> 
> The problem I encounter is that any number of times I have to "edit"
> history in a non-parameterable fashion, in any of the following ways:
> - Change parents.
> - Add merges.
> - Change author, committer, commitdate, authordate.
> - Change the tree (because of conversion errors in the automated
>   conversion process) belonging to a single commit.
> - Retrofit a patch which has to ripple through all of history until
>   the present.
> 
> The only things which are easily done at the moment are:
> Change parents and add merges.  This can be accomplished fairly easily
> using the grafts file.
> The other changes are messy at best and need to be parameterised into the
> form of a shell script so that git filter-branch can have a go at it.
[...]

> I propose the following:
> - Extend git fsck to do more sanity checks on the content of the grafts
>   file (to make it more difficult to shoot yourself in the foot with
>   that file; my feet will be grateful).
> - Extend the grafts file format to support something like the following syntax:
> 
> commit eb03813cdb999f25628784bb4f07b3f4c8bfe3f6
> Parent: 7bc72e647d54c2f713160b22e2e08c39d86c7c28
> Merge: 3b3da24960a82a479b9ad64affab50226df02abe 13b8f53e8ccec3b08eeb6515e6a10a2a
> Merge: ac719ed37270558f21d89676fce97eab4469b0f1
> Tree: 32fc99814b97322174dbe97ec320cf32314959e2
> Author: Foo Bar (FooBar) <foo@bar>
> AuthorDate: Sat Jun 6 13:50:44 1998 +0000
> Commit: Foo Bar (FooBar) <foo@bar>
> CommitDate: Sat Jun 7 13:50:44 1998 +0000
> Logmessage: First line of logmessage override
> Logmessage: Second line of logmessage override
> Logmessage: Etc.
[...]

First, if I remember correctly (from KernelTrap and now defunct Kernel
Traffic and one issue of Git Traffic) the 'graft' mechanizm was
created so it would be possible to "graft" (join) historical
conversion repository with the "current work" git repository (started
from zero when git was deemed good enough for Linux kernel
development).  The same mechanism is used for shallow clone, where one
goes in the opposite direction, shortening history instead of joining
two repositories (two histories).

The fact that git-filter-branch (and earlier cg-admin-rewrite-hist)
respects grafts, and rewrites history so that grafts are no-op and are
not needed further is a bit of side-effect.  So I think that it would
be better to provide generic git-filter-branch filter which can
understand this "generalized grafts" file format, or rather
'description of changes' file.  Put it in contrib/, and here you
go...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
