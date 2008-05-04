From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [PATCH 4/5] Head reduction before selecting merge strategy
Date: Sat, 3 May 2008 21:52:32 -0700
Message-ID: <402c10cd0805032152g1cb3f10cr69f1735785c5d647@mail.gmail.com>
References: <402c10cd0804232252g43606767r10344ebbb2a44af9@mail.gmail.com>
	 <m3prsep6oy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 06:53:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsWEF-0003ZR-4u
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 06:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbYEDEwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 00:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbYEDEwf
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 00:52:35 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:59411 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbYEDEwe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 00:52:34 -0400
Received: by fk-out-0910.google.com with SMTP id 18so185033fkq.5
        for <git@vger.kernel.org>; Sat, 03 May 2008 21:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=DdeYaLyxBNGHs39gDIXi2QRlwn+XuhbvrNtktLCJiVg=;
        b=UZQ0XMeeCb2hBr8QKdNGbZEieTY67V9/c1hjSIfT5AzYOrRHyGOhDTdpdjxzI6qyh1A9rlg0DoxayMXu0jcepGKcrirxwdQoaLLzPM/BMwM41MpxgL/DezEi2h3Qm4sgrMeqym5e8M04Vuo21tEGmAsVHoNPvGQkHEaEXjelFRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cIju4oW/GgLLPjtdK+55/HXo5TTHt6fSwBdMjZ/4rN2O5ebGYYwbzyRyVHxMVcVoFleeOyDtCTUfLdIJDX4xtIWO0DvvidZf9g67vt01SlDv03tbaE9HmzwonXDPlzhF2tS7VpHMkzKdDsrpIT0V/lSC/Petk1qo2qu8Gcrn5P4=
Received: by 10.82.181.8 with SMTP id d8mr136292buf.54.1209876752776;
        Sat, 03 May 2008 21:52:32 -0700 (PDT)
Received: by 10.82.172.1 with HTTP; Sat, 3 May 2008 21:52:32 -0700 (PDT)
In-Reply-To: <m3prsep6oy.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81134>

On Fri, Apr 25, 2008 at 3:31 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> "Sverre Hvammen Johansen" <hvammen@gmail.com> writes:
>
>  > See the documentation for an explanation of this feature.
>
>  I think I get the idea now.
>
>  You want to generalize fast-forward merge, or what's equivalent make
>  fast-formard merge to be special case of head reduction.  This should
>  be written both in commit message and in documentation.  Do I
>  understand your goal correctly?
>
>  With head reduction comes three things:
>   * the merge strategy used
>   * recorded parents
>   * generated merge commit message

The recorded parents and the generated merge commit message is the
same with or without this patch.  The only difference is the merge
strategy used.

>  The simplest way would be to use reduced head for all three things,
>  I think.

Actually, we can't do that.  A real merge always need to involve HEAD.
 In the case that HEAD is not included in the reduced parents we could
do a FF+merge, but that is a rather radical change that deserve its
own patch.

Changing the generated merge commit message is also a radical change.

I don't intend to write any patches for this for now.  Maybe later if
the series gets accepted.

>  But I also think that this commit in series is the most controversial
>  one; is it realy needed for other commits?  I would put it then as the
>  last commit in series...

I agree with you, but I don't intend to spend time on this now to
rewrite it again.  I am quite happy with how the series turned out.

>  > +The following shows master and three topic branches.  topicB is based
>  > +on topicA, topicA is previously branched off from master, and topicC
>  > +is based on the tip of the master branch:
>  > +
>  > +------------
>  > +                    o---o---o  topicB
>  > +                   /
>  > +          o---o---o  topicA
>  > +         /
>  > +    o---o---o---o---o---o  master
>  > +                         \
>  > +                          o---o  topicC
>  > +------------
>
>  I think I would start with simpler example without 'topicC', of
>  reduction of octopus to two-parent ordinary merge.

I am not sure that we need to have this in the documentation at all.
I have asked for comments on this before but not received any
feedback.  This late, the documentation will have to be fixed in-tree,
if needed.

>  > diff --git a/git-merge.sh b/git-merge.sh
>  > index 7c34b6c..7c70c56 100755
>  > --- a/git-merge.sh
>  > +++ b/git-merge.sh
>  > @@ -337,11 +337,16 @@ set x $remoteheads ; shift
>  >
>  >  find_reduced_parents "$@"
>  >
>  > -actual_parents=$(git rev-parse "$@")
>
>  This was introduced by some of your earlier commits, isn't it?

Yes,  [PATCH 3/5] Restructure git-merge.sh

-- 
Sverre Hvammen Johansen
