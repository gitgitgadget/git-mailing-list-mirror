From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: Syncing with CVS
Date: Mon, 19 Jan 2009 12:58:44 +0200
Message-ID: <49745CE4.1000309@panasas.com>
References: <f31e50960901190139w65b69fd1k752973a23c40f384@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian von Kietzell <cuboci@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 12:00:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOrrd-0006IH-9G
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 12:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758612AbZASK6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 05:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758323AbZASK6w
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 05:58:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:35607 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758168AbZASK6v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 05:58:51 -0500
Received: by ug-out-1314.google.com with SMTP id 39so186322ugf.37
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 02:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=kZXaQzNU1LTUtdOc1DYu1sLGnvXDxnNw7zFrfwr9WD0=;
        b=fvcrmQlKmfwZSS92XK8MoOZ8EFyqInH9ovFrJ1fAtG4jpBiIYt7fDjWjmNazXcelPz
         rNMmB/9PAbgD5nTaoR555lpalfg3G0rqtjqoWwC2OhcIoAVIMlQf5uOT+/pHNR2rS/Hx
         k2idJQ4gz7qxpepOtu+F/9MoY1T9w5od2NcSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=BrkUqzaii9DDk/DPkmSMd1aipE50fDERNkjXgv3GwUdOySs2MkbPBs+vy6aB/sQM2N
         qKD8pipH3qZdHosIOX5l42eCtMSjvwJl2sW3QDBJN23+55hy/oBsEwRAbdR5xfjh6iTB
         2vUp42sTbdag2viwu980XROJbZq/iwpJdpGHs=
Received: by 10.67.25.3 with SMTP id c3mr1461227ugj.85.1232362728822;
        Mon, 19 Jan 2009 02:58:48 -0800 (PST)
Received: from bh-buildlin2.bhalevy.com (DSL212-235-53-3.bb.netvision.net.il [212.235.53.3])
        by mx.google.com with ESMTPS id m38sm4498611ugd.46.2009.01.19.02.58.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jan 2009 02:58:48 -0800 (PST)
User-Agent: Thunderbird/3.0a2 (X11; 2008072418)
In-Reply-To: <f31e50960901190139w65b69fd1k752973a23c40f384@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106343>

Christian von Kietzell wrote:
> Hi,
> 
> I have a project I started in git. After a while I exported that to
> CVS via git cvsexportcommit which worked quite nicely. Now, a
> colleague made changes to the project - in CVS. What's the best way to
> get those back into my git repository so that I'll be able to sync
> back and forth between git and CVS? I had a quick look at the wiki but
> couldn't find anything appropriate.
> 
> I know of git cvsimport, of course, but that doesn't work on my
> original repository. Or does it? I didn't find anything on how to
> limit what to import. After all, some of the commits are already in my
> repository (the ones I exported).
> 
> Hope any of you can help. Thanks in advance.
> 
>   Chris

I would "git cvsimport" into temporary new git.
Then "git remote add cvs_import that_temp_git" into the main git
Then find the point of the common base, do
"git tag CVS_GIT_BASE that_base_commit_uid"
"git checkout -b cvs_import cvs_import/master"
"git rebase --onto master CVS_GIT_BASE"

So in fact I'm just cherry-picking the additions from CVS
and reapplying on to original git tree. If you want it more
automatic you'll need to do the above in a script with some
kind of naming conventions for your git tags and CVS's tags
at points of sync.

Boaz
 
