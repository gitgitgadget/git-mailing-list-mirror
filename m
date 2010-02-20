From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Possible bug with git status in 1.7.0
Date: Sat, 20 Feb 2010 12:05:02 +0100
Message-ID: <4B7FC1DE.2020802@gmail.com>
References: <loom.20100217T184109-183@post.gmane.org> <7vvddvoegv.fsf@alter.siamese.dyndns.org> <4B7C490B.8030902@gmail.com> <4B7C5711.8060708@web.de> <4B7EBF7B.3090703@gmail.com> <4B7EFAD8.9040309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Feb 20 12:05:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nin9B-0008EA-GX
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 12:05:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200Ab0BTLFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 06:05:11 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52710 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab0BTLFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 06:05:09 -0500
Received: by vws11 with SMTP id 11so347378vws.19
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 03:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=4XhSi5aVV4jUABYelJlw4cRbJsY2nMe3zry9dYYQsxI=;
        b=fkeY8FYOviIkV7CsMPkTdP1gvukWPGb3H6Eu91kYAa7AGqoVA9sBLqq4zwrL8mKJqJ
         w79PsMF+3WdNTqWKjKgAzsR9gy07AzeyEO4ga+cxHyJulLGQxXSMPTCgD7AB6l0AB+ZH
         GFfP+0FCnl9r87h6RDWXfg8HSWmSeALVk6Qc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=D/tv5/a1LHrD0iCzAGWHETvgRc5zUwWjyifo8pFN9xpL2bqwBUt3TPZMsxgDh2aJ5v
         EZdA5LG6F6kuoH4d5U11NcsWv3WpeBOLjjsJ+eKd7CGui7C8TaJG9Ew9krVny0EyxXjh
         DnZmx6TqapuQFoMJLHoeFRC/vuOn5422Mi9Oo=
Received: by 10.220.88.170 with SMTP id a42mr5208143vcm.144.1266663906591;
        Sat, 20 Feb 2010 03:05:06 -0800 (PST)
Received: from ?192.168.1.101? (adsl-ull-240-174.51-151.net24.it [151.51.174.240])
        by mx.google.com with ESMTPS id 35sm10341591vws.0.2010.02.20.03.05.03
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 03:05:04 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4B7EFAD8.9040309@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140525>

Jens Lehmann wrote:
> Yup, one line per submodule should be enough. But maybe it's nicer to
> have the details /after/ the submodule name:
>
> #	modified:   mod1 (Submodule has new commit(s), modified content, untracked content)
>
> Then it fits more nicely with the output for files, no?
>
> We could drop the "Submodule has " if people see it as a waste of screen
> estate. Also i have no strong feelings about "content", i just happen to
> think it is more appropriate as submodules can contain not only files but
> other submodules too. Opinions?
>
> Will send a patch for discussion as soon as i have something to show ...
>   
How about

#	modified:   mod1 (submodule: new commit(s), modified content, untracked content)

trying to assure that what comes after the ":" is a list of comma 
separated properties.

This can make the thing easier to parse.  I know that there is a "git 
status ---porcelain" but from my understanding it will not be possible 
to get this kind of information from that command since its output 
format is frozen and not extensible, so many could resort to try to 
parse the "normal" git status output to get all the info about 
submodules at once.

Even better would be to have a "--interface_level 2" to go with 
---porcelain, to be able to pass this info even there.

BTW... about the --porcelain option, I wonder if considering an alias to 
--parseable could be on the list.  The plumbing/porcelain metaphor is 
really nice, but a --porcelain option can probably be a bit confusing 
for the beginner getting a

usage: git status [options] [--] <filepattern>...

    -v, --verbose         be verbose
    -s, --short           show status concisely
    --porcelain           show porcelain output format
    -z, --null            terminate entries with NUL
    -u, --untracked-files[=<mode>]
                          show untracked files, optional modes: all, 
normal, no. (Default: all)

considering that status is probably the first command the beginner may 
come into.

Sergio
