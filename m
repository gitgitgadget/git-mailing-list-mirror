From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb.js: Harden setting blamed commit info in incremental blame
Date: Wed, 25 Nov 2009 21:55:58 +0100
Message-ID: <200911252155.59318.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <4B0CAC2E.1060105@gmail.com> <200911251536.08993.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:56:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDOuQ-0008H0-8k
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 21:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935049AbZKYU4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 15:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935046AbZKYU4F
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 15:56:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:57119 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935039AbZKYU4D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 15:56:03 -0500
Received: by fg-out-1718.google.com with SMTP id 19so189325fgg.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 12:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=iv4Qqv2vG6mAzCwENUCrqKYxHKE0sMat7ccYJJ2dqkg=;
        b=svCmvHSdcXLsxKzDOAZEPnJFr7CI5jCgPOTdhDaWKensHMH95xmVDAZc4MKeBcd23M
         bPZZTt5UW1o9ZBLRcLGqBgCT3jhMvRHeCamm3uCCSxeyCoaFFIDp7xi7j7q6XaVord+i
         lFKlCVtwskffTvkkF/XfviZU/D/px3hKVv8qE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qMK62eL/5Err1XZe2SJMJ7Loa0M3YKknKhMg36JTQm9y8YQlPlNOjS14zA4dBO6/Y/
         Ki88c04wVV7J0vd+QVPyDe7cN2HN5H3pdlxCiqZUHBi+A9pTTDi1grtJNnDjVjpYzftR
         UZW+ydA9aULTEXAs3NnfsroNAA/djzMRC/XYg=
Received: by 10.86.248.36 with SMTP id v36mr1677632fgh.37.1259182568389;
        Wed, 25 Nov 2009 12:56:08 -0800 (PST)
Received: from ?192.168.1.13? (abvf67.neoplus.adsl.tpnet.pl [83.8.203.67])
        by mx.google.com with ESMTPS id d8sm286077fga.13.2009.11.25.12.56.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 12:56:05 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200911251536.08993.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133673>

On Wed, 25 Nov 2009, Jakub Narebski wrote:
> On Wed, 25 Nov 2009 05:01, Stephen Boyd wrote:
> > Jakub Narebski wrote:
> > >
> > > Debugging this is serious PITA.  After fix below it appears that this bug
> > > is some intermittent bug, depending on XMLHttpRequest timing.  It more
> > > often than not (at least when I tried to debug it using build-in IE8
> > > debugger) works correctly for the folowing files: README, GIT-VERSION-GEN,
> > > revision.c (once even it did fail when first running for given file, and
> > > then running correctly when reloading from debugger; fun it is not).
> > >
> > > It does consistently fail for gitweb/gitweb.perl... but when I tried
> > > to debug it IE8 would hang up when trying to use debugger (with around
> > > 600MB available RAM).  Perhaps somebody else would have more luck...
> > 
> > Interesting. I don't have time to look into this until early December, 
> > but if it's still around then I'll take a look. I wonder if IE6 or IE7 
> > works (I don't think everyone is on version 8 yet).
> 
> Well, the one time I was able to run debugger (F12, select 'Script', select
> 'gitweb.js') with error occurring

The error was "Unspecified error", char:2 in the mentioned line

> and without IE hanging (for README file) it did show an error for the
> following line: 
> 
>   if (xhr.readyState === 3 && xhr.status !== 200) {
> 
> When I checked 'xhr' object, it has "Unknown error" as contents of 
> xhr.statusText field and as contents of xhr.status (sic!), which should
> be a number: HTTP status code.

It was 'Unspecified error.' shown in xhr watch.  Accessing xhr.status
causes an error.

This might be cause by the fact that xhr (XMLHttpRequest object, or as IE8
shows it in JScript debugger DispHTMLXMLHttpRequest object) is not fully
initialized, or something; gitweb.js calls handleResponse() also from
a timer, to work around the fact that some web browsers onreadystatechange
handler is called only once for each state, and not as soon as new data
is available from server.

Longer term solution would be to use onprogress handler if it is available;
if it is available we don't need trick with calling handleResponse from
timer, as XMLHttpRequest 2.0 proposed specification ensures calling callback
as soon as new data is available.

Short term solution would be to wrap access to xhr.status in try ... catch
block for IE8... although I am a bit reluctant to implement this workaround
bugs in IE8.

-- 
Jakub Narebski
Poland
