From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Finally implement "git log --follow"
Date: Thu, 21 Jun 2007 08:21:30 +0200
Message-ID: <e5bfff550706202321t354ec0e3xb218f382f1c983ae@mail.gmail.com>
References: <alpine.LFD.0.98.0706191358180.3593@woody.linux-foundation.org>
	 <e5bfff550706192327l187b30eblb5bd5e4e76b3eab6@mail.gmail.com>
	 <alpine.LFD.0.98.0706200940000.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 08:21:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1G2v-0006Xs-OJ
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 08:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbXFUGVc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 02:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbXFUGVc
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 02:21:32 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:40434 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbXFUGVb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 02:21:31 -0400
Received: by nz-out-0506.google.com with SMTP id n1so495278nzf
        for <git@vger.kernel.org>; Wed, 20 Jun 2007 23:21:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iarTrbfarlrLTFit7xQs1DGIfVENGwuGo+46+eC2aZFM8IH71VfVahKZ3bJUAEBrNJQqGdBN7hIQ6kiePLh5MvG9pyldYajVNIqhY+vJL0S2IsnOpiYOjwjq1ysQtbezFXTAlC2t/e9c8xBHQ76xLDsRPVVCKMhsuxPRDQ8od2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IF9F5xfHW4JUXfBgVKzLwA9BKuMaHe3z6PWBBA6yT3TrgLEMMx8/27saELhzHLVvay0pYYXmjXE0s53gKi9Piwp79eBNuTY1pl7OjLUbic0EvNhRg1Jao0TqU4bP1aNhuvkDTc7dRhSQ6j6Xb6iETgVv38d6Vk1yxU+JGLxc0c4=
Received: by 10.115.79.1 with SMTP id g1mr1216938wal.1182406890352;
        Wed, 20 Jun 2007 23:21:30 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Wed, 20 Jun 2007 23:21:30 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0706200940000.3593@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50599>

On 6/20/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:

>
> That said, you really would be better off using
>
>         git blame -M --incremental
>

That's how it is currently inplemented in qgit:

- Main view revision list + graph: git-rev-list
- File history and annotation: git-rev-list

The possible options are:

ALL GIT LOG
-------------------

- Main view revision list + graph: git-log
- File history and annotation: git-log

Good: easy implementation and a lot of common code to share among
modules, all the current features (see "range fltering" below) are
preserved

Bad: Currently git-log does not support --stdin option, required IMHO
when git-log is runned by a tool, not a user, due to the possibility
of a very long command line.

MIXED
---------

- Main view revision list + graph: git-rev-list
- File history and annotation: git-blame

Good: Gain additional features of git-blame against git-log

Bad: FWIK "git blame -M --incremental" does not support annotating all
the files in history in one go, as it is possible both with
git-rev-list and git-log. You have to re-annotate the new file when
browsing file history with the mouse.

Impementation cannot reuse big chunks of code, so a lot of new code is
needed and probably old one will not disappear.

FWIK "git blame -M --incremental" does not support "code lines range
filtering", when with the mouse you select some lines of code and
after filtering you see the subset of file's history that modified
that range of code. This feature is currently supported by qgit
annotating code.

Also jump to the same currently selected code line when switching to a
different version in file history it is currently supported by
annotate code.


INTERESTING
--------------------

- Main view revision list + graph: git-log
- File history and annotation: git-blame

A curious mix.



Some advice?


Thanks
Marco
