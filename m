From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Sun, 20 May 2007 20:56:49 +0200
Message-ID: <e5bfff550705201156m244e1cf0v7e6b3ab43fa3b47b@mail.gmail.com>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
	 <7vabvzq0bb.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550705200334pef694cn1a7842c23e2672f5@mail.gmail.com>
	 <7vabvzoij8.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550705200545kcf1f7f9n4f3f6d7d25955e1@mail.gmail.com>
	 <7v1whbmjel.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:56:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpqaQ-0007Gh-JY
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbXETS4x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755065AbXETS4x
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:56:53 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:54119 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339AbXETS4w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:56:52 -0400
Received: by nz-out-0506.google.com with SMTP id z3so108437nzf
        for <git@vger.kernel.org>; Sun, 20 May 2007 11:56:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eoMPvf2f/6XYyKIL9BGqSKHn8LSywsAppjKnNdW0Iru+aWRG2xCp3MHS0bfbEAvSyC58SA9OftBc3pmgLKA9+5CccVlrvBH0dpzSmPYmBu/1Uf9WmHa295RrZbHd9sqYKLFxC5TY+f68Mv6rUjwdF6Xq3juzH3G54un64/p28IQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MZofPbIC5m9ux22HWxVmdvDtAsLNMtHmH2uOR8DpEoD1F1mYtScMqhur2vkwDah2weaKTn4AvxEXACpeaBrDrgD2RHiItWZf23f8otTHP/QRUBZOl/K3Jg6GpTl0BpoMkbxii1f2iyFrhj6qh4N4e+KL5QalvTXFTRq07g0z2Qc=
Received: by 10.114.179.1 with SMTP id b1mr2181860waf.1179687409865;
        Sun, 20 May 2007 11:56:49 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 20 May 2007 11:56:49 -0700 (PDT)
In-Reply-To: <7v1whbmjel.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47887>

On 5/20/07, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > Ok. This is take 3. It works correctly on standard patches and also on
> > u0 example that you gave above.
> >
> > This patch is on top of git 1.5.2
> >
> > Please check it.
>
> I think the checks and actions are at the right places (I
> haven't looked very closely nor tried to run it yet).
>
> > builtin-apply.c |   34 ++++++++++++++++++++++++++++++++++
> > 1 files changed, 34 insertions(+), 0 deletions(-)
> >
> > diff --git a/builtin-apply.c b/builtin-apply.c
> > index 0399743..6032f78 100644
> > --- a/builtin-apply.c
> > +++ b/builtin-apply.c
> > ...
> > @@ -1770,6 +1800,10 @@ static int apply_one_fragment(struct buffer_desc *desc,
> >               if (match_beginning && offset)
> >                       offset = -1;
> >               if (offset >= 0) {
> > +
> > +                     if (desc->size - oldsize - offset == 0) /* end of file? */
> > +                             newsize -= trailing_added_lines;
> > +
> >                       int diff = newsize - oldsize;
> >                       unsigned long size = desc->size + diff;
> >                       unsigned long alloc = desc->alloc;
>
> But we have kept our sources -Wdeclaration-after-statement
> clean so far

??????

Wie bitte?
