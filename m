From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Mon, 10 Jan 2011 18:48:22 +0700
Message-ID: <AANLkTinVYWit95O9Y0r5BKJiMGJRAOvgPqZ0s8Eez7KJ@mail.gmail.com>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
 <alpine.LFD.2.00.1101061552580.22191@xanadu.home> <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com>
 <alpine.LFD.2.00.1101062221480.22191@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Jan 10 12:49:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcGF9-0003wg-R2
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 12:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab1AJLsy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jan 2011 06:48:54 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60720 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504Ab1AJLsx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jan 2011 06:48:53 -0500
Received: by wwa36 with SMTP id 36so562043wwa.1
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 03:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IHzpSa/mfsU7Wn6v0ZV/DX3l60vVo+VevJ3bCjVfqAQ=;
        b=b85p9ohn+2Gp6FuklHwLX3VWQktBZdrorUjM3OWuzgomTBnBUKzl6Z58Sl78Qu/UPA
         crV4Gaz47oUSNjRqRWXcsEM2dMZXYnPfj3gUgRzesdNHdN0suK7jMbNHuMVSKzTVfbp4
         shp0FE87u8RmRoAAkAqufa+QQ86Y1wIc4QCGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ShDSbkpFJc5oZSrEn0vs78sfzaOpaH3jPKu5q76RVISH1fZvhwPg0HZ6GJHsk1teLp
         CJazlhghMD5oKg4JhSd00gouyljBJsT0Icr6Ef8pWAjkfuj2n07JMSyzepQz/D8RbiXB
         4vCwbNTp5XTcUiunPX9Djq9A+8fSS/yGC/muA=
Received: by 10.216.51.67 with SMTP id a45mr1725869wec.19.1294660132462; Mon,
 10 Jan 2011 03:48:52 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Mon, 10 Jan 2011 03:48:22 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1101062221480.22191@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164871>

On Fri, Jan 7, 2011 at 11:33 AM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> Here's what I suggest:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cd my_project
> =C2=A0 =C2=A0 =C2=A0 =C2=A0BUNDLENAME=3Dmy_project_$(date "+%s").gitb=
undle
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git bundle create $BUNDLENAME --all
> =C2=A0 =C2=A0 =C2=A0 =C2=A0maketorrent-console your_favorite_tracker =
$BUNDLENAME
>
> Then start seeding that bundle, and upload $BUNDLENAME.torrent as
> bundle.torrent inside my_project.git on your server.

I was about to ask if we could put more "trailer" sha-1 checksums to
the bundle, so we can verify which part is corrupt without
redownloading the whole thing (this is over http/ftp.. not torrent).

But I realize it's just easier to split the bundle into multiple
packs, so we can verify and redownload only corrupt packs. Logically
it is still a single pack. Splitting help put more sha-1 checksums in
without changing pack format. The packs will be merged back into one
with "index-pack --pack-stream" patch I sent elsewhere.
--=20
Duy
