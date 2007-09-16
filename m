From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [StGit PATCH] It doesn't make sense to sink below an unapplied patch
Date: Sun, 16 Sep 2007 17:41:27 -0400
Message-ID: <9e4733910709161441j43e69ee2j6c57489c4b0eafbb@mail.gmail.com>
References: <20070914002031.GC23330@diana.vm.bytemark.co.uk>
	 <20070914005231.17533.17120.stgit@yoghurt>
	 <9e4733910709131822s3c519a3bj7e42c0ecaa89fb6e@mail.gmail.com>
	 <20070914060456.GA27014@diana.vm.bytemark.co.uk>
	 <9e4733910709140715g3cc3e47fu2eb24eed6d4e2c08@mail.gmail.com>
	 <20070914150609.GA319@diana.vm.bytemark.co.uk>
	 <9e4733910709140918wbe94b5eu6ec326b25b0f3d42@mail.gmail.com>
	 <20070915232252.GA25507@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 23:41:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX1rz-0006Im-53
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 23:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbXIPVl3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2007 17:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbXIPVl3
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 17:41:29 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:43833 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbXIPVl2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Sep 2007 17:41:28 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1786788wah
        for <git@vger.kernel.org>; Sun, 16 Sep 2007 14:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dzBsBlitBHcxYVd1uBqM7j2MCvA30ZvV0i8PIO/Vlzk=;
        b=Gl9qTlzAZuMIN3pX5VKKcahC8UlomoeqdDy7EGBEnvjcoxtKlnnv90Bvfi1CaXEh0jmo3ppvqSEo8iyZq+goH/pds4SWLEKbK5n11mj4dIPzLpDHzc7jmkcIDMLtZS4OWI802xb4AGJODR9yDKeCQo+qrQpoaqCxh2dR7Rbf+wE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lYVJeXNI5+DjMQL2hxwK1IPLNQSR5hZ4sA5upMQ/veXSGeDwYoWBblggNiujdcAClMd0E/dttKjV/4A46jwTIeVOdAtVu3GPOYBGXu+aisak8xF3RIfh5AEMeFR81GvKfY3wQvT7fvNZ9qR8aEtRqOShwoLOLkueLtUefEsRjRU=
Received: by 10.114.209.1 with SMTP id h1mr1643175wag.1189978887270;
        Sun, 16 Sep 2007 14:41:27 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sun, 16 Sep 2007 14:41:27 -0700 (PDT)
In-Reply-To: <20070915232252.GA25507@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58352>

On 9/15/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-09-14 12:18:17 -0400, Jon Smirl wrote:
> > Another way to handle this would be to eliminate the ability of
> > pop/push to reorder and extend sink/float to handle unapplied
> > patches.
>
> I think that I'd like the latter without the former -- that is,
> teaching sink/float how to handle unapplied patches, and leaving
> push/pop as is. That'll let you do what you tried to do in the first
> place, and will leave us with a more redundant command set, but I
> don't think that's bad.

The stack model may be too simplistic. My current patches involve four
groups, there is ordering in the group but the groups can be applied
independently. Patches could be marked as depending on another
patch/group. You could then mark patches applied/unapplied and stg
would sort out the order. Allowing group names would make this easier.

The mm kernel has 1,500 patches. It must be a pain trying to keep
these in a linear order.

The git diff output format could be extended with
Depends-on/Group-name lines. That would let Andrew import the
dependencies.


> Another idea that's been kicked around is to have a general reorder
> command, that spawns an editor and lets you move around (and delete)
> patch names until you're satisfied. (This too would be implemented in
> terms of push and pop of single patches.)
>
> --
> Karl Hasselstr=F6m, kha@treskal.com
>       www.treskal.com/kalle
>


--=20
Jon Smirl
jonsmirl@gmail.com
