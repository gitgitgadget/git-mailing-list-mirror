From: Thomas Nyberg <tomnyberg@gmail.com>
Subject: Re: Corruption of branch?
Date: Mon, 14 Dec 2015 13:08:50 -0500
Message-ID: <566F05B2.8080403@gmail.com>
References: <566EFF11.6010600@gmail.com>
 <CAGZ79kaUw8Hb_7hdAUbvmnmXvm3a-77j5t3zeyQ-7BqwPCSp+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 19:09:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8XYV-000606-1a
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 19:09:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbbLNSIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 13:08:53 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33373 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbbLNSIw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 13:08:52 -0500
Received: by qkck189 with SMTP id k189so112755792qkc.0
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 10:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=hV7n6QWouzecdXJsiV85uk1bMOQSwEPYpvdpPfjS4So=;
        b=hccSoubBdD2ajWzriUK1AAIOj29xKmil+y8aDgMSfypAncrhCL8qRJI0xFQ3AJ33yp
         TFcS/b5lxC53xyNVj0NBO2g0VU9m4qfmu9BPtXaf4lklZ3FljHeABzMHjP43Yq8YKAHI
         nIr3LNS9R7fvTa8/75kWTqEYEOHQ7htpvMsLxqi8DREQ1TV2xlOsMAJ1J7vF1TpOmUA5
         DTITCKIf5fSPDd7Kl1VIYgWIZjkAcwCcE7/6jxMRH6kJsYRc4w9dQDgBPhbFhD7CO01H
         ILS6Y4fUsHaNVXVhOLq4376LuOZ5gRzy8kK7m+w6h/PHTDosSc2rH/H/EWFZzVRBc7Tt
         4ZDA==
X-Received: by 10.55.73.5 with SMTP id w5mr45904945qka.27.1450116531997;
        Mon, 14 Dec 2015 10:08:51 -0800 (PST)
Received: from [128.59.76.160] (dyn-128-59-76-160.dyn.columbia.edu. [128.59.76.160])
        by smtp.googlemail.com with ESMTPSA id n138sm14209634qhc.31.2015.12.14.10.08.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Dec 2015 10:08:51 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kaUw8Hb_7hdAUbvmnmXvm3a-77j5t3zeyQ-7BqwPCSp+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282375>

Hi Stefan thanks for much for the response! So I compiled release 
version 2.6.4 as well as the current master branch on the git git 
repository (2.7.0.rc0.20.g4b9ab0e) and the problem persists on both.

To answer your questions, there are no weird characters. The name of the 
bad_branch is "frus". There is another branch called 
"frus_body_cleaning" that is totally fine.

As to whether the error continues after commits, the answer is no which 
is good. I.e. if I run `git checkout -b frus origin/frus` that works 
fine. I then decided to checkout a new branch (so as to not mess with 
the original branch and possibly turning this into a Heisenbug) and add 
a test commit which I pushed upstream. I then recloned the repository 
and was able to checkout this new branch just fine, but I still couldn't 
check out the original frus branch using the simplified command.

So of course on the practical side, I have a fix which is to just use 
`git checkout -b frus origin/frus` (apparently only this one time) and 
then be on my merry way (in fact I had only just broken myself of the 
habit typing it this older way after many versions of the newer simpler 
syntax), but it seems like it could be good to sort out what's going on 
here...

Thanks again for the response!

Cheers,
Thomas

On 12/14/2015 12:51 PM, Stefan Beller wrote:
> On Mon, Dec 14, 2015 at 9:40 AM, Thomas Nyberg <tomnyberg@gmail.com> wrote:
>> Hello,
>>
>> I have a repository (which I unfortunately cannot provide access to) which
>> is having some odd things happening with one (and only one) of its branches.
>> This workflow repeats the issue (here `bad_branch` is one of the remotes
>> branches; i.e. `origin/bad_branch`):
>>
>> (1) clone the repository
>> (2) git checkout `bad_branch`
>>
>> Basically nothing happens. Nothing is printed and I stay on the master
>> branch. I also checked $? and there is no error code that is set. If I
>> choose any of other branches, it correctly creates a local branch, sets it
>> to track the remote and then switches to the local branch.
>
> Does that branch have a funny name? (i.e. is it ASCII only? Or is it
> also utf8 characters?
> Does it have some special characters in it like points, colons,
> question marks etc)
>
> Does it happen only with a single sha1 or can you apply commits on top
> of that branch
> and the error condition persists?
>
>>
>> It seems like there could be some sort of weird bug in the checkout or
>> possibly somehow some corruption in the actual object tree. From my vantage
>> point, however, the data appears totally fine. For example, in
>> `.git/packed-refs` everything appears normal and if I explicitly checkout
>> the commit IDs directly (i.e. just copy the commit corresponding to
>> refs/remotes/origin/bad_branch and checkout $commit) it checks out fine. If
>> I do this with the bad_branch I get a detached HEAD as expected and git log
>> lists the commits that it should.
>>
>> This seems a bit odd to me. There's certainly some sort of error somewhere,
>> but it's passing silently. I'm not really sure how to debug this and it's
>> too bad I can't actually link the actual repository. I presume if I have the
>> time I could try compiling git from source and seeing if it still shows up.
>> I tested it on the following two versions of git get the same error:
>>
>> * 1.9.1 (installed as a package from Linux Mint 17.2 Rafaela)
>> * 2.1.4 (installed as a package from Debian Jessie 8.2)
>
> The refs handling code is in flux at the moment. (starting mid of last
> year actually)
> I cc'd people who did work recently on the file refs.c
>
> So I think trying with a new version of Git would be a valuable datapoint!
>
>>
>> Also I should note that the original repository is hosted on Github.
>>
>> Thanks for any help. Hopefully the fact that I can't provide enough
>> information for others to reproduce the issue isn't too large a bother...
>>
>> Cheers,
>> Thomas Nyberg
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
