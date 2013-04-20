From: Ilya Basin <basinilya@gmail.com>
Subject: Re[2]: State of CVS-to-git conversion tools (Was: Re: cvsps: bad usage: invalid argument --norc)
Date: Sat, 20 Apr 2013 14:22:51 +0400
Message-ID: <214169596.20130420142251@gmail.com>
References: <323381594.20130414121834@gmail.com> <673219382.20130414124800@gmail.com> <20130414113351.GA1299@thyrsus.com> <1762779000.20130415215818@gmail.com> <20130418094326.GB11038@thyrsus.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 12:24:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTUyJ-0002RH-UA
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 12:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754813Ab3DTKY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 06:24:29 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33996 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770Ab3DTKY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 06:24:28 -0400
Received: by mail-lb0-f176.google.com with SMTP id y8so4349251lbh.7
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 03:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=RoaZ5OYgMIdrKqPfL8Roz67Ryn8UK7f/EKet/c7a7oI=;
        b=dWi6skYqINVw7RxUw+7vVCVJdw7Yr1GL2XyaVJ75rr2I/WVkPIAEsND2FS/xCKqkKB
         t5FrbvyejbBIhzELrr4qai5h9eEh0WPO6cLsbh5IVnYiSfuU/D6MIi8X3QXbVR72L3Yt
         7dVIZuX5lsVx1GohnKitt2Uq/b80YCRVeqFZj1o24fdAlsY7b+OpdDHZV8R2m3iCnHRU
         ovwleJF1bBZc/FHmwOrv3/yciX28Ior0rqLuleRuiN1W+1gxcljOp8BrltnKO9iaEbh4
         hY3rSXnrIRMTGLeNfjIy2+XeFfMIRZFpCX13i8J3UOHkekkZZAjVYU1o/DLF+VXWBxDz
         CWUg==
X-Received: by 10.112.144.165 with SMTP id sn5mr3363891lbb.48.1366453464011;
        Sat, 20 Apr 2013 03:24:24 -0700 (PDT)
Received: from [192.168.0.78] (92-100-227-51.dynamic.avangarddsl.ru. [92.100.227.51])
        by mx.google.com with ESMTPS id w6sm7448418law.8.2013.04.20.03.24.21
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 03:24:22 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <20130418094326.GB11038@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221841>

Hi Eric.

ESR> cvs-fast-export does not have incremental-import support.
ESR> Whether git-cvs-import has it depend on which version you have
ESR> and what backend it it is using. I don't maintain that wrapper.
Did you mean "git-fast-import"? Or do you know any wrapper that
already uses cvsps3 --fast-export?


>> I need it, because full import takes too long.
>> The central repo of my employer is CVS, other people commit to it and
>> I use git internally to be able to tidy my commit history before
>> exporting to CVS.

ESR> You are out of luck. That feature was dependent on a very fragile
ESR> coupling...
OK, OK, I get it.


First of all, I think cvsps3 has almost everithing required for
incremental import: one could just take the date of the last commit
and invoke cvs ps with the '-d' flag. However, to import new commits
into existing branches the stream should contain the "from" command in
oldest commits in each branch (now missing).
If the branch already exists in the target git repo, it's easy to
refer it in the stream:
    from refs/heads/branchname^0

But if the branch is new, but it's parent commit is already imported,
I guess, the only way to refer it is by its SHA-1
Eric, what parent information can cvsps provide for the first commit
in a branch, when invoked with the '-d' flag?
