From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: DWIM .git repository discovery
Date: Thu, 27 Sep 2012 08:22:55 -0400
Message-ID: <CAM9Z-nkCos979Kte+k+wYKZMzo625JhWjmye2zraPKk0BgTHmw@mail.gmail.com>
References: <CACsJy8DOtPWgkq=KSHCb=J3qg4o1aPaLo4aj7U5f_qa+kCCipQ@mail.gmail.com>
	<7v7grhv2fu.fsf@alter.siamese.dyndns.org>
	<CACsJy8B5xXSrqoYX_5BW34Sq0QpP6U=E6e+prJRe_0FWf4Bz0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 14:23:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THD7S-0008Mh-5w
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 14:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab2I0MW5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2012 08:22:57 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61931 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab2I0MW4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Sep 2012 08:22:56 -0400
Received: by bkcjk13 with SMTP id jk13so1664058bkc.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 05:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LHTzRck3D7eV66Fciz6a2kCuP8k5kyd/rDbsKl/aJUM=;
        b=wrtR/ZfQxwv4kn0+UQAbFNYkCmHQWJjCL/h61MFOBJrGY0V0ygy47TLsTvON6DQvxs
         cXBEhbsjonAr06I9fhuxGtLPW4ZSzaDJpuJO29ZdE8SoouH/mybGdxk9bH/V5mSOTJls
         7aKpMPSrnoJzAYG6H/jbZYsCpQa0fHsm2Aa+0hExqLr3YH/KuyMDKdYAzexvK+a6SftH
         nrDQfp5edqhHmIwDj3jSnnWFkx334xQA1ab5NMfnlAszRb6O+SI5wAzb0b4xoGHqAD99
         bTZMZZUGrNkWSpma5GVSXx39qI9rQdIom+5oNzyxjtPYsAJRIQqyi52deiuaTUchO4MV
         MnRw==
Received: by 10.204.156.208 with SMTP id y16mr2065845bkw.76.1348748575293;
 Thu, 27 Sep 2012 05:22:55 -0700 (PDT)
Received: by 10.204.10.87 with HTTP; Thu, 27 Sep 2012 05:22:55 -0700 (PDT)
In-Reply-To: <CACsJy8B5xXSrqoYX_5BW34Sq0QpP6U=E6e+prJRe_0FWf4Bz0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206479>

On Wed, Sep 26, 2012 at 7:02 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Wed, Sep 26, 2012 at 11:21 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> I often find myself attempting to examine another repository,
>>> especially in projects that are closely related but put in differen=
t
>>> git repos. It's usually just a diff or log command
>>>
>>> git log --patch ../path/to/another/repo/path/to/file.c
>>
>> I personally do not think it is _too_ bad to internally do
>>
>>         (cd ../path/to/another/repo/path/to &&
>>          git log --patch file.c)
>>
>
> As long as the .git discovery and path rewriting can be done
> automatically, that'd be nice. But..

I do not think that it should be the job of Git to guess how you would
like your paths recannonicalized. That is truly a pathway to insanity.

>> but I doubt it is worth the numerous implications (I am not talking
>> about implementation complexity at all, but the conceptual burden).
>>
>> For example, where in the working tree of the other project should
>> the command run?  The output from "log -p" happens to be always
>> relative to the top of the working tree, but that does not
>> necessarily hold true for other subcommands.

And for us to presume that changing how all of those operate now by
default would be a good idea is most definitely folly.

> Returned paths should always be relative to cwd (well except diff/log
> which are prefixed by [ab]/). cd'ing internally like above makes it
> more confusing imo. Take grep for example, I find it natural for "git
> grep foo -- ../other/repo/bar/" to return "../other/repo/bar/foo.c
> ...".

In Junio's example it would be relative to the working directory=E2=80=94=
of
the subshell. Neither the shell nor Git is in a position to clean that
up much if at all.

> Prefix currently does not take "../blah" form, but I see no reasons
> why it can't/shouldn't. $(cwd) is most likely outside the other
> project's working directory. An exception running from inside a
> submodule and examining the parent repository.

Is hacking the master project code from inside of a submodule what
this is actually about?

> For too long relative paths, we could even display in ":/" pathspec
> notation. Users who don't recognize them either look up documentation=
,
> or gradually learn to drop the ":/" part, even without know what it's
> for.
>
> Repo modification commands like git-add could cause greater confusion
> (I added and committed it (on the other repo), but when I pushed (on
> this repo), the changes aren't there). We could and probably should
> avoid dwim-ing these cases.

I think you just made a decent case for not doing too much "DWIM"
here. "DWIM" is a very fraught concept because you are assuming that
everybody is going to want to do things exactly (or nearly so) the way
you do.

>> I think that this is a road to insanity; anybody who thinks along
>> this line is already on the other side of the line, I would have to
>> say ;-).
>
> We could go slowly and stop before being diagnosed insane. I mean the
> trick can be opted in for a command subset where it makes sense to do
> so.

I would recommend stopping now then.

--=20
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
