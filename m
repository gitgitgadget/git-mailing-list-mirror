From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git performance results on a large repository
Date: Fri, 10 Feb 2012 19:24:55 +0700
Message-ID: <CACsJy8ANHdG5r10Hk4Ap74+=KGrtDJGYbQa+9731S2YeHCb2Yw@mail.gmail.com>
References: <CACsJy8AxOZQ7S42V1g-b0vdBxPpjhFZe6qDkGaALnxQ6LiUssw@mail.gmail.com>
 <CB599BA0.42A6B%joshua.redstone@fb.com> <CACsJy8DQNHm8sTgxKL=+Ui5OBsJBpvPn+dRmN9bVMwq4TfNuxQ@mail.gmail.com>
 <CAP8UFD1RTa6+btjJrsfqjOOoCjebZBqK6xkPN7ZVLM04bHO9yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joshua Redstone <joshua.redstone@fb.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 13:25:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvpXh-000500-NH
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 13:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758717Ab2BJMZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 07:25:27 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:38867 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758378Ab2BJMZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 07:25:26 -0500
Received: by werb13 with SMTP id b13so1973676wer.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 04:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=K6xEOQVI5S0m1yn/tIrV5ZbICJ9uXPvbWRw/gAphqDM=;
        b=uWSimkVBXUGeYcCX/r4OEtCbXHUoS3ff6VOVY3K564PHmceJqIhVvy4R2j/hxkreve
         d9Y+IBG5fDWtUJUbZY5aoVyCleqE6P5nTpn8gYu0uqsXtKQAWCyhjwI00/9IW4Z9NiXC
         Wb6zY8H2+N+8aZpZiHDmeoMzsqxS3sPw2ZE+0=
Received: by 10.180.19.97 with SMTP id d1mr8983234wie.12.1328876725249; Fri,
 10 Feb 2012 04:25:25 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Fri, 10 Feb 2012 04:24:55 -0800 (PST)
In-Reply-To: <CAP8UFD1RTa6+btjJrsfqjOOoCjebZBqK6xkPN7ZVLM04bHO9yw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190402>

On Fri, Feb 10, 2012 at 4:39 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi,
>
> On Fri, Feb 10, 2012 at 8:12 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>
>> All these involve unpack_trees(), which is full tree operation. The
>> bigger your worktree is, the slower it is. Another good reason to
>> split unrelated parts into separate repositories.
>
> Maybe having different "views" would be enough to make a smaller
> worktree and history, so that things are much faster for a developper?
>
> (I already suggested "views" based on "git replace" in this thread:
> http://thread.gmane.org/gmane.comp.version-control.git/177146/focus=177639)

That's more or less what I did with the subtree clone series [1] and
ended up doing narrow clone [2]. The only difference between the two
are how to handle partial worktree/index. The former uses git-replace
to seal any holes, the latter tackles at pathspec level and is
generally more elegant.

The worktree part from that work should be usable in full clone too. I
am reviving the series and going to repost it soon. Have a look [3] if
you are interested.

[1] http://thread.gmane.org/gmane.comp.version-control.git/152347
[2] http://thread.gmane.org/gmane.comp.version-control.git/155427
[3] https://github.com/pclouds/git/commits/narrow-clone
-- 
Duy
