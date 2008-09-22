From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: ignoring files/directories in git
Date: Mon, 22 Sep 2008 12:52:00 +0400
Message-ID: <20080922085200.GI21650@dpotapov.dyndns.org>
References: <19596152.post@talk.nabble.com> <19599905.post@talk.nabble.com> <48D74B1C.6020408@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mwolfe38 <mwolfe38@gmail.com>, git@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 10:53:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhhAS-0003im-Ng
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 10:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbYIVIwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 04:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbYIVIwH
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 04:52:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:39400 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbYIVIwG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 04:52:06 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1294568fgg.17
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 01:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7BW2MCuuiyWBS8XWXMK2Y+E3uX9AoRv8W4h5cq3UOt4=;
        b=Jiwsednu5z/4cFeevdy/NUtjcRuKvQDjllHDlpz6lpGsqVHdmqrIw0i5jtGm/CIBh0
         7J4V0UbIhlC50cd6T2m0IiH5CkpLr7576A8P7SqeajKzMEy9trnMBFn2c1OUc8dqV8G6
         bOmxODSeS+yCwMypeBvuNTujyNxV75Bs6CEmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FY7MyUOmKiZZaB9Z6A6Xa3vQ0Tm6qhQBA6qX7INE7+yyJ0fklEwS/84nC90aQjMmHz
         D/fMS5wX01N4GNeSrn8Ph3bAf5IISv4Dq1g3UWvV25E+Pgic5hS/CNVZJQF3hXl4QkSc
         cNoJSL/qPfrz+BcK+6i4GO5fKwkDjEr1felTY=
Received: by 10.86.36.11 with SMTP id j11mr4554483fgj.7.1222073524316;
        Mon, 22 Sep 2008 01:52:04 -0700 (PDT)
Received: from localhost (ppp85-140-171-157.pppoe.mtu-net.ru [85.140.171.157])
        by mx.google.com with ESMTPS id l19sm5110364fgb.7.2008.09.22.01.52.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Sep 2008 01:52:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48D74B1C.6020408@panasas.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96460>

On Mon, Sep 22, 2008 at 10:37:00AM +0300, Boaz Harrosh wrote:
> 
> I have 1.6.0.1 I compiled here, and it has the same problem. So it is
> a very recent fix

I certainly tested 1.6.0.1 and does not have this problem, and it was
fixed a long time ago:

===
commit d6b8fc303b389b026f2bf9918f6f83041488989b
Author: Junio C Hamano <gitster@pobox.com>
Date:   Thu Jan 31 01:17:48 2008 -0800

    gitignore(5): Allow "foo/" in ignore list to match directory "foo"

    A pattern "foo/" in the exclude list did not match directory
    "foo", but a pattern "foo" did.  This attempts to extend the
    exclude mechanism so that it would while not matching a regular
    file or a symbolic link "foo".  In order to differentiate a
    directory and non directory, this passes down the type of path
    being checked to excluded() function.

    A downside is that the recursive directory walk may need to run
    lstat(2) more often on systems whose "struct dirent" do not give
    the type of the entry; earlier it did not have to do so for an
    excluded path, but we now need to figure out if a path is a
    directory before deciding to exclude it.  This is especially bad
    because an idea similar to the earlier CE_UPTODATE optimization
    to reduce number of lstat(2) calls would by definition not apply
    to the codepaths involved, as (1) directories will not be
    registered in the index, and (2) excluded paths will not be in
    the index anyway.
===

The patch is included in 1.5.5.

Dmitry
