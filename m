From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH] Git-p4: git-p4.changeOnSubmit to do 'change' instead of 'submit'.
Date: Sat, 15 Oct 2011 00:31:45 +0200
Message-ID: <CA+DMoH-HqA0DCyUSttO-iYO0rUHq1nLqM9W0imAOjHC5H1r_9w@mail.gmail.com>
References: <1318629110-15232-1-git-send-email-andreiw@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Andrei Warkentin <andreiw@vmware.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 00:31:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REqIB-0008OT-8U
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 00:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab1JNWbq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Oct 2011 18:31:46 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62620 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab1JNWbq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 18:31:46 -0400
Received: by vcge1 with SMTP id e1so915934vcg.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 15:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uudB1+g5KJTNKYdjTpoAUcyxPnOO6v3pX8Cgd/iBO40=;
        b=KypDWdTZy0195Xb5Po2/MosSretq9sxDpzTO3bbuTEyi8eA1o+yD0mED3BxxzfuZCv
         md4t0N0JkVjHNRgXELypdrivkgY2/vcamyQuZHqIaxeU2sK0/CljLWZhD0WS3cBe+/5q
         mluSBncf+vtvzaksAu1QMBHTzRZKxboHM8nd4=
Received: by 10.52.176.98 with SMTP id ch2mr10625118vdc.82.1318631505211; Fri,
 14 Oct 2011 15:31:45 -0700 (PDT)
Received: by 10.52.111.38 with HTTP; Fri, 14 Oct 2011 15:31:45 -0700 (PDT)
In-Reply-To: <1318629110-15232-1-git-send-email-andreiw@vmware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183618>

Hi Andrei, and thanks for trying to help improve git-p4! :-)

2011/10/14 Andrei Warkentin <andreiw@vmware.com>:
> Many users of p4/sd use changelists for review, regression
> tests and batch builds, thus changes are almost never directly
> submitted.

Just out of curiosity... what is 'sd'?

> This new config option lets a 'p4 change -i' run instead of
> the 'p4 submit -i'.

Well... I have to say that I'm not crazy about this patch... I don't
think it is very elegant to have a config flag that says that "when
the user says 'git p4 submit', then don't submit, but do something
else instead".

I would much rather have made a patch to introduce some new command
like 'git p4 change'.

> Signed-off-by: Andrei Warkentin <andreiw@vmware.com>
> ---
> =C2=A0contrib/fast-import/git-p4 =C2=A0 =C2=A0 | =C2=A0 16 ++++++++++=
++----
> =C2=A0contrib/fast-import/git-p4.txt | =C2=A0 10 ++++++++++
> =C2=A02 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 2f7b270..19c295b 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -959,7 +959,10 @@ class P4Submit(Command, P4UserMap):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 submitTemplat=
e =3D message[:message.index(separatorLine)]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.isWin=
dows:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 submitTemplate =3D submitTemplate.replace("\r\n", "\n")
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p4_write_pip=
e("submit -i", submitTemplate)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if gitConfig=
("git-p4.changeOnSubmit"):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
p4_write_pipe("change -i", submitTemplate)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
p4_write_pipe("subadasdmit -i", submitTemplate)

=2E.. 'subadasdmit'? Did some debug/test code sneak in to your patch?

>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.prese=
rveUser:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if p4User:
> @@ -981,9 +984,14 @@ class P4Submit(Command, P4UserMap):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file =3D open(fileName, "w+=
")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file.write(self.prepareLogM=
essage(template, logMessage))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file.close()
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print ("Perforce submit te=
mplate written as %s. "
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + "P=
lease review/edit and then use p4 submit -i < %s to submit directly!"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 % (f=
ileName, fileName))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if gitConfig("git-p4.chang=
eOnSubmit"):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print ("Perf=
orce submit template written as %s. "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 + "Please review/edit and then use p4 change -i < %s to create =
changelist!"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 % (fileName, fileName))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print ("Perf=
orce submit template written as %s. "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 + "Please review/edit and then use p4 submit -i < %s to submit =
directly!"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 % (fileName, fileName))
>
> =C2=A0 =C2=A0 def run(self, args):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(args) =3D=3D 0:
> diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git=
-p4.txt
> index 52003ae..3a3a815 100644
> --- a/contrib/fast-import/git-p4.txt
> +++ b/contrib/fast-import/git-p4.txt
> @@ -180,6 +180,16 @@ git-p4.allowSubmit
>
> =C2=A0 git config [--global] git-p4.allowSubmit false
>
> +git-p4.changeOnSubmit
> +
> + =C2=A0git config [--global] git-p4.changeOnSubmit false
> +
> +Most places using p4/sourcedepot don't actually want you submit
> +changes directly, and changelists are used to do regression testing,
> +batch builds and review, hence, by setting this parameter to
> +true you acknowledge you end up creating a changelist which you
> +must then manually commit.
> +

It might be just me, but I never heard of 'sourcedepot' before this
patch... Google tells me that it might be some old version of p4 that
Microsoft used many many years ago. If that's the case, maybe it
doesn't add much value to talk about it in git-p4 docs.. (??)

And you claim 'most places don't want people to submit directly'. I'm
not sure I agree with that, and anyway it seems like the git-p4 docs
should be phrased more neutral than that.


My advice would be, as I mentioned earlier, to rework this into a
patch introducing a separate command 'git p4 change' instead of this
config flag.

Have a good one!

   Tor Arvid

> =C2=A0git-p4.syncFromOrigin
>
> =C2=A0A useful setup may be that you have a periodically updated git =
repository
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
