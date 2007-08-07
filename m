From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Tue, 7 Aug 2007 11:29:23 -0400
Message-ID: <30e4a070708070829l1ca946b6j968c14eebec06bed@mail.gmail.com>
References: <f99cem$4a4$1@sea.gmane.org>
	 <Pine.LNX.4.64.0708071257350.14781@racer.site>
	 <f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sebastian Schuberth" <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 17:29:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIQzx-0007Qk-7G
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 17:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761280AbXHGP31 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 11:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934284AbXHGP30
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 11:29:26 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:59611 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761182AbXHGP3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 11:29:25 -0400
Received: by ik-out-1112.google.com with SMTP id b32so482791ika
        for <git@vger.kernel.org>; Tue, 07 Aug 2007 08:29:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=clU4qtV2z9AY8s7FVwWXovr9GzttSBdSvW/vHM5GIn2vWhSV3RWG+0ucznTxw3Vdes9CLK9r5ldVeBev1ynJo1K7+nz53oyAt0MmXWfNRQ5UEzOuDiuUwxnH/myeHjx6aw5rzsJmE5ZuD/SJgvuOXYwiO0oi9QuvLVQ8Vg6dF74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d5LKKnI3dWrzh7u7vmunnrw5bLjLza3grGTpmsWSqfcY7Vao0aOQcK2wFa4BQuTqLuKzzQwDqYnWtKAfZkTzHmnu/dAn+oAQP+Qgwv4PRep+4XCYENB2mKid5yr3/M/GCm/D+WV+t5bReOuWCtg1VMtP74aY1bJEijFnZ+PvoxM=
Received: by 10.78.206.9 with SMTP id d9mr1824204hug.1186500563297;
        Tue, 07 Aug 2007 08:29:23 -0700 (PDT)
Received: by 10.78.190.5 with HTTP; Tue, 7 Aug 2007 08:29:23 -0700 (PDT)
In-Reply-To: <f99rei$ou$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55265>

On 8/7/07, Sebastian Schuberth <sschuberth@gmail.com> wrote:
> >>>  100% (2295/2295) done
> >>> Resolving 1793 deltas...
> >>>  100% (1793/1793) done
> >>> : not a valid SHA1b870df7cde1e05ee76d1d15ea428f
> >>> fatal: Not a valid object name HEAD
>
>
> I wonder if this happens because git never passes "b" to any fopen()
> calls (as there is no such thing like opening a file in binary mode
> under Linux, because files are always opened "binary"). If fopen()
> safely ignores the "b" option under Linux, I think it should always be
> specified so Cygwin's git will work with text mode mounts when compiled
> from the original git sources.
>
> --
If you follow the Cygwin mailing lists, you'll find that the
developers *really* want to kill off the whole text mount thing:
ultimately, this has proved unsupportable as it requires deep
modifications of every tool "ported" over to Cygwin and invariably
leads to strange bugs as you have just discovered. Originally, Cygwin
had the goal of porting Unix tools to Windows, requiring that every
tool work on text mounts, but they restated their goal as providing a
POSIX environment under Windows that matches what Linux does. So, I
doubt you'll get support from the Cygwin developer's or the Cygwin git
maintainer for a text mount aware version of git. Clearly, the mingw
port has to deal with these issues, and it might be possible to
leverage that work for Cygwin, but the flip side is that under POSIX,
git explicitly recognizes the difference between \0d\0a and \0a while
on a text mount, programs do not, and this would make such a ported
git violate the currently stated Cygwin goals.

Mark
