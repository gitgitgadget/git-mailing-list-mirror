From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: DWIM .git repository discovery
Date: Thu, 27 Sep 2012 19:38:04 +0700
Message-ID: <CACsJy8CaWjV+is0WKh2kYiNfHOkN0M_Hs2wXzH3DUMtUeKMTAQ@mail.gmail.com>
References: <CACsJy8DOtPWgkq=KSHCb=J3qg4o1aPaLo4aj7U5f_qa+kCCipQ@mail.gmail.com>
 <7v7grhv2fu.fsf@alter.siamese.dyndns.org> <CACsJy8B5xXSrqoYX_5BW34Sq0QpP6U=E6e+prJRe_0FWf4Bz0w@mail.gmail.com>
 <CAM9Z-nkCos979Kte+k+wYKZMzo625JhWjmye2zraPKk0BgTHmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 14:38:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THDMb-00079O-N9
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 14:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454Ab2I0Mig convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2012 08:38:36 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57781 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354Ab2I0Mif convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2012 08:38:35 -0400
Received: by ieak13 with SMTP id k13so4226657iea.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 05:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5jkLQZHmYozEpvkxbJlbSNwHeZJZF1t43P2+E4/XckA=;
        b=egfP5SjNbKqXJvHKvyB4qDXjg4au2rZ8A+CD2B41nnqVhxlnb5ZvxW0VLIHAt8HOTu
         CUV9vOQl44Po1wJSGYY2cQ6svYalgy7Z4lyhuNyDUzkYb6fGvuw7HTanG9v/QLhWIPTe
         +sy1XrMyRLfmwPvnVsNzQfWOljbLm3IQL4424Qv2QB8gpZDwzqtquVsJ5IcA2ClmPPBa
         nuFldQ7ZzbQVTtYQKMN311t3qEO7jXxNJ+Tk4/2ffRaMb4VeL2USe5vQC9/pirnUb77r
         i9AXGZN5KptGByS7e6A5J3QZo0Bh4AGL117Mi/rVfQe7s+J4D9ndMaesUpfawlrsYttj
         ljVQ==
Received: by 10.42.62.143 with SMTP id y15mr2848233ich.38.1348749515183; Thu,
 27 Sep 2012 05:38:35 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Thu, 27 Sep 2012 05:38:04 -0700 (PDT)
In-Reply-To: <CAM9Z-nkCos979Kte+k+wYKZMzo625JhWjmye2zraPKk0BgTHmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206480>

On Thu, Sep 27, 2012 at 7:22 PM, Drew Northup <n1xim.email@gmail.com> w=
rote:
>>> I personally do not think it is _too_ bad to internally do
>>>
>>>         (cd ../path/to/another/repo/path/to &&
>>>          git log --patch file.c)
>>>
>>
>> As long as the .git discovery and path rewriting can be done
>> automatically, that'd be nice. But..
>
> I do not think that it should be the job of Git to guess how you woul=
d
> like your paths recannonicalized. That is truly a pathway to insanity=
=2E

I believe we are doing that. We move cwd internally to top worktree,
so we rewrite (well, prefix) all paths.

>> Returned paths should always be relative to cwd (well except diff/lo=
g
>> which are prefixed by [ab]/). cd'ing internally like above makes it
>> more confusing imo. Take grep for example, I find it natural for "gi=
t
>> grep foo -- ../other/repo/bar/" to return "../other/repo/bar/foo.c
>> ...".
>
> In Junio's example it would be relative to the working directory=E2=80=
=94of
> the subshell. Neither the shell nor Git is in a position to clean tha=
t
> up much if at all.

That's implementation details.

>> Prefix currently does not take "../blah" form, but I see no reasons
>> why it can't/shouldn't. $(cwd) is most likely outside the other
>> project's working directory. An exception running from inside a
>> submodule and examining the parent repository.
>
> Is hacking the master project code from inside of a submodule what
> this is actually about?

Hacking, no. Examining, yes. And in my case, no submodules. It's gnome
projects where a bunch of libraries (in their own repositories) may be
needed for an application. I stay in the application directory but
from time to time I'll need to look outside in other repositories.
--=20
Duy
