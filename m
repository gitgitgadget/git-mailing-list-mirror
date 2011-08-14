From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/7] revert: Allow mixed pick and revert instructions
Date: Sun, 14 Aug 2011 09:28:46 -0500
Message-ID: <20110814142846.GI18466@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-5-git-send-email-artagnon@gmail.com>
 <20110814121244.GD18466@elie.gateway.2wire.net>
 <CALkWK0=sggexB0HDN-6LsoLz2RO-ftABTnAYp7q-jVO0oCJu2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 16:34:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qsbly-00029b-Lk
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 16:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab1HNO2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 10:28:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56243 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab1HNO2u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 10:28:50 -0400
Received: by gwaa12 with SMTP id a12so2815636gwa.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UYJ3TTlBVsoiOPjKU5KHwScjU781K+Pyjww6NRDAhWs=;
        b=s9T3Gwq2kcPI40s/0TpbE7UAhONggJXZKiU2XJUFbn5n7QtRYIZOCOhoJBnIzYh6js
         ckRXyWZv7texeB9U89Oqr2586vpLCtQJxhlE3FCbZ+ELXQnrF6297ldoP5IdlsyTNhwE
         KOrLmbLXTcPREaqMvemY5/QCbkuSpdZMGuiyI=
Received: by 10.236.22.129 with SMTP id t1mr9539521yht.184.1313332129915;
        Sun, 14 Aug 2011 07:28:49 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-108-227.dsl.chcgil.sbcglobal.net [68.255.108.227])
        by mx.google.com with ESMTPS id a29sm537117yhj.17.2011.08.14.07.28.48
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 07:28:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=sggexB0HDN-6LsoLz2RO-ftABTnAYp7q-jVO0oCJu2A@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179328>

Ramkumar Ramachandra wrote:

> int len = strchrnul(p, '\n') - p;
> if (len > 255 || len - strchrnul(p, '\n') + p != 0)
>     len = 255;

Yuck.  Why not just use a size_t?

> Shouldn't it be part of error() atleast in the long term?

The default implementation of error() is (practically speaking) a thin
wrapper around fprintf.  What are the new semantics you are proposing
--- truncating %s arguments to one short line?  I don't think that
would be a good idea, since for example, some current callers might be
passing "\n" explicitly as a %s argument.
