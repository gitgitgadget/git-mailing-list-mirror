From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gc getting called on each git command ... what's wrong?
Date: Wed, 08 Jun 2011 10:09:12 -0700 (PDT)
Message-ID: <m3pqmodzee.fsf@localhost.localdomain>
References: <BANLkTi=oUARfwvNFNj-_FvZdwxQgibqPOg@mail.gmail.com>
	<BANLkTiksHRmp102XDJP5+-CLGj8hZXUR=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: geoffrey.russell@gmail.com, git@vger.kernel.org
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:09:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUMFp-0001Y9-Tz
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab1FHRJQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 13:09:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36479 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab1FHRJO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 13:09:14 -0400
Received: by bwz15 with SMTP id 15so598092bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 10:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=s25yWMpS1lQpOcslL8CKgXTDOhwnCYTastWDmECHxd8=;
        b=cL/uI3b/vo7Dj15+Cc908Z9GYaV4JJ41m2h15w2HOs1msLykIBdDMut4thtqQVNwV6
         w/of3ggtIzdYn+c4KAfTIXl1aouTweyXhvxluvY29KY6lvoTX3Q1gWCOvG7bBeryy5/t
         n1U5QyzBlQQpaTanqbByQHQqcT+y5pw92+8Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=eKPNMWGPWdNtbaUkMLrI26M8QKNqlmd7hpNWSoQE//X0f0nKPGyWfnOVbt+wp9pn7B
         M/qqGR2Yicn83PytP4dYKSUwHQATZ7Nyp0vEg2bJmWcjvgYnM6QUdT5zMFfs/UPAYYbG
         AmNp+d52MTDe/WEbo/Gl5pO122uL6vbDyLD/M=
Received: by 10.204.47.66 with SMTP id m2mr907848bkf.146.1307552953284;
        Wed, 08 Jun 2011 10:09:13 -0700 (PDT)
Received: from localhost.localdomain (abvo166.neoplus.adsl.tpnet.pl [83.8.212.166])
        by mx.google.com with ESMTPS id 16sm751491bkm.2.2011.06.08.10.09.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 10:09:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p58H8aJo020039;
	Wed, 8 Jun 2011 19:08:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p58H8PTr020035;
	Wed, 8 Jun 2011 19:08:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTiksHRmp102XDJP5+-CLGj8hZXUR=g@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175403>

Peter Harris <git@peter.is-a-geek.org> writes:

> On Tue, Jun 7, 2011 at 9:33 PM, Geoff Russell wrote:
> >
> > As of today, almost every time I do a git command, gc is getting
> > invoked.
>=20
> >  =A0There are 96 pack files.
>=20
> That's why. See gc.autopacklimit in "git help config" -- by default,
> git will gc if there are more than 50 pack files.

Actually it looks like it is combination of this and packSizeLimit set
to 30M.  Git notices that it has too many packfiles, and tries to
repack them, but packlimit forces Git to split it into small
packfiles... and end up with more packfiles than limit anyway.

Perhaps git should notice that it has nonsensical combination of
options...
--=20
Jakub Narebski
Poland
ShadeHawk on #git
