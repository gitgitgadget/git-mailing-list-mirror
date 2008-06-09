From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] cat-file --batch / --batch-check: do not exit if hashes
 are missing
Date: Mon, 09 Jun 2008 12:17:30 +0200
Message-ID: <484D033A.3020006@gmail.com>
References: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com> <alpine.DEB.1.00.0806090033030.1783@racer> <484C73DA.10804@gmail.com> <alpine.DEB.1.00.0806090201090.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 12:18:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5eSM-0004Cj-ON
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 12:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759150AbYFIKRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 06:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758857AbYFIKRg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 06:17:36 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:58608 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbYFIKRf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 06:17:35 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1497143mue.1
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=u4Ufa50l+1CJmyc2xSHhmn5DXME037cYdfsf3rdmXVk=;
        b=xWiH+5O0irUDCDHfFRh6R4Al2jt538bk61y27eAf3i7zqY5xio1LaDI9NLZ2tbo7Lb
         JAOmHkR+4RgYvdz6R5dGpXwPYUxDj7ag8g79KyGNeLbhkcq9dK3cQyRBWkVgIZLC5DVe
         C4A2w//flFxxDMagRd2VcsoiVY9QnPiy9yH1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=AltltVGb+rOVkcZjSCEcty8blQIskuU2DB6IqZqBGfXRDLiDBZLIex8OsE/K+i1h0S
         zJadysp/uZkEET6mv1fuidRo+8N3LhYRBus872EXl59svRoQJkNlBr+3s/yhqSKvz0oC
         6b4vqveHOubwqzxo40flBzAjQRA4Ra/6zV/bI=
Received: by 10.103.242.7 with SMTP id u7mr2206636mur.100.1213006654300;
        Mon, 09 Jun 2008 03:17:34 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.232.240])
        by mx.google.com with ESMTPS id j10sm16161004muh.18.2008.06.09.03.17.32
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 03:17:33 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <alpine.DEB.1.00.0806090201090.1783@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84375>

Johannes Schindelin wrote:
> That is unexpected.  IMO this is a bug.  rev-parse I can understand, but 
> cat-file not failing when it clearly did not find the object?

 From a recent IRC conversation (with permission):

Dscho thinks that git-cat-file --batch should print an error and exit if 
passed an invalid revision (as opposed to the current behavior of 
printing "<object> missing" and continuing), since anything else would 
be unexpected. [1]  He says that an --ignore-missing option should be 
introduced instead, and cat-file --batch should exit on non-existent 
objects unless the --ignore-missing option is given.

I maintain that my patch isn't introducing a new feature but fixing a 
bug -- cat-file --batch already doesn't exit but (as documented) prints 
"<object> missing" if passed a non-existent object.  The only exception 
is a full (= 40-character) SHA1 that isn't augmented (e.g. by "^" etc.). 
  This exception is neither useful, expected, nor documented.  Hence, my 
patch fixes this inconsistency.

If Dscho (or anybody else) wants to introduce an --ignore-missing 
option, feel free to submit it separately, but please don't object to my 
patch because of it -- my patch is merely fixing the existing code. 
(Note that such an option is unlikely to make it into the code though, 
since it would have to change the existing behavior of cat-file --batch, 
which other programs rely on.)

-- Lea

[1] He says he hasn't read the manual so far though because he doesn't 
have time for it -- if he had read it (as I repeatedly recommended) he 
probably wouldn't find the behavior surprising.
