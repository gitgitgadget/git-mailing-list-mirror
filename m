From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 09:50:20 -0800 (PST)
Message-ID: <m3d4t3q4e5.fsf@roke.D-201>
References: <20071218173321.GB2875@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 18:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4gb9-0006Sj-Pc
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 18:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760895AbXLRRuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 12:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756533AbXLRRuZ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 12:50:25 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:44500 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbXLRRuX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 12:50:23 -0500
Received: by mu-out-0910.google.com with SMTP id i10so3577808mue.5
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 09:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=tR5RxgLewTiZ7yT8JRtjNgN63++QcOqfaX4tlmkINhY=;
        b=pU7ZdrsWJAz2iBjW8DiWDiWn1ZUzhMe+uT3KBREI/3Yaq6MPSd9DzEag+/995xQsbnE+cJX3yUAi64BeJs6JyML1BPiGSVLZAqYAo2eXFmFI9YsZ7cwF/snrsquVqjBEWIgUseX5d75lQObbE1UlyqwsHJhggN5eqOjorzWfwB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=MgPsTVAlJGQJDv2P5vIXOGNtk7EIplCEHE2/gcnZf67y+FpsVeeiOOzsFRvDrsGu3a6T4gusuIQ6XBC6nuqz/mkd+fEAgglindamlrHIQCNyCipFnw6cND5vJXEL3s7b1B0wClEZI0aJziQfCg9F/aBp9q5ZxxnUp7TvUdpOukw=
Received: by 10.86.82.16 with SMTP id f16mr7903019fgb.60.1198000221927;
        Tue, 18 Dec 2007 09:50:21 -0800 (PST)
Received: from roke.D-201 ( [83.8.255.201])
        by mx.google.com with ESMTPS id 4sm2526763fgg.2007.12.18.09.50.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 09:50:20 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBIHoBEB018140;
	Tue, 18 Dec 2007 18:50:11 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id lBIHnsa2018136;
	Tue, 18 Dec 2007 18:49:54 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20071218173321.GB2875@steel.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68788>

Alex Riesen <raa.lkml@gmail.com> writes:

> Noticed by a collegue of mine. Consider:
> 
>     $ cd $GIT/t
>     $ git show 570f32266:t/test-lib.sh    # works
>     $ git show 570f32266:test-lib.sh      # does not work
>     $ git show 570f32266:./test-lib.sh    # does not work
>     $ git show 570f32266:/t/test-lib.sh   # does not work
> 
> Considering that the relative path names work as filters (and many
> agreed on that being useful), it would be nice to allow relative
> pathnames in blob specifications for git-show and git-cat-file.
> 
> (besides the colon is a good delimiter, even tab-completion works with it)

If you think about it a bit, relative path names nor absolute
path names does and should not work.  570f32266:t/test-lib.sh
means path t/test-lib.sh staring from 570f32266^{tree}.  Where
you are in the filesystem is not important and matters not for
this syntax.  Besides if you access other branch file might be
not in filesystem (deleted file, or disjoint branch with separate
contents like 'todo' or 'html' branch in git.git repository).

Besides,

    $ git show 570f32266:t/test-lib.sh    # works
    $ git show cc5ac8b72:test-lib.sh      # also works

works... but 49d8bcd7a2df5 here is SHA-1 id of a 't/' tree
(shortened output of "git rev-parse 570f32266:t").

And I think that with bash-completion from contrib you complete
correct pathnames; don't rely on filesystem pathnames completion.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
