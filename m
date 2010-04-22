From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: bug in name-rev on linux-2.6 repo?
Date: Thu, 22 Apr 2010 09:51:11 -0500
Message-ID: <20100422145111.GA4801@progeny.tock>
References: <20100421195822.GX10984@baikonur.stro.at>
 <r2sbe6fef0d1004220354g6443218ezbd0452428ad9e4b5@mail.gmail.com>
 <20100422121408.GI3211@stro.at>
 <20100422124042.GA1433@progeny.tock>
 <m2hbn37e7q.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: maximilian attems <max@stro.at>, Tay Ray Chuan <rctay89@gmail.com>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Apr 22 16:51:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4xkL-0003Cs-Bs
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 16:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab0DVOvB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 10:51:01 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:45884 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470Ab0DVOvA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 10:51:00 -0400
Received: by pzk32 with SMTP id 32so5462127pzk.21
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 07:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fGExk0mPn6Z0gEYp1ePMKWU7lDDyFoXzHi2mfpJLVh4=;
        b=E8t0YNOp7bARtJCu6JGHdgUazcoaSjzfbRVKEPKiV9Oeb9T2/hn1gHcMHs3Q8uLIy/
         7Fv2ahOKdbf+HOaTQj5PBVWsIhAKF4nOmOqkwZ8KauHe+WEfqB3bmQFYhFgHbinOLi2u
         rgdduon2Ro9cA9knsqSev8KzNNTIQVcvJMiFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uMrP1BsK6rN9VvlL4IUav4KPZlFcD+984oYxSMZbz6hAO7f7xBWQs/WoJHQ/pYBwcg
         rTfxyC4Lhq03WP23ontkhZt1FOPFOAUTNEFuHqqhxt1bTPt4m5VkYk59BQyO4Satp7St
         st7EnNiAMyo3mDNVm+HhzOCy7vhw+T2qiJog4=
Received: by 10.114.18.11 with SMTP id 11mr2042136war.137.1271947859793;
        Thu, 22 Apr 2010 07:50:59 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm28522iwn.1.2010.04.22.07.50.57
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 07:50:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m2hbn37e7q.fsf@igel.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145537>

Andreas Schwab wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> The commit doesn=E2=80=99t seem to be part of any tagged release, no=
r linus=E2=80=99s
>> master:
>
> $ git branch --contains a1de02dccf906faba2ee2d99cac56799bda3b96a
> * master
> $ git merge-base v2.6.34-rc1 a1de02dccf906faba2ee2d99cac56799bda3b96a
> a1de02dccf906faba2ee2d99cac56799bda3b96a
> git merge-base v2.6.33 a1de02dccf906faba2ee2d99cac56799bda3b96a
> 724e6d3fe8003c3f60bf404bf22e4e331327c596
>=20
> So it has been merged beween v2.6.33 and v2.6.34-rc1

To first commit after rc8, to be exact.  But for some reason, the
revision walker doesn=E2=80=99t notice that:

 $ git rev-list origin/master..a1de02dcc | wc -l
 1

The tip of the relevant branch before merging was 64e290e (thanks to
Johan=E2=80=99s --ancestor-path suggestion and Junio=E2=80=99s nice imp=
lementation).
So we can walk up through the revisions:

 $ git rev-parse 64e290e~35
 a1de02dccf906faba2ee2d99cac56799bda3b96a
 $ git rev-list origin/master..64e290e~35 | wc -l
 0
 $ git rev-list origin/master..$(git rev-parse 64e290e~35) | wc -l
 1
 $ for i in 36 35 34 33 32 31 30
 > do
 >	printf "%d " "$i"
 >	git rev-list origin/master..$(git rev-parse 64e290e~$i) | wc -l
 > done
 36 0
 35 1
 34 2
 33 3
 32 4
 31 0
 30 0

Using v2.6.34-rc1~199 (the ext4 merge commit) instead of origin/master
reveals the same problem.  v2.6.34-rc1~199^2 (the tip of the ext4
branch) does not.

Hope that helps.
Jonathan
