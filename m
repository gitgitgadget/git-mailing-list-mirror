From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Unexpected "clean -Xd" behavior
Date: Thu, 19 Jan 2012 14:31:32 +0700
Message-ID: <CACsJy8AE+rwmOVUZez5GRXRHJsTy+W8ekzr59NTd7_C+gB0Byw@mail.gmail.com>
References: <4F1384AE.1050209@pcharlan.com> <20120119002904.GA14107@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Harlan <pgit@pcharlan.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 08:32:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnmTj-000855-EO
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 08:32:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab2ASHcH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 02:32:07 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48885 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535Ab2ASHcF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2012 02:32:05 -0500
Received: by bkas6 with SMTP id s6so3519868bka.19
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 23:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=XATP4wheA7C8+1yFioKkDVe40QkiiLLfqC52GTbM0uw=;
        b=hIKlCLn+N0DMvpxRaBse+g+Fx0VC/5ERMLLz5AKzLK3cr/x1e37MK92H08ZkA4hrQ1
         ufJ9WpWXGa4zgP67F313xYYtMnkIjunrDQ+QuD8AFg/q4NnTrz0/hIkjcXAt2nSBNeHK
         Y374EPf//rNoSMDPrnEv1345JPmcCAYKPM1YI=
Received: by 10.204.154.211 with SMTP id p19mr1785450bkw.130.1326958324238;
 Wed, 18 Jan 2012 23:32:04 -0800 (PST)
Received: by 10.205.123.145 with HTTP; Wed, 18 Jan 2012 23:31:32 -0800 (PST)
In-Reply-To: <20120119002904.GA14107@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188792>

2012/1/19 Jonathan Nieder <jrnieder@gmail.com>:
> Pete Harlan wrote:
>
>> When a directory contains nothing but an ignored subdirectory, that
>> subdirectory does not get removed by "git clean -Xdf".
>>
>> For example, in a new directory:
>>
>> # git init
>> Initialized empty Git repository in /tmp/foo/.git/
>> # echo a/ >.gitignore
>> # git add .gitignore
>> # git commit -m "Initial commit"
>> [master (root-commit) c3af24c] Initial commit
>> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 .gitignore
>> # mkdir -p foo/a
>> # touch foo/a/junk.o
>> # git status
>> # On branch master
>> nothing to commit (working directory clean)
>> # git clean -Xdn =C2=A0# <--- DOES NOT MENTION foo/a

-X is to remove ignored files _only_ (DIR_SHOW_IGNORED flag). And
"foo" is not ignored according to .gitignore, so it cuts short there
and never gets to "foo/a". -x works. May be intentional, may be not
(we hit a corner case). I don't know. Commit message b991625 might
help:

    dir.c: Omit non-excluded directories with dir->show_ignored

    This makes "git-ls-files --others --directory --ignored" behave
    as documented and consequently also fixes "git-clean -d -X".
    Previously, git-clean would remove non-excluded directories
    even when using the -X option.
--=20
Duy
