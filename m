From: Elijah Newren <newren@gmail.com>
Subject: Re: git pull --rebase differs in behavior from git fetch + git rebase
Date: Fri, 27 Aug 2010 17:40:21 -0600
Message-ID: <AANLkTimBv3EVWaEnateD95sUi_LkmNw8RKJZYrW4dUFy@mail.gmail.com>
References: <4C772A01.5030207@workspacewhiz.com>
	<alpine.DEB.2.00.1008270124450.20874@narbuckle.genericorp.net>
	<4C77DE60.6020809@workspacewhiz.com>
	<AANLkTimEO==c7Pzi99VfvDp7S9HN=V2j6t0kk--w1kb9@mail.gmail.com>
	<4C783C66.3000008@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dave Olszewski <cxreg@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 01:40:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op8X7-0004nm-Kw
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 01:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147Ab0H0XkX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Aug 2010 19:40:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49485 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab0H0XkW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 19:40:22 -0400
Received: by fxm13 with SMTP id 13so2322666fxm.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 16:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UzeAJcfNznlH6mIwWC3ONJS5pFnHRtJkO26CGTRc0mM=;
        b=SXglVofnjMVPtBMjeedV36RaWjhvLJX2XC7KdWYumH+lCvx+aJi336FM0ggMuyEi+z
         cJp4uvBhQOJOd1ykOBFnFlAD1+DmM7fT+oUWixUZ/VBZv2Q76x1sthaP7k34Y3wL/xaL
         qbs9cxrXsu92BVcAQNlNUpVtY3XuOajeIhkuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iMLGPFh0aoVyCOEuAepBTR9G4/u+cYmoUfyBiUquh+VQr+HUQICARsAmTrUcFkozpp
         iqYtfsoqQr+SHUK5LTaEvLSxeukKt/XPFDe4ubGLrYitDycNbf4Q+NlHB7pIQ3xTaRzd
         2msJTTv6u/ZYk66cPW/RX+JUAXh1cIrJ/K8S0=
Received: by 10.223.119.147 with SMTP id z19mr1206443faq.64.1282952421370;
 Fri, 27 Aug 2010 16:40:21 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Fri, 27 Aug 2010 16:40:21 -0700 (PDT)
In-Reply-To: <4C783C66.3000008@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154624>

On Fri, Aug 27, 2010 at 4:29 PM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
> It reports to me 'git-rebase --onto XXXX XXXX'.
>
> And it reports nothing to do.
>
> XXXX is properly the origin/master in this case.
>
> git rebase origin/master =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 works.
> git rebase --onto origin/master origin/master =C2=A0 =C2=A0 =C2=A0 do=
es not work.
>
> Thoughts?

It's too bad you can't make this repository public; I thought rebase
should behave the same for those two commands.  We could certainly
just modify git-pull.sh to avoid using the --onto flag when
oldremoteref is not defined (and perhaps that makes sense independent
of anything else), but I'm curious now about rebase.

Can you insert an echo statement right before where git-rebase calls
format-patch to see what arguments it is passing in those two cases?
=46or me it's around line 568; insert an echo statement so that it look=
s
like:
 if test -z "$do_merge"
 then
        echo git format-patch -k --stdout --full-index --ignore-if-in-u=
pstream \
               --no-renames $root_flag "$revisions"
        git format-patch -k --stdout --full-index --ignore-if-in-upstre=
am \
                --no-renames $root_flag "$revisions" |
        git am $git_am_opt --rebasing --resolvemsg=3D"$RESOLVEMSG" &&
Make that change, and then run it with both your rebase commands and
see what you get.

=46or me, in both cases, I get:
  git format-patch ... --no-renames origin/master..HEAD
(except sha1sums of what origin/master and HEAD were rather than that
literal text), which means the same patches are being applied in both
cases for me.

Elijah
