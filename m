From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 1/2] remote tracking: return the tracking branch for  the given branches
Date: Thu, 18 Jun 2009 16:17:06 +0200
Message-ID: <200906181617.07802.jnareb@gmail.com>
References: <1245311834-5290-1-git-send-email-santi@agolina.net> <m3iqithd24.fsf@localhost.localdomain> <adf1fd3d0906180655q5c142889r3375169b6cf1f8b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Santi =?iso-8859-1?q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 16:17:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHIQs-00078A-TU
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 16:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbZFRORW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2009 10:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761352AbZFRORV
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 10:17:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:49208 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760067AbZFRORQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 10:17:16 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1127732fga.17
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=qfBkZsBhOt3ZKtS6wHIgZJ48dQotTqalcYiIHH+oKvc=;
        b=isBgBDJWpHGJWtsQmlITTerQrhtKtzuhZWfyDb4lS9t8LTn7QR8I+hVfbBP2EEhQtm
         CiigaIlpJNDZtauviH4qAZPbTFkbpqXEJS+kraXS7eUk0ZQV+GBHz36dhDumajyeABLH
         kFirDheLZa1Sn1xznJ/CntxNP9uIOFHk3TvGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=t7wqs5DN5vFH57Jfaj+HX5Dj+Dg6iLkw2bpK1kpbyWD7IuqzVcvLkeGe6ip6XjNpAN
         y29n+88H5HDfM/v1oLre8B+XUj8vCsMdb05qMs9YExZhYZCzLBubAr3EzuQOKCZDosSh
         cWRTrBD3PiMKRQHClJQ90H6wCWhAlNiO0WmQw=
Received: by 10.86.90.2 with SMTP id n2mr2016665fgb.39.1245334637224;
        Thu, 18 Jun 2009 07:17:17 -0700 (PDT)
Received: from ?192.168.1.13? (abvq34.neoplus.adsl.tpnet.pl [83.8.214.34])
        by mx.google.com with ESMTPS id 4sm4534881fgg.18.2009.06.18.07.17.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Jun 2009 07:17:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <adf1fd3d0906180655q5c142889r3375169b6cf1f8b0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121845>

On Thu, 18 June 2009, Santi B=E9jar wrote:
> 2009/6/18 Jakub Narebski <jnareb@gmail.com>:

[cut]
> >
> >  $ git remote tracking <remote> <remote branch>
> >
> > would show all local branches that track <remote branch>, and have
> > <remote> as default remote,
>=20
> Maybe my description is unclear, but it's not about local branches
> which track <branch> on <remote>, it is about the local branch
> representation of the remote branch, i.e. not 'master' but
> origin/master (git remote tracking origin master in a default clone).

Ah, the problem with the same (or similar) name for two different=20
things.  If we have local branch 'local' set to track branch 'master'
on remote 'origin', we have:

   /------- local repository ------\            /- origin -\
  /                                 \          /            \
  |                                 |          |            |
  'local'  -------->  'origin/master' -----------> 'master'=20
  refs/heads/local    refs/remotes/origin/master   refs/heads/master   =
            =20

  branch.local.remote =3D origin
  branch.local.merge  =3D refs/heads/master

  remote.origin.fetch =3D +refs/heads/*:refs/remotes/origin/*

'origin/master' is called remote-TRACKING branch (for 'master' branch
on remote 'origin').  Setting up automerge information for local branch
'local' which _follows_ branch 'master' on remote 'origin' is done=20
using --TRACK option to git-branch.

Therefore the confusion.


Do I understand correctly that you want for

  $ git remote tracking origin master

to return

  origin/master

(and perhaps also origin/HEAD?).
--=20
Jakub Narebski
Poland
