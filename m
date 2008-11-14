From: "Bob Hiestand" <bob.hiestand@gmail.com>
Subject: Re: reflog delete results in reflog show strangeness?
Date: Fri, 14 Nov 2008 16:44:46 -0600
Message-ID: <cc29171c0811141444t30a35c65se1319a63a5443354@mail.gmail.com>
References: <cc29171c0811141433t43d27c5gb57ca11d2ddb67cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 23:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L17Qj-0001HN-EO
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 23:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbYKNWos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 17:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbYKNWos
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 17:44:48 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:38525 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbYKNWor (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 17:44:47 -0500
Received: by wa-out-1112.google.com with SMTP id v27so792846wah.21
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 14:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=BaWy/i+9QIGkqepBRb5SBalExXHr3jng+mUx4EhLjCk=;
        b=E0/P7aURTMgB7nY9TqsGlONenHd2QeZ8ZBchRPw+E1PNt4vdDAHBRFp5+ARF6f2IBC
         byMNzv1zXGnlvkLCU1i0dlsZVv8oF9IeqHiGcBUdhQb6wq5W+1bF5i1NCf6bk8GEbCoq
         sUHMUXBuyvuReZXTYde3A9ThoYuOjfEGP55BI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aJk+prcejvLlW4MJCwPhc3/BGc7pYW+WUwYUleoz5aWiMFzkpOjpafCIxp9YDo9ig/
         1PXJy+qfboOKfxa1RNSpiG+sfcpwQS5e3JpuS78X/k52DiDUn6cj3uGI+3RkVE6a2qPj
         5HYrcdmxd9i50X/Pp1kmf7xUyESty4Vk4k/4E=
Received: by 10.114.37.3 with SMTP id k3mr865388wak.98.1226702686639;
        Fri, 14 Nov 2008 14:44:46 -0800 (PST)
Received: by 10.114.123.9 with HTTP; Fri, 14 Nov 2008 14:44:46 -0800 (PST)
In-Reply-To: <cc29171c0811141433t43d27c5gb57ca11d2ddb67cb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101023>

On Fri, Nov 14, 2008 at 4:33 PM, Bob Hiestand <bob.hiestand@gmail.com> wrote:
> I see a possible bug in the output of 'git reflog show' after using
> 'git reflog delete'.  Simple example:
>
> $ git init
> $ git commit --allow-empty -m 'root'
> $ git commit --allow-empty -m 'good'
> $ git commit --allow-empty -m 'bad'
> $ git reflog
> 996ca67... HEAD@{0}: commit: bad
> e431a20... HEAD@{1}: commit: good
> 992dd88... HEAD@{2}: commit (initial): root
>
> $ git reset HEAD^
> $ git reflog
> e431a20... HEAD@{0}: HEAD^: updating HEAD
> 996ca67... HEAD@{1}: commit: bad
> e431a20... HEAD@{2}: commit: good
> 992dd88... HEAD@{3}: commit (initial): root
>
> $ git reflog delete HEAD@{1}
> $ git reflog
> e431a20... HEAD@{0}: HEAD^: updating HEAD
> 996ca67... HEAD@{1}: commit: good
> 992dd88... HEAD@{2}: commit (initial): root
>
> In this listing, please note that, after the delete, the commit SHA
> shown as HEAD@{1} is that of the deleted reference (the bad commit)
> and does not match the reflog message, which has the expected value.

Sorry, forgot to add this:

$ git describe
v1.6.0.4-969-g58a38d0
