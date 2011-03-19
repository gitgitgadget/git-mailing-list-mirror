From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC - Better "git log --follow" support
Date: Sat, 19 Mar 2011 14:57:02 -0700 (PDT)
Message-ID: <m339mi6ago.fsf@localhost.localdomain>
References: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-2?q?Micha=B3_=A3owicki?= <mlowicki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 22:57:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1494-00039p-AW
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 22:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757693Ab1CSV5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 17:57:08 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40352 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757671Ab1CSV5G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 17:57:06 -0400
Received: by wya21 with SMTP id 21so4814607wya.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 14:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=zY4dKW9iRh+kH5+Svp8VS6Qfh/5k1zs0y/ZBZb4ublc=;
        b=fdZo1GILZi/0zWuiQFVUCuRckomkFWXtaiQYSdprEe2pNoIf4Qf2EsP6KeD7ig6FlC
         Dk+DHEes7VcFZEsAC11oL1mifDXwMuNzPqgtUvPDBfXQ7kJUNkLvgORhp5bouUmLD2GI
         sY/vD9o53TmJDNqvYNivaMQ2GPgvFS04PMAIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=RgB9UgQ3wbnVlDqzWlbQU8+gT1S8s+18BtTvLFmV+zGBFAWXtZnNTi6eDJzOwiQR/u
         G6WlSWHvxs9L/VDrsX00r2TjKOneIW1WKzTGSkgddlWh469+9Ccm5ylgAS2Bclbm0ZPj
         LNhuxtXwflkyUZx4c3v48Y6HkKJY26YYD7lZw=
Received: by 10.216.145.23 with SMTP id o23mr2568518wej.14.1300571823930;
        Sat, 19 Mar 2011 14:57:03 -0700 (PDT)
Received: from localhost.localdomain (abrz59.neoplus.adsl.tpnet.pl [83.8.119.59])
        by mx.google.com with ESMTPS id o19sm2050479wee.2.2011.03.19.14.57.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 14:57:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2JLubwf002376;
	Sat, 19 Mar 2011 22:56:47 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2JLuNKY002359;
	Sat, 19 Mar 2011 22:56:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169469>

Micha=B3 =A3owicki <mlowicki@gmail.com> writes:

> I'm looking at idea about better git log --follow support from
> https://git.wiki.kernel.org/index.php/SoC2011Ideas .There is somethin=
g
> like this - "[.. ] it does not interact well with git's usual history
> simplification [...]". Can someone elaborate this? I've found History
> Simplification in git rev-list man but don't know yet about issues
> with --follow.

Well, '--follow' option to git-log is a bit of bolted-on hack. =20

It does work only for single file (it doesn't work e.g. for
directory), and it not always work correctly.  For example

  $ git log --follow gitweb/gitweb.perl

correctly follows gitweb history across gitweb.cgi =3D> gitweb.perl
rename in 5d043a3 (gitweb: fill in gitweb configuration by Makefile,
2006-08-01), but it doesn't follow through subtree merging of gitweb
repository in 0a8f4f0 (Merge git://git.kernel.org/pub/scm/git/gitweb,
2006-06-10).

--=20
Jakub Narebski
Poland
ShadeHawk on #git
