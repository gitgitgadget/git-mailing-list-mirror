From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Can git be stopped from inserting conflict markers during a merge?
Date: Sat, 08 Mar 2008 13:03:18 -0800 (PST)
Message-ID: <m3ve3xexnw.fsf@localhost.localdomain>
References: <loom.20080308T174918-559@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Tanksley <wtanksleyjr+git@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 22:04:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY6DP-00069b-43
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 22:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbYCHVDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 16:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbYCHVDW
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 16:03:22 -0500
Received: from gv-out-0910.google.com ([216.239.58.185]:45383 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbYCHVDV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 16:03:21 -0500
Received: by gv-out-0910.google.com with SMTP id s4so440078gve.37
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 13:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=3TyIAfAd0UDCfReFDj+GzXyWp7cG7YXYdVcc+taZyfo=;
        b=wEernxCgNXgWx4Zsn7H67/kOyWXk1meDEfSI00Ar8C/XV/ejWtDfafrjLgEc2ZM7zN4TzH5X3Uk3O79GF7zA04Q1wYSS8ImEgLdQSMC5gw/i6UhApRvCwNwWUR3QBb3enYZugQKy4EarpqCfBwqQAamwI0wiMqZlenSNcngsqAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=i/e2/3eCHA34PjNCcP0M5MagQauFLWiyxzJne6mavh5fOG2Piv2XOR5Xw4p5Y1YTikbfp6yxOXFZJmN+nqXSqJ6pB722YanN/WDXnSO4ZXaz2TzNMea11aHa5obrl3VLDDPKpkHmoOPGBAJYjGfCZ6MSAQ9MSbstxpG8uit5O6k=
Received: by 10.78.90.10 with SMTP id n10mr8693047hub.79.1205010199044;
        Sat, 08 Mar 2008 13:03:19 -0800 (PST)
Received: from localhost.localdomain ( [83.8.251.176])
        by mx.google.com with ESMTPS id u7sm7125382uge.35.2008.03.08.13.03.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Mar 2008 13:03:18 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m28L3Nar018216;
	Sat, 8 Mar 2008 22:03:23 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m28L3F2t018211;
	Sat, 8 Mar 2008 22:03:15 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20080308T174918-559@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76585>

William Tanksley <wtanksleyjr+git@gmail.com> writes:

> I started using Mercurial a while ago, and I'd like to move up to
> git (for a number of reasons). The one thing that's stopping me is
> that (having recently escaped Subversion and CVS) I'm now used to
> NOT having to worry about conflict markers being shoved into
> files. To put it simply, I really like how Mercurial does that one
> thing.
> 
> So, given the Git is probably the ultimate in configurability, what
> do I need to do to make it not insert merge markers?

First, if you simply enable installed by default (but not enabled)
pre-commit hook, by making it executable:

  $ chmod a+x .git/hooks/pre-commit

it would detect merge markers in changes, and would prevent committing
with "unresolved merge conflict (line <n>)" message[*1*].

You can of course bypass pre-comit and commit-msg hooks with
--no-verify option, for example if committing merge test case, or if
hooks misdetects asciidoc markup for merge conflict markers.


Second, you can change default file-level (file contents) merge driver
to the one used for binary files; it would leave 'ours' version on
disk instead of merged file with merge conflict markers[*2*][*3*] 

Simply add the following to the repository configuration in
'.git/config', or to global (user) git configuration in
'~/.gitconfig', or if you are admin you can even add it to system wide
git config '/etc/gitconfig' although I wouldn't recommend last one:

   [merge]
   	default = binary

Or if you prefer scripted solution,

  $ git config merge.default binary

(this would change repository config: read git-config(1)).


Footnotes:
==========
[*1*] It also detects "trailing whitespace" and "indent SP followed by
      a TAB" errors; whitespace errors can be detected by git-commit
      iself with --cleanup=<mode> option and/or gitattributes.
[*2*] Sample session below:

[master!test]$ git version
git version 1.5.4.2
[master!test]$ git show master:foo
HELLO
hello
[master!test]$ git show side:foo
HELLO
hello side
[master!test]$ git merge side
Auto-merged foo                           # [*4*]
CONFLICT (content): Merge conflict in foo
Automatic merge failed; fix conflicts and then commit the result.
[master!test]$ cat foo 
HELLO
<<<<<<< HEAD:foo
hello
=======
hello side
>>>>>>> side:foo
[master!test]$ git reset --hard HEAD
[master!test]$ git config merge.default binary
[master!test]$ git merge side
Auto-merged foo
CONFLICT (content): Merge conflict in foo
Automatic merge failed; fix conflicts and then commit the result.
[master!test]$ cat foo 
HELLO
hello

[*3*] If you want to do this only for some files, you can use
      gitattributes feature.
[*4*] I wonder about this "Auto-merged foo" message...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
