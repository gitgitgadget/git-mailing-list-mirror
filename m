From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] [RFC] Generational repacking
Date: Wed, 6 Jun 2007 17:04:46 -0700
Message-ID: <56b7f5510706061704r34692c49v994ff368bbc12d05@mail.gmail.com>
References: <11811281053874-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	danahow@gmail.com
To: "Sam Vilain" <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Jun 07 02:04:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw5Ul-0006aI-ND
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 02:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbXFGAEs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 20:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755463AbXFGAEs
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 20:04:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:2082 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbXFGAEr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 20:04:47 -0400
Received: by ug-out-1314.google.com with SMTP id j3so569193ugf
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 17:04:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HKYEO7fnk7qf7S7QwGEvYRtlSVsM5HsUb0DgN+BQWekquLnrf8utHje6dehcrZa8+nRI4t7Ua5bjnsc20XRg9WMzVfpWm9co19A7uZqMuotMmlufAd6Wh65GePnm1B+mBOrLqF2ffFMiUkcrq/QsbQNTFrE8xn3iY8Jmlsj6HEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ePGtPeqBgOFmx/apKs2z6z2JwMCKqc2V5JnP5wg15ly4SMa2OBUwiHx+LpJIIBlqLvfAgaWdvfUMMmLTEHx8VJdbT+G2bUIqIQGz7BFZ+FInkLwvXduDgGOqU7hQ8APHzun4JMYzYVhrJUxOtaPWQArNxiQqqxV1HjZMODuqcXo=
Received: by 10.78.132.2 with SMTP id f2mr523661hud.1181174686179;
        Wed, 06 Jun 2007 17:04:46 -0700 (PDT)
Received: by 10.78.90.18 with HTTP; Wed, 6 Jun 2007 17:04:46 -0700 (PDT)
In-Reply-To: <11811281053874-git-send-email-sam.vilain@catalyst.net.nz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49336>

On 6/6/07, Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
> This is a quick hack at generational repacking.  The idea is that you
> successively do larger repack runs as the number of packs accumulates.
>
> The commandline interface for this should be considered development
> grade only, and of course there are no tests and very verbose output
> :)
>
> The useful invocation of this is git-repack -d -g
>
> The -a option then becomes a degenerate case of generative repacking.
>
> The intention is that this should end up light enough to be triggered
> automatically whenever the (approximate) count of loose objects hits a
> threshold, like 100 or 1000 - making git repositories "maintenance
> free".

This patch complicates git-repack.sh quite a bit and
I'm unclear on what _problem_ you're addressing.
The recent LRU preferred pack patch
reduces much of the value in keeping a repository tidy
("tidy" == "few pack files").

Already git-gc calls git-repack -a -d.  How do you plan to change this?
I wonder if you should be making git-gc more intelligent instead.

Also,  you introduce a new pack properties file (.gen) which seems
awkward to me.

Perhaps something like this would be useful on a huge repository
under active use.  But delta re-use makes full repacking quite quick for
a reasonably-sized repository already,  and I don't see this being very useful
for a repository which is large due to large objects.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
