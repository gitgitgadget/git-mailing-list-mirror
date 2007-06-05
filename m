From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: git-svn and googlecode.com?
Date: Tue, 05 Jun 2007 12:11:48 +0200
Message-ID: <466536E4.9040804@dawes.za.net>
References: <46651AAD.4010705@dawes.za.net> <200706051005.46603.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 12:11:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvW15-0001ze-48
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 12:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763468AbXFEKLt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 06:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763486AbXFEKLs
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 06:11:48 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:56546 "EHLO
	spunkymail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1763468AbXFEKLs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2007 06:11:48 -0400
Received: from [192.168.201.100] (dsl-146-26-199.telkomadsl.co.za [165.146.26.199])
	by spunkymail-a7.g.dreamhost.com (Postfix) with ESMTP id 4CAD75C283;
	Tue,  5 Jun 2007 03:11:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <200706051005.46603.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49179>

Andy Parkins wrote:
> On Tuesday 2007 June 05, Rogan Dawes wrote:
> 
>> (Original) svn checkout http://webgoat.googlecode.com/svn/trunk/ webgoat
>>
>> (Funny, the initial path component had a space in it?!)
> 
> I suspect that that is not the case.  The form of svn checkout is:
> 
>  svn checkout <url> <directory>
> 
> So your command is saying check out http://webgoat.googlecode.com/svn/trunk/ 
> to the local directory "webgoat".  That is to say - it doesn't have a space 
> in it and in fact is nothing to do with the URL at all.
> 

I guess I didn't explain it very well. The checked out project had a 
directory with a leading space in it:

0 $ ls -alp
total 0
drwxr-xr-x+  3 rdawes Domain Users 0 Jun  4 14:20  webgoat/
drwxr-xr-x+  4 rdawes Domain Users 0 Jun  4 14:20 ./
drwx------+ 28 rdawes ????????     0 Jun  5 09:43 ../
drwxr-xr-x+ 10 rdawes Domain Users 0 Jun  4 14:20 .git/

Note the leading space before webgoat/?

i.e. the initial path component actually does have a space in it.

>> 0 $ git-svn clone -T "trunk/ webgoat"
>> https://webgoat.googlecode.com/svn/trunk/
>> Initialized empty Git repository in .git/
>> Using higher level of URL: https://webgoat.googlecode.com/svn/trunk =>
>> https://webgoat.googlecode.com/svn
>> W: Ignoring error from SVN, path probably does not exist: (175002): RA
>> layer request failed: REPORT request failed on '/svn/!svn/bc/100':
>> REPORT of '/svn/!svn/bc/100': 200 OK (https://webgoat.googlecode.com)
>> Path 'trunk/trunk/ webgoat' was probably deleted:
> 
> ... which explains this error because there is no path "trunk/ webgoat".

Not so, see below.

>> However, the following command line does seem to work:
>>
>> git-svn clone -T "trunk/ webgoat" https://webgoat.googlecode.com/svn/
> 
> Oh dear; I'm surprised it worked as well as it did.  I just ran this command, 
> which seemed to work well:
> 
>  $ git-svn clone -T trunk http://webgoat.googlecode.com/svn/ webgoat-local
> 
> This clones webgoat.googlecode.com/svn to the local directory webgoat-local; 
> you can change "webgoat-local" to anything you want, it's just naming the 
> directory on your own computer.

Sure. But then you cd into webgoat-local/, do an "ls -l", and you'll see 
exactly the same thing I showed above.

I'm still running your command above, but I'm seeing

W: -empty_dir: trunk/ webgoat/main/project/JavaSource/org

Note the space       ^

> If you're the maintainer then perhaps you will want to change "http" 
> to "https" as well.
> 
>> Note that I manually removed the "trunk" component from the URL. This
>> suggests that there is something missing in the automatic "Using higher
>> level" detection code.
> 
> I think there is no bug; it's simply a misunderstanding.  git-svn working 
> wonderfully for me.

Um, I think that you did exactly what I said I did, namely removing the 
"trunk" component from the URL. Contrast:

Yours:
$ git-svn clone -T trunk http://webgoat.googlecode.com/svn/ \
     webgoat-local

Mine (original):
$ git-svn clone -T "trunk/ webgoat" \
     https://webgoat.googlecode.com/svn/trunk/
                                        ^^^^^
Mine (eventual):

$ git-svn clone -T "trunk/ webgoat" https://webgoat.googlecode.com/svn/

I'm sure there WAS a misunderstanding. It was me not understanding how 
to translate an SVN command line to a proper git command line, 
accounting for trunks, etc. That was one of the reasons I made the post, 
to clear it up, and to make sure that anyone searching for hints on how 
to use git to clone google code projects will find something, since I 
didn't.

So, it seems that the rule for googlecode is something like:

If the published command line is:

  svn checkout https://<project>.googlecode.com/svn/trunk/ <project>

You can clone this project using git-svn with the following command:

  git-svn clone -T trunk https://<project>.googlecode.com/svn/ <localdir>

If this results in too many levels of directories in the checked out 
project (e.g. "/workspace/webgoat/ webgoat/"), take the extra directory 
component and add it to the -T parameter (e.g. "-T 'trunk/ webgoat'")

Hopefully this helps the next person.

Thanks for your response.

Rogan
