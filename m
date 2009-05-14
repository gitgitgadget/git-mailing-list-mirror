From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Thu, 14 May 2009 14:16:31 +0200
Message-ID: <81b0412b0905140516k4bc84606scb71981936966caf@mail.gmail.com>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
	 <op.utwdsutn1e62zd@merlin.emma.line.org>
	 <7v8wl01iev.fsf@alter.siamese.dyndns.org>
	 <op.utwyczlf1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 14 14:16:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Zre-0003Aj-ER
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 14:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbZENMQe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 08:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752893AbZENMQd
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 08:16:33 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:47623 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbZENMQd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 08:16:33 -0400
Received: by bwz22 with SMTP id 22so1246159bwz.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 05:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uENaOzkhOKtCvgEHvr4aD1UNq9rQGTPJFkRLd0sYAq0=;
        b=EIEs8qWh+6rSbbhtltm9msg53OvndlRcbFSXO4mZDwirPQwDo25+bR9JRS0SotCAy8
         0G18/vdnxl3Y49TCjmsSdMRLC74VCrF+ARkB8ArULBnm8gDmh9nEWcJlJkj/+fUPtPjE
         5+wdsbq6ab9Ecnu4QRyHcF0jsXHRiUjOWk/fc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=at78m3q0q28vgygL8/MrYfeflXpvFpKiBoIxedGpAhuVIuj9iUhquLsEXaA6sqA3qx
         xpuCUPOnyAmlSijjCnxIxT5te6GpSWBX5dj2VIM4uzTPBspgF1sVG61iytFCJYYAY6So
         zkk+OBNrlJex4z4c83Aq2mMu8CWTkmQ/Pp9Tk=
Received: by 10.204.113.12 with SMTP id y12mr2021036bkp.214.1242303391602; 
	Thu, 14 May 2009 05:16:31 -0700 (PDT)
In-Reply-To: <op.utwyczlf1e62zd@merlin.emma.line.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119184>

2009/5/14 Matthias Andree <matthias.andree@gmx.de>:
> Am 14.05.2009, 05:18 Uhr, schrieb Junio C Hamano <gitster@pobox.com>:
>> No. =C2=A0You can tag any object, and a tag is an object. =C2=A0You =
can point a
>> signed tag with your own signed tag to attest your own belief on tha=
t
>> other guy's tag, be it "it's genuine", "the tagged commit suits my n=
eed",
>> etc.
>
> OK, so I can tag/sign any object, fine.
>
> HOWEVER, I see two problems here (yes, they are corner cases):
>
> #1: git tag -f ("replace tag") fails to "replace" a heaviweight tag i=
f I try
> to replace a tag by itself (or create a cycle by some other means).

It is not a "cycle" ("loop"?) The tags information is the SHA1, not
the tag's name.

> The new "foo" is unique in refs (OK), but it's *not unique* in object=
s
> (FAIL), as the old "foo" is referenced by the new "foo" and bears the=
 same
> tag name.

Of course it is unique. Look at tag's SHA1.

> #2: related: git tag -d cannot reliably delete tag objects
>
> Same here: if another tag object references the tag object I'm deleti=
ng, we
> only delete the ref, but not the tag object. It doesn't (cannot) beco=
me
> dangling.

As soon as an object is not referenced anymore by any reference (includ=
ing
references from refs/tags/), reference log or index it will be removed =
by
garbage collection (gc, prune) at the next opportunity.
