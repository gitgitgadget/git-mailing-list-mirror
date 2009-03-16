From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 1/5] Check for local changes with "goto"
Date: Mon, 16 Mar 2009 14:56:11 +0000
Message-ID: <b0943d9e0903160756g79ac3464i4bb6f7f61ba0555a@mail.gmail.com>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com>
	 <20090312120856.2992.48548.stgit@pc1117.cambridge.arm.com>
	 <20090313015755.GA15393@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 15:57:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjEG8-00084C-B1
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 15:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbZCPO4Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 10:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbZCPO4P
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 10:56:15 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:40337 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbZCPO4O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 10:56:14 -0400
Received: by fxm24 with SMTP id 24so3520071fxm.37
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IzvwgGh5t8O3BhKmFc+VWIG32SMXugv5x19IIxD9UsQ=;
        b=CGQHb50i7+9f5F7/fg2UNCiPRKCKhfHzJmW7E5qfWBwmsiDNPrDUupGxd4hbEzzbOC
         1PSfbMFGecHRKTbh63lRywVlG9iS1Kx8GWzR6Hf3SHKmPCIBNsIuce7o50WX86j/spYl
         7aboXnhhPLv07txOOIFDuTjbE02vI8EhGybk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gXZBXF88y7iP/ssxl8DK8XyVK6db6TFJf6UjAWsV6K+o6dkafVIGRf7ntwjva73oJ3
         UtAkFrcD1OXTZuSzdvhY8u2eOHfuFN14cF6Aw7x/wRniF6WJfoHcUqj49czo5NIvcaVv
         zsf2hb73Kn44fVvI9ikQ8rf+QRGVGGEx83Ips=
Received: by 10.204.101.71 with SMTP id b7mr1655961bko.107.1237215371486; Mon, 
	16 Mar 2009 07:56:11 -0700 (PDT)
In-Reply-To: <20090313015755.GA15393@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113331>

2009/3/13 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-03-12 12:08:56 +0000, Catalin Marinas wrote:
>> + =A0 =A0def __assert_index_worktree_clean(self, iw):
>> + =A0 =A0 =A0 =A0if not iw.worktree_clean() or \
>> + =A0 =A0 =A0 =A0 =A0 not iw.index.is_clean(self.stack.head):
>> + =A0 =A0 =A0 =A0 =A0 =A0self.__halt('Repository not clean. Use "ref=
resh" or '
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0'"status --reset"')
>
> "Repository" is misleading here. Maybe something like
>
> =A0 ix_c =3D iw.index.is_clean(self.stack.head)
> =A0 wt_c =3D iw.worktree_clean()
> =A0 if not ix_c or not wt_c:
> =A0 =A0 =A0 self.__halt('%s not clean. Use "refresh" or "status --res=
et"'
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 % { (False, True): 'Index', (True=
, False): 'Worktree',
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (False, False): 'Index an=
d worktree' }[(ix_c, wt_c)])

I added two separate if's as I don't find the above readable :-)

if not iw.worktree_clean():
    self.__halt('Worktree not clean. Use "refresh" or "status --reset"'=
)
if not iw.index.is_clean(self.stack.head):
    self.__halt('Index not clean. Use "refresh" or "status --reset"')
def __checkout(self, tree, iw, allow_bad_head):

--=20
Catalin
