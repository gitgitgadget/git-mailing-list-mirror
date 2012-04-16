From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 8/9 v13] difftool: teach difftool to handle directory diffs
Date: Mon, 16 Apr 2012 01:16:22 -0700
Message-ID: <CAJDDKr7dgW1-jyAuCw7raz47xtdUBuRscSq9pM=fvHe7CYJyDw@mail.gmail.com>
References: <1334335002-30806-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr7Uw3Nwg4p7F2zaY8f82j3_tRf3WiiO+YSN+nA6a9wY6w@mail.gmail.com>
	<CAJDDKr78T1HNFXPPnvMUxBoJhAHP8XGdk9ZbpQCS1sZEQJfR8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, ramsay@ramsay1.demon.co.uk
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 10:16:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJh6s-0005qh-0F
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 10:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab2DPIQZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 04:16:25 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33741 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab2DPIQX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 04:16:23 -0400
Received: by gghe5 with SMTP id e5so2297650ggh.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 01:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zQj7p7ES/guNObaLgwi7bwxm9dGnC3EslYZgnKzHkrw=;
        b=p+bfvE1OEwdlRMuJPXO6PpSE76YvPeZl2N5P/w2IhcXW+QIOiR6Szy1HfHluYDsrAN
         Ym5/IIJ8h8nLUpt06/WrGhp+BAbJNwo3xFmEpfE3kbU9tlPXFfbS++/ywcOA+qXR5rcu
         OcrPy32Yyvj3nVaBQilg4pUEVXbl7vr0ws77RrQstwLX6/Kr0dNHZot39CUot5Laqfbp
         iJI44v68k511vKEdh/LbndhB+5caWwqBMT6kI/WcJRJVxt7QFBbIVePACfbPqXMN8sw2
         xf6yo94WLEZrSia/jIaD8sHR/qn/t0WTkOFJVVd8U67eJ9BA9omsVS4sD+E8xOizICLl
         18uQ==
Received: by 10.236.161.3 with SMTP id v3mr9947071yhk.128.1334564182860; Mon,
 16 Apr 2012 01:16:22 -0700 (PDT)
Received: by 10.147.128.8 with HTTP; Mon, 16 Apr 2012 01:16:22 -0700 (PDT)
In-Reply-To: <CAJDDKr78T1HNFXPPnvMUxBoJhAHP8XGdk9ZbpQCS1sZEQJfR8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195602>

On Sun, Apr 15, 2012 at 6:01 PM, David Aguilar <davvid@gmail.com> wrote=
:
> On Sun, Apr 15, 2012 at 3:20 PM, David Aguilar <davvid@gmail.com> wro=
te:
>> On Fri, Apr 13, 2012 at 9:36 AM, Tim Henigan <tim.henigan@gmail.com>=
 wrote:
>>> When 'difftool' is called to compare a range of commits that modify
>>> more than one file, it opens a separate instance of the diff tool f=
or
>>> each file that changed.
>>>
>>> The new '--dir-diff' option copies all the modified files to a temp=
orary
>>> location and runs a directory diff on them in a single instance of =
the
>>> diff tool.
>>>
>>> Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
>>> ---
>>>
>>> This replaces v12 of the script that was sent to the list on April =
12, 2011.
>>>
>>> Changes in v13:
>>>
>>> The 'git diff' command is now called via 'Git->repository->command_=
oneline'
>>> again. We need to run the command in a way that allows @ARGV to be =
given
>>> as a list, rather than a string, to insure that IFS and shell meta-
>>> characters are handled properly. =C2=A0Thanks to Junio Hamano for p=
ointing
>>> this out [1].
>>>
>>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/195326/=
focus=3D195353
>>
>> Thanks Tim. =C2=A0Sorry for reading this patch out of context and mi=
ssing
>> the obvious point that it needs the diff output to do something usef=
ul
>> in my last review.
>>
>> I started testing this patch. =C2=A0I started on the commit before w=
hat's
>> in pu and then applied this patch:
>>
>> $ git checkout e9653615fafcbac6109da99fac4fa66b0b432048
>> $ git am difftool.patch
>>
>> The basics work and I know folks will be really happy when this
>> feature lands. =C2=A0Folks have personally asked me for this feature=
 in the
>> past. =C2=A0I dig it. =C2=A0I'd also like to help pursue using symli=
nks sometime
>> in the future if that sounds like a reasonable thing to you, but the
>> stabilizing the existing implementation is more important right now.
>>
>> I ran into some issues when trying it against a few random commits. =
=C2=A0I
>> went pretty far back in git's history to see what would happen.
>>
>> $ git difftool --dir-diff e5b06629de847663aaf0f7daae8de81338da3901 |=
 tail
>> Use of uninitialized value $rmode in string eq at
>> /home/david/src/git/git-difftool line 96.
>
> I did some more investigating. =C2=A0I think this happens when the di=
ff
> contains detected renames.
>
> This command made it work:
>
> $ git difftool --dir-diff --no-renames e5b06629de847663aaf0f7daae8de8=
1338da3901
>
> So I think we might need to specify --no-renames when calling git dif=
f --raw.
>
> xxdiff still gives an error message about "$tmp/left/RelNotes: No suc=
h
> file or directory" with --no-renames so we may want to touch some
> dummy files to make the tools happy.

Even better would be to parse the rename line in the diff output and
move/symlink the $left path to a location that corresponds to $right.
That way the diff tool will show a proper diff for renamed files.

One gotcha is that the $left side now has a name that didn't exist at
that commit, but it's a nicer experience then getting an empty file.

Renaming brings along issues such as file paths becoming directories
later in the history, and vice versa.

Deleted files may have similar issues to consider (I haven't checked ye=
t).
--=20
David
