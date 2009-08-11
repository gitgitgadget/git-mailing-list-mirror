From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v3 7/8] Support sparse checkout in unpack_trees() and  read-tree
Date: Tue, 11 Aug 2009 14:38:04 -0700 (PDT)
Message-ID: <m3ab26owub.fsf@localhost.localdomain>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
	<1250005446-12047-2-git-send-email-pclouds@gmail.com>
	<1250005446-12047-3-git-send-email-pclouds@gmail.com>
	<1250005446-12047-4-git-send-email-pclouds@gmail.com>
	<1250005446-12047-5-git-send-email-pclouds@gmail.com>
	<1250005446-12047-6-git-send-email-pclouds@gmail.com>
	<1250005446-12047-7-git-send-email-pclouds@gmail.com>
	<1250005446-12047-8-git-send-email-pclouds@gmail.com>
	<2729632a0908111418m57e03d8as9c122cbb52efc21a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 11 23:38:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Maz2w-0007yN-4K
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 23:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbZHKViI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 17:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbZHKViH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 17:38:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:64877 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbZHKViG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 17:38:06 -0400
Received: by fg-out-1718.google.com with SMTP id e21so992734fga.17
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=hz0lXGKcMAgFgirnqj4qJzOxFr1XnxBuHZyZ8dTM6e8=;
        b=pzHipt5Dodt7tr6Iay5pHxFbv9d7YWKFcDiMEn9LrdCEnhCgvWymx7hS6uaQjTiy4W
         N2n9TAebMMaN1D4maa39G7fT4Vrh6J+ZV4hWCH8LtTI/ji6lMXEwwF/BkEvv/voWtdgy
         IrYzDAY6HZ3TLhhR7WfPr6MOcEO3d5eXJY1bU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=KBk1m9pbwejeJL+vJXCWD1CT1xCM+yxr4qPZzo9eRYOjbjfDznB9wBNflyeczsisdC
         pB25pdFAYboR5ZrOUjhTbjsT0cKVYvUUdMQN1EX6gSUGdBKw6ov56EgX+v5XvGDy3e3H
         gNkZFVnV7BuMX/Li+skkO4fME1EJ5hlx1gE4g=
Received: by 10.86.94.7 with SMTP id r7mr4318072fgb.11.1250026686173;
        Tue, 11 Aug 2009 14:38:06 -0700 (PDT)
Received: from localhost.localdomain (abva90.neoplus.adsl.tpnet.pl [83.8.198.90])
        by mx.google.com with ESMTPS id 12sm14775992fgg.11.2009.08.11.14.38.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 14:38:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7BLc5u4001066;
	Tue, 11 Aug 2009 23:38:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7BLc4ml001063;
	Tue, 11 Aug 2009 23:38:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2729632a0908111418m57e03d8as9c122cbb52efc21a@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125605>

skillzero@gmail.com writes:
> 2009/8/11 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>:

> > [1] .git/info/sparse has the same syntax as .git/info/exclude. File=
s
> > that match the patterns will be set as CE_VALID.
>=20
> Does this mean it will only support excluding paths you don't want
> rather than letting you only include paths you do want?

Errr... what I read is that paths set by .git/info/sparse would be
excluded from checkout (marked as assume-unchanged / CE_VALID).

But if it is the same mechanism as gitignore, then you can use !=20
prefix to set files (patterns) to include, e.g.

  !Documentation/
  *

(I think rules are processed top-down, first matching wins).
=20
> I'm currently using your other patch series that lets you include or
> exclude paths (via config variable) and I find that I mostly use the
> include side of it with only a few excluded paths. This is because I
> typically want to include only a small subset of the repository so
> using excludes would require a pretty large list and any time somebod=
y
> adds new files, I'd have to update the exclude list.

Not true, see above.

--=20
Jakub Narebski

Git User's Survey 2009
http://tinyurl.com/GitSurvey2009
