From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 00:57:25 +0200
Message-ID: <200610180057.25411.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <200610172351.17377.jnareb@gmail.com> <4535590C.4000004@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 00:57:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZxro-0000w4-Mr
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 00:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWJQW44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 18:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWJQW44
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 18:56:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:12592 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750999AbWJQW4z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 18:56:55 -0400
Received: by ug-out-1314.google.com with SMTP id o38so65444ugd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 15:56:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=iv/jDtO0OAvoelT6Zok14kdBJCrKyIcSyIA/wpgphHUyRN5Cp8+tINwOa0vE85OZsqrUCLeZfoI/q6GxHVFfY93uJknKOiL3mq6tS+cLt9Qa9wWFVCqiQ+3eVU9by2mh3zOIX+mvFEYreE8Az9EBtZXWzFKDZggg7O3Lkr8+Ypo=
Received: by 10.67.117.18 with SMTP id u18mr10687937ugm;
        Tue, 17 Oct 2006 15:56:53 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id e1sm246727ugf.2006.10.17.15.56.52;
        Tue, 17 Oct 2006 15:56:52 -0700 (PDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
User-Agent: KMail/1.9.3
In-Reply-To: <4535590C.4000004@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29130>

Aaron Bentley wrote:
> Jakub Narebski wrote:
>> Aaron Bentley wrote:
> 
>>> What is the bad side of using merge in this situation?
>>
>> We want linear history, not polluted by merges. For example you cannot
>> send merge commit via email.
> 
> Oh.  Bazaar supports sending merge commits by email.
> 
>> Another problem is that you want to
>> send _series_ of patches, string of commits (revisions), creating feature
>> part by part, with clean history; with merge you get _final result_
>> which will apply cleanly, with rebase you would get that series
>> of patches will apply cleanly.
> 
> Yes, that's something that I'd heard about the kernel development
> methodology-- that a series of small patches is preferred to one patch
> that makes the whole change.
> 
> That's not the way we operate.  We like to review all the changes at
> once.  But because bundles are applied with a 'merge' command, not a
> 'patch' command, an old bundle will tend to apply more cleanly than an
> old patch would.

Perhaps it would be nice to have "bundles" in git too. As of now
we can save arbitrary part of history in a pack, but it is binary
not textual representation.

Some of git workflow stems from old, pre-SCM Linux kernel workflow
of sending _patches_ via email.


By the way, are bzr "bundles" compatibile with ordinary patch?
git-format-patch patches are. They have additional metainfo,
but they are patches in heart.
  
>>> and more.  Because Python supports monkey-patching, a plugin can change
>>> absolutely anything.
>>
>> Which is _not_ a good idea. Git is created in such way, that the repository
>> is abstracted away (introduction of pack format, and improving pack format
>> can and was done "behind the scenes", not changing any porcelanish (user)
>> commands), but we don't want any chage that would change this abstraction.
> 
> I'm not sure what you think Bazaar does.  In Bazaar, a repository format
> plugin  implements the same API that a native repository format does.
> 
> This is how bzr supports Subversion, Mercurial and Git repositories.

But if I remember correctly Subversion does not remember merge points
(merge commits), so how can you provide full Bazaar-NG compatibility
with Subversion repository as backend? Some repository formats lack
some features. Besides, as I said repository database and stuff is
quite well abstracted away.

In git we have import tools (most of them capable of incremental import),
a few exchange tools like git-cvsexportcommit, git-cvsserver, and
Tailor-like git-svn.
 
>> Changing repository format is not a good idea for "dumb" protocols;
> 
> I can't parse this.  Repository formats and protocols are different
> things, right?

"Dumb" protocols in git are protocols for which server provides access
to contents git repository plus some additional info (usually generated
using hooks). The client (be it git-fetch or git-push) discovers which
files to download or what to upload, but it only can download repository
"as is". So if server repository was created with repository format plugin,
and client doesn't have said plugin, you are out of luck.
 
>> native protocol is quite extensible
> 
> I was meaning dumb protocol extension.  I can't say how extensible the
> bzr native protocol is.

Native git protocol (git:// and git+ssh://) does feature discovery, then
negotiates what contents has to be send, and finally tries to send minimal
number of objects.

>> Adding
>> cURL based FTP read-only support to existing HTTP support was a matter
>> of few lines, if I remember correctly.
> 
> We support read and write over native, ftp and WebDAV (a plugin).  We
> also have readonly http support.

Git has read-only access over git:// protocol (served by git-daemon on
port 9418), read-write access over git+ssh:// protocol (you can limit
exposition using git-shell), read-only access via HTTP, HTTPS, FTP "dumb"
protocols, read-write access via WebDAV "dumb" protocol.

Git is open-source, we don't need plugins ;-)
-- 
Jakub Narebski
ShadeHawk on #git
Poland
