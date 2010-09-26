From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: custom merge driver vs. CONFLICT (delete/modify)
Date: Sun, 26 Sep 2010 03:17:19 -0700 (PDT)
Message-ID: <m38w2ohks3.fsf@localhost.localdomain>
References: <1285445444-sup-3857@flatty.sascha.silbe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Sascha Silbe <sascha-ml-reply-to-2010-3@silbe.org>
X-From: git-owner@vger.kernel.org Sun Sep 26 12:18:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzoJV-0005Ja-IP
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 12:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350Ab0IZKRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 06:17:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44694 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846Ab0IZKRW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 06:17:22 -0400
Received: by fxm3 with SMTP id 3so1361610fxm.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Ijv0eLMubcsMcD6V07bwGXzhnygCToBT57PnTJWTo34=;
        b=GbB0kdKQesTTvm+Cscqm59iwgomQ/0txDyh8laH1j+4TbYfLXmaZCnCF64URRB1FRc
         PIQaH3ZDG8E6wTOWqX7YzZcumCTNf8MNVR2BwbIcpcSnwfPvk6z4ekeFztlwzaxTcf5d
         59/GiZHfWbwFzcgivjOG5uhDMteSgRaEBbZ2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=cuHSy3yBCuvK7fISXCYr9OZMpC1HDMpcl69JUKFEKzgH3b34r3KZ+5u2Mzq8Q4GElE
         kqJ4lWD+8E3Dh7TnA/yN6dBissMaUBvKAvfFYzMUWxYUVVRol1DuHeYH2/S4rqwpt5eJ
         rc/VNmBqTGUWut/nQwRBqqYziyU4gCwCAfbqw=
Received: by 10.223.121.208 with SMTP id i16mr5790416far.46.1285496241425;
        Sun, 26 Sep 2010 03:17:21 -0700 (PDT)
Received: from localhost.localdomain (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id b36sm1869121faq.35.2010.09.26.03.17.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 03:17:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8QAGtJg027713;
	Sun, 26 Sep 2010 12:17:06 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8QAGj2n027707;
	Sun, 26 Sep 2010 12:16:45 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1285445444-sup-3857@flatty.sascha.silbe.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157217>

Sascha Silbe <sascha-ml-reply-to-2010-3@silbe.org> writes:

> I am (automatically) building snapshot packages by combining the packaging
> maintained in one repository (but also containing sources) with (more
> recent) upstream sources from another repository.
> 
> For some files (those touched by rerunning auto*) I want the local
> version to always take precedence. For some other files (autogen.sh, PO
> files) I want the upstream version to take precedence. For all the rest
> I want conflicts to produce an error.
> 
> This has worked fine so far by using custom merge drivers, but while
> adding the second one I encountered a problem: Merge drivers are only
> invoked for modify/modify (and maybe add/add) conflicts.
> More specifically a delete/modify conflict will cause git-merge to bail
> out directly without calling the merge driver to resolve the conflict.
> Such a conflict occurred because the packaging people removed autogen.sh
> (which is reasonable for them, but not for me).
> 
> Is there a way to either resolve all kinds of conflicts in favour of
> one side (like -X <side>) or always take one side (like -s <side>) for
> a specific set of files?
> Alternatively, is there a way to do a merge in multiple "steps",
> operating only on a subset of the files each time (so I can use
> -s <side> / -X <side> for two of three steps per merge)?

Well, you can create your own merge strategy (see git-merge-ours.sh
in contrib/examples/ as an example), put it in appropriate place,
and use '--strategy=<name>' to force using your own custom merge
strategy.

The problem you see is that merge *driver* (as set by gitattributes)
deals only with _file-level_ conflicts, i.e. it is run instead of
ordinary diff3-based merge.  The CONFLICT(Delete/modify) is solved on
the _tree_ level by a merge *strategy*.  Currently there is no way to
change how tree-level conflict is resolved, without creating your own
merge strategy.  Though in princile it doesn't seem impossible...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
