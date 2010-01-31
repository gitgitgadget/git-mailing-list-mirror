From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/12] Teach Makefile to check header dependencies
Date: Sun, 31 Jan 2010 15:14:29 -0600
Message-ID: <20100131211429.GA4550@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock>
 <20100126155714.GM4895@progeny.tock>
 <7viqaic8gs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 22:14:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbh7z-00038C-FU
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 22:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab0AaVOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jan 2010 16:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835Ab0AaVOg
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 16:14:36 -0500
Received: from mail-iw0-f173.google.com ([209.85.223.173]:47676 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab0AaVOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 16:14:33 -0500
Received: by iwn3 with SMTP id 3so3735823iwn.23
        for <git@vger.kernel.org>; Sun, 31 Jan 2010 13:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CXCpTLBE79qHAPS1cE78lR6eDV+Zgw+Ok0xJ8NUlDVc=;
        b=PVqwhGjexTUHreVOnKXf73Z1ZZZvyui8CAc2Xil97cRCA1bBKDNMsgvbv/BygglAWk
         yYsYOKlf2Oww/+TB5RqITXRN8bjeTLU/wpbxaugkwoVYx7V4aA+T6SHJ5eOc5IROEBIX
         reeX95AtAjrv1cLeORHmGwXoTGtE8IUHSkNrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hgNhdtj9XVYnx8GkpSTlTk7eEDQag6Wr/a2ca0sy1tbysHnb9s4esXQjAy715aCc21
         SUpDTJdbWNptgOFc5BHUe3scV+j3AXAXTs/VtvejaozYxdrBBhtJtpKN274/zOJH8eYY
         9cgWPTXsKngzrD5BEIxlj5gg1cmxjtQGD/ws4=
Received: by 10.231.154.8 with SMTP id m8mr1921198ibw.2.1264972472558;
        Sun, 31 Jan 2010 13:14:32 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2711935iwn.5.2010.01.31.13.14.31
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Jan 2010 13:14:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7viqaic8gs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138562>

Junio C Hamano wrote:

> Thanks.
>=20
> Three observations:
>=20
>  * "make distclean" should remove $(dep_files);

It removes $(dep_dirs) in "make clean".  Do you think they should be
kept around?  Or is this about when COMPUTE_HEADER_DEPENDENCIES is
turned off but .o.d files remain?

>  * "deps/" should probably be ".depend/" or something less distractin=
g;

Good idea.

>  * I wish CHECK_HEADER_DEPENDENCIES pointed out unnecessary dependenc=
ies
>    hardcoded in the Makefile.

That would not be hard to do, but wouldn=E2=80=99t the $(GIT_OBJS): $(L=
IB_H)
rule create a lot of noise?

How about if it checks for duplicate dependencies and unnecessary
dependencies that are not in LIB_H?

> -- >8 --
> Subject: [PATCH] Makefile: "make distclean" should remove dependency =
files
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 45b1f54..8578b31 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2110,7 +2110,7 @@ dist-doc:
>  ### Cleaning rules
> =20
>  distclean: clean
> -	$(RM) configure
> +	$(RM) configure $(dep_files)

This couldn=E2=80=99t hurt, but I wonder whether it is necessary; see a=
bove.

Thanks for the feedback,
Jonathan
