From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 1/3] gitweb: Deal with HEAD pointing to unborn branch in "heads" view
Date: Fri, 17 Feb 2012 14:41:34 +0100
Message-ID: <201202171441.35618.jnareb@gmail.com>
References: <1329320203-20272-1-git-send-email-jnareb@gmail.com> <201202162341.09712.jnareb@gmail.com> <7vsjiawe74.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, rajesh boyapati <boyapatisrajesh@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 14:41:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyO42-0003qs-HS
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 14:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685Ab2BQNl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 08:41:26 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42170 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab2BQNlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 08:41:25 -0500
Received: by eaah12 with SMTP id h12so1321757eaa.19
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 05:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=qEM6J4zrBJbRy/4mqSfgMyhUdLHjL81I6pCi49mB6Jo=;
        b=rg73PhXGnhUOiuBKLf/3kHpJ2/MGdVW/IERhpRrMUZP9AXWvojWr0zo+IbK4GyFlxu
         ZxyEONlB3qNvulXfVR+vs2270Aa/GiKt3qRkYVrDi8olztaGb/Vpi2rcIBoCfFfKjHeR
         ukyfhnRtsL/7gErPkVCNxkpq3GA5FKDxLAImE=
Received: by 10.213.19.133 with SMTP id a5mr1127278ebb.72.1329486084295;
        Fri, 17 Feb 2012 05:41:24 -0800 (PST)
Received: from [192.168.1.13] (abwb118.neoplus.adsl.tpnet.pl. [83.8.225.118])
        by mx.google.com with ESMTPS id v51sm38702039eef.2.2012.02.17.05.41.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 05:41:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vsjiawe74.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190956>

On Fri, 17 Feb 2012, Junio C Hamano wrote:
 
> But after trying to write a reroll myself, I have to wonder what would
> happen if you have two branches pointing at the same commit as the one at
> HEAD.  Why isn't the use of current_head class controlled by comparison
> between the name of the ref and the output from "symbolic-ref HEAD"?

If there is more than one branch that points to HEAD commit, they all
will be highlighted.

Using "git symbolic-ref HEAD", or just reading '.git/HEAD' file or symlink
is on my todo list.  This will make gitweb highlight current branch
correctly even if there is more than one branch that point to the same
HEAD commit, and make it possible to support "detached HEAD" (which I think
is not supported at all now).

Anyway the test is here to stay... :-)
 
> -- >8 --
> From: Jakub Narebski <jnareb@gmail.com>
> Date: Wed, 15 Feb 2012 16:36:41 +0100
> Subject: [PATCH] gitweb: Fix "heads" view when there is no current branch
> 
> In a repository whose HEAD points to an unborn branch with no commits,
> "heads" view and "summary" view (which shows what is shown in "heads"
> view) compared the object names of commits at the tip of branches with the
> output from "git rev-parse HEAD", which caused comparison of a string with
> undef and resulted in a warning in the server log.
> 
> This can happen if non-bare repository (with default 'master' branch)
> is updated not via committing but by other means like push to it, or
> Gerrit.  It can happen also just after running "git checkout --orphan
> <new branch>" but before creating any new commit on this branch.
> 
> Rewrite the comparison so that it also works when $head points at nothing;
> in such a case, no branch can be "the current branch", add a test for it.
> 
> While at it rename local variable $head to $head_at, as it points to
> current commit rather than current branch name (HEAD contents).
> 
> Reported-by: Rajesh Boyapati
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Thanks!

-- 
Jakub Narebski
Poland
