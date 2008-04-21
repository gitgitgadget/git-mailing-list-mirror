From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 01/02/RFC] implement a stat cache
Date: Mon, 21 Apr 2008 04:53:40 +0400
Message-ID: <20080421005340.GA2631@dpotapov.dyndns.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org> <20080420111346.GA13411@bit.office.eurotux.com> <alpine.LFD.1.10.0804200836310.2779@woody.linux-foundation.org> <20080420215700.GA18626@bit.office.eurotux.com> <alpine.LFD.1.10.0804201520370.2779@woody.linux-foundation.org> <alpine.LFD.1.10.0804201556290.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luciano Rocha <luciano@eurotux.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 21 02:54:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnkIq-00018i-5a
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 02:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbYDUAxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 20:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752562AbYDUAxr
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 20:53:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:34751 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbYDUAxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 20:53:47 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1561947fgb.17
        for <git@vger.kernel.org>; Sun, 20 Apr 2008 17:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=mAm80liIwA2u1z7+Z01rVg6Rf7O3YsxJauIrV63Z6yI=;
        b=KsC8JL3t+chpdjYi+JPt2herXPSHxTr84MeWs3v1UodP3QERIPt4//x3eINENeTiNkm/1pp7hrxCLdAW3DFsPBJAatl5WfDJQWBjfY60fZdhMtx3fXAQ8Mlwuhw5jwCUlaItGWehs/F3QESC09qWS96cShNJFtb/3t+oHMPKB0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=iaKr7sAgNOJ9EgonZhvhAnI5HJcnqfO0+/TUDthzBiPUnwc7Ad7aApq9H00bEtyNCw7j7WFScZUSHc/6UWzqDClC2r/9QoUJ2ISJhJjq1pxgVaHxKJ/fQ43Hanc//n1a20a35WtCFRDKo2g1IiJA+Blosa+McxvDkaBhvlq2BC0=
Received: by 10.86.97.7 with SMTP id u7mr11760768fgb.65.1208739225401;
        Sun, 20 Apr 2008 17:53:45 -0700 (PDT)
Received: from localhost ( [83.237.185.228])
        by mx.google.com with ESMTPS id z33sm5725911ikz.0.2008.04.20.17.53.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Apr 2008 17:53:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0804201556290.2779@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80008>

On Sun, Apr 20, 2008 at 04:07:35PM -0700, Linus Torvalds wrote:
>
> Junio, what was the logic for that whole "has_symlink_leading_path()"
> thing? I forget. Whatever, it's broken.

===
commit f859c846e90b385c7ef873df22403529208ade50
Author: Junio C Hamano <junkio@cox.net>
Date:   Fri May 11 22:11:07 2007 -0700

    Add has_symlink_leading_path() function.

    When we are applying a patch that creates a blob at a path, or
    when we are switching from a branch that does not have a blob at
    the path to another branch that has one, we need to make sure
    that there is nothing at the path in the working tree, as such a
    file is a local modification made by the user that would be lost
    by the operation.

    Normally, lstat() on the path and making sure ENOENT is returned
    is good enough for that purpose.  However there is a twist.  We
    may be creating a regular file arch/x86_64/boot/Makefile, while
    removing an existing symbolic link at arch/x86_64/boot that
    points at existing ../i386/boot directory that has Makefile in
    it.  We always first check without touching filesystem and then
    perform the actual operation, so when we verify the new file,
    arch/x86_64/boot/Makefile, does not exist, we haven't removed
    the symbolic link arc/x86_64/boot symbolic link yet.  lstat() on
    the file sees through the symbolic link and reports the file is
    there, which is not what we want.

    The function has_symlink_leading_path() function takes a path,
    and sees if any of the leading directory component is a symbolic
    link.

    When files in a new directory are created, we tend to process
    them together because both index and tree are sorted.  The
    function takes advantage of this and allows the caller to cache
    and reuse which symbolic link on the filesystem caused the
    function to return true.

    The calling sequence would be:

        char last_symlink[PATH_MAX];

            *last_symlink = '\0';
            for each index entry {
                if (!lose)
                        continue;
                if (lstat(it))
                        if (errno == ENOENT)
                                ; /* happy */
                        else
                                error;
                else if (has_symlink_leading_path(it, last_symlink))
                        ; /* happy */
                else
                        error; /* would lose local changes */
                unlink_entry(it, last_symlink);
        }
===

And there are some cases where stat() on path is desirable:
http://www.spinics.net/lists/git/msg63988.html

So while stat information for regular files is cached in the index,
stat information for directories is not cached, and that appears to
be wrong. Maybe, Lucano's cache makes sense if it stores only stat
information for directories.

IIRC, some time ago, an otherwise reasonable patch for .gitignore was
rejected just because it would drive the number calls to lstat() up as
these calls on directories are not cached in the index.

Dmitry
