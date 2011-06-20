From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 08/20] remote-curl: accept empty line as terminator
Date: Mon, 20 Jun 2011 02:55:41 -0500
Message-ID: <20110620075541.GA28282@elie>
References: <1308496725-22329-9-git-send-email-srabbelier@gmail.com>
 <1308537351-23209-1-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 09:55:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYZKv-00082y-3j
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 09:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980Ab1FTHzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 03:55:52 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39825 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab1FTHzv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 03:55:51 -0400
Received: by iyb12 with SMTP id 12so1755732iyb.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 00:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7i46lGIH9c6N+EU6+S3vtB4zVhVR4UBfPuMaAdrsdtg=;
        b=h8uMRchCt0qL1MzJFDui4xSfEqe41DJi5xgN0RZp4wG9Tz5nmK9WxQLemrVOx4dzN0
         W0c8H2ZqH4xVbpDk21yi+yug1WXTU6OcflMSc1ZfBKW7heLlJ6zSaFK1Mgw0Uq/Y1MxE
         DcBowEEYuMWfOB+fd1GBuZC75+nRM347TU9Hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xNsVchxzKb9pIGt1DV0JnKHSo/aTKbGhnzq1WBNNMBSbe6dgDbID6dHZrudy4jfxyq
         J+rYTrst3BUrLkwplmci15hKsbPiMFidzNiIGaKJg6oBWel+YoGltUMAChVIlcd2jGGQ
         6rGEq7mWEv1FlIfL3JSwedHZ5r2jtNw5RIVyE=
Received: by 10.43.49.137 with SMTP id va9mr5378367icb.218.1308556550131;
        Mon, 20 Jun 2011 00:55:50 -0700 (PDT)
Received: from elie (adsl-69-209-50-158.dsl.chcgil.sbcglobal.net [69.209.50.158])
        by mx.google.com with ESMTPS id 10sm3039087ibn.37.2011.06.20.00.55.46
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Jun 2011 00:55:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308537351-23209-1-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176057>

Hi,

Dmitry Ivankov wrote:

> As a next step, won't it be better to use "exit\n" or "quit\n"
> as a terminator?

If we were starting over, a "done" command (or "quit" or some other
self-descriptive name) would be a no-brainer.  Unfortunately, there
are existing remote helpers out there --- based on a web search:

 - mediawiki
 - ccnx
 - couch
 - cvs
 - bzr
 - hg

Presumably most already ignore a final blank line and do not check for
"quit".

One possibility would be to emit "done" instead of a blank line if the
remote helper has declared a "done" capability.  But what does it buy?

Side note: a "done" capability doesn't sound like a bad idea, though,
for another reason.  The transport-helper could tell fast-import to
expect a "done" command at the end when importing from a remote helper
declaring it, to catch situations in which the pipe prematurely closes
(for example, because the remote helper has segfaulted).

> I don't see a convention of terminating on a
> blank line in docs,

Yes, this would be nice to document.

> only on EOF.  Also I can imagine a blank
> line being read in a case of communication error

A spurious NL, NL, EOF sequence does not sound likely to me.  If the
command stream is passing through a noisy channel, there are worse
corruptions to worry about (e.g., fetching to the wrong ref).
