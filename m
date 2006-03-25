From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 10:35:39 +0100
Message-ID: <e5bfff550603250135h42b0da62x84973483798d969c@mail.gmail.com>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Davide Libenzi" <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 10:35:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN5BV-0001jc-7X
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 10:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWCYJfl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 04:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWCYJfl
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 04:35:41 -0500
Received: from wproxy.gmail.com ([64.233.184.232]:18544 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751124AbWCYJfk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 04:35:40 -0500
Received: by wproxy.gmail.com with SMTP id 57so1104430wri
        for <git@vger.kernel.org>; Sat, 25 Mar 2006 01:35:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bWDuaX/8dLqQztQRFOpLleU+mZWdS2Qr2XyELLSPuqZ75/EG7pXBOUMuRZu6AJ7KHphl80XYg/Um6PlfVv+IEHdFqtbahJ5sMj47T8Geqdjs3yL7sEzaPicnecaIG4GcUK5a+V0sFLRtbyQOwjEUZnRzKF/BhHVVYYEdBWQazD8=
Received: by 10.64.243.17 with SMTP id q17mr1437211qbh;
        Sat, 25 Mar 2006 01:35:39 -0800 (PST)
Received: by 10.64.142.5 with HTTP; Sat, 25 Mar 2006 01:35:39 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17966>

On 3/25/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> This uses a simplified libxdiff setup to generate unified diffs _without_
> doing  fork/execve of GNU "diff".
>
> This has several huge advantages, for example:
>
> Before:
>
>         [torvalds@g5 linux]$ time git diff v2.6.16.. > /dev/null
>
>         real    0m24.818s
>         user    0m13.332s
>         sys     0m8.664s
>
> After:
>
>         [torvalds@g5 linux]$ time git diff v2.6.16.. > /dev/null
>
>         real    0m4.563s
>         user    0m2.944s
>         sys     0m1.580s
>

Currently 'getting the diffs' is the second most important time
consumer  of annotation calculation (just after getting the file
history). On big and heavily modified files, as drivers/net/tg3.c in
Linux tree, this can be very slow (around 10s on my box).

The profiling has been done on qgit, but I think  it is of general
interest because qgit uses git-rev-list and git-diff-tree -p to get
file's history and diffs respectively.

So this patch is more then welcomed!  Thanks!

Marco
