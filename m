From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use Git.pm, and use its parse_rev method for git_get_head_hash
Date: Sat, 31 May 2008 02:40:13 -0700 (PDT)
Message-ID: <m3lk1q24nb.fsf@localhost.localdomain>
References: <1212188412-20479-1-git-send-email-LeWiemann@gmail.com>
	<484087A7.2030107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 11:41:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Nak-00044g-9a
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 11:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbYEaJkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 05:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbYEaJkT
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 05:40:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:58627 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbYEaJkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 05:40:16 -0400
Received: by ug-out-1314.google.com with SMTP id h2so56462ugf.16
        for <git@vger.kernel.org>; Sat, 31 May 2008 02:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ZkGoUcI5QcFwKKrz12aab6BzG8VU+eNCAZsBUr+4te4=;
        b=lGjEFePqPIifbUFhB6tnrFWD/CJdROPvGGdJfsgjpodt00I9Nzmg2V8FcXbO1enp1T
         NZVBaFXh7/2kMAe976rC8EcikWl7oUKUDdcbXtzSJx3GAga/57RrdFyJvakN7VvQjGVb
         mDRYJfmIB5vbas/w1iP5IpXLp2pBHRdBHg1YY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=sU4NxPf/fj36Zyl+f7qx3fMYK16Tqv4IOGYWb+Q63s5Ez+jHBM+xVGpiamfDdqiwQ1
         x4tPUCOlMVNT+N6GJDQ4Rfy7QN5f+9ML9SuDq/OxzKKYh2/MusMjSXxqUpp/alplpIsj
         7uzT0GHLaZU0wgDooA93jXCNQBCXwM4oM3IR0=
Received: by 10.66.216.7 with SMTP id o7mr517466ugg.69.1212226815162;
        Sat, 31 May 2008 02:40:15 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.238.103])
        by mx.google.com with ESMTPS id e34sm1589797ugd.38.2008.05.31.02.40.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 02:40:13 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4V9e9sh030057;
	Sat, 31 May 2008 11:40:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4V9e9bd030054;
	Sat, 31 May 2008 11:40:09 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <484087A7.2030107@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83368>

Lea Wiemann <lewiemann@gmail.com> writes:

> Lea Wiemann wrote:
> > Subject: [PATCH] gitweb: use Git.pm, and use its parse_rev method
> >          for git_get_head_hash
> 
> For clarification, this is my first patch for refactoring Gitweb to
> use Git.pm's API.

Good.

I'm not sure however how much of gitweb engine should be moved to
Git.pm.  I think calling git commands could be moved from git_cmd() to
command_output_pipe() or command_oneline(), replacing global variable
$git_dir by global variable $repo.  Perhaps gitweb's config file
parsing should be added as an option to Git.pm.  But I'm not sure for
example about parsing subroutines.

> In the end, I'm hoping that all (or at least most) of Gitweb's
> accesses to the repositories will go through this API, which allows us
> to add caching to the Git.pm API (rather than Gitweb) pretty easily
> and cleanly.

IMVHO caching command output is bad idea.  I'd rather have gitweb
cache _parsed_ data (i.e. Perl structures).

For example projects list (but also summary page for a project) is
composed as result of parsing output of _many_ git commands, in the
case of projects list coming from many different repositories.
Caching git command output (something like IPC::Cmd::Cached?)
would only repeat bad I/O patterns of git commands.

Also I don't think it is a good idea to pollute Git.pm by caching
command output.  Perhaps in Git::Cached, but as a last resort...

P.S. Here it is what could go to Git.pm:
 * Eager config parsing, using e.g. $repo->parse_config() to prepare
   %config hash, and have $repo->config(VAR) etc. use %config hash.
   This means one git command and not one git command per variable,
   but it also means that we have to convert to bool or int, or color
   in Perl.
 * unquote() (which is not repository instance merhod, but utility
   subroutine) to unquote and unescape filenames.
 * generating rfc2822 and iso-8601 dates from timestamp plus timezone,
   i.e. from author/committer/tagger date; it would be useful for
   example in git-send-email.

I'm not sure about parse_* subroutines (some of which are not generic
enough, I guess).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
