From: Chris Packham <judge.packham@gmail.com>
Subject: Re: git web--browse error handling URL with & in it (Was Re: [RFC/PATCH]
 Configurable hyperlinking in gitk)
Date: Sun, 18 Sep 2011 12:32:04 +1200
Message-ID: <4E753C04.1070202@gmail.com>
References: <20110917022903.GA2445@unpythonic.net> <4E7467B7.1090201@gmail.com> <20110917134527.GA28463@unpythonic.net> <4E752E32.2010208@gmail.com> <4E753BB9.7030804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Sun Sep 18 02:31:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R55Ic-0007bF-IL
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 02:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723Ab1IRAbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 20:31:52 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:55079 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab1IRAbv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 20:31:51 -0400
Received: by yie30 with SMTP id 30so3537748yie.19
        for <git@vger.kernel.org>; Sat, 17 Sep 2011 17:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ahgp6p7hqXNdkSOx2s9/jJwd1Gs5C53v+ZfKl8NTIjM=;
        b=Mft2/PLg8nCiQqPRvCreP4OF/Vtz84ODqd5gqJkZ8k7ei28Ki4X4CQ520p3hR+J6qH
         fKZUmtD2JFznr3QOqIryOR+CKoteUnDJTlyt6zb95jwF5LlzjLbpBw6ZoMc/eeYFzVYw
         3d/Y/aq7h8IGfTolhrvIyLEN7Nf8Ww9CswLAY=
Received: by 10.236.183.170 with SMTP id q30mr5911292yhm.42.1316305911081;
        Sat, 17 Sep 2011 17:31:51 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id n8sm25905822and.1.2011.09.17.17.31.47
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Sep 2011 17:31:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.20) Gecko/20110804 SUSE/3.1.12 Thunderbird/3.1.12
In-Reply-To: <4E753BB9.7030804@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181589>

On 18/09/11 12:30, Chris Packham wrote:
> On 18/09/11 11:33, Chris Packham wrote:
>> On 18/09/11 01:45, Jeff Epler wrote:
>>>>> There are probably better names for the configuration options, too.
>>>>
>>>> It'd be nice if the config variables weren't gitk specific. .re and .sub
>>>> could be applied to gitweb and maybe other git viewers outside of
>>>> gig.git might decide to use them. My bikeshedding suggestion would be to
>>>> just drop the gitk prefix and have linkify.re and linkify.sub.
>>>
>>> This seems like a reasonable idea, though since the implementation
>>> languages of gitk and gitweb are different it means some REs might get
>>> different interpretations in the different programs.
>>>
>>>> Sometimes when a commit fixes multiple bugs we put all the bug numbers
>>>> in separated by commas. I don't know Tcl well enough to tell if your
>>>> code supports that or not.
>>>
>>> Multiple matches per line are OK, but they must be non-overlapping.
>>>
>>> Looking at the actual practice in Debian changelogs, I see that they do
>>> this:
>>>     evince/changelog.Debian.gz:        (Closes: #388368, #396467, #405130)
>>> so my original example would only linkify "Closes: #388638".  But a
>>> revised pattern of #(\d+) would linkify "#388368", "#396467" and "#405130".
>>> (but risk a few more "false positive" links).  I should revise my
>>> example accordingly.
>>>
>>> As for the problems with your substitutions, "&" is special in a tcl
>>> regsub (it stands for the whole matched string, like \0), so you'd want
>>> to use a substitution like
>>>     git config gitk.linkify.debian-bts.sub \
>>>         'http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=\1\&foo=bar'
>>
>> Hmm no joy with \&. Seems to upset the invocation of git web-browse
>>
>>   git config gitk.linkify.bugtracker.sub \
>>        'https://internalhost/code\&stuff/bugs.php?id=\1'
>>
>>   gitk
>>   /home/chrisp/libexec/git-core/git-web--browse: line 167:
>> stuff/bugs.php?id=bug123: No such file or directory
>>   fatal: 'web--browse' appears to be a git command, but we were not
>>   able to execute it. Maybe git-web--browse is broken?
> 
> This is probably a issue with git web--browse and nothing to do with
> your changes.
> 
> Sure enough this works fine
> 
>   git web--browse --browser=firefox \
>       https://internalhost/code\&stuff/bugs.php?id=foo
> 
> While this doesn't
> 
>   git web--browse https://internalhost/code\&stuff/bugs.php?id=foo
> 
> /home/chrisp/libexec/git-core/git-web--browse: line 167:
> stuff/bugs.php?id=foo: No such file or directory
> fatal: 'web--browse' appears to be a git command, but we were not
> able to execute it. Maybe git-web--browse is broken?
> 
> Neither does this
> 
>   git web--browse --browser=konqueror \
>      https://internalhost/code\&stuff/bugs.php?id=foo
> 
> A little bit more info that might help diagnose the issue - I'm running
> openSUSE 11.4 (kde 4.6) which ships with firefox set as the default web
> browser so 'kfmclient newTab http://www.example.com' actually opens firefox.
> 
> However trying kfmclient with my funny URL still works
> 
>   kfmclient newTab https://internalhost/code\&stuff/bugs.php?id=foo
> 
> I'm a little stumped as to what is going wrong in git web--browse.
> 

Update: it's the call to eval that causes the problem

  eval kfmclient newTab https://internalhost/code\&stuff/bugs.php?id=foo
  [1] 14728
  bash: stuff/bugs.php?id=foo: No such file or directory
