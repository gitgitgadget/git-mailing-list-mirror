From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/5] unpack_trees(): add support for sparse checkout
Date: Wed, 29 Jul 2009 04:48:31 -0700 (PDT)
Message-ID: <m3zlan1zhv.fsf@localhost.localdomain>
References: <1248850154-5469-1-git-send-email-pclouds@gmail.com>
	<1248850154-5469-2-git-send-email-pclouds@gmail.com>
	<1248850154-5469-3-git-send-email-pclouds@gmail.com>
	<1248850154-5469-4-git-send-email-pclouds@gmail.com>
	<1248850154-5469-5-git-send-email-pclouds@gmail.com>
	<1248850154-5469-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 13:48:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW7eD-0001E4-Aw
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 13:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbZG2Lse convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 07:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754234AbZG2Lse
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 07:48:34 -0400
Received: from mail-bw0-f221.google.com ([209.85.218.221]:54480 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217AbZG2Lsd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 07:48:33 -0400
Received: by bwz21 with SMTP id 21so630819bwz.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 04:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=PH4Bz4VYwvTACS9sycnX8ZcJIM88qu/Yp2+nXPxrdq0=;
        b=UtD+38Df682OLT92u66Q3g83Ku4MstT7ScBEb5VIby1QLByc88RX1jQRkXu6d/EVOn
         uB4jJfxfG9UL8ic503ROFRY97LtgaPllmyJPhWNqYkb2WVUj+e0FprDM/ogd+vZ42Q9F
         /jhRZ+24fS6ci355/vK0fpWo4dD18hBQo7+k0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=tO6jmIoDnlvdRNb9ksXTcD0srkrCSFazL894g7FrMPd3WXLygv+/rvS2PIwIJiamp2
         TTpWPIbQEChl4OoYVqfwYOQi37c39KZrqzZKRSjh9b+kmwJtwPc7cVAlb8Dj12Ym/InE
         iZzVWyHXuQEJFqSwUlo00/+UN/c53GY54N5nY=
Received: by 10.204.117.16 with SMTP id o16mr5533328bkq.100.1248868111997;
        Wed, 29 Jul 2009 04:48:31 -0700 (PDT)
Received: from localhost.localdomain (abvm110.neoplus.adsl.tpnet.pl [83.8.210.110])
        by mx.google.com with ESMTPS id p9sm591501fkb.37.2009.07.29.04.48.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Jul 2009 04:48:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6TBmTb7020074;
	Wed, 29 Jul 2009 13:48:30 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6TBmTQ5020065;
	Wed, 29 Jul 2009 13:48:29 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1248850154-5469-6-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124345>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy    <pclouds@gmail.com> writes=
:

> This patch teaches unpack_trees() to checkout/remove entries
> on working directories appropriately when sparse checkout area is
> changed. A helper "git shape-workdir" is needed to help determine
> which entry will be checked out, which will be not.

Wouldn't "git update-index --index-info" (perhaps extended) be enough?

>=20
> "git shape-workdir" will receive from stdin in this format
>=20
> X\tpathname
>=20
> where X is either
>  - '!' current entry is already CE_VALID
>  - 'N' current entry is "new" (it has not been in index before)
>  - '-' current entry is "normal" entry
>=20
> "git shape-workdir" is expected to return either "1" or "0"
> immediately. "1" means the entry should be in workdir. "0" means
> setting CE_VALID and get rid of it from workdir.

Just in case it would be better IMVHO if it returned "1\tpathname" or
"2\tpathname".  By the way, is 'pathname' quoted if necessary, and
does git-shape-workdir support -z/--null option?

Signoff (also in some other patches in this series)?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
