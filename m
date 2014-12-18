From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Saving space/network on common repos
Date: Wed, 17 Dec 2014 16:07:23 -0800
Message-ID: <20141218000723.GP29365@google.com>
References: <CAGXKyzEYhR69w1=4q-xtBagVBwOPqNA9C=AD0bAorB+5eRtVRg@mail.gmail.com>
 <20141217223215.GO29365@google.com>
 <CAGXKyzEqTik3p=A8NZJ6kUscFjw_Dh1mBPT-ciwq9L8kNKDDig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Craig Silverstein <csilvers@khanacademy.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 01:07:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1Ocs-0006uy-Vz
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 01:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbaLRAH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 19:07:27 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:35156 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbaLRAH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 19:07:26 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so141905ier.20
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 16:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=m5Mz7fxlYhKHx9WLYJTV5wMwY9jjyQfq36r7myBCWxc=;
        b=FwfH955VUZMcQao8+rCg+g5qzCJ9347sG75b1KcTehi2FG2uoWKTWlqQzKH0nV6xK3
         iwL+AyiFEN00dIVCD25W3HGmCs7637v+DqJF73y+at+QmgyNJZAApPCd6wY9sw+rEOHK
         PzmyVSldWMC5Vgpv5DFYh3d+o4pq7fHnXceHw230tLTU46+VBTtSlC3ilyTSZh0lyt81
         SGMRp3CJHR5RlVapr82oDrpt6TwSSqXfT8Wrx8QABbXZfzQccMQ2lS3VoWDEku18AFFY
         wXaWAoz1qbT+OWC1PndBgD0C740VQWE36jVqXkQ9R0mdtjxXuibKazCvf1+16rFABU0R
         LnxA==
X-Received: by 10.43.126.67 with SMTP id gv3mr35187398icc.31.1418861245984;
        Wed, 17 Dec 2014 16:07:25 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c577:d193:b305:4b9f])
        by mx.google.com with ESMTPSA id r18sm2483747ioi.28.2014.12.17.16.07.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Dec 2014 16:07:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGXKyzEqTik3p=A8NZJ6kUscFjw_Dh1mBPT-ciwq9L8kNKDDig@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261510>

Craig Silverstein wrote:
> On Wed, Dec 17, 2014 at 2:32 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Craig Silverstein wrote:

>>> Question 4) Is there a practical way to set up submodules so they can
>>> use the same object-sharing framework that the main repo does?
>>
>> It's possible to do, but we haven't written a nice UI for it yet.
>> (In other words, you can do this by cloning with --no-recurse-submodules
>> and manually creating the submodule workdir in the appropriate place.
>
> Hmm, let me see if I understand you right -- you're suggesting that
> when cloning my reference repo, I do
>     git clone --no-recurse-submodules <my repo>
>     for (path, url) in `parse-.gitmodules`: git clone url path
> # this is psuedocode, obviously :-)
>
> and then when I want to create a new workdir, I do something like:
>     cd reference_repo
>     git new-workdir /var/workspace1
>     for (path, url) in `parse-.gitmodules`: cd path && git new-workdir /var/workspace1/path
>
> ?  Basically, I'm going back to the old git way of having each
> submodule have its own .git directory, rather than having it have a
> .git file with a 'gitdir' entry.  Am I understanding this right?

Basically.  The initial clone can still use --recurse-submodules.
When you create a new workdir you'd create new workdirs for the
submodules by hand.

A 'git submodule foreach' command in the initial repo can take
care of the `parse-.gitmodules` part.

[...]
> Also, it seems to me there's the possibility, with git-newdir, that if
> several of the workspaces try to fetch at the same time they could
> step on each others' toes.  Is that a problem?  I know there's a push
> lock but I don't believe there's a fetch lock, and I could imagine git
> getting unhappy if two fetches happened in the same repo at the same
> time.

That's a good question.  If concurrent fetches cause trouble then I'd
consider it a bug (it's not too different from multiple concurrent
pushes to the same repository, which is a very common thing to do),
but I haven't looked carefully into whether such bugs exist.

Hopefully someone else can chime in.

Thanks,
Jonathan
