From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 3/5] Create a git.Branch class as ancestor of stack.Stack
Date: Thu, 5 Jun 2008 13:03:55 +0100
Message-ID: <b0943d9e0806050503x40191104ye332d6a8435811a5@mail.gmail.com>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
	 <20080604211334.32531.74258.stgit@localhost.localdomain>
	 <20080605070126.GC23209@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 14:06:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4ED7-0006ne-6I
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 14:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143AbYFEMD7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2008 08:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756134AbYFEMD7
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 08:03:59 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:30495 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919AbYFEMD6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jun 2008 08:03:58 -0400
Received: by wa-out-1112.google.com with SMTP id j37so386758waf.23
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 05:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Nb3lU5eIpaxtdFbfo6xXZ7WtC0pBPpXuChH4zi09uAQ=;
        b=cGrTIfHGuIjVBoLoAg/nTdjjElCC9LoW0Z7PN5vJopt4PwQ9C6BT/1Fd9O68PYtJVY
         W1Hg9/gRE97zJCM9zWolqqWMuLtbZyoxmqiO4nTrYJeiMOoDbI5LWrwsUTBp54tQrfok
         2IwfQwSPToK1jGdk1TLUBE/RX0cN4Ee1Kky9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fylwjlYb9RITkju2reJ5r1rrjz3yaQIWANKYAInA6rCoJNXUNKoOr+o25XXJ4aRTGU
         lUmGJNz9w0GX8eZ+1dWOuX262PzWkXW1xiBGQjXuUIDLfwYc4o8O2zTjIzF3S6qTh05e
         uJDKg/5QGisBWva1Nb8uqCZV0U7lAPFfN6R5k=
Received: by 10.114.184.7 with SMTP id h7mr1302096waf.183.1212667436027;
        Thu, 05 Jun 2008 05:03:56 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Thu, 5 Jun 2008 05:03:55 -0700 (PDT)
In-Reply-To: <20080605070126.GC23209@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83911>

2008/6/5 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-06-04 22:13:35 +0100, Catalin Marinas wrote:
>> +    def __init__(self, repository, name):
>> +        self._repository =3D repository
>> +        self._name =3D name
>
> Using double leading underscores will give you a class-local name. Wh=
y
> just one?

Just a convention: double underscore - private, simple underscore -
protected (using C++ or Java naming). The _repository or _name are
meant to be made available to a derived class (stack.Stack in our
case), though we have the corresponding public properties already.

>> +    @classmethod
>> +    def create(cls, repository, name, create_at =3D None):
>
> Minor nit: in case of things that are clearly "owned" by other things
> (git objects are owned by a git repository, for example), I've tried
> to put the creation function in the owner, not the owned. I'm not
> insisting, though.

As I see these things, the git.Repository and the derived
stack.Repository are indeed object factories but they are mainly
responsible for creating/returning a new Python object and passing
some arguments to the class' __init__. The Repository object doesn't
need to know more than the name as the rest is handled by __init__.

The same goes for the "create" function, the repository shouldn't need
to know the directory or files structure that a Stack or Branch are
using. I think we get a clearer separation this way.

--=20
Catalin
