From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 8/9 v13] difftool: teach difftool to handle directory diffs
Date: Sun, 15 Apr 2012 18:01:06 -0700
Message-ID: <CAJDDKr78T1HNFXPPnvMUxBoJhAHP8XGdk9ZbpQCS1sZEQJfR8w@mail.gmail.com>
References: <1334335002-30806-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr7Uw3Nwg4p7F2zaY8f82j3_tRf3WiiO+YSN+nA6a9wY6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 03:01:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJaJw-0004kI-Ay
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 03:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab2DPBBI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Apr 2012 21:01:08 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48634 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab2DPBBH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2012 21:01:07 -0400
Received: by yenl12 with SMTP id l12so2250432yen.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 18:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6CH4ixEd7tZGxMDy5STzkmOBSSbKRBimlLvZsgDXhOQ=;
        b=Vh4WxDvxeBsbJ57xcWE7cIcmYkeqxg0Xe6TsbL3A95h0/CNxEvDhm6H3SYnCidbslO
         xiH7EZ1VfRSR8+pFIRb3sMXA+UIp4H8mxnufO4FMzQ4EN802Av7BRTpVwcKyOzXTjFca
         JsgspomVKhuovRAH2hLUE1tapD/3Lit+0NoGIC5Ld1XvC1aCbYnVexcMrf6RDd7FKFSw
         /jmpTZicxuB9qCrBEh5Rjr6n5JkH8Y6DNXRIb7dPy/KyKwu68VeAj9WgX5v/87ib9Sxc
         JW/KsNpaiykMeOqJiWUv8Ld6G5rdKrnH7+95FGnWbbbeAor67PYaXBqo/0XHCyNxZJVA
         kHbQ==
Received: by 10.100.213.8 with SMTP id l8mr2076395ang.29.1334538066531; Sun,
 15 Apr 2012 18:01:06 -0700 (PDT)
Received: by 10.147.128.8 with HTTP; Sun, 15 Apr 2012 18:01:06 -0700 (PDT)
In-Reply-To: <CAJDDKr7Uw3Nwg4p7F2zaY8f82j3_tRf3WiiO+YSN+nA6a9wY6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195596>

On Sun, Apr 15, 2012 at 3:20 PM, David Aguilar <davvid@gmail.com> wrote=
:
> On Fri, Apr 13, 2012 at 9:36 AM, Tim Henigan <tim.henigan@gmail.com> =
wrote:
>> When 'difftool' is called to compare a range of commits that modify
>> more than one file, it opens a separate instance of the diff tool fo=
r
>> each file that changed.
>>
>> The new '--dir-diff' option copies all the modified files to a tempo=
rary
>> location and runs a directory diff on them in a single instance of t=
he
>> diff tool.
>>
>> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
>> ---
>>
>> This replaces v12 of the script that was sent to the list on April 1=
2, 2011.
>>
>> Changes in v13:
>>
>> The 'git diff' command is now called via 'Git->repository->command_o=
neline'
>> again. We need to run the command in a way that allows @ARGV to be g=
iven
>> as a list, rather than a string, to insure that IFS and shell meta-
>> characters are handled properly. =C2=A0Thanks to Junio Hamano for po=
inting
>> this out [1].
>>
>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/195326/f=
ocus=3D195353
>
> Thanks Tim. =C2=A0Sorry for reading this patch out of context and mis=
sing
> the obvious point that it needs the diff output to do something usefu=
l
> in my last review.
>
> I started testing this patch. =C2=A0I started on the commit before wh=
at's
> in pu and then applied this patch:
>
> $ git checkout e9653615fafcbac6109da99fac4fa66b0b432048
> $ git am difftool.patch
>
> The basics work and I know folks will be really happy when this
> feature lands. =C2=A0Folks have personally asked me for this feature =
in the
> past. =C2=A0I dig it. =C2=A0I'd also like to help pursue using symlin=
ks sometime
> in the future if that sounds like a reasonable thing to you, but the
> stabilizing the existing implementation is more important right now.
>
> I ran into some issues when trying it against a few random commits. =C2=
=A0I
> went pretty far back in git's history to see what would happen.
>
> $ git difftool --dir-diff e5b06629de847663aaf0f7daae8de81338da3901 | =
tail
> Use of uninitialized value $rmode in string eq at
> /home/david/src/git/git-difftool line 96.

I did some more investigating.  I think this happens when the diff
contains detected renames.

This command made it work:

$ git difftool --dir-diff --no-renames e5b06629de847663aaf0f7daae8de813=
38da3901

So I think we might need to specify --no-renames when calling git diff =
--raw.

xxdiff still gives an error message about "$tmp/left/RelNotes: No such
file or directory" with --no-renames so we may want to touch some
dummy files to make the tools happy.
--=20
David
