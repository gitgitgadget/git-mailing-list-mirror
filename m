From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-log - hide parent (was: merging two equivalent branches)
Date: Fri, 8 Jan 2010 14:50:03 -0500
Message-ID: <32541b131001081150k3de53301tf6d206718d538a6@mail.gmail.com>
References: <B0543B3C-C139-4BD3-B028-58B4DA132422@gmail.com> 
	<46d6db661001071022t79ca65foac249d948a20c328@mail.gmail.com> 
	<DF05F91F-CBFD-458A-A99F-79E98ACA5146@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian MICHON <christian.michon@gmail.com>
To: David Reitter <david.reitter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 20:50:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTKqs-0000yW-TZ
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 20:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001Ab0AHTuZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 14:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893Ab0AHTuY
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 14:50:24 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:61092 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508Ab0AHTuY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 14:50:24 -0500
Received: by gxk3 with SMTP id 3so8852281gxk.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 11:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0Pv+NLV5gHKmTdRj9GVcME/WbXQQAbmDdX5FNaGLanE=;
        b=IIxMM7X01bcVXuP5rL+EAq9EwqOyOJ4g6BxsWnZYmuKLGcynfiKdYFWIbf+1NyB9PW
         q7GqfBvbydY7K2GIwhYbepUHbzcuqJ7t0KL8A0je7oGo4AdC8grgytoJTNaysG6swf9Z
         UQh/RnhBx5Lufdxmzfob2vqM80o4lXqMFgctM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WcBpL5arK7mHu4yyx7vAFKNEMrB5HAZRInz5LBJh5YnF6kJEkRzoqC+E58BrZbCusD
         3H4DVsVAcnXQYRgMO5jNyxdH3Mc8PGXppdk6Vd6kQHzQ9VXdbYGMigkxKSc4baqromga
         dSBW6zYKB7e01uzdkSWdHbmTq73LmdB1dRX/U=
Received: by 10.150.174.8 with SMTP id w8mr1334945ybe.204.1262980223075; Fri, 
	08 Jan 2010 11:50:23 -0800 (PST)
In-Reply-To: <DF05F91F-CBFD-458A-A99F-79E98ACA5146@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 7, 2010 at 4:16 PM, David Reitter <david.reitter@gmail.com>=
 wrote:
> I'm still unsure how, after the filter-branch, I would have some ance=
stor from the
> B series so that future pulls from the remote work, while having an a=
ncestor from
> A, to make sure I can continue merging into C. =A0If history is rewri=
tten, I'll get new
> revisions and lose ancestors.
> I'm beginning to thing that the cutting and pasting I'd like is conce=
ptually impossible.

Hmm, this is pretty nasty.  Essentially, you want your repo to include
both sets of commits (so that it doesn't try to re-merge in the other
commits later), but you don't want to *see* them in git log.
Basically, you want git log to lie to you :)

Luckily, it already has this ability: it's called history simplificatio=
n :)

Try this in your merged repo:

   git log .

(note the '.').

Without the dot, git log doesn't simplify any history, and you get
every change.  With the dot, it shows only commits that had a tangible
effect on the file in question (in this case, the top directory, which
includes *everything*).  Thus, a "git merge -s ours" gets eliminated.

Beware that it might eliminate other equally non-impactful commits, how=
ever.

The same trick also works with gitk.

Have fun,

Avery
