X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Mon, 11 Dec 2006 23:18:54 +1300
Message-ID: <46a038f90612110218u48b7737due56437da57091547@mail.gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
	 <200612102359.20083.jnareb@gmail.com>
	 <46a038f90612101816j33870bb1j39182358440aaa40@mail.gmail.com>
	 <200612110959.56492.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 10:19:16 +0000 (UTC)
Cc: "Jeff Garzik" <jeff@garzik.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rogan Dawes" <discard@dawes.za.net>,
	"Kernel Org Admin" <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H/c5aKH07Rx/4KmfMtuoQm0zhwTmvxgVb4YEIIGaFvLs+gykSRXEcLZBA06OZbHapepmjMqidtla//VidGQ1DJZDm0zzDmMP9msALb1OZI0czrNi88phjn4X8XVgowqsV1ic8cPcz3z9CR++pjcKzgpwI62bSeQkkx5qUgv7U7I=
In-Reply-To: <200612110959.56492.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33988>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtiFZ-0004wq-Ov for gcvg-git@gmane.org; Mon, 11 Dec
 2006 11:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762748AbWLKKS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 05:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762749AbWLKKS5
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 05:18:57 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:54303 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762748AbWLKKS4 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 05:18:56 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1954069nfa for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 02:18:55 -0800 (PST)
Received: by 10.49.13.14 with SMTP id q14mr4289590nfi.1165832334787; Mon, 11
 Dec 2006 02:18:54 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Mon, 11 Dec 2006 02:18:54 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/11/06, Jakub Narebski <jnareb@gmail.com> wrote:
> I was thinking not about ending execution, but about not sending script
> output but sending HTTP 304 Not Modified reply by Apache.
>
> I meant the following sequence of events:
>  1. Script sends headers, among those Last-Modified and/or ETag
>  2. Apache scans headers (e.g. to add its own), notices that Last-Modified
>     is earlier or equal to If-Modified-Since: sent by browser or reverse
>     proxy, or ETag matches If-None-Match:, and sends 304 instead of script
>     output
>  3. Script finishes execution, it's output sent to /dev/null
>
> Again, I don't know if Apache (or any other web server) does that.

It doesn't. You want to take the decision to send a 304, cleanup and
exit _inside_ the CGI. If it was up to apache, then the CGI script
would end up creating the (potentially expensive to produce) content
just to see it sent to /dev/null OR if apache was to terminate
execution of the CGI more violently, the CGI wouldn't have a chance to
cleanup and release resources.

So it's a matter of setting the header to 304 and exiting.

cheers,


martin

