From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 8/8] vcs-svn: allow to disable 'progress' lines
Date: Wed, 6 Jul 2011 17:10:07 +0530
Message-ID: <CALkWK0mVcEvaXiODtvNT0S88b4uuc_h1AZx-CLi6KN6KO2=ESw@mail.gmail.com>
References: <1309715877-13814-1-git-send-email-divanorama@gmail.com>
 <1309715877-13814-9-git-send-email-divanorama@gmail.com> <CALkWK0nWSVrrtzwE2ePucK=XTnSHWuojxhoayRSUbZmk1We9Fg@mail.gmail.com>
 <CA+gfSn-LEW36+bbxs1ydnhd3iQu-+wvrsSTuTszTYKm+jmuhOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 13:40:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeQT3-0007Rw-H8
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 13:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab1GFLk2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 07:40:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36079 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab1GFLk2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 07:40:28 -0400
Received: by wyg8 with SMTP id 8so4602195wyg.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 04:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5ULvL/z0G4o7r8TUpcL182I62TNVjk+nhBl6B3tN+XI=;
        b=ck4mgMy5c7L5rAoKif+8cuwlmC+ENHESpVT4Xh5CzOmVz4nzmMW7dhQDoVJS9BaM4j
         fktK2HSg76xB4HNpC7I7yhfW4DLCwGGlKjfYuPCdYYhf9e1f5YeQithBwvq9nCkHPmXI
         VqY64rhUeJ/BB3C3CK4/DPi6EZhPFAOwjd4Kc=
Received: by 10.216.187.65 with SMTP id x43mr5883066wem.62.1309952427096; Wed,
 06 Jul 2011 04:40:27 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 04:40:07 -0700 (PDT)
In-Reply-To: <CA+gfSn-LEW36+bbxs1ydnhd3iQu-+wvrsSTuTszTYKm+jmuhOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176694>

Hi again,

Dmitry Ivankov writes:
>>> - =C2=A0 =C2=A0 =C2=A0 if (svndump_init(NULL, url, ref, backflow_fd=
))
>>> + =C2=A0 =C2=A0 =C2=A0 if (svndump_init(NULL, url, ref, backflow_fd=
, progress))
>>
>> You're modifying the svndump_init API for every new option that's
>> added. =C2=A0This'll clearly break down when you have many options -=
- how
>> about wrapping it up in an options structure and then passing that?
> Well, there has to be a function to init that structure then. And the
> structure will become a part of API.
> So don't know if it's worthy.

Well, you'll be wrapping up url, ref, backflow_fd, progress, and all
other future command-line parameters in one variable.  Think about it.
 You can use the parse-options API to fill in default arguments
anyway.

>>> diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
>>> index a7ad368..f1a459e 100644
>>> --- a/contrib/svn-fe/svn-fe.txt
>>> +++ b/contrib/svn-fe/svn-fe.txt
>>> @@ -39,6 +39,9 @@ OPTIONS
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Integer number of file descriptor from w=
hich
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0responses to 'ls' and 'cat-blob' request=
s will come.
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Default is fd=3D3.
>>> +--[no-]progress::
>>> + =C2=A0 =C2=A0 =C2=A0 Write 'progress' lines to fast-import stream=
=2E These
>>> + =C2=A0 =C2=A0 =C2=A0 can be displayed by fast-import.
>>
>> Hm, this will make it a little too silent for the end-user. =C2=A0Wh=
at do
>> you feel about printing something minimalistic like a '.' for each
>> imported revision? Atleast it won't look like it's hung.
> For a medium 8k commit repo it is 100 lines - still too much.
> A single line for the first revision seem harmless and will indicate
> that the remote connection succeeded
> (helps to see that it's not a connection timeout, probably caused by
> dns lookup or a firewall).

Ah, right. I agree with you.

>> =C2=A0Also, how does this interact with the 'progress' option of fas=
t-import protocol?
> git fast-import --quiet prints any progress line produced by a helper=
=2E
> transport-helper.c tries to set the option
> but doesn't fail if it is not accepted or if helper doesn't support
> options at all.
> For now the helper doesn't use this protocol option.
>
> A better solution could be to use progress.o api to display progress.
> Or an ad-hoc hack with adaptive progress step, say report a progress
> on each "power of two"-th revision.
> As a starting point for tests let there bust a simple switch-off.

Yeah, that makes sense -- would love to see that in future.

>>> -void fast_export_init(int fd, const char *dst_ref)
>>> +void fast_export_init(int fd, const char *dst_ref, int progress)
>>> =C2=A0{
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0first_commit_done =3D 0;
>>> + =C2=A0 =C2=A0 =C2=A0 print_progress =3D progress;
>>
>> The only reason you're modifying the API of fast_export_init is so
>> that it can set a global static variable?
> Looked once more at how these new variables are used. We can move
> progress lines generation to svndump.c. And also move ref_name from
> _init and being global static to a parameter in fast_export_begin_com=
mit(),
> and to be more sane s/revision/target_mark/ s/revision - 1/from_mark/=
 and
> add a from_mark parameter, move first_commit_done logic to svndump.o.
> This way fast_export.o can operate on single commits and maybe it'll =
be
> easier to use it to apply svn branches layout in svn-fe in one run, t=
hough I'm
> not sure I'll use svn-fe to manage svn branches.

Makes sense.
Thanks.

-- Ram
