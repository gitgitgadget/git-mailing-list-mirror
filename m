From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Thu, 22 Nov 2012 01:38:57 +0100
Message-ID: <CAMP44s1tkAZPza7skVza-qm5aQMur7CEbXZdE=RYYN2ZV2gwGw@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
	<7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
	<20121121041735.GE4634@elie.Belkin>
	<7vfw43pmp7.fsf@alter.siamese.dyndns.org>
	<0F47AA24-F5B6-4197-8D74-6DD32E253856@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:40:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbcdP-0000CR-UR
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549Ab2KVTkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:40:10 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:43646 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab2KVTkI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2012 14:40:08 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so8325126oag.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DB0NT5PkDZZtOG+0B+hidkXpUK4SKNTq2zuqHu2OsvI=;
        b=sIJutymvseLa4xq/c7nk9NJ3S1fo3DGwOUPAqoiUUUx6Rxp/aTN8Xc69nsXugR678F
         iN55w8IbbAJGSU/4e9O+WdKv9spARSxFCNoWexoFnl4ks/LBEpuoe6wV4nA07yYly4vj
         NNy7vIxF2I4/57XFzvgXLrs0ij2eaogFYbM/c9cYYB5RCPib2x5nEYB5VklIAzQf7CQC
         QShnwNsGGLiamk0sBY4Oqw1Xu04lzUWFocP3SbIoHoUPER2V6h6BIYpQ/lHtsEldyi+0
         p0G0kezj0K7Lj+phGYPtaa65kwkS/QdeQs6P9FIAPJKFvpkhBzKl+o/Tr+WrRkzM0YZl
         RcZg==
Received: by 10.182.64.101 with SMTP id n5mr17592673obs.11.1353544737307; Wed,
 21 Nov 2012 16:38:57 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Wed, 21 Nov 2012 16:38:57 -0800 (PST)
In-Reply-To: <0F47AA24-F5B6-4197-8D74-6DD32E253856@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210199>

On Wed, Nov 21, 2012 at 11:30 PM, Max Horn <max@quendi.de> wrote:

> 2) Some are interfaces to foreign systems (bzr, hg, mediawiki, ...). They cannot use sha1s and must use marks (at least that is how I understand felipe's explanation). These tools use import combined with either export, or push. Examples:
>
> - git-remote-mediawiki: import, push, refspec
>     (its capabilities command also prints "list", but that seems to be a bug?)

I don't think remote mediawiki uses marks. They are strictly not
needed by 'import' because the remote helper has full control over
this operation. For example, in my remote helpers, I store the
previous tip of the branches, so when git ask for 'import
refs/heads/master', I only import the new commits. I named this file
'marks' anyway, but they are not marks for fast-import.

> - git-remote-hg: import, export, refspec, import-marks, export-marks
>     (both the msysgit one and felipe's
> - git-remote-bzr: import, push
>     (the one from https://github.com/lelutin/git-remote-bzr)
> - git-remote-bzr (felipe's): import, export, refspec, *import-marks, *export-marks
>     (but why the * ?)

AFAIK both of my remote helpers have * in them, they are to denote
they are required.

> Does that sound about right? If so, can somebody give me a hint when a type 2 helper would use "export" and when "push"?

I don't know when would be appropriate to use push, there's another
git-remote-bzr that uses the bzr-git infrastructure, and uses push.

I picked export/import because I think they are the easiest to
implement to get all the features, and should be efficient.

> And while I am at it: git-remote-helpers.txt does not mention the "export", "import-marks" and "export-marks" capabilities. Could somebody who knows what they do look into fixing that? Overall, that doc helped me a bit, but it is more a reference to somebody who already understands in detail how remote helpers work, and who just wants to look up some specific detail :-(. Some hints on when to implement which capabilities might be useful (similar to the "Tips and Tricks" section in git-fast-import.txt).

I've had problems finding out the right information, but I hope the
git-remote-testgit I wrote in bash in less than 90 lines of code
should give a pretty good idea of how the whole thing works.

> As it is, felipe's recent explanation on why he thinks marks are essential for remote-helpers (I assume he was only referring to type 2 helpers, though) was one of the most enlightening texts I read on the whole subject so far (then again, I am fairly new to this list, so I may have missed lots of past goodness). Anyway, it would be nice if this could be augmented by "somebody from the other camp" ;).

Wouldn't that be nice?

Cheers.

-- 
Felipe Contreras
