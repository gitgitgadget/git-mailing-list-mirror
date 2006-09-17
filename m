From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] gitweb:  Make git_get_refs_list do work of  git_get_references
Date: 16 Sep 2006 18:40:22 -0700
Message-ID: <864pv7tgmx.fsf@blue.stonehenge.com>
References: <200609170226.39330.jnareb@gmail.com>
	<7vodtf8eym.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 03:40:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOle0-0006X5-IP
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 03:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWIQBkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 21:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWIQBkZ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 21:40:25 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:62275 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932091AbWIQBkY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 21:40:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 52BEE8F332;
	Sat, 16 Sep 2006 18:40:24 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 22789-01-25; Sat, 16 Sep 2006 18:40:23 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id A865A8F396; Sat, 16 Sep 2006 18:40:23 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.11.12; tzolkin = 4 Eb; haab = 5 Chen
In-Reply-To: <7vodtf8eym.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27149>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> Jakub Narebski <jnareb@gmail.com> writes:
>> Make git_get_refs_list do also work of git_get_references, to avoid
>> calling git-peek-remote twice. It now returns either list of refs as
>> before in scalar context, or references hash and list of refs in list
>> context.

Junio> I do not think we want to have too many functions that return
Junio> different things depending on contexts.  Forcing callers to
Junio> remember what the function does in which context is bad.

That's even an inaccurate description, so an expert in Perl (I've
known a few) would just scratch his head.

You cannot ever ever return a list in a scalar context.  Ever.  Never ever.

You can return an array ref that *contains* a list of references, sure.
Perhaps that's what you mean, as in:

  return [$ref1, $ref2, $ref3, $ref4]; # scalar return

But to be sloppy about the terminology confuses me.  For example,
I can't tell from your description if you mean the list-value return is:

  return \%some_hash, $ref1, $ref2, $ref3, $ref4; # list return: N items

Or, reverse engineering your sloppiness on the other description, you
*MIGHT* mean:

  return \%some_hash, [$ref1, $ref2, $ref3, $ref4]; # list return: 2 items

Perl5 does *no* implicit referencing/dereferencing (just like C).  So yes,
being precise with your language is necessary.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
