From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] combine-diff: use textconv for combined diff format
Date: Sat, 16 Apr 2011 14:37:30 -0700 (PDT)
Message-ID: <m31v11yj37.fsf@localhost.localdomain>
References: <20110414213006.GA7709@sigill.intra.peff.net>
	<36a715a966a22207135f60532e723f6d87dd1ffb.1302881295.git.git@drmicha.warpmail.net>
	<7voc47cqj0.fsf@alter.siamese.dyndns.org>
	<4DA96E48.3050008@drmicha.warpmail.net>
	<7vei52azbf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 23:37:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBDBe-0006E2-T1
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 23:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171Ab1DPVhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 17:37:33 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37452 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab1DPVhc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 17:37:32 -0400
Received: by wya21 with SMTP id 21so3046260wya.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 14:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=Cy7RboJnVu3/99ukEjsqkRiLcmp3wVkN+9voqCyiyvE=;
        b=PSG5gTGOujjkkvL4fDnLhVUFF7XLArw8Ma9V+XK8qFBzV7oXaJMrzRx/QvPcory1fx
         JldB9bUrJj+aykDXOzbtjFvVbUDEsdo+5ByFAIpSxyWC3y/C3bIq4ASBkAcg2uVu+0Mn
         jE48+B9xIBpWAf28PC3k913Be/oBmOgEZHEsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=oH8ABixlejYSufMJcj4jazVKzAnmEuiBR8ZtCDSOiWvQbnSoyvYqX0Cvj5uKQpNI4m
         +G8/+/P3QepOdILAJFWZFU+HzucFh7V+Al2tJdkXQDHctW0mrj9lF72zgFO/Ug6MQRc0
         grz8P8CIsRtN51YwMYfoKnFN5QKxP4mV1CjKU=
Received: by 10.227.195.75 with SMTP id eb11mr3514781wbb.120.1302989850953;
        Sat, 16 Apr 2011 14:37:30 -0700 (PDT)
Received: from localhost.localdomain (abvu151.neoplus.adsl.tpnet.pl [83.8.218.151])
        by mx.google.com with ESMTPS id y29sm2367003wbd.38.2011.04.16.14.37.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 14:37:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3GLaru4022522;
	Sat, 16 Apr 2011 23:37:04 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3GLaTPE022505;
	Sat, 16 Apr 2011 23:36:29 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vei52azbf.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171696>

Junio C Hamano <gitster@pobox.com> writes:

> But that opens an old can of worms we should have opened and closed four
> years ago.
> 
> The header shows "diff --cc a" followed by "--- a/a" followed by "+++ b/a"
> before the hunk for a two-way merge.  But if we are to "combine and
> condense", another possibility is to show:
> 
>     diff --cc a/a b/a c/a
>     index bf7c788,fa9d23a,5d24d9f..cc69134
>     --- a/a
>     --- b/a
>     +++ c/a
>     @@@@ -74,26 -74,6 -74,29 +74,50 @@@@
>     ...
> 
> to keep the paths information.  I do not think anybody cared so far, and
> perhaps we should have done it when we introduced -c/--cc, but it is not
> at all worth changing now.

Such feature would greatly simplify gitweb code for dealing with
combined diff (for a merge commit).  It wouldn't have to jump through
hoops[1] to get pre-image names to have correct link to pre-image...

This affects gitweb performance... in those rare case where we have
rename in merge commit (gitweb is smart enough to do this dance only
if there is rename in a merge).

Note that tree-diff doesn't help either - we have only post-image
name.

[1]: fill_from_file_info subroutine, which in turn uses
     git_get_path_by_hash once per parent, which uses git-ls-tree
-- 
Jakub Narebski
Poland
ShadeHawk on #git
