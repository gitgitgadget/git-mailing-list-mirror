From: Bryan Donlan <bdonlan@gmail.com>
Subject: Re: proper way to merge?
Date: Mon, 2 Mar 2009 03:33:59 -0500
Message-ID: <3e8340490903020033l78329c82la186cadaa528bc32@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E709F06FDA@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 09:35:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le3cb-0001qj-3T
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 09:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbZCBIeG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 03:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754811AbZCBIeF
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 03:34:05 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:41204 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbZCBIeC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 03:34:02 -0500
Received: by gxk22 with SMTP id 22so4403692gxk.13
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 00:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NDbKqiigpxE1KZ5Mr2Xj6K9D8yVzJxEJE3+3rNKsCvE=;
        b=dMK+awWU96xqjeoQ9qiDP6ImNHAoeJeZy4tWTwuKNPtHfxVgPpuZ+WS4pR+Zl+RSBw
         fT0Jb3Tazxcv8TDE3+gfe4nkQiVLHxkNcd5pfgXKRuNdTkvB+P17m1lPoc8blo33J6GQ
         1LnVM/RZms/KET0xLqnXaO9SlmYbyhuUQ7eAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DGpF4ZGIYNOT0p5twhoDMD6JvUHiUUMWKhiUJOWor5XqxfDR1ZcCGOF7eSzJklM/LN
         2km/Z+tgfDVOtlSErGZdFObYr/qHNWbcBNbjquJsAc5trcNj8PH/UAKUT0GG83ShMA+P
         eYUDlSOY+dpFzRJPQQRMLq+hIeu7I1aRJUtLE=
Received: by 10.220.85.200 with SMTP id p8mr1542257vcl.86.1235982839590; Mon, 
	02 Mar 2009 00:33:59 -0800 (PST)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709F06FDA@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111917>

On Fri, Feb 27, 2009 at 5:11 PM, John Dlugosz <JDlugosz@tradestation.co=
m> wrote:
> I'm merging two branches: let's say "dev" is for development of futur=
e
> releases, and "rel" is changes made to the current release for immedi=
ate
> application. =A0Now I want to bring the changes made in rel back to d=
ev.
>
> Rather than trying to merge it all at once, I'm applying the changes =
a
> few at a time and making sure it still compiles as I go. =A0Then,
> git-reset and I have dev as my HEAD and the desired merge result in t=
he
> working tree.
>
> Now, I want to introduce the proper commit node to show that this is =
the
> graft. =A0But, I don't want to be presented with all the differences =
that
> I already resolved; I know what it should look like already. =A0How d=
o I
> commit the current state of things and have it show up with both dev =
and
> rel as parents? (then make that the new dev)
>
> I'm also interesting in learning how to do it better next time. =A0Bu=
t I'm
> doing the incremental merging now and need to know how to conclude it=
=2E

So, if I understand correctly, you've manually applied (manually
applying diffs or something?) your changes from the release branch to
the dev branch, and now want to inform git of what happened?

If so, you could commit what you have now, use a graft to change its
parentage, then git-filter-branch to actually update the commit
object. Something like this, I believe:
git commit -m 'Merge .....'
echo '<full 40-character commit ID of the merge> <parent on the dev
branch> <parent on the release branch>' >> .git/info/grafts
git-filter-branch dev~..dev
## You can remove (that line from) .git/info/grafts now

In the future, you may want to perform this sort of incremental merge
by simply git merging intermediate revisions in the release branch.
