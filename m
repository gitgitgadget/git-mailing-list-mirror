From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Git thinks a failing command doesn't exist
Date: Wed, 11 Aug 2010 19:45:14 +0000
Message-ID: <AANLkTik3QmyP3sygbd36VhUQtdK-z81vqVAoAcPofFO+@mail.gmail.com>
References: <AANLkTin7E-v9TYd1KoD73knnSwSMy-V-pvS0TmpQd72M@mail.gmail.com>
	<20100811192554.GA8106@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 11 21:45:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjHEq-0002aR-5X
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554Ab0HKTpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 15:45:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55531 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756190Ab0HKTpQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 15:45:16 -0400
Received: by fxm13 with SMTP id 13so382592fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f8TK9IXXad7AVQXerDWfUS8Sbh/dWLvMWEvMhZfi9oA=;
        b=ofuWWEvVcmfplRRF0mEtWjmB3qXWZNnjb73DzFg/GSYMTC3n6WvHm2f1QVuydAjDgj
         dcTgxrxZeqWGxtG+MnEaKQG3tw87G1vdBoicxpr+KwdVqEHI3mHh8i4GBBACgi33MOcK
         meLZf4sjCMrrirTZLZo1zKA3qKh0cmke+dwl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wrKxlTLTT611+JQvU7T2PnmHcIMVUGbSlMe2tDGEQfR0g3UB/XSDEY1URfWXskqtJF
         dVN2+088rzPJGxvWLYVRJKxRh41iZiGCtnPqrGLMOCj/HsO0gELg2TuN/0SdpjIMqDD8
         sDPMXg5qzycVP6E4LQoTseymbTpn27UyrZx2o=
Received: by 10.223.110.73 with SMTP id m9mr20685743fap.25.1281555914912; Wed, 
	11 Aug 2010 12:45:14 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 12:45:14 -0700 (PDT)
In-Reply-To: <20100811192554.GA8106@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153294>

On Wed, Aug 11, 2010 at 19:25, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 11, 2010 at 07:12:38PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> Has this been noted before:
>>
>> =C2=A0 =C2=A0 $ git rebase --continue
>> =C2=A0 =C2=A0 .: 986: Can't open /home/avar/g/git/.git/rebase-merge/=
author-script
>> =C2=A0 =C2=A0 git: 'rebase' is not a git command. See 'git --help'.
>> =C2=A0 =C2=A0 Did you mean this?
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rebase
>>
>> Rebase failed, but the help mechanism seems to just test the exit
>> code, or something similar.
>
> Which git version and which platform? There is code in run-command to
> check for an exit code of 127 (which is what posix shells should prod=
uce
> for a missing command), and to set ENOENT in that case, which is what
> execv_dashed_external notices for a missing command.

It's 1.7.2.1.295.gdf931 on Debian testing. Which is pu as it was on
midnight UTC (I build it from cron) + these patches (which shouldn't
matter):

    # Monkeypatches

                  git cherry-pick 041bc904d2 # t/lib-git-svn.sh: use
$PERL_PATH for perl, not perl from $PATH
    git cherry-pick 855a1f8836 # commit: fix test broken by
jn/commit-no-change-wo-status
    git revert --no-edit 48e46574e6 # rebase -i: add exec command to
launch a shell command

> So either your shell is producing that exit code for a different case=
,
> or git is broken.

My shell is Debian /bin/dash 0.5.5.1-6.

Unfortunately the error with rebase was some one-off thing that I
couldn't reproduce. I'm not even sure /what/ I did to make it happen.
