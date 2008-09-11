From: "Eric Raible" <raible@gmail.com>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git reset --hard"
Date: Wed, 10 Sep 2008 19:46:40 -0700
Message-ID: <279b37b20809101946k309ad113neb7d051f1c6c410e@mail.gmail.com>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>
	 <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Changsheng Jiang" <jiangzuoyan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 04:47:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdcDn-0007Dw-Vo
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 04:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbYIKCqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 22:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752640AbYIKCqm
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 22:46:42 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:14275 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbYIKCql (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 22:46:41 -0400
Received: by py-out-1112.google.com with SMTP id p76so122023pyb.10
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 19:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=1FDNQcPvDExN3FqZOVHqGTe/HWOyRGErKcxk1fw84bA=;
        b=NEQEzQtO99OxeIEW5demSSJwgc4M8wa+zBMA/bze+ZIFonG5s3qPlhBfCtt1wkTyPy
         1EwIw3WS94pVamCTkNPD0n3viHHi2ZN6B0X8ks8gteCg0uO+lW0pLVZW6aRLbRWiOpYu
         p2dkX3F75ePPitX4pQ8mvA3HPORNEL5rRJEEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Az7pzuFzbErz3eHjid1I5TPOCKa9ZtXmOXfMr0PZ9hmrVgDfpFsB7OSVWdyBYBA9PM
         G1ZVvROpWT3fqsfrBoSVvOlYwaytknhVrvN7N6tzHfgw9xwK6A8x8oBpS7KjFghTQFVs
         BVPSszvYXtYpuGyuetjN5zqzSqO7HjB4UbZKI=
Received: by 10.143.19.16 with SMTP id w16mr720069wfi.223.1221101200443;
        Wed, 10 Sep 2008 19:46:40 -0700 (PDT)
Received: by 10.142.177.12 with HTTP; Wed, 10 Sep 2008 19:46:40 -0700 (PDT)
In-Reply-To: <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95576>

On Wed, Sep 10, 2008 at 7:12 PM, Changsheng Jiang <jiangzuoyan@gmail.com> wrote:
> I think the current behavior is better than you described. If you want to
> ignore some files, you can added it to the exclude file. All files not
> excluded in the repo directory is maintained by git.

That doesn't really address the problem.  This is an
updated example that specifically ignores the file:

# Create a single commit in a new repo (so that we have a HEAD)
mkdir xx
cd xx
git init
git commit --allow-empty -m"initial"
# Add an important file
echo "Important stuff" > file42
git add file42
echo file42 > .gitignore
git status # -> new file:   file42
ls # -> file42, or course
git reset --hard
ls # -> nothing

So not only was file42 never actually tracked by git
(IMHO - I realize that this is debatable) but it was also
specifically ignored, and it is _still_ deleted w/out a trace!

I realize that "git reset" will simply unstage the new file
in either case (w or w/out .gitignore), but the consequences
of an accidental "git reset --hard" are pretty severe in this
case.  This behavior seems definitely contrary to Linus's
explanation:

   And "git reset" won't be deleting files it doesn't track (it had _better_
   not touch them), even more so when it has been told to ignore them, so it
   makes total sense to _not_ delete them when doing that reset.

- Eric
