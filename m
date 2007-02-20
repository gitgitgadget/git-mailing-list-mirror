From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH/RFC 2/3] git-fetch: Split fetch and merge logic
Date: Tue, 20 Feb 2007 12:21:56 +0100
Message-ID: <8aa486160702200321l35e309eeqe5799dc56be5dac6@mail.gmail.com>
References: <874ppmplw7.fsf@gmail.com> <87vei2o75x.fsf@gmail.com>
	 <7v649x7u90.fsf@assigned-by-dhcp.cox.net>
	 <8aa486160702191413p10c8ca0ek949580ffe953ea79@mail.gmail.com>
	 <7vfy91684y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 12:22:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJT4P-0000V7-UJ
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 12:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbXBTLV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Feb 2007 06:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964774AbXBTLV7
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 06:21:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:55046 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964795AbXBTLV5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Feb 2007 06:21:57 -0500
Received: by ug-out-1314.google.com with SMTP id 44so761171uga
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 03:21:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rjyIOqcvQIo/HWkd9tM6Y6tgMMzEWEuOHGDmml1THWK72JcryuSGFwifOp+dTb5ieonUnG5ZVhqovLzwHe11z6QbF7agTKClfNkESvr+oMDiViXRQ0/m3DEQ/wv8s7zsspZKn1vKoXhjGQEOJycVh/uBNytcXLQfsXDOXiCdYyc=
Received: by 10.78.193.19 with SMTP id q19mr1213164huf.1171970516325;
        Tue, 20 Feb 2007 03:21:56 -0800 (PST)
Received: by 10.78.69.4 with HTTP; Tue, 20 Feb 2007 03:21:56 -0800 (PST)
In-Reply-To: <7vfy91684y.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40231>

On 2/20/07, Junio C Hamano <junkio@cox.net> wrote:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
> >> > There are two cases where the behaviour is changed:
> >> >
> >> > 1) branch.*.merge no longer must exactly match the remote part
> >> >    of the branch fetched. Both are expanded in full (as refs/hea=
ds/...)
> >> >    and matched afterwards.
> > ...
> >>  I see this as a regression.
> >> If you are setting configuration, wouldn't you rather see the
> >> behaviour consistent even when remote adds new refs?
>
> Maybe I misread your description, but I took it to mean that you
> are allowing:
>
>         branch.master.merge =3D a
>
> to mean what we traditionally spelled
>
>         branch.master.merge =3D refs/heads/a
>
> and guessed (I haven't looked for where it happens in the code)
> the way you do that conversion is by tail-matching the ref; if
> the other end creates "refs/heads/b/a", suddenly remote branch
> b/a starts matching that pattern wouldn't it?

No. branch.master.merge =3D a is equivalent to refs/heads/a and only
matches with the remote branch refs/heads/a. It continues to exactly
match the two branches, but with the full patch (refs/...). So now it
is possible to have:

[remote "origin"]
url =3D ...
fetch =3D refs/heads/*:refs/heads/origin/*

[branch "master"]
remote =3D origin
merge =3D master

or the other way:

[remote "origin"]
url =3D ...
fetch =3D master:refs/heads/origin

[branch "master"]
remote =3D origin
merge =3D refs/heads/master

>
> Earlier we fixed the ambiguous use of branch.*.merge in
> 756373da; I think the same reasoning should apply here.
>
> Configuration is something you set once because you want to
> forget about it afterwards (iow, not having to type every time),
> and I think making sure it names things unambiguously outweighs
> one-time convenience of being able to write the configuration in
> a looser fashion.

It is unambiguous.

But if it is problematic I'll try to keep the current behaviour.

Santi
