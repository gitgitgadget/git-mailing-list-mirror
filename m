From: Shawn Pearce <spearce@spearce.org>
Subject: Re: large files and low memory
Date: Mon, 4 Oct 2010 12:11:22 -0700
Message-ID: <AANLkTin-mbzt93DWtp71vYBEUcDLHgo=G-6zynT5NC_r@mail.gmail.com>
References: <20101004092046.GA4382@nibiru.local> <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
 <20101004185854.GA6466@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: weigelt@metux.de, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 21:11:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2qRy-0003pt-Iw
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 21:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367Ab0JDTLo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 15:11:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49022 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab0JDTLo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 15:11:44 -0400
Received: by iwn5 with SMTP id 5so7263050iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 12:11:43 -0700 (PDT)
Received: by 10.231.19.3 with SMTP id y3mr10649766iba.156.1286219503528; Mon,
 04 Oct 2010 12:11:43 -0700 (PDT)
Received: by 10.231.168.70 with HTTP; Mon, 4 Oct 2010 12:11:22 -0700 (PDT)
In-Reply-To: <20101004185854.GA6466@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158098>

On Mon, Oct 4, 2010 at 11:58 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Shawn Pearce wrote:
>
>> The mmap() isn't the problem. =A0Its the allocation of a buffer that=
 is
>> larger than the file in order to hold the result of deflating the fi=
le
>> before it gets written to disk.
>
> Wasn't this already fixed, at least in some cases?
>
> commit 9892bebafe0865d8f4f3f18d60a1cfa2d1447cd7 (tags/v1.7.0.2~11^2~1=
)
> Author: Nicolas Pitre <nico@fluxnic.net>
> Date: =A0 Sat Feb 20 23:27:31 2010 -0500
>
> =A0 =A0sha1_file: don't malloc the whole compressed result when writi=
ng out objects

This change only removes the deflate copy.  But due to the SHA-1
consistency issue I alluded to earlier, I think we're still making a
full copy of the file in memory before we SHA-1 it or deflate it.  So
Nico halved the memory usage, but we're still using 1x the size of the
file rather than ~2x.


--=20
Shawn.
