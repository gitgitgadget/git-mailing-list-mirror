From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 1/2] git-p4: Don't edit renamed files if not necessary.
Date: Fri, 19 Nov 2010 12:14:14 +0000
Message-ID: <AANLkTimkHECHmn22xY3fHzJd0KQD7EMJhHj0hCA+ccBs@mail.gmail.com>
References: <1290130693-30855-1-git-send-email-vitor.hda@gmail.com> <1290130693-30855-2-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vitor Antunes <vhugo@synopsys.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 19 13:14:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJPrh-00054Z-EP
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 13:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543Ab0KSMOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Nov 2010 07:14:46 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62114 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351Ab0KSMOp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 07:14:45 -0500
Received: by qyk2 with SMTP id 2so83005qyk.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 04:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2TXeGZERck4aTebcQgdDcVjTgKiRcqARTCZxegeP/bM=;
        b=Pe3jMT9lUgW/PwuoTm73pta0VPhJoK9RX6NcYbUea455dlKQfDR4HEoSetv2Mo6qIM
         LOVRLrFqmQClz6z67xGgpWMCknv95baPWDGXKlqJGLW0NuJcbwXBSTbxrzBb112f0Y/X
         0KzfI5AFXbnZMH2R/AhzT+yqLYbaIH9DnMWLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YDOXPf2V8SMCxWsuRauBJC+lKN8KLggFjPV2NY6yIea22iHpvw3zL2JYki/4lRmAmt
         nEA7g/O99soWVrUx72IKlFBN0IT6ksq7xDJNlJy1dGJAyPHeI7J5iSx7tq7wIj3LnNzI
         842NcxKgVcfBKxLBNypgnK4M9fM/RmIkwOb7A=
Received: by 10.224.20.2 with SMTP id d2mr807749qab.300.1290168884824; Fri, 19
 Nov 2010 04:14:44 -0800 (PST)
Received: by 10.220.186.66 with HTTP; Fri, 19 Nov 2010 04:14:14 -0800 (PST)
In-Reply-To: <1290130693-30855-2-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161742>

There is a typo in this patch. I'll send a patch this night.

Sorry.

On Fri, Nov 19, 2010 at 1:38 AM, Vitor Antunes <vitor.hda@gmail.com> wr=
ote:
> Only open files for edit after integrating if the SHA1 of source and
> destination differ from each other.
> Also added git config option to allow permanent rename detection.
> The detectRenames option should be set to the desired threshold value=
=2E
> Rename detection can still be enabled through -M option.
> ---
> =A0contrib/fast-import/git-p4 | =A0 11 +++++++++--
> =A01 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 04ce7e3..ba18512 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -613,7 +613,13 @@ class P4Submit(Command):
>
> =A0 =A0 def applyCommit(self, id):
> =A0 =A0 =A0 =A0 print "Applying %s" % (read_pipe("git log --max-count=
=3D1 --pretty=3Doneline %s" % id))
> - =A0 =A0 =A0 =A0diffOpts =3D ("", "-M")[self.detectRename]
> +
> + =A0 =A0 =A0 =A0detectRenames =3D gitConfig("git-p4.detectRenames")
> + =A0 =A0 =A0 =A0if len(detectRenames) > 0:
> + =A0 =A0 =A0 =A0 =A0 =A0diffOpts =3D "-M%s" % detectRenames
> + =A0 =A0 =A0 =A0else:
> + =A0 =A0 =A0 =A0 =A0 =A0diffOpts =3D ("", "-M")[self.detectRenames]
> +
> =A0 =A0 =A0 =A0 diff =3D read_pipe_lines("git diff-tree -r %s \"%s^\"=
 \"%s\"" % (diffOpts, id, id))
> =A0 =A0 =A0 =A0 filesToAdd =3D set()
> =A0 =A0 =A0 =A0 filesToDelete =3D set()
> @@ -640,7 +646,8 @@ class P4Submit(Command):
> =A0 =A0 =A0 =A0 =A0 =A0 elif modifier =3D=3D "R":
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 src, dest =3D diff['src'], diff['dst'=
]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p4_system("integrate -Dt \"%s\" \"%s\=
"" % (src, dest))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p4_system("edit \"%s\"" % (dest))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if diff['src_sha1'] !=3D diff['dst_s=
ha1']:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p4_system("edit \"%s\"" % (d=
est))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if isModeExecChanged(diff['src_mode']=
, diff['dst_mode']):
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 filesToChangeExecBit[dest] =3D=
 diff['dst_mode']
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 os.unlink(dest)
> --
> 1.7.2.3
>
>



--=20
Vitor Antunes
