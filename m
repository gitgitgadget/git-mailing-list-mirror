From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Thu, 14 Feb 2008 22:59:59 +0100
Message-ID: <200802142300.01615.jnareb@gmail.com>
References: <200802081828.43849.kendy@suse.cz> <m3y79nb8xk.fsf@localhost.localdomain> <alpine.LSU.1.00.0802142054080.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brian Downing <bdowning@lavos.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 14 23:00:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPm8Q-0004ie-5U
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 23:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932679AbYBNWAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 17:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933318AbYBNWAM
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 17:00:12 -0500
Received: from mu-out-0910.google.com ([209.85.134.188]:22248 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932679AbYBNWAK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 17:00:10 -0500
Received: by mu-out-0910.google.com with SMTP id i10so331855mue.5
        for <git@vger.kernel.org>; Thu, 14 Feb 2008 14:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=vuU14n3MPsnjCoFARgnKqXZYLZzKbTaRxlXlQY4Xnvc=;
        b=ivGZCWOGGZFbkieLiVTP1vWdUwO8WAo+GQpw40gybxAOw2Agkm7+106S5U9jP9EsmC29CzMtEVT/WBUcp5g+EaoltEDHxFCesJJxu53JUYx1Wt3BUNqqWjnpptMDVrncDIQ3jx7EMEZkuYWkn0joDOGm5K1lSLhMvG3tC0S8DFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oLAIcDpKmBgfjBSX04GnUj0v6nRTYOKr0/ZH+BiDP84xoxIYenwvnw71A7bHxze1R33/uJvOfnlglytFPOiBLzylYEVmNsVAB76iD290761I+LbRDyX66B0uYE7wmk+yH7ucr84aZk8RfAbD6MivoDfyD/JSXJ6XLb5IrtuA9X0=
Received: by 10.82.186.5 with SMTP id j5mr1794349buf.12.1203026408080;
        Thu, 14 Feb 2008 14:00:08 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.219.2])
        by mx.google.com with ESMTPS id h1sm6670743nfh.20.2008.02.14.14.00.05
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Feb 2008 14:00:06 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802142054080.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73917>

Johannes Schindelin wrote:
> On Thu, 14 Feb 2008, Jakub Narebski wrote:

>> Perhaps you could try running contrib/stats/packinfo.pl on this pack to 
>> examine it to get to know what takes most space.
> 
> $ ~/git/contrib/stats/packinfo.pl < \
> objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack 2>&1 | \
> tee packinfo.txt
> Illegal division by zero at /home/imaging/git/contrib/stats/packinfo.pl 
> line 141, <STDIN> line 6330855.

Errr... sorry, I should have been more explicit. What I meant here
is the result of

$ git verify-pack -v <packfile> | \
  ~/git/contrib/stats/packinfo.pl


>> What is the size of checkout, by the way?
> 
> I work on a bare repository, but:
> 
> $ git archive origin/master | wc -c
> 2010060800
> 
> Or more precisely:
> 
> $ echo $(($(git ls-tree -l -r origin/master | sed -n 's/^[^ ]* [^ ]* [^ ]*  
> *\([0-9]*\).*$/\1/p' | tr '\012' +)0))
> 1947839459
> 
> So yes, we still have the crown of the _whole_ repository being _smaller_ 
> than a single checkout.
> 
> Yeah!


Brandon Casey wrote:
> Jakub Narebski wrote:
>> 
>> What is the size of checkout, by the way?
> 
> 2.4G

That's huuuuge tree. Compared to that 1.6G (or 1.4G) packfile doesn't
look large.

I wonder if proper subdivision into submodules (which should encourage
better code by the way, see TAOUP), and perhaps partial checkouts
wouldn't be better solution than lazy clone. But it is nice to have
long discussed about feature, even if at RFC stage, but with some code.

-- 
Jakub Narebski
Poland
