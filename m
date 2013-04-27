From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 00/11] completion: general cleanups
Date: Sat, 27 Apr 2013 13:33:44 +0200
Message-ID: <517BB798.4070703@gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 13:34:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW3OU-0000HM-AJ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 13:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638Ab3D0LeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 07:34:14 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:64185 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab3D0LeN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 07:34:13 -0400
Received: by mail-ee0-f41.google.com with SMTP id c50so1673337eek.14
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 04:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=+XxSBiYG1WtcjEmMsv2/kviq0W8mjt+OF4rv7sbQuh4=;
        b=j+YB92g/fVaJodlt+LWi5oqPLZJZgCi7Mlf9xUHZgYP69blwSg1ZkI/YpzFkNhPXkF
         EzEdtNOFiq0C441gZucM2kWoFTEuJ+Fp/+jmhkWe0IqD1gcxu/cX/gh7ZRXn5ATY6mTt
         5Fppb4R976eqpuLuV5F16ybebho9ALIrRLIaWoaFRrTSANkTSd+uZEcyq2Ag3Dc85fjk
         KHO9YZLOQnYeV3QgA2MKEXeU0+iNyhxZpv1GPmBG83BCcXiY6vdNWcKPotC1WB4BVLQ5
         uIy9GWd5NP40cECOnRPe42ZlVKXNz3uehc+/XJehxu+ih7M7t21EfRQ9OfWGHZlT1DfB
         dOCg==
X-Received: by 10.14.219.8 with SMTP id l8mr77347638eep.40.1367062451757;
        Sat, 27 Apr 2013 04:34:11 -0700 (PDT)
Received: from [192.168.0.3] ([151.70.212.83])
        by mx.google.com with ESMTPSA id j43sm21340840eep.4.2013.04.27.04.34.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 04:34:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222638>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 27/04/2013 12:19, Felipe Contreras ha scritto:
> Hi,
> 
> Basically while trying to understand the code for path completion, I found that
> a lot of code was duplicated, and for not much gain.
> 
> I also noticed that doing 'git add file' doesn't add the trailing space as
> before. It's not clear if it should be possible to do that with -o filenames,
> but after all, what do -o filenames gives us? Nothing we can't do ourselves,
> apparently.
> 

No, you can not do it yourself, as far as I know.

I added the `compopt -o filenames` on Junio request for something like
"It  would be nice if completion for real files would behave like
builtin bash completion", if I remember correctly.

Try `git rm contrib/completion/<TAB>`, in the git reporitory.

Using the new feature, bash will suggest:
"git-completion.bash  git-completion.tcsh  git-completion.zsh
git-prompt.sh"

Old behaviour, instead, was to suggest:
"contrib/completion/git-completion.bash
contrib/completion/git-completion.zsh
contrib/completion/git-completion.tcsh  contrib/completion/git-prompt.sh"

I tried several things, but I was unable to emulate Bash builtin file
completion, whithout having to use `compopt -o filenames`.



As far as the "double slash" problem with the
__git_index_file_list_filter_bash function, please try
`git rm contrib<TAB>`.

With current code, Bash will suggest:
"blameview/ diffall/ git-shell-commands/"

If you remove the __git_index_file_list_filter_bash function and use
__git_index_file_list_filter_compat instead, Bash will suggest:

"blameview// diffall// git-shell-commands//"

I can confirm this on my system, and it was confirmed by another user.
It only happens when you use `compopt -o filenames`. I don't know if
this is a bug or a feature, but I can try to ask to Bash mailing list,
so that we can update the comment to make more clear why a separate
function was needed.


> [...]


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlF7t5gACgkQscQJ24LbaUSO5QCffllxM8RbGUP47kb7uL5J3drF
hkUAn26ezKptTAC412EJZnxjh7RVcdAO
=Piyz
-----END PGP SIGNATURE-----
