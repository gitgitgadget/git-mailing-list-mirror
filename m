From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/11] completion: general cleanups
Date: Sat, 27 Apr 2013 07:36:35 -0500
Message-ID: <CAMP44s1od7W0OufMhn2TCZTAo0aK9D+7VLzwVy7BSGNxAMuk6w@mail.gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
	<517BB798.4070703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 14:36:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW4Ms-0007iH-3e
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 14:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545Ab3D0Mgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 08:36:37 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:45850 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3D0Mgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 08:36:37 -0400
Received: by mail-lb0-f172.google.com with SMTP id d10so1628973lbj.31
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 05:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=kj3WiGk/NjTxL3ThUI4N3kf6I+FpKEwCIUCam3FOwNk=;
        b=cToUS8NEzQDnaPA+9gsrWpr/tcCfnzZNhrMSlW0qp/yGCnZ9w6H1SIs5UkxQ25b2HC
         M4M9cc2ZiQ8xiBob5kukPH+YqgsWehv7dIa46zYxd9XpNzSIU08jpuQNi5F3TnGf8V8o
         PiGB59eS0ov4/Q8ogeG3Pc2py1MsgcpqVlSAkhIf3tU3T8oWCubwOhrRc60B6ogkal4K
         0HxiX2lkVPB5jdYVstp8JMx1QFI+wRdpVdZATsRu8fHGSyy27tnObV9+DjldGm/7nZcv
         evgY7rs5P4refeFVeQAmsRyBejZrzwAvA1mdwDOVkUGa1nNiCCRY9cwlY+moeYwWp5Kr
         WzkA==
X-Received: by 10.112.163.6 with SMTP id ye6mr23330877lbb.59.1367066195572;
 Sat, 27 Apr 2013 05:36:35 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sat, 27 Apr 2013 05:36:35 -0700 (PDT)
In-Reply-To: <517BB798.4070703@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222640>

On Sat, Apr 27, 2013 at 6:33 AM, Manlio Perillo
<manlio.perillo@gmail.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Il 27/04/2013 12:19, Felipe Contreras ha scritto:
>> Hi,
>>
>> Basically while trying to understand the code for path completion, I found that
>> a lot of code was duplicated, and for not much gain.
>>
>> I also noticed that doing 'git add file' doesn't add the trailing space as
>> before. It's not clear if it should be possible to do that with -o filenames,
>> but after all, what do -o filenames gives us? Nothing we can't do ourselves,
>> apparently.
>>
>
> No, you can not do it yourself, as far as I know.
>
> I added the `compopt -o filenames` on Junio request for something like
> "It  would be nice if completion for real files would behave like
> builtin bash completion", if I remember correctly.
>
> Try `git rm contrib/completion/<TAB>`, in the git reporitory.
>
> Using the new feature, bash will suggest:
> "git-completion.bash  git-completion.tcsh  git-completion.zsh
> git-prompt.sh"
>
> Old behaviour, instead, was to suggest:
> "contrib/completion/git-completion.bash
> contrib/completion/git-completion.zsh
> contrib/completion/git-completion.tcsh  contrib/completion/git-prompt.sh"
>
> I tried several things, but I was unable to emulate Bash builtin file
> completion, whithout having to use `compopt -o filenames`.

I see. I'm not convinced it's such a great feature, but it would be
nice to have.

Anyway, 'compopt -o filenames +o nospace' should restore the old
behavior to add a space after the completion.

> As far as the "double slash" problem with the
> __git_index_file_list_filter_bash function, please try
> `git rm contrib<TAB>`.
>
> With current code, Bash will suggest:
> "blameview/ diffall/ git-shell-commands/"
>
> If you remove the __git_index_file_list_filter_bash function and use
> __git_index_file_list_filter_compat instead, Bash will suggest:
>
> "blameview// diffall// git-shell-commands//"
>
> I can confirm this on my system, and it was confirmed by another user.
> It only happens when you use `compopt -o filenames`. I don't know if
> this is a bug or a feature, but I can try to ask to Bash mailing list,
> so that we can update the comment to make more clear why a separate
> function was needed.

I've managed to reproduce the issue. The slash doesn't appear in the
completion, it appears on the list of completions.

I'll see what I can think to fix the issues while still keep the code simple.

Cheers.

-- 
Felipe Contreras
