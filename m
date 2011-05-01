From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add --info-path and --man-path options to git.
Date: Sun, 1 May 2011 18:48:33 -0500
Message-ID: <20110501234833.GC11550@elie>
References: <1304237785-56101-1-git-send-email-jon.seymour@gmail.com>
 <7vbozmthhy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 01:49:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGgNm-0006OY-Gi
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 01:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747Ab1EAXsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2011 19:48:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35995 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab1EAXsj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2011 19:48:39 -0400
Received: by iyb14 with SMTP id 14so4282536iyb.19
        for <git@vger.kernel.org>; Sun, 01 May 2011 16:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=qPAke2Ybm8w/LXBwB7j7aEjKt06o5YHxfPHUAdDCZWE=;
        b=GTumwEtPChFqDK9/juEp09s8UpbWWvMncPuBFNxKK9Ftact9ZmOwZQ8dVkptDfhmd9
         EM0bEIAyqPM3EgIJ2E876L/LwDQ1L84Syo8Ye5T5fOlSRZxUn1oPHLR4EJ+C5eU9O8Hq
         E3FXSRO833YWen7E1wiwuXTuBM8c7fwLqJkrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MBzkWtcnRg1xi3aLIL0V2JRJRtyZQ9YeNQQn0ViSus8jKpx8NOKl4ULt8hqiJXLsU1
         TXm905up63W1rPMRDkWlCaH253aoD+5PrOwT9X1qTTmarw1FzckQAo44gHkaTxFLarYV
         zh4gc1EvpSvIQW6iwzFy8Wb6OAWFThidxdG1g=
Received: by 10.42.40.129 with SMTP id l1mr7642770ice.225.1304293718433;
        Sun, 01 May 2011 16:48:38 -0700 (PDT)
Received: from elie (adsl-69-209-62-211.dsl.chcgil.ameritech.net [69.209.62.211])
        by mx.google.com with ESMTPS id g16sm2124889ibb.3.2011.05.01.16.48.36
        (version=SSLv3 cipher=OTHER);
        Sun, 01 May 2011 16:48:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbozmthhy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172551>

Junio C Hamano wrote:

> This an improvement that is pretty much independent from the issue of
> third party extensions. In fact, even people who would oppose to the idea
> of any third party crap [*1*] contaminating the install directories owned
> by git may want to this patch.
>
> It is useful to have these options even for read-only users. Cf. 89a56bf
> (add --html-path to get the location of installed HTML docs, 2009-04-05).

I don't mind this patch at all, but I do not have a full picture yet
of how it helps.

In the case of HTML, the standard way to show git documentation in your
custom documentation viewer is to pull up file://$(git --html-path)/index.html,
using the full path to the HTML files.  So if "git gui" were to gain a
documentation viewer widget instead of relying on git web--browse, it
would need the HTML path.

By contrast, man and info typically use standard search mechanisms:
man using $MANPATH and info using the dir.info file.  The usual
interface to git's documentation through a man browser is not

	man /usr/share/man/man1/git-add.1.gz

but

	man git-add;	# or "man git add" if your man viewer supports it

And the usual interface through an info browser is

	info git

.

So it is not clear to me how this would help when you want to view
documentation.  Similarly, if you want to sneak documentation into an
existing git installation (ignoring the question of whether that's a
good idea), using HTML you would have to modify git's index.html and
add your HTML files alongside it, while using "man" or "info" you
would have to modify the index page (git.1 or gitman.info) but could
put your custom pages wherever you want in the viewer's search path.

So while I can't see the harm in exposing --info-path and --man-path,
the current patch seems to do an incomplete job of documenting them.
Perhaps this is about finding the documentation corresponding to a
particular copy of git when a machine has multiple copies?
