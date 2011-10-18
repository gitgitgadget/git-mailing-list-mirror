From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] completion: match ctags symbol names in grep patterns
Date: Tue, 18 Oct 2011 02:26:55 -0500
Message-ID: <20111018072655.GA22309@elie.hsd1.il.comcast.net>
References: <20111018044955.GA8976@sigill.intra.peff.net>
 <20111018050105.GC9008@sigill.intra.peff.net>
 <7vd3duixdg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 09:27:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG450-0007df-Kv
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 09:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264Ab1JRH1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 03:27:14 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51026 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757056Ab1JRH1N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 03:27:13 -0400
Received: by iaek3 with SMTP id k3so392950iae.19
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 00:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VLvOuo1OMk2K+5O4zLbWqqfz5QQN8U1BI7MCqqJlmQ8=;
        b=Xv/AnEtSSEEQFnwmGe+mIxUvgBN+H4DmqUdGn3nISmiiy9Ra9KFQioM6ppq/J5/pBJ
         52/87s0PntDcERAl5d3NPkoPC6ukhlMACKztOU5fPRL2CaRt6qpoMcoa4NXpiGlbIdMY
         10JuwJd8Qqp24LEsKNQ0w20+DfDry2nLfndXM=
Received: by 10.42.19.67 with SMTP id a3mr2327486icb.21.1318922833224;
        Tue, 18 Oct 2011 00:27:13 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z10sm3298055ibv.9.2011.10.18.00.27.12
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Oct 2011 00:27:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vd3duixdg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183867>

Junio C Hamano wrote:

> Perhaps something like this is in order?
[...]
> +++ b/Makefile
> @@ -2127,17 +2127,25 @@ po/git.pot: $(LOCALIZED_C)
>  
>  pot: po/git.pot
>  
> +git_check = $(shell git ls-files >/dev/null 2>&1; echo $$?)
> +ifeq ($(git_check),0)
> +FIND_SOURCE_FILES = git ls-files '*.[hcS]'
> +else
> +FIND_SOURCE_FILES = $(FIND) . \( -name .git -type d -prune \) \
> +		-o \( -name '*.[hcS]' -type f -print \)
> +endif

Neat.  I'd prefer something like

	FIND_SOURCE_FILES = \
		git ls-files '*.[hcS]' 2>/dev/null || \
		$(FIND) . -name .git -prune -o -name '*.[hcS]' -type f -print

that avoid punishing people who were using the makefile for some
purpose unrelated to tags and cscope, though. ;)
