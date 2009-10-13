From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH v2 05/16] Add multi_ack_2 capability to fetch-pack/upload-pack
Date: Tue, 13 Oct 2009 14:35:07 -0700 (PDT)
Message-ID: <m3ocobf067.fsf@localhost.localdomain>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
	<1255400715-10508-6-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 23:43:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxp9I-0004He-SM
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 23:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761240AbZJMVfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 17:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761198AbZJMVfU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 17:35:20 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:50498 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754863AbZJMVfS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 17:35:18 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so10750963fxm.17
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 14:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=263pfPk+1rOXPCGShqQ3R/F3DHmZ3fNORsdwRJBhVmw=;
        b=p+M2DPGREu1KZR1yoJkniW9jhDCj0LWqLnsgjVjd8uYciWpvRDV5ujAN7XtHfU5bZH
         Ax4KpadP6IO7B4xM0IJN/Je/42CQzjAyYDxEEnppQGT1YRlExUa8aS8B0FO1DNhL4Tr+
         5RVr8lXLUrfVOXI0orhA6W0PUO3rLSlbH+fYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Qkii5eerlPLaa5qH71TmN/JC2sqzB6lzgTddUABZd+IsHSR1TxRwRA2WIeHy3Txtib
         fRwP1JaqI10I06VYxk21oFS6jXkeD+HB1NVzJKmqU2jysC6od7uKHMURX8edQR1ad84o
         ImUQNUyYPADwKmzTZWQAKrznapBi8SWRRS7hU=
Received: by 10.103.84.12 with SMTP id m12mr3258963mul.79.1255469707662;
        Tue, 13 Oct 2009 14:35:07 -0700 (PDT)
Received: from localhost.localdomain (abvb70.neoplus.adsl.tpnet.pl [83.8.199.70])
        by mx.google.com with ESMTPS id n7sm78362mue.27.2009.10.13.14.35.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Oct 2009 14:35:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9DLYeuP005867;
	Tue, 13 Oct 2009 23:34:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9DLYOHM005860;
	Tue, 13 Oct 2009 23:34:24 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1255400715-10508-6-git-send-email-spearce@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130218>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> When multi_ack_2 is enabled the ACK continue messages returned by the
> remote upload-pack are broken out to describe the different states
> within the peer.  This permits the client to better understand the
> server's in-memory state.

Errr... can't you find better name than multi_ack_2?  Perhaps
multi_ack_detailed or something...

> 
> The fetch-pack/upload-pack protocol now looks like:
[...]

> ACK %s continue
> -----------------------------------
>   * multi_ack only:
> 
>     Sent in response to "have".
> 
>     The remote side wants the client to consider this object as
>     common, and immediately stop transmitting additional "have"
>     lines for objects that are reachable from it.  The reason
>     the client should stop is not given, but is one of the two
>     cases below available under multi_ack_2.
> 
> ACK %s common
> -----------------------------------
>   * multi_ack_2 only:
> 
>     Sent in response to "have".  Both sides have this object.
>     Like with "ACK %s continue" above the client should stop
>     sending have lines reachable for objects from the argument.
> 
> ACK %s ready
> -----------------------------------
>   * multi_ack_2 only:
> 
>     Sent in response to "have".
> 
>     The client should stop transmitting objects which are reachable
>     from the argument, and send "done" soon to get the objects.
> 
>     If the remote side has the specified object, it should
>     first send an "ACK %s common" message prior to sending
>     "ACK %s ready".
> 
>     Clients may still submit additional "have" lines if there are
>     more side branches for the client to explore that might be added
>     to the common set and reduce the number of objects to transfer.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
