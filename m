From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] builtin-config: add --exec-editor for use in scripts
Date: Mon, 02 Feb 2009 01:56:57 -0800 (PST)
Message-ID: <m3pri1w484.fsf@localhost.localdomain>
References: <20090201025349.GA22160@dcvr.yhbt.net>
	<7v4ozdo7yt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 10:58:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTvZW-0007bI-F0
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 10:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbZBBJ5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 04:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbZBBJ5D
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 04:57:03 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:35244 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbZBBJ5A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 04:57:00 -0500
Received: by fg-out-1718.google.com with SMTP id 16so532238fgg.17
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 01:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=NLgTGID5lheCwOf4MLehXvdU32LbD86Ei+2+33s01MQ=;
        b=XxkI+eIpqpyzXOlXRhqpTzsCcAU+2Vr5ub3Ny1qqQysV/kI//t/+2+nqcMYJq9kCGN
         RA5sQABxhZGEbXvo3hYkEj+p6Q4ODCCZGp0uUAfkJGC49qikrhRdjkdSHKz5DJGB7/Qk
         +ELBfiMCs23lUPzsIHf12Fp2RkKW1JqdsS4fI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=cg9HJ6KsLOH1SQ7lyXlXAdVZOXLW4RZzrFZbVGrpPmjfgGV0t80eFJta6OJr90WA0e
         lt+ZnWvCX/uVrqxsB/r767FPRmnxrZ2SqGjc92p/dqqPRIusEzIHD260x0zz//kJ5Ys+
         r/8GLMxmvmlFD7eP6jumRLYKx7/8tQCerby/E=
Received: by 10.86.3.4 with SMTP id 4mr483926fgc.41.1233568617947;
        Mon, 02 Feb 2009 01:56:57 -0800 (PST)
Received: from localhost.localdomain (abwn190.neoplus.adsl.tpnet.pl [83.8.237.190])
        by mx.google.com with ESMTPS id 12sm47662fgg.23.2009.02.02.01.56.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Feb 2009 01:56:57 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n129vmmn013204;
	Mon, 2 Feb 2009 10:57:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n129vl4U013200;
	Mon, 2 Feb 2009 10:57:47 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v4ozdo7yt.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108076>

Junio C Hamano <gitster@pobox.com> writes:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > This exposes the launch_editor() library function for use by
> > various scripting languages.  This allows the ensure consistent
> > handling of GIT_EDITOR/VISUAL/EDITOR environment variables as
> > well as the handling of special characters such as spaces in the
> > various environment variables.
> >
> > Signed-off-by: Eric Wong <normalperson@yhbt.net>
> > ---
> >
> >  I'm not sure if git-config is the best place to stick it.  I plan to
> >  start using this in git-svn but I don't want to implement Git::Editor
> >  in Perl and have to keep track of editor.c.  Of course this also makes
> >  the logic/rules used in libgit usable to any other scripting language
> >  capable of launching other programs.
> 
> I agree that git-config is probably a wrong place.  A separate command
> "git editor" (or "git user-preference --editor", if you extend it to pager
> and others) perhaps?
> 
> I also agree that something like this would make scripting Porcelains a
> much pleasant experience.

I don't think this is something that should be put in 'git rev-parse',
but perhaps a bit obscure 'git var' (print a git logical variable)
would be a good place for that?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
