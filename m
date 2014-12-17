From: Craig Silverstein <csilvers@khanacademy.org>
Subject: Re: Saving space/network on common repos
Date: Wed, 17 Dec 2014 15:57:32 -0800
Message-ID: <CAGXKyzEqTik3p=A8NZJ6kUscFjw_Dh1mBPT-ciwq9L8kNKDDig@mail.gmail.com>
References: <CAGXKyzEYhR69w1=4q-xtBagVBwOPqNA9C=AD0bAorB+5eRtVRg@mail.gmail.com>
	<20141217223215.GO29365@google.com>
Reply-To: csilvers@khanacademy.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 00:57:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1OTK-0004fQ-04
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 00:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbaLQX5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 18:57:34 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:53338 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaLQX5d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 18:57:33 -0500
Received: by mail-ig0-f178.google.com with SMTP id hl2so333531igb.11
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 15:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khanacademy.org; s=google;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ujxEWPdGwkKkAhNWMDpqg3Vy6eHlImz5mUllrNE7Gl8=;
        b=aTJKGkF23X/HoOBXYdU8I2RtQLmuSTYiKbQfvuhCMvcbnNTW2h0g3vUlR9pMwSow1r
         /1NwVJl1dH7gHacULTSc1ekX1qXGFeaWIe0vKg5g+xMH9qw/X9yS914r6nLWkW5WG5w2
         qvm7q/Ik59OkTQOIOYbh4p+Hqy+7DF0KKq9Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ujxEWPdGwkKkAhNWMDpqg3Vy6eHlImz5mUllrNE7Gl8=;
        b=eROomQPViiFEuItV1Mh2Tos6w+kcthasPBhiiULIYqwfq95yNmFidlH7CC/VbZ53n+
         7XXhF7ghQUJLSMxz3XoZFKkFkTyOJyvf0ROArrB4sYuTS+E3NggBOklgWoW6VugoTVmP
         kliplliqXucqagspbfmectYJbdC4iS5SlhNOIx7k6XHyf6J5AWhAVxQBFbc8TYszVguS
         LH4bdBR7j/faAFrm/p4f5/Q40pz2JZEaz21Rayy4McI1lzMBtRwxZQRNYyElAnEZqvEp
         +lzQJ9snH/t9mI29o1pNi9UNEuSiS1fcQq6FRBIVS3PEJ+aJmnje3HLaTVmZF2FvtARE
         RGCg==
X-Gm-Message-State: ALoCoQmfcdRDd0hHOX8JFVDBObaefA+/3WgnzZZAwveMNiuu0Bx6KvVGavDaEaESNh0/bjD+W+xN
X-Received: by 10.107.132.78 with SMTP id g75mr42148827iod.21.1418860652537;
 Wed, 17 Dec 2014 15:57:32 -0800 (PST)
Received: by 10.107.7.159 with HTTP; Wed, 17 Dec 2014 15:57:32 -0800 (PST)
In-Reply-To: <20141217223215.GO29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261508>

On Wed, Dec 17, 2014 at 2:32 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> You might find 'git new-workdir' from contrib/workdir to be helpful.
> It lets you attach multiple working copies to a single set of objects
> and refs.

Thanks!  That does indeed sound promising -- like a more principled
version of my GIT_OBJECT_DIRECTORY suggestion.

>> Question 4) Is there a practical way to set up submodules so they can
>> use the same object-sharing framework that the main repo does?
>
> It's possible to do, but we haven't written a nice UI for it yet.
> (In other words, you can do this by cloning with --no-recurse-submodules
> and manually creating the submodule workdir in the appropriate place.

Hmm, let me see if I understand you right -- you're suggesting that
when cloning my reference repo, I do
    git clone --no-recurse-submodules <my repo>
    for (path, url) in `parse-.gitmodules`: git clone url path
# this is psuedocode, obviously :-)

and then when I want to create a new workdir, I do something like:
    cd reference_repo
    git new-workdir /var/workspace1
    for (path, url) in `parse-.gitmodules`: cd path && git new-workdir
/var/workspace1/path

?  Basically, I'm going back to the old git way of having each
submodule have its own .git directory, rather than having it have a
.git file with a 'gitdir' entry.  Am I understanding this right?

Also, it seems to me there's the possibility, with git-newdir, that if
several of the workspaces try to fetch at the same time they could
step on each others' toes.  Is that a problem?  I know there's a push
lock but I don't believe there's a fetch lock, and I could imagine git
getting unhappy if two fetches happened in the same repo at the same
time.

craig
