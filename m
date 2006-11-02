X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: weird strncmp usage?
Date: Thu, 02 Nov 2006 01:44:36 +0000
Message-ID: <45494D84.2060402@shadowen.org>
References: <eibhga$tpg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 01:47:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <eibhga$tpg$1@sea.gmane.org>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30681>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfRdy-0004o9-CU for gcvg-git@gmane.org; Thu, 02 Nov
 2006 02:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752454AbWKBBpS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 20:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbWKBBpR
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 20:45:17 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:27913 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1752454AbWKBBpQ
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 20:45:16 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GfRdE-0002xK-66; Thu, 02 Nov 2006 01:44:37 +0000
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:
> 
> Hi,
> 
> the git source seems full of calls similar to
> 
>   strncmp (x, "constant string", 15)
> 
> is there a reason not to use something like
> 
>   int
>   strxmp (char const *x, char const *y)
>   {
>     return strncmp (x, y, strlen (y));
>   }
> 
> everywhere?

If you are doing these a _lot_ then there is a significant additional
cost to using strlen on a constant string.

That said if you know its constant you can also use sizeof("foo") and
that is done at compile time.  Something like:

#define strxcmp(x, y)	strncmp((x), (y), sizeof((y))

-apw
