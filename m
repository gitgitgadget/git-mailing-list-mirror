From: "David Aguilar" <davvid@gmail.com>
Subject: Re: Git - Pushing to a production website
Date: Sat, 10 Jan 2009 03:04:17 -0800
Message-ID: <402731c90901100304w2ed740e0gdcb41381a41a7f5d@mail.gmail.com>
References: <20090109222344.3539138a@family.dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: 4jxDQ6FQee2H@dyweni.com
X-From: git-owner@vger.kernel.org Sat Jan 10 12:06:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLbez-0002av-GY
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 12:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbZAJLET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 06:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753629AbZAJLET
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 06:04:19 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:52268 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbZAJLES (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 06:04:18 -0500
Received: by rv-out-0506.google.com with SMTP id k40so9345407rvb.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 03:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VRRCxmjVqpk/S6skUT7hvDBLmsF6WDLcMsfwuBdozeM=;
        b=mHNqBmzfpFjzpNRrI2s9/kyZ4eBknO5SQJPpW5BtoiNl2ducpsgo6hvHZRe7jtehgx
         YGbrxRphOCd7Dtz54QlyrpuCDtOK6gFUE5p6ph0IWkPkKXCztr8qfhIOVB4FvXD+f8Rn
         kvt7GMUOoEp/HGb4XOpN+GUiI5RPndtRwOfKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HY2RYTvTsbBudX+9cfHDcb+s0x/WeUuPGJRZJqL7FsSqu5gfGpuuax+Pw4OVnzsQrR
         YeutB7jZ+EKl4gIOnXgznVg+q97JxgBK9nUztUUnf8EVwed5tD+oyMPUp0z9KlxjJR/Q
         0w49xYTwIhDEsZ4PX0em+E7k+HjsedfId/2pY=
Received: by 10.142.240.19 with SMTP id n19mr11165944wfh.10.1231585457607;
        Sat, 10 Jan 2009 03:04:17 -0800 (PST)
Received: by 10.142.241.20 with HTTP; Sat, 10 Jan 2009 03:04:17 -0800 (PST)
In-Reply-To: <20090109222344.3539138a@family.dyweni.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105091>

On Fri, Jan 9, 2009 at 8:23 PM,  <4jxDQ6FQee2H@dyweni.com> wrote:
> Hi,
>
> Our company's website is stored in a GIT Repository.
>
> The repository is coded for our test server.  When we push updates to
> the production server, have manually run a script to patch several
> files to make the code work on the production server (i.e. port
> numbers, etc).

The simplest solution is to not track those files at all.
Instead of tracking app.conf, mv it to app.conf.sample
and track that instead.  Likewise, add an entry for app.conf
in .gitignore.

When devs create new sandboxes they just
        cp app.conf.sample app.conf
and all is well because app.conf is in .gitignore.

If you literally do 'git mv' in a sandbox and push it out then
be careful since pushing that change to production will do
exactly what it was told to do (remove the config).
it's a small price to pay for simplicity, though, so just
remember to keep a backup.


> I'd like to write a script to email me whenever someone changes files
> on the production server without checking those changes back into git
> (i.e. running 'git status | grep "nothing to commit" ...').

Having the config files in .gitignore eliminates a lot of work in
your update hooks and it makes writing this script much easier.

The only extra cost comes in having to manage the config files
separately from the application, but it's nothing that can't be
automated.


> However, this approach get confused by the files patched to work
> correctly.
>
> Is there any way to 'save' those patched files so they don't get
> reported by 'git status', yet not mung up the git history every time
> we push out an update?
>
> Thanks!
> --


-- 
    David
