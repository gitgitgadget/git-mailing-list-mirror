From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Can't handle renamed resources on case insensitive filesystems.
Date: Mon, 14 Dec 2009 15:50:16 +0100
Message-ID: <40aa078e0912140650t7e061da0nfc75955cb584f3ba@mail.gmail.com>
References: <63135FDB-C8EF-4DBC-AEF5-4B0636C8D349@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Lhunath (Maarten B.)" <lhunath@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 15:50:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKCFm-0000iR-Jw
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 15:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756569AbZLNOuV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 09:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756125AbZLNOuU
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 09:50:20 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:43470 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212AbZLNOuS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 09:50:18 -0500
Received: by fxm5 with SMTP id 5so3613107fxm.28
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 06:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ms6F5/3UZCSRGAqcD93osNRsGjwoS5STVpTZ/8NJHVY=;
        b=q6NhYcm6yc0D16zgfD1D8ShcmUnDz1WsUwVPWX6aPg8zPQVqqpaDWC7syP7MzCl6Cy
         vmVrOWQkGRNzXEdFET72ORCpwCdI86lPmsBrZYehhErF+VRiEp7AP6enzh3xxzqzyo9z
         P8PZetSXNGgIhyWqJRZC5TckAw1J1xksnKjJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=sR6HC6Ehe5p8aa/I5yrpj2XvYhAe9TaaqSX1NyedCsTCA5k82D/S3MvEyyV69lu2Sk
         fQoITa7xcFPb5PgXehbZCWDfvYxP96049lOkxF8t8xyhRrt0AEvmE0Mm0KNiD5nxn1UZ
         1h/zmPR8j1biEqeFh+2t5HezC/qvmXQow1lw8=
Received: by 10.216.89.194 with SMTP id c44mr2047436wef.199.1260802216565; 
	Mon, 14 Dec 2009 06:50:16 -0800 (PST)
In-Reply-To: <63135FDB-C8EF-4DBC-AEF5-4B0636C8D349@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135215>

On Mon, Dec 14, 2009 at 3:27 PM, Lhunath (Maarten B.) <lhunath@gmail.co=
m> wrote:
> GIT has quite a few issues concerning renamed files on case insensiti=
ve filesystems, such as Mac OS X's default HFS+.
>
> For instance:
>
> lhunath@Myst t $ git mv Foo foo
> fatal: destination exists, source=3DFoo, destination=3Dfoo
>
> Moreover, when a repository contains Foo and foo in one commit and in=
 a subsequent commit, "foo" is removed; "Foo" will also disappear when =
checking out the latter.
>
> Most of these issues are likely just a result of the underlying file =
system's handling of GIT's commands; though considering that Mac OS X's=
 default fs is case insensitive by default, and the Mac and Windows use=
rbases combined are quite large; it might be very much appropriate to d=
o a check for this (if needed) and handle renames (and other operations=
?) in a way that they would not cause conflicts on these file systems (=
eg. rename to a temporary filename first and then rename to destination=
).
>
> In particular; these issues make it awfully painful to refactor Java =
class names from things like JndiUtils -> JNDIUtils. =A0Not only is it =
hard to get the commit INTO the repository correctly; it is also hard t=
o check the commit OUT for somebody who has no idea any of this is need=
ed.--

Actually, you have only discovered the tip of the iceberg that is git
and case insensitivity. However, it is probably also the most annoying
part of it. Changing git mv to skip moving (or moving in a way that
works better) the file when core.ignorecase is enabled and the source
and destination are the same when compared in a case insensitive
fashion might make sense.


--=20
Erik "kusma" Faye-Lund
