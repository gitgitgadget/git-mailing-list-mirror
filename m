From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked 
	files
Date: Wed, 11 Aug 2010 12:24:02 +0000
Message-ID: <AANLkTikPSR36SdUuzWsXxZsy9jsKOnp=_iz43BF-6nYe@mail.gmail.com>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de
To: Greg Brockman <gdb@mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 11 14:24:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjALr-00061V-Bv
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 14:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab0HKMYF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 08:24:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59367 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab0HKMYE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 08:24:04 -0400
Received: by fxm13 with SMTP id 13so35956fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZexI9UVbRG3NJkr+a1wq167HlFxTvsoHlpJIcMrSync=;
        b=am0AOXblkjVY9RSuPptbAfsIVWSBfOoIR58ZxBmUqIOkcTIMtghvJVbqHSaUnRRndS
         66elJOKvAcxiGxT1RBM36S5NxsLmZHBLOie6BO0F6mcvUINk140T5+93gd5fIDMj7wHp
         a6DKuKFaek7ai8txccCt2X4TkVbf2GwmjVc/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V1ijTptXYjsiseHpN3bHm+fGV0DyTb6k6LYHgXhBZn2WNP7PWqxHdjoOJlcKvbQE1M
         noW8Xp78eKox5t+NlDrIy0203iYf4LZMa99Hol51YNpdtIzLLMlKuZLWw6NZrcdptSx2
         seKFUwYHNjWeyLMzfe2fSTC4TIvl8ACmmrkwc=
Received: by 10.223.120.65 with SMTP id c1mr19889837far.68.1281529442857; Wed, 
	11 Aug 2010 05:24:02 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 05:24:02 -0700 (PDT)
In-Reply-To: <1281510236-8103-1-git-send-email-gdb@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153230>

On Wed, Aug 11, 2010 at 07:03, Greg Brockman <gdb@mit.edu> wrote:
> Currently, 'git add' will complain about excluded files, even if they
> are already tracked:
>
> $ mkdir dir && touch dir/file && cat > .gitignore <<< dir
> $ git add -f dir/file
> $ git status
> =C2=A0...
> =C2=A0new file: =C2=A0 dir/file
> =C2=A0...
> $ git add dir/file
> The following paths are ignored by one of your .gitignore files:
> dir
> Use -f if you really want to add them.
> fatal: no files added
>
> This commit changes 'git add' to disregard excludes for tracked files
> whose paths are explicitly specified on the command-line. =C2=A0So in=
 the
> above example, 'git add dir/file' no longer requires a '-f'. =C2=A0Ho=
wever,
> 'git add dir' does.
>
> Signed-off-by: Greg Brockman <gdb@mit.edu>
> ---
> =C2=A0builtin/add.c | =C2=A0 19 +++++++++++++++++++
> =C2=A01 files changed, 19 insertions(+), 0 deletions(-)
>
> What do people think of this behavior? =C2=A0My motivation in writing=
 this patch is
> that I sometimes track files in an ignored directory, and it can be c=
umbersome
> to remember to pass '-f' when adding them. =C2=A0Related commands suc=
h as 'git add -p'
> and 'git commit -a' do not require a '-f' in this case, so it feels n=
atural to me not
> to require extra user confirmation when an explicit path has been pro=
vided.

I like it. I keep a /etc in git with .gitignore "*". This would help a
lot for use cases like that. Explicitly specifying a full path should
override gitignore IMO.

I think with some tests this should be ready to go.
