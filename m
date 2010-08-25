From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Tue, 24 Aug 2010 23:21:22 -0600
Message-ID: <AANLkTikv9zHGRdJRoFV6Pr0HMUbKPPz_1kUXC6DnoSXL@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<20100824223741.GB2376@burratino>
	<AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
	<AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 07:21:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo8Qc-0006Vg-Ey
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 07:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627Ab0HYFVZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 01:21:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32890 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602Ab0HYFVY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 01:21:24 -0400
Received: by fxm13 with SMTP id 13so94703fxm.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 22:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OxUU29FvBOlHNa7W0xPf0cZnZ3YZwFFQAlsWI28pUyU=;
        b=H8f0Fq2e6x9f7SW4DJ4bD+M+cptDeGTKhKYSLCYwbB3f3kWFWNnOZ3VwhfPd9I7tL+
         uzNcbEyLVlzODQcyaobwFK+3N8GT4Ig1I7XbPlUa2kX6YBuQ0qBPU7pptI/lejQxYozD
         ZvXhksQFBKCnAa3tCGrf/I4g2sUDRle0/Brsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gXYk1fCMTkXCvyQbn06KJnHYWFGixkhP3yD+rlEOutqlRztDF5H+gxGNVMaL0+nAht
         4xjjomEk05JSyVztzZoI0V14HCnLW+Th5tL9LJSbhILunXQBQfXMwcRby+3y5tuPkVzM
         8QKLqQi4u+ev8wjrI4EwHzoUVNHFpRTf0PCfg=
Received: by 10.223.104.136 with SMTP id p8mr6851509fao.105.1282713682728;
 Tue, 24 Aug 2010 22:21:22 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Tue, 24 Aug 2010 22:21:22 -0700 (PDT)
In-Reply-To: <AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154420>

Replying to myself...

On Tue, Aug 24, 2010 at 10:37 PM, Elijah Newren <newren@gmail.com> wrot=
e:
<snip>
> outside the narrow tree. =C2=A0Because of that, I think you can handl=
e
> paths outside the narrow region using trivial-merge logic: =C2=A0From
> Documentation/technical/trivial-merge.txt, I think the relevant cases
> are 2, 3, 8, 10, 13, or 14. =C2=A013 & 14 already have a specified
<snip>
> That only leaves cases 2 & 3 as being slightly tricky -- if a path on
> one side of the merge started empty and ended empty, it would seem to
> make sense that the non-empty path on the other side would be the
> resolution. =C2=A0We can't do that in the non-narrow clone case becau=
se the
> non-empty path may have been created due to a rename and we'd like to
> have changes follow the rename appropriately. =C2=A0However, in the n=
arrow
> clone case, one can't rename from a path you don't have to a path you
> do, so this possibility is eliminated.

I just realized I was assuming the path was empty in the merge base
and in upstream, but non-empty on the side of the merge corresponding
to the local sparse/narrow repository.  My wording certainly reflected
that assumption.  If so, I still think what I said was correct.  If
not, it's slightly more subtle.  If the non-empty side is upstream,
then it may be a rename case that needs special handling.  If it's a
rename from a path outside our subtree (and we can somehow detect this
case), then although we don't have the data to do any special
handling, it wouldn't be necessary since we did not modify either the
source or destination of the rename.  The tricky case is if it's a
rename from a path within our subtree to a file outside; we'd only be
able to handle such situations if there was no modification other than
the rename.  Unfortunately, we can't distinguish between (1) renames
from paths outside our subtree to outside our subtree and (2) renames
plus changes from paths inside our subtree to outside our subtree.

That puts us in a bit of a pickle for the empty->empty vs. non-empty
case.  We can only resolve it if the non-empty side is in our subtree,
or if we decide to just ignore renames in our merges.
