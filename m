From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: local URLs are not for ssh
Date: Sun, 29 Sep 2013 07:33:38 +0700
Message-ID: <CACsJy8B-wA=bX6+E6O6UvX2vEtOwnR1PCMZNoi-q0x_jacB89Q@mail.gmail.com>
References: <201309282137.21802.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 29 02:34:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ4xj-0006op-Iw
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 02:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263Ab3I2AeK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Sep 2013 20:34:10 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:47253 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab3I2AeJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Sep 2013 20:34:09 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo20so4229461obc.13
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 17:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PQMwCIO55C9M2uCcPjSPdIBbioviUkNVpo3w2YKL1yA=;
        b=RDtK1QeOKvS+uGwzZmf7lSUsbLz9NeKUK3qVHZtlZh+GXotLvYdR77Gf0NzY5Yfuhj
         PumXi/Jfk/xrxWWAjVXyz+0DOB/JE5sydIEKQztB1S7sSFicebrn6Iq9M9lj+pLTlHB0
         stVACT+QhXg1CtqAX/SZ0HpPHBxT4QY6slB5ng/VAU+CTmJ4k5or/vPn74sg+TdWkIu2
         Oie+JXp0sOwDzXaMTDpj+9fnc8HbXFW9VgRR1aevdsqktxjrWM0fTN2ovq30E6TMIeSy
         xYpnHQNzPYs6U/TWdktDp9g8i9o+pSNyB9XMN6Fw2G7hauDTnPyblkVvT1LFlFeDYUIP
         xQCw==
X-Received: by 10.182.106.4 with SMTP id gq4mr12883820obb.4.1380414848808;
 Sat, 28 Sep 2013 17:34:08 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Sat, 28 Sep 2013 17:33:38 -0700 (PDT)
In-Reply-To: <201309282137.21802.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235572>

On Sun, Sep 29, 2013 at 2:37 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> "git clone /foo/bar:baz" or "git clone ../foo/bar:baz"
> are meant to clone from the local file system, and not to clone
> from a remote server over git-over-ssh.

I don't think this is necessary. Commit 6000334 should detect both
cases fine because both have a slash before the first colon.

>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  connect.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/connect.c b/connect.c
> index a80ebd3..b382032 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -550,7 +550,8 @@ struct child_process *git_connect(int fd[2], cons=
t char *url_orig,
>                 end =3D host;
>
>         path =3D strchr(end, c);
> -       if (path && !has_dos_drive_prefix(end)) {
> +       if (path && !has_dos_drive_prefix(end) &&
> +           url[0] !=3D '/' && url[0] !=3D '.' ) {
>                 if (c =3D=3D ':') {
>                         if (path < strchrnul(host, '/')) {
>                                 protocol =3D PROTO_SSH;
> --
> 1.8.4.457.g424cb08
>



--=20
Duy
