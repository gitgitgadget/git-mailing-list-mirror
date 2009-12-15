From: Russ Dill <russ.dill@gmail.com>
Subject: Re: Generic filters for git archive?
Date: Tue, 15 Dec 2009 00:08:42 -0700
Message-ID: <f9d2a5e10912142308o50c8b9edy63bb485658c93a03@mail.gmail.com>
References: <f9d2a5e10912071706m10ed7112ob7db47cdfac510d6@mail.gmail.com>
	 <4B202945.50200@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Dec 15 08:08:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKRWg-0003N6-Qp
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 08:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396AbZLOHIp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2009 02:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752936AbZLOHIo
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 02:08:44 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:59736 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbZLOHIn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Dec 2009 02:08:43 -0500
Received: by vws30 with SMTP id 30so893390vws.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 23:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k2yryBMZ+dbJN8F8AgvScS1sKLa3/7xv/QBKn/Oqgwo=;
        b=UA3YtX5jPg05Q7kUQgX6J1hEeqnIIV1RLB1pSTeF4pl/tL7j8o7YukW17NVqqLLiru
         ShOQtD/yH7tBAxZ9ZqiY3CVJg4I8AX18uIbXBH4EcjeBQLj/j/REmahhy3XP6iuI1R2w
         SRUqHTOWhxRXIjtn0QUvsdw31iHHTqYRsBQgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XbxM60cD6h92UFDNvtTSIkzdJ6SI4WxKZmJv4rQnWQXldgn6ec2giJPhmYIoMR+kWj
         Yd+HdiP50MEV9zf+Dy0jwht0I1cJ3zkAkJsU8HSy+oa6L0LYqnKVxv9Hi42I6elSrHf4
         w5Hho+sJrSTaKSyHCNkRrbSzIIXZn5txOOFxQ=
Received: by 10.220.65.200 with SMTP id k8mr1096116vci.116.1260860922720; Mon, 
	14 Dec 2009 23:08:42 -0800 (PST)
In-Reply-To: <4B202945.50200@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135274>

On Wed, Dec 9, 2009 at 3:48 PM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 08.12.2009 02:06, schrieb Russ Dill:
>> I'm trying to add copyright headers to my source files as they are
>> exported via git archive. eg:
>>
>> * $Copyright$
>>
>> to
>>
>> =C2=A0* Copyright (c) 2003-2009 by Foo Bar
>> =C2=A0*
>> =C2=A0* This program is free software; you can redistribute it and/o=
r modify it
>> =C2=A0* under the terms of the GNU General Public License as publish=
ed by the
>> =C2=A0* Free Software Foundation; either version 2 of the License, o=
r (at your
>> =C2=A0* option) any later version.
>> =C2=A0*
>> =C2=A0* This program is distributed in the hope that it will be usef=
ul, but
>> =C2=A0* WITHOUT ANY WARRANTY; without even the implied warranty of M=
ERCHANTABILITY
>> =C2=A0* or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See the GNU Gener=
al Public License
>> =C2=A0* for more details.
>> =C2=A0*
>> =C2=A0* You should have received a copy of the GNU General Public Li=
cense
>> =C2=A0* along with this program; if not, write to the Free Software =
=46oundation,
>> =C2=A0* Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>>
>> And properly handling things like '# $Copyright$', '// $Copyright$',
>> etc. I have a sed script that does this, but no way to apply it to t=
he
>> output of git archive. I tried setting up a smudge filter that would
>> only smudge output on archive exports, but it doesn't appear that th=
e
>> smudge filters get run on git archive.
>>
>> I am currently running 1.6.3.3
>
> Is the filter attribute contained in a .gitattribute file that's part=
 of
> the tree you are trying to export? =C2=A0If it's only in the worktree=
 copy,
> then you need to use the option --worktree-attributes to make git
> archive use it.

hmm..It does seem to be running. But I'd really like to use the
gitattributes from the tagged version I'm exporting and I don't want
the smudge filter to run on files I'm working on in my source tree,
just on the export.
