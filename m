From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Speed up bash completion loading
Date: Sat, 14 Nov 2009 13:33:00 -0600
Message-ID: <20091114193300.GA1856@progeny.tock>
References: <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
 <20091111220832.GA31620@progeny.tock>
 <4AFCFF50.5080401@gmail.com>
 <20091113070652.GA3907@progeny.tock>
 <4AFD06CD.7090003@gmail.com>
 <20091113085028.GA4804@progeny.tock>
 <20091113090343.GA5355@progeny.tock>
 <4AFDC4F3.1050607@gmail.com>
 <20091114110141.GB1829@progeny.tock>
 <20091114144303.GA31540@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 14 20:22:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9OCk-00063t-9Q
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 20:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbZKNTWZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Nov 2009 14:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbZKNTWZ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 14:22:25 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:60008 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbZKNTWY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 14:22:24 -0500
Received: by gxk26 with SMTP id 26so3941255gxk.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 11:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Q+v1Mrcd60EaG5u4d+JfPytgsJWqnL81mYK1cWE9VEc=;
        b=uCE0crtU2ZFY0vJm7KvX/mW0D9rj7aGhRP4I4x/hte1/5evHX12D83elXZYNBoOGc5
         mxt/L4F52GfAuHBiZPrs2otcwaF5etehRkh9C0g/e+XdOVxNEYiOe7js8CoDDjjrI5vX
         IT9dRYBBQ2VSqJo+4mUpcyumFxH7QVVd5Tu+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jfZb0CqbRNVLe1F+vCL+4Q8EM+Kaqd+zUSh6Q4sAaLgvyOHaOsNK+aIP3huE7/m2vN
         YRp5MkAJXI9gKNpabAaSuOMjtFbHQK9TY9xr2kafAX/QVKc7uCxLdWuS88R8Yczu/1cY
         QGMiszCAeEHBgPTuhJtu1sM+A+3Rr6pI9McSs=
Received: by 10.150.30.10 with SMTP id d10mr10323562ybd.341.1258226549862;
        Sat, 14 Nov 2009 11:22:29 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm2478257gxk.8.2009.11.14.11.22.28
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Nov 2009 11:22:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091114144303.GA31540@neumann>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132880>

Hi G=E1bor,

SZEDER G=E1bor wrote:

> Why?  Don't get overly creative here, the command
>=20
>   . /path/to/git-completion.bash
>=20
> already does that, plus it fixes the merge strategy completion issue,
> and it's friendly enough for the users.

Sounds like a good approach.  Squashing this in should get that
working again.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
In this patch, I assume the merge strategy list is not being cached
any more.  Something like this would allow recovering from the merge
strategy completion issue, but the victim would have to notice what
went wrong first.

 contrib/completion/git-completion.bash |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 634941f..ae39373 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -495,6 +495,7 @@ __git_list_all_commands ()
 	done
 }
=20
+unset __git_all_commands
 __git_compute_all_commands ()
 {
 	: ${__git_all_commands=3D$(__git_list_all_commands)}
@@ -586,6 +587,7 @@ __git_list_porcelain_commands ()
 	done
 }
=20
+unset __git_porcelain_commands
 __git_compute_porcelain_commands ()
 {
 	__git_compute_all_commands
--=20
1.6.5.2
