From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How are the same file modified on different brances stored physically?
Date: Mon, 03 Mar 2008 04:10:42 -0800 (PST)
Message-ID: <m3zltghut1.fsf@localhost.localdomain>
References: <15799383.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: amishera <amishera2007@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 13:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW9W0-00038W-MK
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 13:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbYCCMKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 07:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753785AbYCCMKt
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 07:10:49 -0500
Received: from gv-out-0910.google.com ([216.239.58.188]:14157 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393AbYCCMKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 07:10:47 -0500
Received: by gv-out-0910.google.com with SMTP id s4so2757275gve.37
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 04:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=Q7ZuTfYBMDuuhGdXsxsFrWr1eYcCs24F2JDlQq4MJKU=;
        b=mfVphPH4HW9oA/z8FmI765twdWYYo6KGFlpkirXfRrEPS4qM/wxQaBAHorYqKcSO2W6Kqnjic94//++94MqPUq8yuanZ0Zt9UkaC8BQNqwm/GdFYNQ+8NctRuxbAHfSuKnom5Yfazn8mAR1mkeoTZnyKjWD8tHyTGGPZblEuKDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=Gb7Qz32nFB68n71y0SvFHGkNAR0itJDRSANjk91Vrco8g5HP2/6HrBsnHL15l4PfTcxZRiiVCe+gyibv4AjQzAy99r9nMrAAxKgBAytL4UBP96frlCVprdDMqTMHdArKzAkCTeHnJBq33Goo7haaSCcXshVHYhkqHb7yyDfjOeM=
Received: by 10.78.132.2 with SMTP id f2mr18643500hud.37.1204546242993;
        Mon, 03 Mar 2008 04:10:42 -0800 (PST)
Received: from localhost.localdomain ( [83.8.251.32])
        by mx.google.com with ESMTPS id 32sm23671310nfu.7.2008.03.03.04.10.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Mar 2008 04:10:42 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m23CAqio002196;
	Mon, 3 Mar 2008 13:10:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m23CAp0p002193;
	Mon, 3 Mar 2008 13:10:51 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <15799383.post@talk.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75921>

amishera <amishera2007@gmail.com> writes:

> I am trying to figure out how stuffs work behind the scene. We know
> that we can switch branches freely and then work on the switched
> branch. If the same file is modified on two branches then how are
> the two copies of the two branches saved?

First, read existing bundled and on-line documentation: git(7), "Git
User's Manual", "Git Magic", "Git for Computer Scientists", "Git in
Nutshell".  One of them should explain git concepts to you.

Let's assume for simplicity that project consist of two files, 'foo'
and 'bar' in top directory.  You have created side branch, using
"git checkout -b test-branch" for example. You have modified file
'foo', and committed those changes (either "git add foo; git commit"
or "git commit -a".  This created three new objects in repository (in
object database): a "blob" object containing new contents of file
'foo', new "tree" object with 'link' to old 'bar' and new 'foo', and
"commit" object, with given commit message, with 'parent' to previous
commit, and with 'tree' to newly created "tree" object.  It also
advances refs/heads/test-branch to new commit.

Now you switch to previous branch, with "git checkout master".  You
modify file 'foo' and commit changes.  Again, this creates three new
objects: "blob", "tree" and "commit".  This means that there are three
blob objects with contents of 'foo' and one blob object with contents
of 'bar'.

Of course after repacking ("git gc") contents for file 'foo' might be
stored as base objects (usually largest version) and binary deltas
from base.  But those are implementation (engine) details.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
