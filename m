From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] contrib: add a credential helper for Mac OS X's keychain
Date: Wed, 14 Sep 2011 04:01:31 -0400
Message-ID: <CAEBDL5UprYM0=SgNQrsY8_aCGf+pxKc1NP0AFjJy8igzt3vDZQ@mail.gmail.com>
References: <1315683874-95583-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>,
	Jeff King <peff@peff.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 10:01:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3kPZ-0006em-Sd
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 10:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630Ab1INIBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 04:01:32 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59999 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab1INIBb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 04:01:31 -0400
Received: by qyk30 with SMTP id 30so3564671qyk.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 01:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GSR1lf/yW5OujE3Z8BhFIchE73bguFLKDNWMjd7vHd4=;
        b=W8HUePBO6AHiWkhtptJrg/c0ne298xXNYjCsGbxwK+R4V9Eum4suxKk/H/Utw/DlJv
         DwoHTeOkUC4zGemlIdxtpP07L9GsYJ9JN7ubegmlWIWynD7ZDvhyX5sRwJMqbtBfOV4F
         s0OOsVzQbF+ypYUbbsH/diGyuaecAjZx+8Rkg=
Received: by 10.52.116.69 with SMTP id ju5mr524797vdb.258.1315987291112; Wed,
 14 Sep 2011 01:01:31 -0700 (PDT)
Received: by 10.52.160.196 with HTTP; Wed, 14 Sep 2011 01:01:31 -0700 (PDT)
In-Reply-To: <1315683874-95583-1-git-send-email-jaysoffian@gmail.com>
X-Google-Sender-Auth: xj0AsyFFbDy7jj8Hba2rqiIvW-U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181343>

On Sat, Sep 10, 2011 at 3:44 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> A credential helper which uses /usr/bin/security to add, search,
> and remove entries from the Mac OS X keychain.
>
> Tested with 10.6.8.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> This is a quick script to explore the new credential API. A more robu=
st
> implementation would be to link to OS X's Security framework from C.
[snip]
> +def add_internet_password(protocol, hostname, username, password):
> + =C2=A0 =C2=A0# We do this over a pipe so that we can provide the pa=
ssword more
> + =C2=A0 =C2=A0# securely than as an argument which would show up in =
ps output.
> + =C2=A0 =C2=A0# Unfortunately this is possibly less robust since the=
 security man
> + =C2=A0 =C2=A0# page does not document how to quote arguments. Empri=
cally it seems
> + =C2=A0 =C2=A0# that using the double-quote, escaping \ and " works =
properly.

I'm not sure this comment is correct... it looks like you're passing
the password on the command line...

> + =C2=A0 =C2=A0username =3D username.replace('\\', '\\\\').replace('"=
', '\\"')
> + =C2=A0 =C2=A0password =3D password.replace('\\', '\\\\').replace('"=
', '\\"')
> + =C2=A0 =C2=A0command =3D ' '.join([
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'add-internet-password', '-U',
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'-r', protocol,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'-s', hostname,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'-a "%s"' % username,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0'-w "%s"' % password,

=2E..right here. :-(

-John
