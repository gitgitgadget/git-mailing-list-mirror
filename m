From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] do not overwrite untracked symlinks
Date: Mon, 21 Feb 2011 20:46:23 +0100
Message-ID: <20110221194623.GA31181@localhost>
References: <201102022025.06140.j6t@kdbg.org>
 <7v7hdixkys.fsf@alter.siamese.dyndns.org>
 <201102022324.22123.j6t@kdbg.org>
 <201102051918.44848.j6t@kdbg.org>
 <20110205183351.GA25717@localhost>
 <20110220121343.GA21514@localhost>
 <7vaahpluy9.fsf@alter.siamese.dyndns.org>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 20:44:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prbge-0001UW-P4
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 20:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651Ab1BUTon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 14:44:43 -0500
Received: from mail-bw0-f42.google.com ([209.85.214.42]:65357 "EHLO
	mail-bw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab1BUTon (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 14:44:43 -0500
Received: by bwz13 with SMTP id 13so2976816bwz.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 11:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IncBcwIW+74K+punE/ECFjDTR1AHO6ae9CltAQEgOQ8=;
        b=jOgOWwsgHAf0mC/ZZf/yFU+zTrvQBYPOCN+tTrgA9p42uURKFzL0pAw0sLAwhFuOYV
         68DoDjytKYNbpeTTcfTK9HgwqxPe8H0439fdi0/ekHH0BfNnksI8cGLbz9tXAXyY3Rc3
         RkfJHpHEbEVk90GdC+pNQXl/Gv/0kOsG6dbTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=bo8EmXiF5cC/l0ylYbNPmS6GUaQXLvFGDyRoXyJTxuUmbfG6sPETOQk/PErYQWoK8k
         wMkeiMJUWv7aBdj2Oy4RnttTP1Ch3bzd0+82/DaumSEtdZ7H09cnM8+msgYBcYD8MTmd
         u/9hsB01yNgCnpS3iL185eZf17vloPgIYdcuo=
Received: by 10.204.121.138 with SMTP id h10mr1699531bkr.40.1298317473891;
        Mon, 21 Feb 2011 11:44:33 -0800 (PST)
Received: from darc.lan (p5B22C930.dip.t-dialin.net [91.34.201.48])
        by mx.google.com with ESMTPS id j11sm3973079bka.0.2011.02.21.11.44.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 11:44:32 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PrbiB-0008Cu-CB; Mon, 21 Feb 2011 20:46:23 +0100
Content-Disposition: inline
In-Reply-To: <7vaahpluy9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167501>

Hi Junio,

On Sun, Feb 20, 2011 at 11:15:26PM -0800, Junio C Hamano wrote:
> 
> The title of the test says that checkout must keep a/b-2/c/d; if "git
> checkout" without "-f" doesn't do so and you had to change it to "git
> checkout -f", it would mean one of two things: (1) you broke "checkout",
> or (2) the behaviour the test wanted to keep working turned out to be
> unwanted (iow, "git checkout" without "-f" should fail under the initial
> condition this test sets up).

I didn't write the test, but to me it looks like the test wants to
make sure that while the symlink is removed, the tree it's pointing
to is not removed. I am not sure why that was ever a concern. But
by adding -f the test stays the same, except for the fact that it
is now forcefully overwriting a symlink, which could be done
silently before.

But I am fine with removing the test if you think it's meaningless.
And Hannes posted a number of tests for "symlink preservation"
earlier in this thread:

 http://mid.gmane.org/201102051918.44848.j6t@kdbg.org

We should rename the test to 2020, since 2019 is by now already
taken.  But otherwise I think the tests are fine as-is. I also used
them to test my patch.

Clemens
