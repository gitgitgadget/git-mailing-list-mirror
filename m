From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 1/5] diff_tree_sha1: skip diff_tree if old == new
Date: Thu, 31 Mar 2011 08:56:11 -0500
Message-ID: <AANLkTi=sShiwiRMF+cgiWimO80FBRKNmskwTb4JYZeSG@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
	<AANLkTinwovtXfm-OvVivwyjs2RT8+D6Mj=OXkQCNH8uy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 15:56:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5IMI-0005pc-3J
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 15:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857Ab1CaN4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 09:56:15 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60398 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757778Ab1CaN4N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 09:56:13 -0400
Received: by wwa36 with SMTP id 36so2839964wwa.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oCCA3XffMKmBFEEEHcPO2NyPgiPH/FBikLtinOLNaq0=;
        b=EgeK+oE+CWtqu816X6BTwkhXcbF4Vi0lpO8H4oaIWspGnY3tqTn4PykOxmwlR2Yzg7
         qWHwzFtJbRQBGpiXdRAmewAtFQW7LWJeg4gFJUWAYuOVFpvwdWD81cOsj9FkVPZrwccz
         gtrFLuI++XMGyDc0LQ6IX7S7/vmEORx8j7AJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d2KQovGWsKh/rGcqxZ+qUl0eBxWfXddZk7QSYyjBkSKlzn7CvrJke/RRBRwLoD2RB5
         3Zirdtfcb4I2rAPbMEOvTUYWYsWduW77lHB9q+mPWj3Kmp/rzfJvVNfoToZUl1da4txz
         dm7n2F80VjHnNQtsx8AkGta+ETMuUc8Wr42lM=
Received: by 10.227.206.84 with SMTP id ft20mr2873385wbb.161.1301579772244;
 Thu, 31 Mar 2011 06:56:12 -0700 (PDT)
Received: by 10.227.147.16 with HTTP; Thu, 31 Mar 2011 06:56:11 -0700 (PDT)
In-Reply-To: <AANLkTinwovtXfm-OvVivwyjs2RT8+D6Mj=OXkQCNH8uy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170490>

On Thu, Mar 31, 2011 at 7:58 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> On Thu, Mar 31, 2011 at 8:37 AM, Dan McGee <dpmcgee@gmail.com> wrote:
>> These next few patches are all derived from trying to make operation=
s on this
>> repository a bit faster:
>> =C2=A0 =C2=A0http://projects.archlinux.org/svntogit/packages.git/
>>
>> ...
>>
>> time git log -- zzzzz_not_exist >/dev/null
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A035.558s =C2=A0 =C2=A0 =C2=A00.976s
>
> Do you have numbers before and after applying this series? It'd be
> interesting to see how much we gain from the series.

Whipped some up for you:

Repo            Operation                           master   after    d=
elta
arch-packages   ../git/git-log                      2.26     2.27     -=
0.01
arch-packages   ../git/git-log -- zzzzz_not_exist   34.69    26.75    7=
=2E93
arch-packages   ../git/git-log -- aaaaa_first       6.02     5.76     0=
=2E26
linux-2.6       ../git/git-log                      5.51     5.50     0=
=2E02
linux-2.6       ../git/git-log -- zzzzz_not_exist   0.95     0.92     0=
=2E03
linux-2.6       ../git/git-log -- aaaaa_first       0.89     0.86     0=
=2E03

These are all the "real" value from time with the full set of patches
applied. As you can see, one either gains or isn't really affected by
these; anything under 0.05s delta is noise.

Bigger gains than this don't seem too plausible unless we move away
from linear parsing and traversal of tree objects.

-Dan
