From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH] contrib: added git-diffall
Date: Tue, 21 Feb 2012 21:02:43 -0500
Message-ID: <CAFouetiLmK3dXLRkBh+cTNA_OMPS77xo8z95WK5y4tk-o-UUog@mail.gmail.com>
References: <1329785969-828-1-git-send-email-tim.henigan@gmail.com>
	<7vd397g8ic.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 03:02:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S01Xc-0008EW-K5
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 03:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294Ab2BVCCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 21:02:44 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58716 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab2BVCCn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 21:02:43 -0500
Received: by iacb35 with SMTP id b35so9680317iac.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 18:02:43 -0800 (PST)
Received-SPF: pass (google.com: domain of tim.henigan@gmail.com designates 10.50.11.200 as permitted sender) client-ip=10.50.11.200;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tim.henigan@gmail.com designates 10.50.11.200 as permitted sender) smtp.mail=tim.henigan@gmail.com; dkim=pass header.i=tim.henigan@gmail.com
Received: from mr.google.com ([10.50.11.200])
        by 10.50.11.200 with SMTP id s8mr23828283igb.10.1329876163157 (num_hops = 1);
        Tue, 21 Feb 2012 18:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5OX6P98nN7iBAnQmDWaNXd7hgAJNUAqlqDQysjZTbMU=;
        b=udvEZ3xiSIrv/u5mBmDEc5gIe3Do5Kc5Cw8pz7WklBntlBS73KltXvqH7zVDvgqqeL
         3pzezJVobdARSsDHo99DhgNfHhD2AQYh3zaWs9i73qsPs+EfCwPVTbSy/CXyfYySefKC
         1fczas/bWa6x+hL/xFHB49yO2EGXHkfwPx1RM=
Received: by 10.50.11.200 with SMTP id s8mr19268883igb.10.1329876163057; Tue,
 21 Feb 2012 18:02:43 -0800 (PST)
Received: by 10.42.220.136 with HTTP; Tue, 21 Feb 2012 18:02:43 -0800 (PST)
In-Reply-To: <7vd397g8ic.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191219>

Thank you for taking the time to review this patch.  I appreciate it.


On Tue, Feb 21, 2012 at 4:51 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tim Henigan <tim.henigan@gmail.com> writes:

>> +#!/bin/bash -e
>
> Does this have to be bash-only (iow, infested with bash-isms beyond
> repair), or is you wrote this merely from inertia?

There is no specific reason it must be bash.  I changed from
"#!/bin/sh" to "#!/bin/bash -e" due to a bug report from a user on
Ubuntu [1].  The user reported that:

    "If you use /bin/sh on ubuntu you get the dash shell instead of bas=
h shell.
    This causes git_merge_tool_path to fail. The error isn't trapped,
so it exits
    without displaying anything and without cleaning up."

Given that all the other scripts distributed with git use /bin/sh, I
will change this script to match.


> The following is only after a cursory scanning, so there may be other
> things that needs fixing, but anyway:
>
> =C2=A0- Don't use "which" in scripts. =C2=A0Its output is not machine=
 parseable, and
> =C2=A0 exit code is not reliable, across platforms. =C2=A0It is only =
meant for
> =C2=A0 consumption by human who can read English (or natural language=
 in the
> =C2=A0 current locale).

I used "which" in two places.  Both were added to support problems
with missing standard tools on certain platforms (missing mktemp on
msysgit and missing option from tar on Mac [2]).  Is there some other
standard way to detect the platform or if certain utils are present?

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if test -z "$paths"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 paths=3D$1
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 paths=3D"$p=
aths $1"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi
>
> Just a style tip; if you are going to let shell $IFS split this list
> anyway, it is customary to write the above as
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0paths=3D"$paths$1 "

Nice...I will change to use this format.


>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git diff --name-only "$l=
eft"..."$right" -- $paths > "$tmp"/filelist
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff ... -- $paths >"$tmp/filelist"
=2E.. <snip>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mkdir -p "$tmp/$left_dir" "$tmp/$right_dir=
"

Will change all instances.


>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if test -n "$compare_sta=
ged"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ls_list=3D$(git ls-tree HEAD $name)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if test -n "$ls_list"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mkdir -p "$tmp"/"$left_dir"/"$(dirname =
"$name")"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git show HEAD:"$name" > "$tmp"/"$left_d=
ir"/"$name"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mkdir -p "$tmp"/"$left_dir"/"$(dirname =
"$name")"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git show :"$name" > "$tmp"/"$left_dir"/=
"$name"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi
>
> That's misleadingly indented. =C2=A0First I thought "in what case wou=
ld we want
> to switch the LHS between HEAD:$path and :$path when doing diff --cac=
hed?"
> but the overindented four lines starting from the funny "fi" is about=
 non
> cached case.

That is embarrassing.  I will fix it.

<snip>

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 find "$tmp/$right_dir" -=
type f|while read file; do
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 cp "$file" "$git_top_dir/${file#$tmp/$right_dir/}"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 done
>
> Why is this loop written in such a dense way? =C2=A0Everything else (=
except for
> that misindented part) were almost to our CodingStyle and was fairly =
easy
> to read, though.

I missed this in my style cleanup.  I will fix it.


>> + =C2=A0 =C2=A0 fi
>> +
>> + =C2=A0 =C2=A0 # Remove the tmp directory
>> + =C2=A0 =C2=A0 rm -rf "$tmp"
>> +}
>> +
>> +trap cleanup EXIT
>
> Does this even trigger? =C2=A0This is not Perl that parses and runs s=
et-up code
> before executing everything else, so I suspect this last line amounts=
 to
> the same thing as writing just
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cleanup
>
> without trap nor signal names.

The cleanup triggers on all the platforms I have tested (Ubuntu,
msysgit, Mac).  I could change it, but for me it has "just worked".


> If you are to set up temporary files or directories that you want to =
clean
> up, a good discipline is to follow this order:
>
> =C2=A0- define variable(s) to hold the temporary locations, e.g.
> =C2=A0 =C2=A0tmpdir=3D$(mktemp ...)
>
> =C2=A0- set the trap before starting to use these temporary locations=
, e.g.
> =C2=A0 =C2=A0trap 'rm -rf "$tmpdir' 0 1 2 3 15
>
> =C2=A0- and then start populating tmpdir and do whatever you want to =
do.

I will review the changes needed for this before submitting v2 of my pa=
tch.

[1]: https://github.com/thenigan/git-diffall/pull/9
[2]: https://github.com/thenigan/git-diffall/pull/2#issuecomment-498472
