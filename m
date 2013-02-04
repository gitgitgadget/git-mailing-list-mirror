From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Mon, 4 Feb 2013 10:34:37 -0800
Message-ID: <20130204183437.GA15552@google.com>
References: <12070540.431901359961105650.JavaMail.weblogic@epml10>
 <7vehgw5z7n.fsf@alter.siamese.dyndns.org>
 <20130204083701.GA30835@sigill.intra.peff.net>
 <7vsj5c4exz.fsf@alter.siamese.dyndns.org>
 <20130204093821.GA32095@sigill.intra.peff.net>
 <7vboc03u3e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, jongman.heo@samsung.com,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 19:35:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Qso-0003Hc-EH
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 19:35:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab3BDSes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 13:34:48 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:56039 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab3BDSer (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 13:34:47 -0500
Received: by mail-pa0-f51.google.com with SMTP id hz1so2537962pad.38
        for <git@vger.kernel.org>; Mon, 04 Feb 2013 10:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ca/ZnTVyxRq8oxLtuALm+CTiw4++kSZDpgYCX3T3SQM=;
        b=PA6QK5j3pQqXEqFnTmgEsJjRHg34aw8WZuuioWwjQELSui2AtcKkxpaMsxNwEtMgVv
         TOT65/xSHsqPD81MHOx3UOM9XS35hEnFgb6eclqpfIpimTc7hsHnPrlmgikQq9+02hpz
         z1lVj0zYoWQLThWWq1C8WXiu99JhAYR1exErvueDyevjSXheI6AXVzoUGNxFTtf6uwLW
         8z+yZnYnmXyN1D/97jxf85iX8/xIFrY4YZiNKaAGnuV65BtnAQgvKSPB51tG3N+Y2rmz
         E829slD92V2p4kchCWnRzvUfmwh2dRn+zJD4u45DmHCXRhLTWmStbSESOP0tW4OFAF0e
         v/Nw==
X-Received: by 10.66.85.73 with SMTP id f9mr55368193paz.13.1360002886945;
        Mon, 04 Feb 2013 10:34:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id b3sm20608177pax.14.2013.02.04.10.34.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 04 Feb 2013 10:34:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vboc03u3e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215407>

Junio C Hamano wrote:

> The only case that worries me is when make or cc gets interrupted.
> As long as make removes the ultimate target *.o in such a case, it
> is fine to leave a half-written .depend/foo.o.d (or getting it
> removed) behind.

gcc removes the target .o in its signal handler in such a case.  In
cases where it doesn't get a chance to (e.g., sudden power failure),
there is a partially written .o file already in place, the linker
produces errors, and the operator is convinced to run "make clean",
all without .depend's help.
