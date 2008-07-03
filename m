From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Thu, 3 Jul 2008 23:05:45 +0100
Message-ID: <b0943d9e0807031505n5b119a6fxf0b050d72b59352a@mail.gmail.com>
References: <20080612052913.23549.69687.stgit@yoghurt>
	 <20080612053424.23549.64457.stgit@yoghurt>
	 <b0943d9e0806170324j12605a55m41b582ad09925cce@mail.gmail.com>
	 <20080617123138.GA6932@diana.vm.bytemark.co.uk>
	 <b0943d9e0806170711w6da8e841p3ac83a59a81f6577@mail.gmail.com>
	 <20080617153247.GA12520@diana.vm.bytemark.co.uk>
	 <20080701201355.GA19096@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 00:06:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEWwx-0001gE-Su
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 00:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbYGCWFt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2008 18:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754392AbYGCWFt
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 18:05:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:26791 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbYGCWFs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2008 18:05:48 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1199362rvb.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 15:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qruHfer2sighZy598lU1AO40rde9uX7bUbqyNPs6Rgg=;
        b=Al5L6Q3o0EkS8/IN7KEmNmIHnn7THaqawcstH36lcCZdd9VWUNCd0bcuuFv/CnGaBp
         Q9zFdEJZly0OP1hD9d7dK/ZYnSvwlevF26UpO3dcqG3tA2JBqlGL/k2byk5j80vmv0Qf
         2i17xaKkw2mkLM42Z10WyyEXoFMyNW6GYrVLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vzgQfxlOXmPSx4k/kPEFy50mZUbAYdaOSSI1SH/XSd7QOTQ5KpfhTZw6/ek9ebbg4J
         kqv/Jt/w5YpoTJhTZMuvd/1gcZ7fiNDzy3TD2VA6zL4oJUuMlSQZYTkExc/lZVa0tGKL
         XVUh1kHUcKaG2PSWLZqYj9tahMwT7MaFE4pfU=
Received: by 10.114.52.1 with SMTP id z1mr1789579waz.42.1215122745248;
        Thu, 03 Jul 2008 15:05:45 -0700 (PDT)
Received: by 10.114.124.9 with HTTP; Thu, 3 Jul 2008 15:05:45 -0700 (PDT)
In-Reply-To: <20080701201355.GA19096@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87328>

2008/7/1 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-17 17:32:47 +0200, Karl Hasselstr=F6m wrote:
>
>> On 2008-06-17 15:11:42 +0100, Catalin Marinas wrote:
>>
>> > 2008/6/17 Karl Hasselstr=F6m <kha@treskal.com>:
>> >
>> > > On 2008-06-17 11:24:53 +0100, Catalin Marinas wrote:
>> > >
>> > > > 2008/6/12 Karl Hasselstr=F6m <kha@treskal.com>:
>> > > >
>> > > > >  class _Directory(object):
>> > > > > -    def __init__(self, needs_current_series =3D True):
>> > > > > +    def __init__(self, needs_current_series =3D True, log =3D=
 True):
>> > > >
>> > > > i.e. we make log =3D False here by default.
>> > >
>> > > I might not have understood precisely what you meant; but I
>> > > don't think API backwards compatibilty should be an issue here?
>> > > I simply fix all callers. If log should default to true or false
>> > > is immaterial -- it just means some extra text in one or the
>> > > other of two equally common cases.
>> >
>> > Not an issue, I just favour the existing one when the two cases
>> > are almost equal.
>>
>> Fair enough. I'll change it.
>
> I had an even better idea: no default value. Every caller gets to say
> either log =3D True or log =3D False, which makes it immediately obvi=
ous
> to the reader. (That is, every caller still using the old
> infrastructure; with the new infrastructure, we log if and only if a
> transaction is run.)

=46air enough.

--=20
Catalin
