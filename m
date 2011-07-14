From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-archive and tar options
Date: Thu, 14 Jul 2011 12:12:41 -0700 (PDT)
Message-ID: <m3oc0wad94.fsf@localhost.localdomain>
References: <ivla29$liu$1@dough.gmane.org>
	<20110714015656.GA20136@sigill.intra.peff.net>
	<4E1F2468.6080409@lsrfire.ath.cx>
	<20110714172718.GA21341@sigill.intra.peff.net>
	<4E1F2B23.1020908@lsrfire.ath.cx>
	<20110714181858.GA25172@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 21:12:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhRL7-0006PW-18
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 21:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611Ab1GNTMo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 15:12:44 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:46798 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab1GNTMn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 15:12:43 -0400
Received: by fxd18 with SMTP id 18so1507150fxd.11
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 12:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=zijwtet025DWAZ4zXMwNieHEYFyvE4KkMvNNUJ+wfLQ=;
        b=OjNsAl28cvMwBxximMyHW3dBz4KvHcPofUU5V/L1G/LLBapsJGeOjoF/wwTo1HcyXD
         uH33EfXiFf4cDqVspbfldtJrXON/E0tm7KqlI61NB5KYCNmv4h0d2wLF/2m28LA39/K3
         vUKoiFSjXIZIXMpFodSrAIbJIvBnEIYOIgHjI=
Received: by 10.223.52.132 with SMTP id i4mr3954763fag.107.1310670762572;
        Thu, 14 Jul 2011 12:12:42 -0700 (PDT)
Received: from localhost.localdomain (abva152.neoplus.adsl.tpnet.pl [83.8.198.152])
        by mx.google.com with ESMTPS id l22sm319135fam.9.2011.07.14.12.12.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jul 2011 12:12:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6EJC2bK004669;
	Thu, 14 Jul 2011 21:12:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6EJBZSS004664;
	Thu, 14 Jul 2011 21:11:35 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110714181858.GA25172@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177160>

Jeff King <peff@peff.net> writes:

> On Thu, Jul 14, 2011 at 07:45:07PM +0200, Ren=E9 Scharfe wrote:
>=20
> > > We didn't when git-archive was written, but these days we have
> > > get_sha1_with_context to remember incidental things about an obje=
ct we
> > > look up. It should perhaps remember the commit (if any) we used t=
o reach
> > > a treeish, and then the above command line could still insert the=
 pax
> > > header.
> >=20
> > That's a good idea to increase consistency, as there shouldn't real=
ly be
> > a difference in output between the two subdirectory syntaxes.
>=20
> The patch to do this is pretty tiny. See below.
>=20
> There are a few issues, though:
>=20
>   1. I think this is probably the right thing to do, and most people
>      will be happy about it. But I guess I can see an argument that t=
he
>      commit-id should not be there, as the subtree does not represent
>      that commit.
>=20
>      IOW, if you assume the commit-id in the output means
>      "by the way, this came from commit X", this change is a good thi=
ng.
>      If you assume it means "this is the tree from commit X", then it=
's
>      not.  I have no idea how people use it. I never have, but I alwa=
ys
>      assumed the use case was "I have this random tarball. Where did =
it
>      come from?".

Perhaps we should embed '<commit-id>:<subtree>' instead in pax header,
in that case?  Or <commit-id>.<subtree> if ':' is forbidden.

--=20
Jakub Nar=EAbski
Poland
