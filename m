From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH] Add a --tree flag to stg push
Date: Tue, 19 May 2009 09:50:26 +0200
Message-ID: <87d4a5fs59.fsf@krank.kagedal.org>
References: <20090518144754.30487.84132.stgit@krank>
	<20090519072512.GA8451@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin marinas <catalin.marinas@gmail.com>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue May 19 09:50:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6K5w-0004cb-BG
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 09:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbZESHuc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 03:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbZESHub
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 03:50:31 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:53535 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780AbZESHua (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 03:50:30 -0400
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id E930340087;
	Tue, 19 May 2009 09:50:04 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id DCD4D40092; Tue, 19 May 2009 09:50:04 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [95.209.167.132])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 04E6040087;
	Tue, 19 May 2009 09:50:04 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 00B52DC26A; Tue, 19 May 2009 09:50:26 +0200 (CEST)
In-Reply-To: <20090519072512.GA8451@diana.vm.bytemark.co.uk> ("Karl
 =?utf-8?Q?Hasselstr=C3=B6m=22's?= message of "Tue\, 19 May 2009 09\:25\:12
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119502>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2009-05-18 16:50:18 +0200, David K=C3=A5gedal wrote:
>
>> This scratches a long-time itch for me. The typical use case is when
>> you want to break up a larg patch inte smaller ones. You back out
>> the orignal patch, apply a small set of changes from it and then
>> push the patch back again. But then you don't want to do a merge,
>> with the possibility of conflict. You simply want to restore to the
>> tree that the patch had before so you can see what's left to create
>> cleaned-up patches of. The command "stg push --tree" does just that.
>
> Thanks!
>
> There's no sign-off.

I counted on getting comments, so it's not finished yet...

>> The naming of flags and functions isn't very obvious, and
>> suggestions for improvements are welcome.
>
> --set-tree maybe?

Probably better. But perhaps there is a way to not have to talk about
"trees" at all?

>>  t/t1207-push-tree.sh     |   64 +++++++++++++++++++++++++++++++++++=
+++++++++++
>
> A test! Very good.
>
>> +    opt('--tree', action =3D 'store_true',
>> +        short =3D 'Push the patch with the original tree')
>
> This probably deserves a long description as well. (That most existin=
g
> options lack them is unfortunate---the support for long descriptions
> was added rather recently.)

I didn't look putside push.py, and just followed the pattern
there. But a long description sounds like a good idea. It won't be
obvious what this does with just a short one.

>> +        if any(getattr(cd, a) !=3D getattr(orig_cd, a) for a in
>> +               ['parent', 'tree', 'author', 'message']):
>> +            comm =3D self.__stack.repository.commit(cd)
>> +            self.head =3D comm
>> +        else:
>> +            comm =3D None
>> +            s =3D ' (unmodified)'
>
> Shouldn't self.head be set in both cases?

I guess so. I'm a bit unsure about the correctness of that whole
function.

>> +# Copyright (c) 2006 David K=C3=A5gedal
>
> Been sitting on this patch long? :-)

Copy/paste error.

>> +# don't need this repo, but better not drop it, see t1100
>> +#rm -rf .git
>> +
>> +# Need a repo to clone
>> +test_create_repo foo
>
> Umm, your test doesn't seem to depend on using this separate repo
> instead of the default one.

Call it copy/paste programming or cargo cult programming. I will clean
up.

--=20
David K=C3=A5gedal
