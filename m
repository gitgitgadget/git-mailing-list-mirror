From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] index-pack: always zero-initialize object_entry list
Date: Wed, 20 Mar 2013 15:12:07 -0400
Message-ID: <CAPig+cQobu8GoqSNjVw8498e8D3vEJKU+UVUqkYbwypLyPTNhQ@mail.gmail.com>
References: <20130319102422.GB6341@sigill.intra.peff.net>
	<20130319105852.GA15182@sigill.intra.peff.net>
	<8738vr5rqh.fsf@pctrast.inf.ethz.ch>
	<20130319154353.GA10010@sigill.intra.peff.net>
	<20130319155244.GA16532@sigill.intra.peff.net>
	<20130319161722.GA17445@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Zager <szager@google.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 20:12:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIORC-0004F4-VV
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 20:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757795Ab3CTTML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 15:12:11 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:49281 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079Ab3CTTMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 15:12:09 -0400
Received: by mail-la0-f46.google.com with SMTP id fq12so3576643lab.5
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=B1X+xzkCRMHnYStqrmSCSEf8/CzwmANYpUiGjHZnkCk=;
        b=antFkd72+fHGnVK7sQQ/XAMWs0h9kr0iEj/t5ugPVCjA4M/nzDsCM+600aE8sAs8kl
         es6lHfBpOA/6QTqsumz8nzeYeqdCmblvt1Sq/qgnk7ahSBHnsa5lgLya2jwvOa1kfqbU
         LnPhYFGQMrHTs0uPmJ6h+da35mdlz6nHWElIxUJzifVE8uL3KsvKmx+bmleoz4i0KynG
         qz2/qAgi6Em8AQkOZExDlSTPMyhL0EzA+ly7vwCaTRZ2i//1dyhutOL3+mPHS6CeS0Ui
         J8N8zqTuPsL8RsX73C0xK22ocps+Km0+3EySWVEyOHEQyLRWAPLRqF2+bD6pp0fv6KfP
         6J+g==
X-Received: by 10.112.88.35 with SMTP id bd3mr10264507lbb.56.1363806727617;
 Wed, 20 Mar 2013 12:12:07 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Wed, 20 Mar 2013 12:12:07 -0700 (PDT)
In-Reply-To: <20130319161722.GA17445@sigill.intra.peff.net>
X-Google-Sender-Auth: ilw-qzSJfdlHj3HhUlFOcqMkccc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218660>

On Tue, Mar 19, 2013 at 12:17 PM, Jeff King <peff@peff.net> wrote:
> To ensure that all depths start at 0, that commit changed
> calls to xmalloc the object_entry list into calls to
> xcalloc.  However, it forgot that we grow the list with
> xrealloc later. These extra entries are used when we add an
> object from elsewhere pack to complete a thin pack. If we

s/elsewhere pack/pack/

> add a non-delta object, its depth value will just be
> uninitialized heap data.
