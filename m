From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-gui: more issues with diff parsing
Date: Fri, 12 Sep 2008 11:01:15 -0700 (PDT)
Message-ID: <m3ljxxnt09.fsf@localhost.localdomain>
References: <200809091030.04507.barra_cuda@katamail.com>
	<20080912152345.GE22960@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 20:02:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeCyS-0005Fk-08
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 20:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbYILSBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 14:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbYILSBT
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 14:01:19 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:38300 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbYILSBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 14:01:19 -0400
Received: by gxk9 with SMTP id 9so19856696gxk.13
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 11:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=wE8+rCS2aylEjzW+5M5JDkVm6osnsO5eBsXfcwrFIxc=;
        b=oHuw3AaJXY4j6F7SzsvSwRn8kv43v40Gne2gsvwbjOjWyr45rIPPrRF6ma9AuXHKqc
         HCwlM5cdA/pR0ljmWL9n3aJtxdx6POUt9niXANQYvxoZx67WcURjT3tttQG2UwjLmpPT
         YEU9aJyGoIy8rgJR/lnjvixwzxj/Ce4Ylcfa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=G0jL3LRwK89plt7kUrP5KBs9PBdqzVAvDdGUsfLj4B69O2Dv6mxxZRF6x8uUrqu4kx
         AVXwuJtKXROHjqwbgeQBjem7RGah60o8xuBi7bq3FwRdRSiJLv43yaeAGWeH65NUNalo
         EENTGrCkq+gOiDH73lQ4F5i4OlzWrrlXYRBho=
Received: by 10.86.26.1 with SMTP id 1mr3454805fgz.35.1221242476598;
        Fri, 12 Sep 2008 11:01:16 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.211.228])
        by mx.google.com with ESMTPS id l12sm13179074fgb.6.2008.09.12.11.01.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Sep 2008 11:01:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8CI1DeT019871;
	Fri, 12 Sep 2008 20:01:13 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8CI1BEl019868;
	Fri, 12 Sep 2008 20:01:11 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080912152345.GE22960@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95755>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> The diff is weird:
> 
>   $ git-diff-index --cached -p --no-color -U5 \
>       d6e02aa06c91c711d98ae06e6e69c5de5841a5e5 -- g
>   diff --git a/g b/g
>   deleted file mode 100644
>   index e69de29..1a010b1
>   diff --git a/g b/g
>   new file mode 120000
>   index e69de29..1a010b1
>   --- /dev/null
>   +++ b/g
>   @@ -0,0 +1 @@
>   +file
>   \ No newline at end of file
> 
> Notice how we get two diffs for the same file?  That's why git-gui
> is choking on this particular change.  It expected only one diff
> for the path it gave to Git.  It got two back.  In cases like this
> we may not be able to support line or hunk application as the patch
> is really two different patches against that path.  :-|

Hmmm... it looks _exactly_ like a problem I had with writing
"syntax highlighting" (and linkage) for the patchset part of
'commitdiff' and 'blobdiff' views, namely that typechange
(file to symlink and vice versa) generates two patches for
single difftree (raw diff format output) line.

See git_patchset_body in gitweb/gitweb.perl, and is_patch_split
function, and commit message of 0cec6db (gitweb: Fix and simplify
"split patch" detection), which tells about alternate solution.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
