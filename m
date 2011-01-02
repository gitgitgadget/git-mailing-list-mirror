From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Consistent use of AC_LANG_PROGRAM in configure.ac and
 aclocal.m4.
Date: Sun, 2 Jan 2011 04:00:12 -0600
Message-ID: <20110102100012.GA12284@burratino>
References: <20110102060044.GJ19818@gmx.de>
 <20110102075953.GB8937@burratino>
 <20110102094730.GA10365@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 02 11:00:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZKjt-0004VQ-0f
	for gcvg-git-2@lo.gmane.org; Sun, 02 Jan 2011 11:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931Ab1ABKAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jan 2011 05:00:23 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55430 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab1ABKAW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jan 2011 05:00:22 -0500
Received: by iyi12 with SMTP id 12so11395122iyi.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 02:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=i55wwVk3YV/zZwlrZTjJzMCKH90P8YqDONuSaD/ZEKE=;
        b=b6iAX3maC+STVuf7G/QuLthU1GRbJtjZ1ajQ2U8u07vAa8MVRqq/pZEhWPoKBahDYO
         NP7fhJfdB7rqc1pd9Rid/loJUBEpNcaKxBlgQqalpCMaPvxhDpMEiz3niHIcL9AFBU5c
         6/bDIEha5UEIv8wgEEj17u5jff7IUq/xvTM2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jCzBuL+7ExVr3CgIWWdoZYLxUbgMa8LFd3tUjtTbNtBnGki/YSDEOhnR0H912qPFqt
         ISLByxYL/fAZCqyoi0EOfyQbC+fcX7iNSbYy1rLGOlWmU0OwfDa8u5ILLTfvl9m+pios
         smHrMMo6cNXyQfvAsm2fh1VUw9F5UbF8zPUyA=
Received: by 10.231.30.76 with SMTP id t12mr5925886ibc.193.1293962421319;
        Sun, 02 Jan 2011 02:00:21 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id 8sm17534058iba.10.2011.01.02.02.00.19
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 02:00:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110102094730.GA10365@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164415>

Ralf Wildenhues wrote:

> See above.
>
> I would be happy to update the patch in a way that makes it more
> helpful, but most of the above is fairly general Autoconf rules,
> so I'm not sure what you need (being blinded by looking at this
> stuff too often).

A little essay in the commit message should be sufficient.  Something
vaguely like this, maybe.  (cut and pasted from the above)

 This avoids warnings from Autoconf 2.68 about missing use of
 AC_LANG_PROGRAM and friends.

 Allow me to quote autoconf-2.68/NEWS:

   ** The macros AC_PREPROC_IFELSE, AC_COMPILE_IFELSE, AC_LINK_IFELSE, and
      AC_RUN_IFELSE now warn if the first argument failed to use
      AC_LANG_SOURCE or AC_LANG_PROGRAM to generate the conftest file
      contents.  A new macro AC_LANG_DEFINES_PROVIDED exists if you have
      a compelling reason why you cannot use AC_LANG_SOURCE but must
      avoid the warning.

 The underlying reason for this change is that AC_LANG_{SOURCE,PROGRAM}
 take care to actually supply the previously computed set of #defines
 (and include the standard headers if so desired), for preprocessed
 languages like C and C++.

 In some cases, AC_LANG_PROGRAM is already used but not sufficiently
 m4-quoted, so we just need to add another set of [quotes] to prevent
 the autoconf warning from being triggered bogusly.  Quoting all
 arguments (except when calling special macros that _need_ to be
 expanded before recursion) is better style, anyway.  These and more
 rules are described in detail in 'info Autoconf "Programming in M4"'.

 The patch should not cause any semantic changes in the generated
 configure script.

 Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
