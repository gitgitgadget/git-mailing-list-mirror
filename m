From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/11] completion: general cleanups
Date: Sat, 27 Apr 2013 08:07:58 -0500
Message-ID: <CAMP44s3h43S=A7+QEWuv0iefxbXyKZsiJ2QMdc-XiouoO3yYng@mail.gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
	<517BB798.4070703@gmail.com>
	<CAMP44s1od7W0OufMhn2TCZTAo0aK9D+7VLzwVy7BSGNxAMuk6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 15:08:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW4rG-0003mZ-UB
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 15:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724Ab3D0NIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 09:08:01 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:33279 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab3D0NIA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 09:08:00 -0400
Received: by mail-la0-f47.google.com with SMTP id em20so1033814lab.20
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 06:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=LjL4zZbkUOry+w34/YqFht5aZpXmJxKi7IVB9kHMUx4=;
        b=FSflVDbP+6gTGbM4P6vuHgnIApYap4EjBM3a0sfleoq1KQtw/LPMwRBN2Z4XYecIYU
         P8nfwmCLOyUDgmD9CjpB+IBHy0OFh/lf2g2NRSUX+f1wPVTaWfv9Na55rkswwY5VNg36
         BxHqcJI68SVNITrZFNyXV4te4ZKdtbcT3iBdOfY3Etkj490wJtO5DcfazTrbd7nIqTtI
         EjSjkmP9N+bRoDSahNPa/oYaIJN5LGbD4rZFqye1ctMHssh3QzPI2PwKEhNfWmdkgpl+
         5ZX7ikpIKEpY+lOCtl69lcuge9/mOU05aC+8n11lIo1g+TPedDZVpizFDm5npPLcgNHa
         /nvg==
X-Received: by 10.152.19.10 with SMTP id a10mr24293641lae.8.1367068078410;
 Sat, 27 Apr 2013 06:07:58 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sat, 27 Apr 2013 06:07:58 -0700 (PDT)
In-Reply-To: <CAMP44s1od7W0OufMhn2TCZTAo0aK9D+7VLzwVy7BSGNxAMuk6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222643>

On Sat, Apr 27, 2013 at 7:36 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Apr 27, 2013 at 6:33 AM, Manlio Perillo
> <manlio.perillo@gmail.com> wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Il 27/04/2013 12:19, Felipe Contreras ha scritto:
>>> Hi,
>>>
>>> Basically while trying to understand the code for path completion, I found that
>>> a lot of code was duplicated, and for not much gain.
>>>
>>> I also noticed that doing 'git add file' doesn't add the trailing space as
>>> before. It's not clear if it should be possible to do that with -o filenames,
>>> but after all, what do -o filenames gives us? Nothing we can't do ourselves,
>>> apparently.
>>>
>>
>> No, you can not do it yourself, as far as I know.
>>
>> I added the `compopt -o filenames` on Junio request for something like
>> "It  would be nice if completion for real files would behave like
>> builtin bash completion", if I remember correctly.
>>
>> Try `git rm contrib/completion/<TAB>`, in the git reporitory.
>>
>> Using the new feature, bash will suggest:
>> "git-completion.bash  git-completion.tcsh  git-completion.zsh
>> git-prompt.sh"
>>
>> Old behaviour, instead, was to suggest:
>> "contrib/completion/git-completion.bash
>> contrib/completion/git-completion.zsh
>> contrib/completion/git-completion.tcsh  contrib/completion/git-prompt.sh"
>>
>> I tried several things, but I was unable to emulate Bash builtin file
>> completion, whithout having to use `compopt -o filenames`.
>
> I see. I'm not convinced it's such a great feature, but it would be
> nice to have.
>
> Anyway, 'compopt -o filenames +o nospace' should restore the old
> behavior to add a space after the completion.
>
>> As far as the "double slash" problem with the
>> __git_index_file_list_filter_bash function, please try
>> `git rm contrib<TAB>`.
>>
>> With current code, Bash will suggest:
>> "blameview/ diffall/ git-shell-commands/"
>>
>> If you remove the __git_index_file_list_filter_bash function and use
>> __git_index_file_list_filter_compat instead, Bash will suggest:
>>
>> "blameview// diffall// git-shell-commands//"
>>
>> I can confirm this on my system, and it was confirmed by another user.
>> It only happens when you use `compopt -o filenames`. I don't know if
>> this is a bug or a feature, but I can try to ask to Bash mailing list,
>> so that we can update the comment to make more clear why a separate
>> function was needed.
>
> I've managed to reproduce the issue. The slash doesn't appear in the
> completion, it appears on the list of completions.
>
> I'll see what I can think to fix the issues while still keep the code simple.

This should do the trick. No?

--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -262,16 +262,17 @@ __git_ls_files_helper ()
 #    If provided, only files within the specified directory are listed.
 #    Sub directories are never recursed.  Path must have a trailing
 #    slash.
+# 3. Compat mode; set to enable.
 __git_index_files ()
 {
-       local dir="$(__gitdir)" root="${2-.}" file
+       local dir="$(__gitdir)" root="${2-.}" file old="${3-}"

        if [ -d "$dir" ]; then
                __git_ls_files_helper "$root" "$1" |
                while read -r file; do
                        case "$file" in
-                       ?*/*) echo "${file%%/*}/" ;;
-                       *) echo "$file " ;;
+                       ?*/*) echo "${file%%/*}${old:+/}" ;;
+                       *) echo "${file}${old:+ }" ;;
                        esac
                done | sort | uniq
        fi
@@ -480,7 +481,7 @@ __git_complete_revlist_file ()
 # The exception is --committable, which finds the files appropriate commit.
 __git_complete_index_file ()
 {
-       local pfx="" cur_="$cur"
+       local pfx="" cur_="$cur" old

        case "$cur_" in
        ?*/*)
@@ -490,7 +491,8 @@ __git_complete_index_file ()
                ;;
        esac

-       __gitcomp_nl "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_" ""
+       compopt -o filenames +o nospace 2> /dev/null || old=1
+       __gitcomp_nl "$(__git_index_files "$1" "$pfx" "$old")" "$pfx" "$cur_" ""
 }

 __git_complete_file ()

-- 
Felipe Contreras
