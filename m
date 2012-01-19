From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Rebase and incrementing version numbers
Date: Thu, 19 Jan 2012 15:02:46 -0500
Message-ID: <CADo4Y9iJyirdkEr1GCg9BD5rwX9=1uKptqHsiWB0_MiDKb_wUA@mail.gmail.com>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com>
	<CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
	<1327000803.5947.59.camel@centaur.lab.cmartin.tk>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Jan 19 21:03:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnyCJ-0001v6-Ri
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 21:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932978Ab2ASUCu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 15:02:50 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37252 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932945Ab2ASUCr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2012 15:02:47 -0500
Received: by vcbfo1 with SMTP id fo1so257722vcb.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 12:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=UC3QvN9+43kCkkq5bp0JjE8T+4VRejxTv5IePaKxffE=;
        b=mY+szCzTM3wd92c2UIwjrkkosmaYi5BBZ2QH3YuKi9rGO+y+entQohIf+AGflU/Y/v
         X9FIBWGVj7anm+wPc3eU5wOLIatVkCNi7DFBfhe8a2moAZdf7SmjOW0PQa53r+OM7ful
         32k6Fugx5GtSrkpXHU4MRGz1vKZiM5YK/E+ds=
Received: by 10.220.215.65 with SMTP id hd1mr16149788vcb.46.1327003366377;
 Thu, 19 Jan 2012 12:02:46 -0800 (PST)
Received: by 10.52.64.231 with HTTP; Thu, 19 Jan 2012 12:02:46 -0800 (PST)
In-Reply-To: <1327000803.5947.59.camel@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188829>

I'm guessing here, but I believe the "version number" is used to make
a directory on the production machine.  Thus, older versions of the
javascript are available on the production machines under their older
version number.  If there's an issue in production with the new
version, code can be redirected to use the older version that is still
in its directory.

So it probably looks like:
/100/js/<files>
/101/js/<files>
/103/js/<files>
/104/js/<files>

If something goes wrong with version 104, the admin can just tell the
machine to use version 103 instead of 104.

You're right that incrementing this version number is probably not an
issue for SVN users because they put N features in a single commit and
they update the version number once.   With git, a user can put N
features in N commits and changing the version number really belongs
in each commit.  This makes rebasing suck.


On Thu, Jan 19, 2012 at 2:20 PM, Carlos Mart=EDn Nieto <cmn@elego.de> w=
rote:
> On Thu, 2012-01-19 at 12:20 -0500, Michael Nahas wrote:
>> I'm at a new job and using Git-SVN at a place that is accustomed to =
SVN.
>>
>> The problem I'm running into is that whenever I change a file in a
>> directory, I have to bump up the version number in the configuration
>> file. =A0The larger version value in the config file causes my chang=
es
>> to be loaded over the old ones.
>
> Is this a deployment script that does this? Why can't it look at whet=
her
> files have changed? If a feature isn't ready for production, why is i=
t
> in a branch that gets deployed?
>
>>
>> Most of my commits are edits to a file like "foo.js" and an incremen=
t
>> to the version number in "config". =A0Ideally, each of my features
>> should live in a single commit and I should be able to make a sequen=
ce
>> of them, each time incrementing the version number in config.
>>
>
> So if you've changed the file but don't increase the config file's
> version, it means that the change isn't ready for production? If that=
's
> the case, you've just implemented branches, poorly.
>
> Contrary to what apparently many people think, subversion does suppor=
t
> branches. Get your team to use them.
>
>> The problem I'm running into starts with me editing version=3D100. =A0=
I
>> create new commits where I set the version to 101, 102, 103, 104.
>> When I go to push ("git svn dcommit"), my coworkers have incremented
>> the version to 103. =A0So, I rebase my changes, and get conflicts ev=
ery
>> time because of the version number!
>
> This sounds like a race condition that the svn users might be avoidin=
g
> by committing everything immediately. Sounds like a buggy development
> process.
>
>>
>> Is there a good way to avoid these conflicts? =A0Is there a hook I c=
an
>> write? =A0Is there a change to this process that would work smoother
>> with Git and its distributed development? =A0It's okay if the versio=
n
>> number skips numbers (e.g., jumps from 100 to 104), as long as it
>> increases.
>
> You could write a merge driver that detects this situation and writes=
 in
> a higher number, but it's all working around the fact that it's a rac=
e
> condition.
>
> =A0 cmn
