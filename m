From: Elijah Newren <newren@gmail.com>
Subject: Re: Unable to shrink repository size
Date: Wed, 5 Mar 2014 21:21:23 -0800
Message-ID: <CABPp-BGPPj63zLjjp5R6+vpJr3nLX_aSCz34qCf2E8tm8J7EDQ@mail.gmail.com>
References: <CAHd499AW6nev81iVVhuoYfT0us28SSBDwbHCBa3teYB=cJR99g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 06:21:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLQkK-0006B2-VU
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 06:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbaCFFVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 00:21:24 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:60717 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbaCFFVY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 00:21:24 -0500
Received: by mail-ie0-f169.google.com with SMTP id to1so2250299ieb.28
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 21:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8t1L3gU2CweZXzelf+j6cC3vgcVvSOI8paOa68MBCJk=;
        b=dk2QViVJTF+n8DyXllzA91ibD9Q29/71ps3JvzxOJOQ9Gz6HSaly4KArUvpI5uQi51
         BhQJ1k3oyCRIv0AjE6hHnfXscZV02jpMC7y2RhSZB77VRDpLm3rSDmsh5PvXKxhz2oGY
         dW7VXTSzJKkb5SmW2QECRN9V74YruEVtdLmhIW9RHoYHNZASmsumdpdxMrCEYtdPjj+J
         pQR2iULzZq+ZuviKfZWfC1GusE16yesYgLQn+lazyn+itsDu/IVr9pCzt064kOVGKwM6
         is7dvNE/O808wHdHYgFgSblQTAlrpdXKD4erFOl7fhbJwQLIrvuVzg8rFbjsrHUKeU8U
         RQ5w==
X-Received: by 10.43.131.2 with SMTP id ho2mr52851icc.75.1394083283769; Wed,
 05 Mar 2014 21:21:23 -0800 (PST)
Received: by 10.64.127.69 with HTTP; Wed, 5 Mar 2014 21:21:23 -0800 (PST)
In-Reply-To: <CAHd499AW6nev81iVVhuoYfT0us28SSBDwbHCBa3teYB=cJR99g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243499>

On Wed, Mar 5, 2014 at 6:55 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> What I'd like to do is somehow hunt down the largest commit (*not*
> blob) in the entire history of the repository to hopefully find out
> where huge directories have been checked in.
>
> I can't do a search for largest file (which most google results seem
> to show to do) since the culprit is really thousands of unnecessary
> files checked into a single subdirectory somewhere in history.
>
> Can anyone offer me some advice to help me reduce the size of my repo
> further? Thanks.

If you are trying to see which commits changed the most files (and/or
lines), you may find
   git log --oneline --shortstat
helpful.  A quick search through that output may help you decide where
to dig further.


Also, I'm sure someone else here probably has a better idea, but
here's a quick hack I came up with to look at "commit sizes":

mkdir tmp && for i in $(git rev-list --all); do git branch -f dummy $i
&& git bundle create tmp/$i.bundle dummy --not dummy^@; done

Follow that up with a quick "ls -alrSh tmp/" and you can see the
"size" of each commit.


Hope that helps,
Elijah
