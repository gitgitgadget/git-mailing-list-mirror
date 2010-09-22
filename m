From: Pat Notz <patnotz@gmail.com>
Subject: Re: [PATCHv2 1/4] commit: --fixup option for use with rebase --autosquash
Date: Wed, 22 Sep 2010 12:01:13 -0600
Message-ID: <AANLkTinKCuFRYf4Bu856nhtfA3gPY5FZpQ6jcik=4=GC@mail.gmail.com>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com> <1285100703-49087-2-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 20:01:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyTdV-0002fE-W6
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 20:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018Ab0IVSBg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Sep 2010 14:01:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59414 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab0IVSBf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Sep 2010 14:01:35 -0400
Received: by fxm12 with SMTP id 12so217224fxm.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=xMfuXXotisPYvzdMKpLu1n+kJyeLqHQ19DoIKr5+0AQ=;
        b=q9LlZyk+41Bs0Hcde4W+y7bPIxXXz2H04ZuACGYT9+vd4RnnZyJfmXLhh18fDeN0Uf
         ilq6Y/cabQ1TDUTHeqlYLH2JBPhpviCJN2oEQcmC6HIPK0t6gH9w7q2XDmtidhR9HgiV
         zb+XBojQxo6SP3vyCEHDkmVpxe054kbSQh4Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=tjsoaoQ8p9NRt0yuw3yu1QSdD3XumkwNTT18GKSKarGPS4uZ76iPPNPrpc2CDIPkYY
         pUpRWytz+VKWpn6oNki3wD/mq0xVfoBzU1j8pNAPkHhjG/IHWKYuLcTX4/XnlozmZNEH
         d5hLJqmja9bRkfIM0i+blpfOXc1i8/0FDGl2I=
Received: by 10.239.155.70 with SMTP id h6mr31846hbc.94.1285178494101; Wed, 22
 Sep 2010 11:01:34 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Wed, 22 Sep 2010 11:01:13 -0700 (PDT)
In-Reply-To: <1285100703-49087-2-git-send-email-patnotz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156814>

On Tue, Sep 21, 2010 at 2:25 PM, Pat Notz <patnotz@gmail.com> wrote:
> This option makes it convenient to construct commit messages for use
> with 'rebase --autosquash'. =A0The resulting commit message will be
> "fixup! ..." where "..." is the subject line of the specified commit
> message.
>
> Example usage:
> =A0$ git commit --fixup HEAD~2
>
> Signed-off-by: Pat Notz <patnotz@gmail.com>
> ---
> =A0Documentation/git-commit.txt | =A0 13 +++++++++----
> =A0builtin/commit.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 23 ++++++++++++++++=
+++----
> =A02 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.=
txt
> index 42fb1f5..3367f8f 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -9,10 +9,10 @@ SYNOPSIS
> =A0--------
> =A0[verse]
> =A0'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [=
--dry-run]
> - =A0 =A0 =A0 =A0 =A0[(-c | -C) <commit>] [-F <file> | -m <msg>] [--r=
eset-author]
> - =A0 =A0 =A0 =A0 =A0[--allow-empty] [--allow-empty-message] [--no-ve=
rify] [-e] [--author=3D<author>]
> - =A0 =A0 =A0 =A0 =A0[--date=3D<date>] [--cleanup=3D<mode>] [--status=
 | --no-status] [--]
> - =A0 =A0 =A0 =A0 =A0[[-i | -o ]<file>...]
> + =A0 =A0 =A0 =A0 =A0[(-c | -C | --fixup) <commit>] [-F <file> | -m <=
msg>]
> + =A0 =A0 =A0 =A0 =A0[--reset-author] [--allow-empty] [--allow-empty-=
message] [--no-verify]
> + =A0 =A0 =A0 =A0 =A0[-e] [--author=3D<author>] [--date=3D<date>] [--=
cleanup=3D<mode>]
> + =A0 =A0 =A0 =A0 =A0[--status | --no-status] [--] [[-i | -o ]<file>.=
=2E.]
>
> =A0DESCRIPTION
> =A0-----------
> @@ -70,6 +70,11 @@ OPTIONS
> =A0 =A0 =A0 =A0Like '-C', but with '-c' the editor is invoked, so tha=
t
> =A0 =A0 =A0 =A0the user can further edit the commit message.
>
> +--fixup=3D<commit>::
> + =A0 =A0 =A0 Construct a commit message for use with `rebase --autos=
quash`.
> + =A0 =A0 =A0 The commit message will be the subject line from the sp=
ecified
> + =A0 =A0 =A0 commit with a prefix of "fixup! ".
> +

I should add links to the git-rebase man page here.
