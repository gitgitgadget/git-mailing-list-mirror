From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 02/27] Convert git_snpath() to strbuf_git_path()
Date: Fri, 7 Mar 2014 00:26:43 -0500
Message-ID: <CAPig+cR_JaaW18ng8Z8_hsXy3DNT216o7ogNLxmcW2+tp2Ax9Q@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-3-git-send-email-pclouds@gmail.com>
	<CAPig+cTjqrveuOS+3+bonwJa_Kjg=STJU1JJ2Kj7Gs5U9eEB9Q@mail.gmail.com>
	<CACsJy8DeGCdnWHOxTeGUV4CsHyV-u_DgR-03iyOrEKznsQsqGA@mail.gmail.com>
	<CACsJy8BwUa63yG0WownJQNedNE8JC+5_oG8PBs6sy7_tiHOh-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 06:27:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLnJF-0007U0-L7
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 06:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbaCGF0p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2014 00:26:45 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:55545 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbaCGF0o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2014 00:26:44 -0500
Received: by mail-yk0-f177.google.com with SMTP id q200so9504654ykb.8
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 21:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=mtoDwIh6q2yav9MXwatQx7E+31DmAO3uNk03nTkDhAU=;
        b=xL+o9IZIED1RC8JHz9gzVrsElBJhUkclSNTZgFEvM6Rw5QLUhwTMDQ46mXtnPrbWRC
         SFSzetDHCPwmE01K5T+xl9DNnxF2a4BNlWzU93SsbEdDC/BxMyLnMLfOqgXOu1qMCeB3
         IRUEp2cVHKJpupB0/LFI/O/uoofN7ElLWMkorWZhJVKPogeGTwepjLlA51wiFwzFJkqC
         GvxJnjcKt/uKfeRKyJ5/M0f0jjncD3Wa3XrMvxHLksgNnocX40LQ8zZYl+36x/QmU/R1
         CBvH4940UmeDqVwKMpvKwvBUVExxysKGZxYwq9yY4nWds8AX664Ilex4/em27ZtQcyQT
         9sbw==
X-Received: by 10.236.5.174 with SMTP id 34mr19526782yhl.48.1394170003532;
 Thu, 06 Mar 2014 21:26:43 -0800 (PST)
Received: by 10.170.180.134 with HTTP; Thu, 6 Mar 2014 21:26:43 -0800 (PST)
In-Reply-To: <CACsJy8BwUa63yG0WownJQNedNE8JC+5_oG8PBs6sy7_tiHOh-A@mail.gmail.com>
X-Google-Sender-Auth: St9DW-__4z__QgV_LLb1NZk_KLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243587>

On Fri, Mar 7, 2014 at 12:03 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Mar 3, 2014 at 7:15 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, Mar 3, 2014 at 7:02 AM, Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>>> On Sat, Mar 1, 2014 at 7:12 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>>> In the previous patch, git_snpath() is modified to allocate a new
>>>> strbuf buffer because vsnpath() needs that. But that makes it awkw=
ard
>>>> because git_snpath() receives a pre-allocated buffer from outside =
and
>>>> has to copy data back. Rename it to strbuf_git_path() and make it
>>>> receive strbuf directly.
>>>>
>>>> The conversion from git_snpath() to git_path() in
>>>> update_refs_for_switch() is safe because that function does not ke=
ep
>>>> any pointer to the round-robin buffer pool allocated by
>>>> get_pathname().
>>>>
>>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@=
gmail.com>
>>>> ---
>>>> diff --git a/refs.c b/refs.c
>>>> index 89228e2..434bd5e 100644
>>>> --- a/refs.c
>>>> +++ b/refs.c
>>>> @@ -2717,17 +2729,19 @@ static int copy_msg(char *buf, const char =
*msg)
>>>>         return cp - buf;
>>>>  }
>>>>
>>>> -int log_ref_setup(const char *refname, char *logfile, int bufsize=
)
>>>> +int log_ref_setup(const char *refname, struct strbuf *sb_logfile)
>>>>  {
>>>>         int logfd, oflags =3D O_APPEND | O_WRONLY;
>>>> +       const char *logfile;
>>>>
>>>> -       git_snpath(logfile, bufsize, "logs/%s", refname);
>>>> +       strbuf_git_path(sb_logfile, "logs/%s", refname);
>>>> +       logfile =3D sb_logfile->buf;
>>>>         if (log_all_ref_updates &&
>>>>             (starts_with(refname, "refs/heads/") ||
>>>>              starts_with(refname, "refs/remotes/") ||
>>>>              starts_with(refname, "refs/notes/") ||
>>>>              !strcmp(refname, "HEAD"))) {
>>>> -               if (safe_create_leading_directories(logfile) < 0)
>>>> +               if (safe_create_leading_directories(sb_logfile->bu=
f) < 0)
>>>
>>> At this point, 'logfile' is still 'sb_logfile->buf', so do you real=
ly
>>> need this change?
>>
>> Junio made the same comment last time and I missed it. Will update.
>
> No I will not :-) safe_create_leading_directories takes an editable
> string, but logfile is now a const string. We could use
> s_c_l_d_const() but that one will make a copy of the string
> unncessarily. Will make a note in the commit message though.

Rather than explaining it in the commit message, it might be better
eliminate the source of confusion by taking one of these approaches:

1. Drop the 'const char *logfile' variable altogether; rename the
strbuf argument to 'logfile'; and just use logfile->buf everywhere
'logfile' is used in the current code. This makes the diff a bit more
noisy, but eliminates confusion of reviewers reading the patch.

2. Keep the 'const char *logfile' but assign it just before its first
(real) use in 'logfd =3D open(logfile...)'. (There's one earlier use in
a diagnostic, but sb_logfile->buf could suffice there.)

3. Just declare it 'char *logfile' and use it everywhere in the
function. This is a bit ugly since it's not obvious to the reviewer
that it is non-const only for the sake of
safe_create_leading_directories().

I fiind myself favoring #1 in this particular case.
