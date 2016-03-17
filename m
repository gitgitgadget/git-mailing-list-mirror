From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 19/19] hack: watchman/untracked cache mashup
Date: Thu, 17 Mar 2016 20:06:14 +0700
Message-ID: <CACsJy8Cx7LnPC1+17qov_pJK9OMpYtdOzS_uTBh5Fnr=A8z_OQ@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
 <1457548582-28302-20-git-send-email-dturner@twopensource.com>
 <CACsJy8DGEQJmhxZpX3Zd=tGk_9T0n+ZhcaaEahaqFuh6NRvgSQ@mail.gmail.com> <1458176165.9385.9.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 14:06:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agXda-0000Tj-Tc
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 14:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431AbcCQNGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 09:06:48 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34510 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756419AbcCQNGp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 09:06:45 -0400
Received: by mail-lf0-f43.google.com with SMTP id e138so40783438lfe.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vVTLBAW26P9qAbiR5DSTecFOA2A6i2/m592/0DYZvG4=;
        b=E0pE3nKF3dywlbYq/MWzC22vLngaSooT3Yb9B7MpDi5qczV+AFmfTG0fJ3py/Fph4Y
         0W20UFCpLDbegyXVf9d4J6f4iYQwQGHIXeJVilBHseCNBjpBV/ZRod/RJwJGLdPqyH7H
         Riz0gC44GWpLbIgVoC6aNBebQpRel5LuP1iRs+Yb2XXn6vxLFd8SRC5/pXdLTFeIES3m
         tbsP6Cfa7uoOSTdTSn/CZBwLQLweEKJv4lnElbFhY1I3sUjJKlBBbo/S10z/l6Chu9+c
         Bmta8Jqhk+ba5dbqVNDdNnJG5BKuOfijm+iKh5SvweRBvRbFMLAE89yZnUz08T+WXOty
         Cddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vVTLBAW26P9qAbiR5DSTecFOA2A6i2/m592/0DYZvG4=;
        b=cx8wNgAfoi40JpN1BP/eYt1ER2DAA367O6feuNInEUl6z+ejOvSfnKPikYF1Ky3LiL
         gTND7rGuE/8FxozpiHXN+6bJNPHzNyDhYwjCUQpywANqbPEWzXVzTpTS3TNrn2gG5iBa
         n46s2vADZE4hxBQt5gG/krLNkH5wJUn2WEho+5FTGEpEG3p/EA5w5Pfw6zuLeahPwcZq
         45jNXmRtG/eK6i0H0U2Bk3dm648qkhbOF8idxdfvk3V1YcPR8OCRQc5+YbWqNDB6mO88
         hHdX6zv6C4V7RGV0iZe/yB562BlMNDZ6457zd8PXM1fpHCNFt7S1rD+fxoyoAamPcg3w
         8LIQ==
X-Gm-Message-State: AD7BkJLsLtC1slip8yY/nqRIODyckMmXa18rFmKx4y+jA7cZjOTFd+2DYYDyzUMHyyt1/yGHQcVeJJ1v8mAilA==
X-Received: by 10.25.23.94 with SMTP id n91mr2925384lfi.3.1458220004012; Thu,
 17 Mar 2016 06:06:44 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 17 Mar 2016 06:06:14 -0700 (PDT)
In-Reply-To: <1458176165.9385.9.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289110>

On Thu, Mar 17, 2016 at 7:56 AM, David Turner <dturner@twopensource.com> wrote:
>> So if we detect an updated file that's not in the index, we are
>> prepared to invalidate that path, correct? We may invalidate more
>> than
>> necessary if that's true. Imagine a.o is already ignored. If it's
>> rebuilt, we should not need to update untracked cache.
>
> Yes, that's true.  But it would be true with the mtime system too. This
> is no worse, even if it's no better.  In-tree builds are a hard case to
> support, and I'm totally OK with a system that encourages out-of-tree
> builds.
>
> We could check if it's ignored, but then if someone changes their
> gitignore, we could be wrong.
>
> Or we could suggest that people make their watchmanignore match their
> gitignore.

So your purpose is to reduce stat() on those "quiet" directories?
Putting it that way, yes it's reasonable to do this way. I want to "do
better" but we can do in steps and the first step "no worse, no
better" is already good.

>> What I had in mind (and argued with watchman devs a bit [1]) was
>> maintain the file list of each clock and compare the file list of
>> different clocks to figure out what files are added or deleted. Then
>> we can generate invalidation list more accurately. We need to keep at
>> least one file list corresponds to  the clock saved in the index.
>> When
>> we get the refresh request, we get a new file list (with new clock),
>> do a diff then save the invalidation list as an extension. Once we
>> notice that new clock is written back in index, we can discard older
>> file lists. In theory we should not need to keep too many file lists,
>> so even if one list is big, it should not be a big problem.
>>
>> I have a note with me about race conditions with this approach, but I
>> haven't remembered exactly why or how yet.. My recent thoughts about
>> it though, are race conditions when you do "git status" is probably
>> tolerable. After all if you're doing some I/O when you do git-status,
>> you're guaranteed to miss some updates.
>>
>> [1] https://github.com/facebook/watchman/issues/65
>
> I think it would be possible to just check the UNTR extension and only
> add a dir to it if that dir doesn't already contain (untracked) the
> file that's being modified.  Or is that also racy?

Sorry can't comment on this racy thing yet. Still haven't sat down,
redrawn the timeline and retraced what I thought months ago :)
-- 
Duy
