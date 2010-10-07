From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/t5560: use `X=Y && export X' not `export X=Y'
Date: Thu, 7 Oct 2010 08:09:34 +0000
Message-ID: <AANLkTi=cMYoLVipaiFajcssrRBVPX5NXFNwj21Ji3Lru@mail.gmail.com>
References: <1286437634-12593-1-git-send-email-avarab@gmail.com>
	<vpqhbgy8mjj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 07 10:09:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3lXv-000200-7l
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 10:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760165Ab0JGIJj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 04:09:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33367 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab0JGIJf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 04:09:35 -0400
Received: by iwn9 with SMTP id 9so524679iwn.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 01:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QS9YpS3680mtIsfPRXYY3YnK2D30bYGRHNsD3Q876ho=;
        b=Qw0pxBnUzB8PCDRYGwROXN7/7Ojw0MK3s2N3TFNDzLMagdCyK+oas1sqIxRy36lwAZ
         FsoLJ68eNDYSK/yKzUGq//eg2T94ab84HmVkQtofotT8YOXhr5taVi02zYvaJCFCMiKs
         gAuT88yHcWlNlFMueOMHknYvCSZHCAsWiSn1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HLu7yBzy2+DUsapKw+aW48nphswGhZkEOFyk2Cf10/pZjAgI+O/5UOBD0nxZp22EHf
         mqvq20bmV192JqUUFTunfcV6NaixMFboBVMyZEoZMJlP/ZK+DmaAwPdYMOE7ip2Bur6B
         iX1xRLQt78sHtO2e43GESLh8tMhcTpqL8u/BU=
Received: by 10.231.183.200 with SMTP id ch8mr459410ibb.124.1286438974769;
 Thu, 07 Oct 2010 01:09:34 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 7 Oct 2010 01:09:34 -0700 (PDT)
In-Reply-To: <vpqhbgy8mjj.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158382>

On Thu, Oct 7, 2010 at 07:55, Matthieu Moy <Matthieu.Moy@grenoble-inp.f=
r> wrote:
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.com> writes:
>
>> Change t/t5560-http-backend-noserver.sh to use the `X=3DY && export =
X'
>> style instead of `export X=3DY'. The latter doesn't work on all POSI=
X
>> shells.
>
> According to
>
> git grep '\<export [A-Za-z_]*=3D'
>
> there seem to be a couple of other instances of this.

Yeah, the ones in Documentation/*.txt are OK IMO. The users reading
the docs probably don't have a shell old enough to complain about
this.

Likewise for contrib/hg-to-git/hg-to-git.py and gitweb/INSTALL.

These we probably want to fix:

    git-am.sh:          export GIT_MERGE_VERBOSITY=3D0
    git-rebase.sh:          export GIT_MERGE_VERBOSITY=3D1
    git-stash.sh:           export GIT_MERGE_VERBOSITY=3D0

and maybe this:

    git-gui/lib/shortcut.tcl:                               puts $fd
"export PATH=3D[sq [file dirname $::_git]]:\$PATH &&"

This is the only other thing in the test suite:

    t/t1509-root-worktree.sh:export GIT_DIR=3D"$TRASH_DIRECTORY/.git"
    t/t1509-root-worktree.sh:export GIT_WORK_TREE=3D/
    t/t1509-root-worktree.sh:export GIT_DIR=3D"$(echo
$TRASH_DIRECTORY|sed 's,^/,,')/.git"

But I didn't touch that since nobody runs that test anyway, and if
they do having a strict POSIX shell is the least of their problems.
