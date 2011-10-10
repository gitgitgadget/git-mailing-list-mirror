From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/3] traverse_trees(): allow pruning with pathspec
Date: Mon, 10 Oct 2011 06:42:01 +0200
Message-ID: <4E927799.6000604@alum.mit.edu>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org> <1314653603-7533-1-git-send-email-gitster@pobox.com> <1314653603-7533-2-git-send-email-gitster@pobox.com> <4E91C031.9030205@alum.mit.edu> <CACsJy8D9sJOtXj_jkVSyoAJ9TC4wmKNAD5YwsFXTYkpvM4e13w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 06:43:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD7hf-0005g7-Qm
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 06:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964Ab1JJEmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Oct 2011 00:42:09 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58199 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab1JJEmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 00:42:08 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9A4g1fA032196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Oct 2011 06:42:01 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <CACsJy8D9sJOtXj_jkVSyoAJ9TC4wmKNAD5YwsFXTYkpvM4e13w@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183220>

On 10/09/2011 11:35 PM, Nguyen Thai Ngoc Duy wrote:
> On Mon, Oct 10, 2011 at 2:39 AM, Michael Haggerty <mhagger@alum.mit.e=
du> wrote:
>> On 08/29/2011 11:33 PM, Junio C Hamano wrote:
>>> diff --git a/tree-walk.c b/tree-walk.c
>>> index 33f749e..808bb55 100644
>>> --- a/tree-walk.c
>>> +++ b/tree-walk.c
>>> [...]
>>> @@ -376,16 +396,22 @@ int traverse_trees(int n, struct tree_desc *t=
, struct traverse_info *info)
>>>                       mask |=3D 1ul << i;
>>>                       if (S_ISDIR(entry[i].mode))
>>>                               dirmask |=3D 1ul << i;
>>> +                     e =3D &entry[i];
>>>               }
>>>               if (!mask)
>>>                       break;
>>> -             ret =3D info->fn(n, mask, dirmask, entry, info);
>>> -             if (ret < 0) {
>>> -                     error =3D ret;
>>> -                     if (!info->show_all_errors)
>>> -                             break;
>>> +             interesting =3D prune_traversal(e, info, &base, inter=
esting);
>>
>> According to gcc 4.2.4 (though, strangely, not gcc 4.4.3):

I checked this a bit more carefully.  gcc 4.2.4 emits a warning when th=
e
-O1 or -O2 optimization levels are used, but not with -O0.  gcc 4.4.3
does not emit a warning regardless of optimization level.

>> tree-walk.c: In function =E2=80=98traverse_trees=E2=80=99:
>> tree-walk.c:347: warning: =E2=80=98e=E2=80=99 may be used uninitiali=
zed in this function
>=20
> False alarm. If e is not initialized in the for loop, mask would be
> zero and therefore prune_traversal(e, info, &base, interesting), whic=
h
> would use uninitialized "e", would never be called.

That's good to know.  Still, it might be worthwhile to initialize the
variable explicitly to avoid future confusion.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
