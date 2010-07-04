From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP/PATCH] Teach fast-import to print the id of each imported
 commit
Date: Sun, 4 Jul 2010 02:22:06 -0500
Message-ID: <20100704072206.GA758@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100702051201.GC7209@burratino>
 <AANLkTintWyhcx9pURSqxs3e9BBkPx9KSPPYh4UOU7kv6@mail.gmail.com>
 <20100702154028.GB2287@burratino>
 <1278201760.9701.39.camel@denix>
 <20100704003543.GA25858@burratino>
 <1278215044.13014.33.camel@denix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Jul 04 09:22:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVJXR-0005zy-JK
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 09:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708Ab0GDHWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jul 2010 03:22:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36803 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911Ab0GDHWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jul 2010 03:22:42 -0400
Received: by iwn7 with SMTP id 7so4560239iwn.19
        for <git@vger.kernel.org>; Sun, 04 Jul 2010 00:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5sMHt9yo3h/aC8nPrPf5SczIOZM1bcxgFFo631NnDrY=;
        b=D4Rtw9gJCSC0eOb5wev36H9nTIdrwU3072uKcuh6eTm10zFGKSpBBNscChRnp4fsFw
         xM6ySOyc8Mi4a00KmVg4pJso3pVZxwLnQFxvyujpaALJBgHS67FoW7YgHICf77ZUDw2g
         e7Ytf4vOE0kRAVU980EnH8Sm0IiTOxFMVkYXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=o+kUOUDlh/r5YC+glolmzKW63yXuBU8Pe7ajeOF+Yx7Hn8+M0YWxMVdU1zRBlYUq7m
         u3MrcmAhORNmJlUNfmCAhy1yOKhVYbpiXMAYKpV/bVlaeUaM639Xcv/PBNuJc0FySAZJ
         +weEjHRADqr/ipDg9gVmv0W9s4RW7xb9SW3vE=
Received: by 10.231.148.73 with SMTP id o9mr1484811ibv.21.1278228161372;
        Sun, 04 Jul 2010 00:22:41 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm9668679ibb.20.2010.07.04.00.22.40
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 04 Jul 2010 00:22:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278215044.13014.33.camel@denix>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150217>

Sam Vilain wrote:

> Let me explain further.  If in fast-import.c:new_object, if it were t=
o
> make a struct object (see object.h), and make sure it was put in
> obj_hash (see object.c, particularly create_object()), then you might
> find a whole load of plumbing would magically start working and be ab=
le
> to work with the new objects that you are trying to load.  Of course
> there may be a couple of other functions which might need to change.
> Primarily object.c:read_object, which needs to be able to check the
> packfile being spooled by git fast-import.
>=20
> If you did this, then to implement this feature you could in principl=
e
> just call read_sha1_file()

Oh, to implement the =E2=80=98cat=E2=80=99 feature, I was planning to c=
all
gfi_unpack_entry; the hard part is finding a spare moment to do that
(if others have more spare moments, I would be happy to find that
step unnecessary).

What you describe sounds more useful as part of a longer-term plan.
If fast-import and its caller live in the same process, then being
able to use the usual object access APIs would be convenient indeed.
In other words, it sounds like an incentive to libify fast-import.

Well, everything in due time.

Thanks for the comments,
Jonathan
