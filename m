From: Craig Silverstein <csilvers@khanacademy.org>
Subject: Re: [PATCH] git-new-workdir: support submodules
Date: Fri, 23 Jan 2015 16:48:40 -0800
Message-ID: <CAGXKyzEwAjCNTxRtjSuFh9b6BzzOYKOQryKtXBGY3_hkkFvyVw@mail.gmail.com>
References: <CAGXKyzHoLLgkXk0X4UVtLBEryqsHriKmmO5+2iVWk3mR8y7=Hw@mail.gmail.com>
Reply-To: csilvers@khanacademy.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 24 01:48:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEou6-0002an-QW
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 01:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbbAXAsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 19:48:43 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:46690 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbbAXAsl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 19:48:41 -0500
Received: by mail-ig0-f173.google.com with SMTP id a13so455773igq.0
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 16:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khanacademy.org; s=google;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=iD28GncCGqkg78WmPoto3v+kq6ABo9q/LB1oTMKNcRk=;
        b=lg5kUfudPCEpjhad/vg4/HcrAulEJpzZaGPkgU4Gf98UDzwnyOOIOOsZvGphqcfjMr
         b3MEqylG0bMKcniZw5kcF9G9s8MOr0CpKbxRW8QMWlDQ4xQJTqTU9yCYOOL4SIk4CdO/
         zA7oiaCRW8GXri7vHkHxtZKD2dlYi1CcXywL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=iD28GncCGqkg78WmPoto3v+kq6ABo9q/LB1oTMKNcRk=;
        b=aQwQfrdZ6A1w3UGdqE+rdw0wmmqVdpoExx3NtxbZ28WzFaZ55wrW7SdEnLjo+V2rTC
         ly2EclzFZHgRjUAvFT5xHkeYF0qKtEs0w+44zeURS+NJZ0E9EgcxYac8fb0Isji7CrI5
         5ufdTmw6a+ZL+6EWXqSfuMWKVgQxZY/UYGS4l35JltP0zGqo4l5gqacNQXO0JuEJZdmb
         EDJmmNMLbQArdp/upsejF4QwfgTU6cEw9QrKQJYb5872JV6ucNNucQglzvOr2Y4jgqJy
         UE25dLW/CTaKh1JtDZ4fwbkDLj1+hJKgvXIv9LlgUK9xa0/j7dVBTyxpuitgEE+sWOzr
         YTiw==
X-Gm-Message-State: ALoCoQl/xitnusc7ktTJnw5dhZ0iM2vaLjFIcknXkdiddeUE9GN5duz+dJ1VhER6AuBf+1sLj9n3
X-Received: by 10.43.19.134 with SMTP id qk6mr11328320icb.29.1422060520890;
 Fri, 23 Jan 2015 16:48:40 -0800 (PST)
Received: by 10.36.76.76 with HTTP; Fri, 23 Jan 2015 16:48:40 -0800 (PST)
In-Reply-To: <CAGXKyzHoLLgkXk0X4UVtLBEryqsHriKmmO5+2iVWk3mR8y7=Hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262982>

Ping! (now that the holidays are past)

craig

On Tue, Dec 23, 2014 at 1:51 PM, Craig Silverstein
<csilvers@khanacademy.org> wrote:
> [Ack, I forgot to cc myself on the original patch so now I can't reply
> to it normally.  Hopefully my workaround doesn't mess up the threading
> too badly.]
>
> Junio C Hamano <gitster <at> pobox.com> writes:
>>
>> Hmmmm, does that mean that the submodule S in the original
>> repository O's working tree and its checkout in the secondary
>> working tree W created from O using git-new-workdir share the same
>> repository location?  More specifically:
>>
>>     O/.git/                 - original repository
>>         O/.git/index            - worktree state in O
>>         O/S                     - submodule S's checkout in O
>>         O/S/.git                - a gitfile pointing to O/.git/modules/S
>>     O/.git/modules/S        - submodule S's repository contents
>>         O/.git/modules/S/config - submodule S's config
>>
>>     W/.git/                 - secondary working tree
>>         W/.git/config           - symlink to O/.git/config
>>         W/.git/index            - worktree state in W (independent of O)
>>     W/S                     - submodule S's checkout in W (independent of O)
>>     W/S/.git                - a gitfile pointing to O/.git/modules/S
>
> Right until the last line.  The .git file holds a relative path (at
> least, it always does in my experience), so W/S/.git will point to
> W/.git/modules/S.
>
> Also, to complete the story, my changes sets the following:
>
>         W/.git/modules/S    - secondary working tree for S
>              W/.git/modules/S/config   - symlink to O/.git/modules/S/config
>              W/.git/modules/S/index    - worktree state in W's S
> (independent of O and O's S)
>
>> Doesn't a submodule checkout keep some state tied to the working
>> tree in its repository configuration file?
>
> Do you mean, in 'config' itself?  If so, I don't see it.  (Though it's
> possible there are ways to use submodules that do keep working-tree
> state in the config file, and we just happen not to use those ways.)
> Here's what my webapp/.git/modules/khan-exercises/config looks like:
> ---
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = false
>         logallrefupdates = true
>         worktree = ../../../khan-exercises
> [remote "origin"]
>         url = http://github.com/Khan/khan-exercises.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>         remote = origin
>         merge = refs/heads/master
>         rebase = true
> [submodule "test/qunit"]
>         url = https://github.com/jquery/qunit.git
> --
>
> The only thing that seems vaguely working-tree related is the
> 'worktree' field, which is the field that motivated me to set up my
> patch the way it is.
>
>> Wouldn't this change
>> introduce problems by sharing O/.git/modules/S/config between the
>> two checkouts?
>
> It's true that this change does result in sharing that file, so if
> that's problematic then you're right.  I'm afraid I don't know all the
> things that can go into a submodule config file.
>
> (There are other things I don't know as well, such as: do we see .git
> files with 'gitdir: ...' contents only for submodules, or are there
> other ways to create them as well?  Are 'gitdir' paths always
> relative?  Are there special files in .git (or rather .git/modules/S)
> that exist only for submodules and not for 'normal' repos, that we
> need to worry about symlinking?  I apologize for not knowing all these
> git internals, and hope you guys can help point out any gaps that
> affect this patch!)
>
> craig
