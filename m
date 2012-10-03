From: Scott Batchelor <scott.batchelor@gmail.com>
Subject: Re: Git diff-file bug?
Date: Wed, 3 Oct 2012 09:04:55 +0100
Message-ID: <CAEkqydxxmG1QsNUGqQnNn9xfXmS3D3qUvJR6OPV2poabKqcVeQ@mail.gmail.com>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
	<7vr4plkhin.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 10:06:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJJxJ-0007k6-Ho
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 10:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781Ab2JCIFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 04:05:00 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49727 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770Ab2JCIE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 04:04:56 -0400
Received: by ieak13 with SMTP id k13so16689573iea.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 01:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=6g7rGR4F2oF1JGf4kE2lVNFwN8pNVnBwmwNDxCFrMKI=;
        b=S0bhCRcR09b5nK6IMQlVF6u3M5V7qZ9Clwn1RxepchlCqNdavpzHDsLmgHb2W7OfVn
         W88hYNC9kAA69oA05hRMI5e2llU9pmp3x1fMDXN2NIDYtrMEi1LQ0onVZ/3AhPtsMPzU
         Bdc5s3iybU6ObTdzh87rTGG1194eJdgSLB92dmnuT5+GuwV0gcycMADgMxlaJskHtyDe
         nAOtRCR6Dayd7rogW3DKRneUh5xc+2D9YpdILpVmCng71OVM7+gdBmmvxhsbm2zOBq0a
         YTY9I15iHDMCPu0BL/pXptqMXtV0DmprwUPH9r/yg7XCVgjRfBLQ1Vecd1FtV/BWCP/W
         bsCg==
Received: by 10.50.7.135 with SMTP id j7mr1076081iga.34.1349251495833; Wed, 03
 Oct 2012 01:04:55 -0700 (PDT)
Received: by 10.50.22.68 with HTTP; Wed, 3 Oct 2012 01:04:55 -0700 (PDT)
In-Reply-To: <7vr4plkhin.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206868>

Many thanks to all who have responded to my question.
I have found that something is, indeed, modifying the inodes for all
the files in my repository. Our systems administrator executes a
backup using "tar" with the "--atime-preserve" flag. It is this flag
that modifies the "changed time" in the inode, and causes gitk to show
that all my files have changed.
Thanks,
Scott.

On 28 September 2012 21:40, Junio C Hamano <gitster@pobox.com> wrote:
> Scott Batchelor <scott.batchelor@gmail.com> writes:
>
>> I'm fairly new to git and am witnessing some strange behavior with git
>> that I suspect may be a bug. Can anyone set my mind at rest.
>>
>> Every so often (I've not quite figured out the exact set of
>> circumstances yet)
>
> Figure that circumstances out.  That is the key to the issue.
> Something in your workflow is futzing with the inode data of the
> files in your working tree behind your back.  It sometimes is a
> virus scanner.
>
> "git diff-*" plumbing commands are meant to be used after running
> "git update-index --refresh" once in the program and when the caller
> of these commands (in your case, gitk) knows that any change in the
> information returned by lstat(2) on the paths in the working tree
> files since that call indicate real changes to the files.
>
> "git status" internally runs an equivalent of "--refresh" before it
> goes to find changes, so after running it, until that something
> smudges the inode data behind your back, "gitk" will not be
> confused.
>
