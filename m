From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/11] completion: general cleanups
Date: Sat, 27 Apr 2013 14:15:43 -0500
Message-ID: <CAMP44s32WrnFr9Lp03Wu8gC6=FaACBtDbi1rnu=bo94Aa73TBA@mail.gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
	<517BB798.4070703@gmail.com>
	<CAMP44s1od7W0OufMhn2TCZTAo0aK9D+7VLzwVy7BSGNxAMuk6w@mail.gmail.com>
	<CAMP44s3h43S=A7+QEWuv0iefxbXyKZsiJ2QMdc-XiouoO3yYng@mail.gmail.com>
	<517BF167.7090300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:15:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWAb8-00029B-Iy
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121Ab3D0TPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:15:46 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:59051 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab3D0TPp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:15:45 -0400
Received: by mail-lb0-f172.google.com with SMTP id d10so1796384lbj.17
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ifaeCSOSgFnW/gxG4ixpulp+AsiADXXdN/loYVQXGXw=;
        b=slZOq+dNSRARCCc39FzUxoV8bAVyOMVDyi4obZjuUKZijSoEEWVvMlB1RybbF/S7H8
         Vzk2Yhz6Cw+19qQ6DX334oifyeN1OZQesLXPi5R/qdpuvvlqr3iKx5lgEreseCZzRBLj
         I4ba8EAmv+gbslW9va6bUIEEAIydLqaNCb/UtpziBMSNCmDrnsc/aOfNOXn7PJ3GT+Iq
         Jlw9859bXFI7Ltc91p3ys5hBuDBGDx6z7wtzXybjA6fRoQyK1ri6azH1SFO4ccWNzmhu
         6+w587Jx1nmqrpnTw34m8ciNvKDBDdFVrr3tdYuNHt/GE78Mw4coloCy2jQ61rau+UuJ
         8QSg==
X-Received: by 10.152.20.134 with SMTP id n6mr12616532lae.19.1367090143993;
 Sat, 27 Apr 2013 12:15:43 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sat, 27 Apr 2013 12:15:43 -0700 (PDT)
In-Reply-To: <517BF167.7090300@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222661>

On Sat, Apr 27, 2013 at 10:40 AM, Manlio Perillo
<manlio.perillo@gmail.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Il 27/04/2013 15:07, Felipe Contreras ha scritto:
>> [...]
>> This should do the trick. No?
>>
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -262,16 +262,17 @@ __git_ls_files_helper ()
>>  #    If provided, only files within the specified directory are listed.
>>  #    Sub directories are never recursed.  Path must have a trailing
>>  #    slash.
>> +# 3. Compat mode; set to enable.
>>  __git_index_files ()
>>  {
>> -       local dir="$(__gitdir)" root="${2-.}" file
>> +       local dir="$(__gitdir)" root="${2-.}" file old="${3-}"
>>
>>         if [ -d "$dir" ]; then
>>                 __git_ls_files_helper "$root" "$1" |
>>                 while read -r file; do
>>                         case "$file" in
>> -                       ?*/*) echo "${file%%/*}/" ;;
>> -                       *) echo "$file " ;;
>> +                       ?*/*) echo "${file%%/*}${old:+/}" ;;
>> +                       *) echo "${file}${old:+ }" ;;
>>                         esac
>>                 done | sort | uniq
>>         fi
>> @@ -480,7 +481,7 @@ __git_complete_revlist_file ()
>>  # The exception is --committable, which finds the files appropriate commit.
>>  __git_complete_index_file ()
>>  {
>> -       local pfx="" cur_="$cur"
>> +       local pfx="" cur_="$cur" old
>>
>>         case "$cur_" in
>>         ?*/*)
>> @@ -490,7 +491,8 @@ __git_complete_index_file ()
>>                 ;;
>>         esac
>>
>> -       __gitcomp_nl "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_" ""
>> +       compopt -o filenames +o nospace 2> /dev/null || old=1
>> +       __gitcomp_nl "$(__git_index_files "$1" "$pfx" "$old")" "$pfx" "$cur_" ""
>>  }
>>
>>  __git_complete_file ()
>>
>
> I like the idea (but I have not tested it), however compopt is called
> two times, for each completion.

Why two times?

> Maybe we can test for `-o filenames` support when script is loaded,
> where currently there is a Bash version check, and set a global variable?

Yeah, that's the way bash-completion used to do it. But I wonder if we
should be worrying about this at this point, even bash-completion
dropped support for bash < 4 more than two years ago, and even debian
stable is at 4.1.

http://anonscm.debian.org/gitweb/?p=bash-completion/bash-completion.git;a=commitdiff;h=f1b3be235722d1ea51160acf50120eb88995a5b7

Cheers.

-- 
Felipe Contreras
