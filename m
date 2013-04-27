From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/11] completion: general cleanups
Date: Sat, 27 Apr 2013 14:43:30 -0500
Message-ID: <CAMP44s10Uv-n2rBLPS-uYpZBoyZDCjQ_hRA2q=zf1WC4S=ac6g@mail.gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
	<517BB798.4070703@gmail.com>
	<CAMP44s1od7W0OufMhn2TCZTAo0aK9D+7VLzwVy7BSGNxAMuk6w@mail.gmail.com>
	<CAMP44s3h43S=A7+QEWuv0iefxbXyKZsiJ2QMdc-XiouoO3yYng@mail.gmail.com>
	<517BF167.7090300@gmail.com>
	<CAMP44s32WrnFr9Lp03Wu8gC6=FaACBtDbi1rnu=bo94Aa73TBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:43:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB20-00053v-Fc
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290Ab3D0Tnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:43:32 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:61859 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab3D0Tnb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:43:31 -0400
Received: by mail-lb0-f180.google.com with SMTP id t11so4686162lbi.11
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=efLAlxAYFXH3j4MTpoiHddN1EeaVwQJZSjY/xpMHNb0=;
        b=m9083sL223BQM/ewLNQTWGWSFodISv1BTnQcRxc/FvP5MXE6gPomdXmrSJO2PKQPAs
         U9Hx5H6QFdwJcZyL95JuPTokjWGAterA4buHv5PQ1rMePBk+MZukCw4O+1s1fh4fm9ut
         xDi562qwsX6w++SL+k4HD7s2FWsntwUef1beS4YCFKkbBuESyNNV/Ogx9Wx52vAPGVcD
         yanl8SciNIf9oGdLA5YOduJlkD8OvHBbBpaZ/pXUuIwbpXw6+sLqoDnkWgs1NhUpLMX4
         kPLPjpbnXRPUxCM6hzLcXwNCzvKOYH/rx9jUJBd+0Ur3aWKfZeCRoZYiyNB2EwzEvzJ8
         kJeg==
X-Received: by 10.152.19.10 with SMTP id a10mr24796932lae.8.1367091810124;
 Sat, 27 Apr 2013 12:43:30 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sat, 27 Apr 2013 12:43:30 -0700 (PDT)
In-Reply-To: <CAMP44s32WrnFr9Lp03Wu8gC6=FaACBtDbi1rnu=bo94Aa73TBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222662>

On Sat, Apr 27, 2013 at 2:15 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Apr 27, 2013 at 10:40 AM, Manlio Perillo
> <manlio.perillo@gmail.com> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Il 27/04/2013 15:07, Felipe Contreras ha scritto:
>>> [...]
>>> This should do the trick. No?
>>>
>>> --- a/contrib/completion/git-completion.bash
>>> +++ b/contrib/completion/git-completion.bash
>>> @@ -262,16 +262,17 @@ __git_ls_files_helper ()
>>>  #    If provided, only files within the specified directory are listed.
>>>  #    Sub directories are never recursed.  Path must have a trailing
>>>  #    slash.
>>> +# 3. Compat mode; set to enable.
>>>  __git_index_files ()
>>>  {
>>> -       local dir="$(__gitdir)" root="${2-.}" file
>>> +       local dir="$(__gitdir)" root="${2-.}" file old="${3-}"
>>>
>>>         if [ -d "$dir" ]; then
>>>                 __git_ls_files_helper "$root" "$1" |
>>>                 while read -r file; do
>>>                         case "$file" in
>>> -                       ?*/*) echo "${file%%/*}/" ;;
>>> -                       *) echo "$file " ;;
>>> +                       ?*/*) echo "${file%%/*}${old:+/}" ;;
>>> +                       *) echo "${file}${old:+ }" ;;
>>>                         esac
>>>                 done | sort | uniq
>>>         fi
>>> @@ -480,7 +481,7 @@ __git_complete_revlist_file ()
>>>  # The exception is --committable, which finds the files appropriate commit.
>>>  __git_complete_index_file ()
>>>  {
>>> -       local pfx="" cur_="$cur"
>>> +       local pfx="" cur_="$cur" old
>>>
>>>         case "$cur_" in
>>>         ?*/*)
>>> @@ -490,7 +491,8 @@ __git_complete_index_file ()
>>>                 ;;
>>>         esac
>>>
>>> -       __gitcomp_nl "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_" ""
>>> +       compopt -o filenames +o nospace 2> /dev/null || old=1
>>> +       __gitcomp_nl "$(__git_index_files "$1" "$pfx" "$old")" "$pfx" "$cur_" ""
>>>  }
>>>
>>>  __git_complete_file ()
>>>
>>
>> I like the idea (but I have not tested it), however compopt is called
>> two times, for each completion.
>
> Why two times?
>
>> Maybe we can test for `-o filenames` support when script is loaded,
>> where currently there is a Bash version check, and set a global variable?
>
> Yeah, that's the way bash-completion used to do it. But I wonder if we
> should be worrying about this at this point, even bash-completion
> dropped support for bash < 4 more than two years ago, and even debian
> stable is at 4.1.
>
> http://anonscm.debian.org/gitweb/?p=bash-completion/bash-completion.git;a=commitdiff;h=f1b3be235722d1ea51160acf50120eb88995a5b7

Actually, there's a way to trigger this in bash < 4, I've tested it
and it works:

--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -270,8 +270,8 @@ __git_index_files ()
                __git_ls_files_helper "$root" "$1" |
                while read -r file; do
                        case "$file" in
-                       ?*/*) echo "${file%%/*}/" ;;
-                       *) echo "$file " ;;
+                       ?*/*) echo "${file%%/*}" ;;
+                       *) echo "${file}" ;;
                        esac
                done | sort | uniq
        fi
@@ -490,6 +490,10 @@ __git_complete_index_file ()
                ;;
        esac

+       # use a hack to enable file mode in bash < 4
+       compopt -o filenames +o nospace 2> /dev/null ||
+       compgen -f /non-existing-dir/ > /dev/null
+
        __gitcomp_nl "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_" ""
 }


-- 
Felipe Contreras
