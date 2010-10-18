From: Mihai Rusu <dizzy@google.com>
Subject: Possible bug in "git rebase" (non-interactive) with regards to post-rewrite
Date: Mon, 18 Oct 2010 15:39:44 -0700
Message-ID: <AANLkTikv+TuVK3uyEd5ymLRq6Qs7tQYm4kUH3t9hTtQP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 19 00:42:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7yOz-0006KS-MW
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 00:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933654Ab0JRWjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 18:39:52 -0400
Received: from smtp-out.google.com ([74.125.121.35]:60239 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933539Ab0JRWjr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 18:39:47 -0400
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id o9IMdkkF023910
	for <git@vger.kernel.org>; Mon, 18 Oct 2010 15:39:46 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1287441586; bh=MYGbo9XhYS7nAQBhqkCWOxoOJ8g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type;
	b=IHiciS/t3lBgksZnuLiGg2CAckYIA0Dhg671aeDjMzUAEvZcXlsFDewAR+NV1Y8go
	 Qr50eHwx/RQF+6sa1XqxA==
Received: from ewy5 (ewy5.prod.google.com [10.241.103.5])
	by wpaz29.hot.corp.google.com with ESMTP id o9IMcuGe013817
	for <git@vger.kernel.org>; Mon, 18 Oct 2010 15:39:45 -0700
Received: by ewy5 with SMTP id 5so1140069ewy.28
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 15:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=mIXAKZTokJD6zY6yj5sUVeSn4YFTUAKN0yu/sAsChS8=;
        b=KTNlre88rh2u0EGV8kl2i9+lNCO+K8Ebx0OCf1ZlrHXNYURRMn27+YMyVBreZbJqfb
         KCOOAm0rDr9Y4N0aw6Ag==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=It5/R8ZpNO8sOlTakuDyaeZjX4Fx85p/ZBhjp95r0JdX/t8LT4gitYtqEyhjd3w3P6
         /QUlezRQFVYmsxX2ji/Q==
Received: by 10.213.9.137 with SMTP id l9mr3923238ebl.67.1287441584455; Mon,
 18 Oct 2010 15:39:44 -0700 (PDT)
Received: by 10.213.10.5 with HTTP; Mon, 18 Oct 2010 15:39:44 -0700 (PDT)
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159293>

Hi

I have found a possible bug in Git. When running "git rebase"
(non-interactively, ie not "git rebase -i") on code that would
conflict on the last commit that is being rebased and if that last
commit is being skipped (git rebase --skip) then after the rebase is
done the "post-rewrite" hook is not called by "git rebase". If I get a
conflict and "git rebase --skip" any other commit or if I use "git
rebase -i" and "git rebase --skip" the last commit when it conflicts
then it calls post-rewrite just fine. Because this hook is normally
called only once, at the end of a non-aborted rebase the fact that
"git rebase" does not call it when the last commit conflicts and is
skipped means the script is not called at all for that rebase
operation thus breaking the code that depends on it.

Please advise, thank you.

-- 
Mihai Rusu
