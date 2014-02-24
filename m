From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] commit: add --cleanup=scissors
Date: Tue, 25 Feb 2014 06:28:29 +0700
Message-ID: <CACsJy8AkxJqXvR3H36+m_GJ0Z3z8XLw+Our0Eu7X5B6ZZ1C-nQ@mail.gmail.com>
References: <1392521840-21628-1-git-send-email-pclouds@gmail.com>
 <1392639332-7703-1-git-send-email-pclouds@gmail.com> <1392639332-7703-4-git-send-email-pclouds@gmail.com>
 <20140222005856.GA9231@lanh> <xmqqd2icbf75.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 25 00:29:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI4xP-0006sC-Ly
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 00:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbaBXX3A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Feb 2014 18:29:00 -0500
Received: from mail-qa0-f50.google.com ([209.85.216.50]:63685 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbaBXX27 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Feb 2014 18:28:59 -0500
Received: by mail-qa0-f50.google.com with SMTP id cm18so4911425qab.9
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 15:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2LqiTiTEi5coDGHVhPFnK9Qra87H9rBBisy6G4QXlqI=;
        b=i2h+hicB1JYUetK1V4m+sMd6ImtJ11eSBLA49jnfn57dFz5pwcEVOSqhO0mFZWThBy
         0ek2zpyL9Fvtm9sKROgLOXa8tcQ4nMXN9hL/t0Rez/4zQfyYq7C4Dbh4+q+mF/dTUMhy
         2WAxaTXR7SJ5wNKNpaGV8MQWT8skUntGeNlmavRm4cYpqxehOtpDlj1H5fcC3NXMrCV3
         vfa61D6e3SKaXOkd/5G1XXBien5dvGrJbhIvTBYdjcwZWh8tubk1slcG3IO046PtfqX0
         5kMTlHWJ7Y5t19voCnMpPyyqbWqbfHZR2S3AizEvAfS5iYee/gHSQrjeh92mFd20bqtf
         va+w==
X-Received: by 10.140.84.40 with SMTP id k37mr25701991qgd.98.1393284539073;
 Mon, 24 Feb 2014 15:28:59 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Mon, 24 Feb 2014 15:28:29 -0800 (PST)
In-Reply-To: <xmqqd2icbf75.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242652>

On Tue, Feb 25, 2014 at 12:20 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Mon, Feb 17, 2014 at 07:15:32PM +0700, Nguy=E1=BB=85n Th=C3=A1i N=
g=E1=BB=8Dc Duy wrote:
>>> @@ -777,6 +778,8 @@ static int prepare_to_commit(const char *index_=
file, const char *prefix,
>>>                              _("Please enter the commit message for=
 your changes."
>>>                                " Lines starting\nwith '%c' will be =
ignored, and an empty"
>>>                                " message aborts the commit.\n"), co=
mment_line_char);
>>> +            else if (cleanup_mode =3D=3D CLEANUP_SCISSORS)
>>> +                    wt_status_add_cut_line(s->fp);
>>>              else /* CLEANUP_SPACE, that is. */
>>>                      status_printf(s, GIT_COLOR_NORMAL,
>>>                              _("Please enter the commit message for=
 your changes."
>>
>> This cut line does not cover the merge conflict message before it. T=
he
>> following patch should be squashed in to move the cut line up in tha=
t
>> case.
>
> I somehow thought that it was a policy decision we made in very
> early days that these conflict messages are meant to be edited with
> explanation of how they were resolved, not to be simply edited away?
>
> The other stuff (commented out instructions and patch text) are
> meant to aid humans while editing the log message, and stripping
> away automatically after they are done editing like your patch does
> is perfectly fine, but I find this change questionable.

I think I described it incorrectly as "conflict message" while it's
not. This is the part to be cut out by the patch

# It looks like you may be committing a merge.
# If this is not correct, please remove the file.
#     MERGE_HEAD
# and try again.

(similar message for CHERRY_PICK_HEAD).

>
>> -- 8< --
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index ea2912f..1033c50 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -755,7 +755,9 @@ static int prepare_to_commit(const char *index_f=
ile, const char *prefix,
>>       strbuf_addstr(&committer_ident, git_committer_info(IDENT_STRIC=
T));
>>       if (use_editor && include_status) {
>>               char *ai_tmp, *ci_tmp;
>> -             if (whence !=3D FROM_COMMIT)
>> +             if (whence !=3D FROM_COMMIT) {
>> +                     if (cleanup_mode =3D=3D CLEANUP_SCISSORS)
>> +                             wt_status_add_cut_line(s->fp);
>>                       status_printf_ln(s, GIT_COLOR_NORMAL,
>>                           whence =3D=3D FROM_MERGE
>>                               ? _("\n"
>> @@ -771,6 +773,7 @@ static int prepare_to_commit(const char *index_f=
ile, const char *prefix,
>>                               git_path(whence =3D=3D FROM_MERGE
>>                                        ? "MERGE_HEAD"
>>                                        : "CHERRY_PICK_HEAD"));
>> +             }
>>
>>               fprintf(s->fp, "\n");
>>               if (cleanup_mode =3D=3D CLEANUP_ALL)
>> @@ -778,7 +781,7 @@ static int prepare_to_commit(const char *index_f=
ile, const char *prefix,
>>                               _("Please enter the commit message for=
 your changes."
>>                                 " Lines starting\nwith '%c' will be =
ignored, and an empty"
>>                                 " message aborts the commit.\n"), co=
mment_line_char);
>> -             else if (cleanup_mode =3D=3D CLEANUP_SCISSORS)
>> +             else if (cleanup_mode =3D=3D CLEANUP_SCISSORS && whenc=
e =3D=3D FROM_COMMIT)
>>                       wt_status_add_cut_line(s->fp);
>>               else /* CLEANUP_SPACE, that is. */
>>                       status_printf(s, GIT_COLOR_NORMAL,
>> -- 8< --



--=20
Duy
