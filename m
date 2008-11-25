From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: inted problems when upgrading to 1.6.0.4
Date: Tue, 25 Nov 2008 11:36:03 +0100
Message-ID: <200811251136.03546.brian.foster@innova-card.com>
References: <492BC56A.6040506@xmos.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Luis Gutierrez <luis.gutierrez@xmos.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 11:37:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4vIW-0000ZK-5G
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 11:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbYKYKgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2008 05:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbYKYKgU
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 05:36:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:59196 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbYKYKgT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2008 05:36:19 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1276844nfc.21
        for <git@vger.kernel.org>; Tue, 25 Nov 2008 02:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=SGxzrr5xb/JJwQtwldEVe3s34/MQuSDSB8zkJ2SYlAk=;
        b=nAUTfhKi/7FhCMroa9ZCXVfJBB2XDf+iWr4Yjp2YEoO3XB0SDOjkq08cHfrpKceBSJ
         E/jL53mjGNqg3ncI8r/sszJT7XTm7hhGleiLwJWiQ9KuzvWLmTv1IcQlTrWFipy8GZdS
         tW5ax4EjKCoGkE2BxFWziI+zOSjkJC2bfirlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=AfVo9tXgMEniA1oXw9DtIiGqqGYx4jx03fEeH8izB7GwVQ4mfB5VYKf/dT0qXyqFg3
         CkcoI7RSn1tauIl2X2tDmDydVnyG+ZQlW3KWby92gGkmgpTM9ep9gIZiCVrrGJBCuVhZ
         ptqGDUkCpagr6NVSFpYpJ3VrR+IpT+NkwVN94=
Received: by 10.210.54.19 with SMTP id c19mr4592728eba.116.1227609376307;
        Tue, 25 Nov 2008 02:36:16 -0800 (PST)
Received: from innova-card.com (1-61.252-81.static-ip.oleane.fr [81.252.61.1])
        by mx.google.com with ESMTPS id 10sm1574320eyd.33.2008.11.25.02.36.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Nov 2008 02:36:14 -0800 (PST)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
In-Reply-To: <492BC56A.6040506@xmos.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101656>

On Tuesday 25 November 2008 10:29:14 Luis Gutierrez wrote:
>[ ... ]
> This is my current xinetd config:
> service git
> {
>     disable      =3D yes
>     socket_type  =3D stream
>     wait         =3D no
>     user         =3D git
>     type         =3D UNLISTED
>     protocol     =3D tcp
>     log_on_failure    +=3D USERID
>     port         =3D 9418
>     server       =3D /usr/local/bin/git
>     server_args  =3D daemon --inetd --syslog --verbose --export-all -=
-base-path=3D/vol0/git/projects --allow-override=3Duploadpack
> }

   In the past I also had a problem when git was installed
  in /usr/local/bin and git-daemon was launched from xinetd.
  I don't recall the details now, but believe all the obvious
  suspects (conflicting git installation, /usr/local/bin not
  in PATH, mis-installed/mis-configured git, et al.) seemed Ok.
  In any case, I debugged the problem by adding:

     env  +=3D  GIT_TRACE=3D/tmp/LOG-git-daemon

  to the xinetd config.  I suggest trying that and seeing
  what the logfile contains.

cheers!
	-blf-

p.s.  In my case, *using the information in the logfile*,
     I eventually worked-around it by adding
     =E2=80=98--exec-path=3D/usr/local/bin=E2=80=99 to the =E2=80=98ser=
ver_args=E2=80=99.
     I never did work out exactly what was going wrong (this
     was with a self-built git v1.5.5 on CentOS release 5).

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
