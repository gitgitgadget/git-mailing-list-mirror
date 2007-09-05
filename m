From: Russ Brown <pickscrape@gmail.com>
Subject: Re: git-svn and a nested branches folder
Date: Wed, 05 Sep 2007 04:56:07 -0500
Message-ID: <46DE7D37.9040905@gmail.com>
References: <46DD6EEA.9010304@gmail.com> <20070905001513.GA9362@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Sep 05 11:56:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISrcX-00055l-15
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 11:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935AbXIEJ4P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 05:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755640AbXIEJ4O
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 05:56:14 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:23756 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755520AbXIEJ4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 05:56:13 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2061040wxd
        for <git@vger.kernel.org>; Wed, 05 Sep 2007 02:56:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GyZGE28FAygFXqgyn/eqWlnVDyIahHzVJj30a+pu6bO0mt04WNE7ofh+FWRy3mFl3d0lpqJCTb04e38jI32B0bD45UB+IFxKwSE2u/ikuoyo91cTKMrTb0qilrSvJpzreGn/FdGQjW7LnxZ75H0A/RTZGT6tU4NW91x48z5Ak74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RW4lY9/1PbLlS0ZaCY1IoFj+EaqhCCzrbdi7igaoUTkdPh1BoeRGXs1TziLIb+rO5WTUFcQtFVJhaQDwyrOvd1a5v6xgfL6uHcAsF45eIAO10WRhDR63QBpmUMgstQUOX+II73etkIoiyY+mz8k9Az3rbji9eT5gtfdQOK04QOA=
Received: by 10.90.52.18 with SMTP id z18mr6677632agz.1188986172654;
        Wed, 05 Sep 2007 02:56:12 -0700 (PDT)
Received: from ?192.168.0.100? ( [71.164.207.197])
        by mx.google.com with ESMTPS id 9sm7167846agc.2007.09.05.02.56.10
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Sep 2007 02:56:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070807)
In-Reply-To: <20070905001513.GA9362@soma>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57704>

Eric Wong wrote:
> Russ Brown <pickscrape@gmail.com> wrote:
>> Hi,
> 
> Hi Russ,
> 
>> I'm having some trouble with using git-svn to fetch a repository, and I
>> think it's because the repository doesn't store branches as a flat list
>> directly under the 'branches' directory.
>>
>> Basically, we have a structure like this:
>>
>> |
>> +-trunk
>> +-tags
>> +-branches
>>   + category-a
>>     + branch-a
>>     + branch-b
>>   + category-b
>>     + branch-c
>>     + branch-d
>>
>> etc. category-a and category-b are simple directories created using svn
>> mkdir. The branches are created using svn cp.
>>
>> It helps us to organise the branches better, but the rationale is
>> besides the point. The problem is that git-svn seems to want to treat
>> category-a and category-b as branches, which isn't right at all. As a
>> result, git-svn seems to skip most (if not all) revisions that occur in
>> these directories and creates a lot of entries in unhandled.log.
> 
> This is a known problem with the way git-svn handles branches and tags.
> Nested branch (and tags) structures aren't supported with globbing and
> so you can't have more than one branches/tags specification in your
> config.
> 
>> I've also encountered an index corruption in one of the
>> .git/svn/<branch>/index files which I think it probably related.
> 
> Not sure about that.  git-svn should detect and attempt to fix index
> corruptions (which happened for me since I interrupt git-svn quite
> often when working on it).
> 

I've since trashes that repo and it's not happened again, so it must
have been cosmic particles or something. :)

>> I've had a quick look at the source myself, but perl isn't my strong
>> point. What I think it should do is something like recurse down the tree
>> from the directory given looking for folders that copy from trunk (or
>> some other branch that already exists). That would work perfectly well
>> for the default flat branch storage method as well as the one we use.
> 
> The globbing functionality of branches in git-svn is some of the ugliest
> code I've ever written in my life.  Somehow I got it working for the
> simple general cases but I've been afraid to touch it for a while...
> 

Yeah, I know what you mean. :) A really nasty thing to get working and
once you do you don't want to touch it again. :)

>> The only other problem is in branch naming, which could clash if you
>> only use the outer-most directory name, so I'd suggest something that
>> involves concatenating the folders in the path relative to 'branches' to
>> keep them unique (if git can handle slashes in branch names then all the
>> better).
> 
> As Peter suggested, disable globbing for branches and use explicit
> fetch refspecs for now...
> 

I've actually knocked up a rough script which generates a list of
refspec lines for you given a repo URL, trunk reference and branches
directory. It uses svn log -v --xml and pipes it through a couple of
XSLT templates, and basically looks for all copies that copy from trunk
(recursively: so it includes branches of branches too). I can post it to
the list if you'd find it useful or interesting.

It's generating output that looks sensible to me, but the results aren't
quite what I'd expected. I'll paste a sample in here in case there's
anything obvious someone might spot that I've missed

# This line was generated by git-svn init, and I kept it
fetch = all/trunk:refs/remotes/trunk

# These lines generated by my tool, dirnames replaced for security reasons:

fetch = branches/folder/projecta:refs/remotes/svn/folder/projecta
fetch = branches/folder/projectb:refs/remotes/svn/folder/projectb
fetch = branches/folder/projectc:refs/remotes/svn/folder/projectc
fetch = branches/folder/projectd:refs/remotes/svn/folder/projectd
fetch = branches/folder/projecte:refs/remotes/svn/folder/projecte
fetch = branches/folder/projectf:refs/remotes/svn/folder/projectf
fetch = branches/folder/projectg:refs/remotes/svn/folder/projectg

git branch -a doesn't list any of those branches after fetch completes.
Looking back at the output from fetch, all revisions applied were to trunk.

Anything wrong with those fetch lines?

Thanks for your time.

-- 

Russ
