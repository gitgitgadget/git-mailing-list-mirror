From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More git status --porcelain lossage
Date: Fri, 09 Apr 2010 12:22:22 -0700 (PDT)
Message-ID: <m3ochsh1oc.fsf@localhost.localdomain>
References: <20100409190601.47B37475FEF@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Raymond <esr@snark.thyrsus.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 21:23:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0JnU-0006Ro-HZ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 21:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105Ab0DITWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 15:22:36 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:50459 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755508Ab0DITWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 15:22:25 -0400
Received: by fxm23 with SMTP id 23so3051666fxm.21
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=u2QO5GMblslN0YM5c6cQSOxk+qnFP2hpBxfAkr92KHY=;
        b=oeNeqPgIHLEDtIOPkknuh3sJMoqDc4/As1s3dyg0X3QUOtItQ+BGxSoelkJBhinl7s
         63TMP2FoVXeRa5gEJjP7rPriLeNpYcYu4SD+shNxBgHhYYrWMS01fPUUJBNCGeDjOoGO
         ZEV8ZdZrUQvf2fSgBGIGcVddGtau+2PGgzmn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=xZLeSVUxlkfXUGxZdpKJEP065Z64pGN8tX4HgLBaKqgajlWFYqajJR9afznJdgC8LB
         DAolZa+Y9Bb2DAj6mOg/zfLJLu2ZYtH6c4wy3HBjM0oHqSMAhAp4Tizs4dt00zd3JBBi
         YI7WD3f/thqEn1g03di9iHFpsVIoZLhAEGQ1w=
Received: by 10.103.84.1 with SMTP id m1mr272634mul.26.1270840943650;
        Fri, 09 Apr 2010 12:22:23 -0700 (PDT)
Received: from localhost.localdomain (abvc167.neoplus.adsl.tpnet.pl [83.8.200.167])
        by mx.google.com with ESMTPS id j10sm6803545muh.58.2010.04.09.12.22.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 12:22:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o39JLvML017280;
	Fri, 9 Apr 2010 21:22:08 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o39JLe3F017275;
	Fri, 9 Apr 2010 21:21:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100409190601.47B37475FEF@snark.thyrsus.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144460>

Eric Raymond <esr@snark.thyrsus.com> writes:

> After I posted my last, I noticed another crash landing...
> 
> A format properly designed for script parseability should use even use
> whitespace as a field separator.
> 
> Why?
> 
> Because if you do that, front ends *will* do field analysis using a
> naive split-on-whitespace operation.  And then...someday...someone
> will try to run one of these of these on a volume from a system where
> filenames contain embedded whitespace.  Like Mac OS X or Windows.
> 
> Hilarity will ensue.
> 
> Conclusion: As it is presently, git status --porcelain format is
> irretrievably botched.  You need a field separator that's musch less
> likely to land in a filename, like '|' - and to warn in the documentation
> that careful front ends must check for and ignore '\|'. 

Or follow what other porcelain does, like git-diff-tree raw output
format, where all fields except final filename are space separated,
filename is separated by tab character (or NUL when '-z' options is
used).  If there are two names (in the case of copy or renames),
they are separated by a tab (or NUL).  Record ends with LF (or NUL).

When '-z' option is not used, TAB, LF, " and backslash characters
are represented by '\t', '\n', '\"' and \\, and the filename is
enclosed in '"' doublequotes.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
