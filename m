From: "rae l" <crquan@gmail.com>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Mon, 8 Oct 2007 00:42:10 +0800
Message-ID: <91b13c310710070942q31cb4b5do81d1488bbd88dff@mail.gmail.com>
References: <1191719841666-git-send-email-shawn.bohrer@gmail.com>
	 <alpine.LFD.0.999.0710061827010.23684@woody.linux-foundation.org>
	 <20071007154126.GD5642@mediacenter.austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org, frank@lichtenheld.de, gitster@pobox.com
To: "Shawn Bohrer" <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 07 18:42:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeZCu-0006Fk-HM
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 18:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbXJGQmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 12:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbXJGQmM
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 12:42:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:1729 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbXJGQmL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 12:42:11 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1044432wxd
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 09:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=JBmdZBZ2UcFUr4Z11PDD2pzr8QDPdUBjyxctxfkR6bE=;
        b=Trv217r6ckLTxnrUyh8rgU/lq+7A9Ao3n7aZAwrZWMAFRyKr2YIgfpbdqKd01UHaPNKybaVncAWmURYImZ/bpbpz3V/wqllDB5vGHRhwvzl3kMO7YVNMSuOOIx3oBpS06wxsz8expF3eXN5j5yYqPJMAGUgYavWxrijGJzIvTGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dd2ksJ/4qA2E9siZbEYKPluw4m+fc3LuikKwGdWq7ebWBXmaZiWpS08A8L0P3F8yD5e0G2JdywFdlbNksI4bJX/RJJWGJvqIdDdAvbqxgR1cfpA9TLBZmz1obtgDazsZJTd+YD3Ai40Rn6ODN/FBuXhkmMqw5RUaGb5gygvPAgM=
Received: by 10.90.93.6 with SMTP id q6mr3066636agb.1191775330573;
        Sun, 07 Oct 2007 09:42:10 -0700 (PDT)
Received: by 10.90.92.7 with HTTP; Sun, 7 Oct 2007 09:42:10 -0700 (PDT)
In-Reply-To: <20071007154126.GD5642@mediacenter.austin.rr.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60198>

On 10/7/07, Shawn Bohrer <shawn.bohrer@gmail.com> wrote:
> Thanks for the input.
>
> On Sat, Oct 06, 2007 at 06:31:36PM -0700, Linus Torvalds wrote:
> > This looks better, but I think you'd be even better off actually using the
> > "read_directory()" interface directly, instead of exec'ing off "git
> > ls-files" and parsing the line output.
>
> Perhaps, I'll take a look at how git-ls-files does it and see if I can
> do that directly.  Since I'm new to git (and C) it will probably take me
> a while to re-implement though.
>
> > I also would still worry a bit about 'chdir(x)' and 'chdir("..")', because
> > quite frankly, they are *not* mirrors of each other (think symlinks, but
> > also error behaviour due to directories that might be non-executable).
> > Now, admittedly, if a directory isn't executable, I can imagine other git
> > things having problems (anybody want to test?), but that whole pattern is
> > just very fragile and not very reliable.
>
> Yes it does seem fragile, but 'chdir("-")' doesn't work in C and I
> couldn't find any equivalents.  I actually did think about symlinks, and
> my code does do the right thing since I test if it is a directory before
> doing the 'chdir(x)'. Symlinks are therefore treated as normal files and
> removed.
'chdir -' is just supported by the shell, and the C interface could
use chdir(OLDPWD).
