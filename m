From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 06/20] checkout: check_linked_checkout: improve
 "already checked out" aesthetic
Date: Fri, 17 Jul 2015 08:42:59 +0700
Message-ID: <CACsJy8AGp7Y+nJjVvp2sgfTvPuKE2ODdfa3wsJ9YhPk57YOtCg@mail.gmail.com>
References: <1437034825-32054-1-git-send-email-sunshine@sunshineco.com>
 <1437034825-32054-7-git-send-email-sunshine@sunshineco.com>
 <xmqqy4ig3s3q.fsf@gitster.dls.corp.google.com> <CAPig+cRtCon=jaqbjZyHTvJ3cydiyAz+5OC=3x30VfAJniYYMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 03:43:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFugZ-0005n1-Sr
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 03:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbbGQBna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2015 21:43:30 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38220 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbbGQBn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2015 21:43:29 -0400
Received: by iggf3 with SMTP id f3so27295618igg.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2015 18:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2qY9vD43RErVC1nxtzL/FijBwPGeVzSER76aksOT8F8=;
        b=kxXnivI++e7Gt4JQuQH3dO/4H+fsFAQSDzRRSdrDl5XNpuf2Fh8rBSdSVfYCornmVw
         1FEwHFMKVl6+V9U9weKLvcg+Zdb2LQz7WVnZI2BZPDxlADOJS2ZLsEP8ZlrtT7M2F1eR
         4J1qdOINAprtpB2+1B3x3393BOK6NM0pgcj12UujtZf34DBZA9kSV9gJ6bt6Xyc2yxAb
         aQfPZzGpe1YiSV0C7wkfpRXodfyC0LfmmWPwJ2+58n1dYyTZ+1Lit7CV+kCnrDkNAzpi
         F6EsZe8ZwgIfbSkRZPCAwHlh9MbTv8ILhWzcQeOFOQfda3a9jSm0yJdcUcfvql6EQ4Ot
         v7ug==
X-Received: by 10.50.137.100 with SMTP id qh4mr7700602igb.1.1437097408782;
 Thu, 16 Jul 2015 18:43:28 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Thu, 16 Jul 2015 18:42:59 -0700 (PDT)
In-Reply-To: <CAPig+cRtCon=jaqbjZyHTvJ3cydiyAz+5OC=3x30VfAJniYYMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274056>

On Fri, Jul 17, 2015 at 7:32 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> In the new world order with GIT_DIR and GIT_COMMON_DIR, does
>> "$GIT_DIR" always have to be the same as "$GIT_WORK_TREE/.git"?  Do
>> we need some sanity check if that is the case?  Perhaps: if you have
>> $GIT_DIR set to $somewhere/.git/worktrees/$name, then
>>
>>  - $GIT_COMMON_DIR must match $somewhere/.git,
>>
>>  - $somewhere/.git/worktrees/$name/commondir must point at
>>    $GIT_COMMON_DIR,
>>
>>  - $GIT_WORK_TREE/.git must match $GIT_DIR
>>
>> or something like that?
>
> Duy is probably better suited to answer this, as he would likely have
> taken these issues into consideration when implementing the feature.
> (I've been poking through documentation and code for quite a while
> trying to answer this email but don't yet have a sufficient grasp to
> do it justice. I'm not even sure where such a sanity check would be
> placed.)

The thing is, we just don't know where the worktree is. All we know is
somewhere there is a .git file sharing this repository. People can
create a linked worktree, then move the actual linked worktree away,
set GIT_DIR/GIT_WORK_TREE to reflect that, and everything must still
work. So, we could say "foo is already checked out at the worktree
that is linked to /some/path/.git" to be technically correct. But
that's not so friendly? We could cache the $GIT_WORK_TREE, when the
user accesses the linked checkout, somewhere in .git/worktrees/foo and
show it instead of /some/path/.git. But that's not always accurate.
-- 
Duy
