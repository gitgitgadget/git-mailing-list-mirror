From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: end-of-line diff checkout direction dependence problem
Date: Tue, 30 Jun 2015 16:41:23 +0200
Message-ID: <5592AA93.9090002@web.de>
References: <5592A3D9.3080706@ivision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: tvie@ivision.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 16:41:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9wiw-0001N8-UW
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 16:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbbF3OlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 10:41:19 -0400
Received: from mout.web.de ([212.227.15.4]:59936 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbbF3OlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 10:41:17 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LjP7H-1Ydd6k1Jkd-00dTfb; Tue, 30 Jun 2015 16:41:13
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <5592A3D9.3080706@ivision.de>
X-Provags-ID: V03:K0:GwPPw0B7CynKN4JTGMPDGn0X+iEr2xUPRpTzbFeFRzPrxma50hN
 AIZfr8xlHAwtMvxM7yVwNSqQSPSXb2cE4po7k67y1yJNkR6G20UIJIqVe5NDCazuTEOm5aY
 r5o/JHt3UzrnaJO+A7YU6bUnyhJ86DiI7DWhpLP/4t4edBgJh25ladpNjoIRKJj3vJDoedr
 pIFGiwktlCuW8TNb5FY8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZGhIIPsTRhk=:sAfg5/1toKd4LKn/o5VRii
 Y5mfUMU1dDwfO6qARGomXpauhyKPSj89y74aiZDMzuLNziNib8GdZ5nd9vhK5EkGIFDa2ggtu
 vnxFKCFlnjDYh7pJqIy5n0W1dZtnMAt0S5lnFzJDkV3Ep/B03W9oo8dWOtrheXcPy4JTxVYL0
 CXln5A7bMwMAQGMcyOUb1WLJOTl71rAZ4QqCozH6bLDTvI5Y/UJdrIFjgWJQ/ZltNumvHWVaS
 AjLPZwJfHzTW2xUlBdgovhfGUEHqKjnxRW98xvY76o7LUxfCcmKjkTOxQ7QC0nBSeFWYIm0XH
 nxtSpe2L4BJJuSmlspz6FE1aCqJ2ZZJHmYuqvaJ+xNjnnDSrhhF/QZ6lxxztWSwxz8iyRPVTn
 Du6kBGX9kKrITQL95PxGul+xiUioWj96uTwVgfXGoOwJ+NOZCO8h/AYp1Ra+Tat/V7YkRaz7C
 jH+UsY2nFiPgATTdtXBi1jPgV9C5JcYI4GQv/4ipzV1Tkd9eZctqJTJHIpyStoANARh3ByAqy
 i9VyBJdk+ESjrbxyGf5mzSWUjdXtTSPEMaQ+6He0f2KnR1uEJVu+hMfF3+KDBQe0nFEDziLBJ
 NWN3MJuDhkBKVeTnIErxPqcUuiFJ1qpyU4qK03L26PqQ5d3MTubRwcBMJEy8e+hSnvT9UZOfR
 7xJTqRCSe4hwqmv+IdloJ0CJP88FhoGKcZ0NLaYxtm1LRvB7qTvGsnyvoLhXIZHUHVzg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273066>

On 2015-06-30 16.12, Thomas Vieten wrote:
> We face a very inconvenient problem with end-of-line diffs which are not "real".
> We know the end-of-line problem very well as we thought.
> But now we found a new phenomenon and nobody mentioning it.
> 
> Consider the following repository structure:
> 
>           -----------|----|------------->branch1
>         /
> master
>         \
> ----------|-------|---------|--------------->branch2
> 
> The branches are based on master/head.
> We just consider one branch here, e.g. branch1 .
> 
> Working with the head of branch1 gives no problems. No end-of-line diffs.
> Also going back in the direction of master - no problems.
> Only in the case if we do a checkout from branch1 to master, then
> all of a sudden end-of-line diffs appear.
> The files might be changed, but the end-of-line attributes in gitattributes are
> not changed in the branch.
> 
> It seems to be the case that since the last change to the files which pop up
> with eol differences, gittattributes where changed and touch their extensions.
> 
> With the operation
> 
> git ls-files -z | xargs -0 rm -f  # delete all the files of this version - here
> master/head
> git reset --hard                  # force checkout of master/head and reset index
> 
> The problem disappears! No eol problems anymore. Something like a brute force
> checkout.
> 
> Also checking out versions in the direction of branch1 give never end-of-line
> diffs.
> 
> What has changed somewhen are the gitattributes.
> 
> We estimate that this becomes a problem when applying the diffs from branch1 in
> the direction of
> the master. Finally then the diffs result in a different state from the master.
> 
> But when the master is checked out freshly, this difference does not appear.
> 
> Very, very annoying.
> 
> We check now every time when these end-of-line diffs appear, if they are really
> end of line diffs
> 
> git diff --ignore-space-at-eol
> 
> and then try the procedure above.
> 
> But to have a dependence from the direction of the checkout is somewhat irritating.
> 
> If this is not a bug - then how to avoid it ?
> 
> bye for now
> 
> Thomas
> 
The things which are described don't sound unfamilar.
First some questions:
Which Git/OS are you running on ?

CYGWIN ?
Git-for-Windows ?
Linux ?
Other ?

Which versions ?
How does your .gitattribute file look like ?

It may be, that you need to "nornalize" your repo:

https://www.kernel.org/pub/software/scm/git/docs/gitattributes.html
The search for this text
"When text=auto normalization"
and follow the instructions:
