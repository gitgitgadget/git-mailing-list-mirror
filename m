From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@dwim.me>
Subject: Re: BUG in git diff-index
Date: Thu, 31 Mar 2016 15:57:47 +0200
Message-ID: <1459432667.2124.2.camel@dwim.me>
References: <loom.20160331T143733-916@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andy Lowry <andy.work@nglowry.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 15:57:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ald6g-0000eI-Ph
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 15:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756AbcCaN5v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 09:57:51 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50734 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752768AbcCaN5u (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 09:57:50 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id B74BF22102
	for <git@vger.kernel.org>; Thu, 31 Mar 2016 09:57:49 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 31 Mar 2016 09:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=dwim.me; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=eXIu13JNph0uCIE9PhzS8CmmVEg=; b=fHS5KA
	vOSBOwpaiuYVu6CtyL9ZGGPHvJgFk6E3gJaPM6fHoKSYzxDx7UlL7Xy8XiQi8IJH
	+/0RCoT+WpkGvg0FePByD8stz6ZIuVkpIygQHs7Als608sENiOR6+lgrZ1yHP86/
	4Kxhg3RO+EKw+d847KwLZRv6HXfrY5ZOt/Cac=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=eXIu13JNph0uCIE
	9PhzS8CmmVEg=; b=kv7PH2FiVep1yUE4Fk11uFVnx9A9fYBUGBOhakJaEVqfu6U
	tX1SNOtCj34EF9eZ5cFoIhrjYuFVc76ryeVbbZJtvlpHetjSvY5GpTz2dTl3h5DB
	dJejRNKIPz3LyATiIy6bWaAMH7rhFK3bCH+0OOoLQMPvhcBOdWUHo3A/b1Vs=
X-Sasl-enc: dcXj4Mx0VT4DC9raPzo40aPoYOOzonFQcVwoI0LIXrkB 1459432669
Received: from ip5b40609c.dynamic.kabel-deutschland.de (ip5b40609c.dynamic.kabel-deutschland.de [91.64.96.156])
	by mail.messagingengine.com (Postfix) with ESMTPA id 11F58C00013;
	Thu, 31 Mar 2016 09:57:48 -0400 (EDT)
In-Reply-To: <loom.20160331T143733-916@post.gmane.org>
X-Mailer: Evolution 3.18.5.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290383>

On Thu, 2016-03-31 at 12:39 +0000, Andy Lowry wrote:
> Following transcript illustrates what I believe to be a bug in git
> diff-
> index. The session used a git built from latest source, located in=C2=
=A0
> /tmp/git/git.
>=20
> 1. New repo, create empty file A, commit changes.
> 2. touch A
> 3. git diff-index reports A has changed, and reports bogus
> destination=C2=A0
> SHA
> 4. This is stable behavior until next step

This is expected and matches the documentation. See the bit starting
with

=C2=A0 =C2=A0 OPERATING MODES
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0You can choose whether you wan=
t to trust the index file entirely (using the --cached flag) or ask the=
 diff
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logic to show any files that d=
on=E2=80=99t match the stat state as being "tentatively changed". Both =
of these
=C2=A0=C2=A0    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0operations are very usefu=
l indeed.

The next two sections describe what you are seeing. The default is non-
cached mode which also shows files which don't match the stat data in
the index (which you've changed by touching the file).

Cheers,
=C2=A0 =C2=A0cmn
