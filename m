From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [RFC/PATCH] submodule: add 'exec' option to submodule update
Date: Fri, 28 Jun 2013 12:42:43 +0200
Message-ID: <20130628104243.GD27497@paksenarrion.iveqy.com>
References: <1372413190-32732-1-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 12:43:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsW93-0002Wj-LL
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 12:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab3F1KnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 06:43:09 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:57439 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121Ab3F1KnH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 06:43:07 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so1987961lab.19
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wcL95ilZjZYBq9wrbOGLoQRTxMHFa63jNUZkIx+6gvY=;
        b=y3PJy75UKab5bpRBZPGAaYWBaNz4zi9ZYLX29sSASpZXzOlS5n71pva/bXj04l5fsw
         R9ze6P/D7VZ4TKBPmFxSaDb9AyZsilNC5xwz+/2X+dGNymol5XeWmr7ACYUrYcPQBzfF
         7EJao+bzn9/931EQrB9Faxl0ZW8wfvZY5x0XlazIcJibrRiW3J3XcFootbWl4RbCv9T/
         K0Kk7ESA+36fuEPOCq8Zgz/PlNgOese/IZQUVcFmaqHv3wXNzxA0OO3RzoD/vLnC+nr3
         jgReaS3FCIB5C9fLXAalOCXSwSqPL7wqHGEP+YaLFgpbi5M4sZX0wdQ198zDMGEwhw06
         ICqw==
X-Received: by 10.152.28.129 with SMTP id b1mr6240575lah.51.1372416185459;
        Fri, 28 Jun 2013 03:43:05 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id ea14sm2446347lbb.11.2013.06.28.03.43.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 03:43:04 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UsW8Z-00052L-Dh; Fri, 28 Jun 2013 12:42:43 +0200
Content-Disposition: inline
In-Reply-To: <1372413190-32732-1-git-send-email-judge.packham@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229186>

Hi,

On Fri, Jun 28, 2013 at 09:53:10PM +1200, Chris Packham wrote:
> This allows the user some finer grained control over how the update i=
s
> done. The primary motivation for this was interoperability with stgit
> however being able to intercept the submodule update process may prov=
e
> useful for integrating or extending other tools.
>=20
> Signed-off-by: Chris Packham <judge.packham@gmail.com>
> --
> Hi,
>=20
> At $dayjob we have a number of users that are accustomed to using stg=
it.
> Stgit doesn't play nicely with git rebase which would be the logical
> setting for submodule.*.update for our usage. Instead we need to run
> 'stg rebase --merged' on those submodules that have been initialised
> with stgit.
>=20
> Our current solution is an in-house script which is a poor substitute
> for git submodule update. I'd much rather replace our script with git
> submodule update but we do have a requirement to keep stgit for the
> foreseeable future.  Rather than narrowing in on stgit it seems logic=
al
> to allow an arbitrary update command to be executed.
> ---
>  Documentation/git-submodule.txt |  8 +++++++-
>  git-submodule.sh                | 22 +++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 2 deletions(-)
>=20

technically it looks fine to me (except for the lack of tests) but I'm
not sure I follow the use case.

In your case, you want to run a script to determinate if that certain
submodule should use merge or rebase depending on "whatever". And this
can't be done with git submodule foreach because you want to know the
sha1 to update to. Have I understood you correctly?
--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
