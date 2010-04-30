From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git cherry(pick) dumps core
Date: Fri, 30 Apr 2010 08:32:29 -0500
Message-ID: <20100430133228.GA1620@progeny.tock>
References: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com>
 <r2s302ed1461004281249xd1b65e41l43fa7b639db7c97d@mail.gmail.com>
 <h2v76c5b8581004281259yfaca7abfz5a455ff8fd6cdc6b@mail.gmail.com>
 <o2j2cfc40321004281539j28fe44e0r5d029061e3e08b90@mail.gmail.com>
 <20100428233758.GA1654@progeny.tock>
 <20100429191150.GA10526@inner.home.ulmdo.de>
 <20100429194936.GA31941@progeny.tock>
 <20100429202139.GW10879@inner.home.ulmdo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 30 19:45:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7uHY-0005vn-So
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 19:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933429Ab0D3RpF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Apr 2010 13:45:05 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:32942 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933496Ab0D3Ro5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 13:44:57 -0400
Received: by pwj9 with SMTP id 9so292143pwj.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 10:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sHfBZsYHuMPIxumupy9PA0qTwHLiTyQrCJzUmRs/ZLE=;
        b=UHjv9zslxMkH0clMbf/a3P6DUGLAvEtznQWZddKQUujn2JBsVLtumv7b6vrcZFlnnE
         iUjhkkH7UJ8ja5kZBeIkH8j7QO0rLt5k0iGINAkzmcc6pb4i/A3goMZudQItLa17Aaez
         j+GxdqCbH6bw0Y5+BPYGeyp2Qa0ID1L0oA70Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=u1riiLPinGlFi9PcD/S8X68+UVvqr4l9murjaPS4asqVWkPMLMTgF9qTiPmY/lfg0k
         rOuycLE4JBTujaZn5Ok3+AusEi/PE7533jX0ZNjvG5HJLxHbgsCrs5P4Y2hnhwvxhJIR
         gYl0loKsLySmPlrkTs7dp+GWHvUxvxsm3FrHs=
Received: by 10.115.20.18 with SMTP id x18mr12083592wai.50.1272634358024;
        Fri, 30 Apr 2010 06:32:38 -0700 (PDT)
Received: from progeny.tock (1555hostw130.starwoodbroadband.com [207.14.48.130])
        by mx.google.com with ESMTPS id 21sm1881192pzk.0.2010.04.30.06.32.35
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Apr 2010 06:32:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100429202139.GW10879@inner.home.ulmdo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146038>

Andreas Krey wrote:
> On Thu, 29 Apr 2010 14:49:36 +0000, Jonathan Nieder wrote:

>> Thanks for the report.  What encoding were you using?  (You can chec=
k
>> with =E2=80=98git cat-file commit <revision you were trying to cherr=
y-pick>=E2=80=99.)
>
> Actually, it was both UTF-8, both by the defaults in get_message():
[...]
> There being two different incarnations of iconv on this machine
> isn't making anything easier. :-( Will report when I find out
> what's wrong here. utf8 should be pretty universally known by now.

Yes, the problem is that the to and from encodings match.  I hadn=E2=80=
=99t
realized so before, but iconv doesn=E2=80=99t like that on some platfor=
ms
(e.g., Solaris).

Since this is the usual case, we should probably check for it like
git mailinfo does instead of waiting for iconv to fail.

Jonathan
