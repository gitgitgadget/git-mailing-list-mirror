From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] difftool: add support for an extended revision syntax
Date: Fri, 27 Mar 2009 08:59:39 -0700 (PDT)
Message-ID: <m33acz2byv.fsf@localhost.localdomain>
References: <1237803348-9329-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 17:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnEUe-0003DP-5W
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 17:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbZC0P7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 11:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753706AbZC0P7o
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 11:59:44 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:65471 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214AbZC0P7n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 11:59:43 -0400
Received: by ewy9 with SMTP id 9so1120188ewy.37
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 08:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=irKh4z5F1CsmQ0mv7Ezmjq0dL86ClMzEnCgbZXTk/Dc=;
        b=QKeZwXjp/z7lNn+p8KaseijOHzSrPFpxoLm4ez173RTowmhkn0ey1QnWSjGdqP4BY/
         YIsElfVk2znhfv6PtbDaVg/bDAm2Z+/kmx7iLrfI6YYFLiGNqzyjn20pAuB+bCsyBdXp
         U9h5sEmdSBmLLuYHnX9fUtVNimRXbkyaaQ0hs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=WwPduZEWvMlM+efQq72kDdpcAKOyaAJO879L/jUBOdp4Dws8DjQhU+b0xOdZVN8AQ8
         WroMRgX5UJDQwpcvN0SzdcdRRtEumPHgdj68cP7zJRZrwNie4LdkfcAzgOaLK05FFIk9
         vZnx9UIMIN1MHEoE7D8UMJftYjPT8wYqERVfg=
Received: by 10.216.24.206 with SMTP id x56mr895138wex.39.1238169580520;
        Fri, 27 Mar 2009 08:59:40 -0700 (PDT)
Received: from localhost.localdomain (abvq19.neoplus.adsl.tpnet.pl [83.8.214.19])
        by mx.google.com with ESMTPS id q9sm2452453gve.27.2009.03.27.08.59.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 08:59:39 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n2RFxbU4009683;
	Fri, 27 Mar 2009 16:59:38 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n2RFxbBf009680;
	Fri, 27 Mar 2009 16:59:37 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1237803348-9329-1-git-send-email-davvid@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114905>

David Aguilar <davvid@gmail.com> writes:

> This adds an extended revision syntax to git-difftool.
> Users often ask "how do I compare a file against its
> previous version" and the answer is typically a combination
> of 'git log <file>' and 'git difftool <sha1> <sha1> <file>'.
> 
> This makes answering that question considerably easier.
> Users can now simply say:
> 
> 	$ git difftool <file>~
> 
> to compare <file> in the worktree against its
> previous version, and:
> 
> 	$ git difftool <file>~2 <file>~
> 
> to compare <file> from 2 versions ago to <file>'s
> previous version, etc.

Because <rev>~<n> means (see git-rev-parse(1) for example) n-th parent
in _first parent_ line, then <file>~<n> should also use first-parent
line, otherwise you invite confusion.

Also I am not sure about the syntax, as there are no restrictions on
filenames, and filenames can contain '~'.  Perhaps (proposed in this
thread) ~<n>:<file> == 
  "$(git rev-list -n <n> --first-parent HEAD -- <file> | tail):<file>"

But this might be mistaken for HEAD~<n>:<file>, which can be something
else...
 
> The extended revision syntax also expands revisions
> that are suffixed with '!' as a convenient way to
> see commit diffs.  Specifying only '!' is equivalent
> to specifying 'HEAD!'.
> 
> This makes the following statements equivalent:
> 
> 	$ git difftool !
> 	$ git difftool HEAD!
> 	$ git difftool HEAD~ HEAD

Errr... there already exists such syntax, and it is called HEAD^!
(if git-difftool can accept a..b revision specification)... or not,
as git-rev-parse(1) states:

  r1^! includes commit r1 but excludes all of its parents.

So depending on how "r1 --not r1^" and "r1 --not r1^1 r1^2" is
interpreted by diff (which accpets points, not ranges) it might be, or
might be not what you wanted by introducying '!' / <rev>:!
specification...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
