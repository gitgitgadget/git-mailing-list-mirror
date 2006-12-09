X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Easy shell question: how to make a script killing all his childs when killed?
Date: Sun, 10 Dec 2006 00:06:34 +0100
Message-ID: <e5bfff550612091506g41e40e87n6356b8ddd5e16a5d@mail.gmail.com>
References: <e5bfff550612090716p215167b9r2277b09c09b18894@mail.gmail.com>
	 <20061209173703.GA12373@steel.home>
	 <e5bfff550612090951l43a83a00o7ea2e244ca562c77@mail.gmail.com>
	 <20061209213937.GB12373@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 23:06:56 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WOD5uC0GEMcSlo34W4eqnpZS9qu05s695DJuWI3dYRd6DC/LhMlZA01w70IPD7N3wgbstriL/FzcEPdnNXVTyGueUAAbd2Bkr3D8uMAc8cytSt5soeAgpyWpFykBur2HmpGAU9OWyS/JwrAayqVegmBfZgZdNGvYGRNsIfUrpZo=
In-Reply-To: <20061209213937.GB12373@steel.home>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33845>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtBHP-0005Uw-8I for gcvg-git@gmane.org; Sun, 10 Dec
 2006 00:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759712AbWLIXGg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 18:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759714AbWLIXGg
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 18:06:36 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:43267 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1759712AbWLIXGf (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 18:06:35 -0500
Received: by py-out-1112.google.com with SMTP id a29so643239pyi for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 15:06:35 -0800 (PST)
Received: by 10.35.76.9 with SMTP id d9mr8696712pyl.1165705595032; Sat, 09
 Dec 2006 15:06:35 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Sat, 9 Dec 2006 15:06:34 -0800 (PST)
To: "Alex Riesen" <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/9/06, Alex Riesen <fork0@t-online.de> wrote:
>
> Why do you need to save it in temporary file at all? Why don't you
> read the output like gitk does?  You can take a look at popen(3). It's
> known to be portable among operating systems and libc's.  Or, BTW, why
> don't you just read qprocess.h, use processIdentifier()/pid(),
> read*()-methods and the like?  (though, looking at the QProcess in
> qt3, I wouldn't really blame you)
>

Well, I _used_ QProcess interface until last week. It's socket based
and it's quite fast (much more then gitk BTW), but due to some
internal buffering not so fast as reading from a file (in my last post
regarding git-rev-list access there are some performance numbers to
document this). It seems that socket/pipe based IPC is not as fast as
file write/read. Of course we are talking of OS cached files, no disk
access must be involved to keep the speed.

Probably someone more versed in IPC and OS internals could comment on
this, I just base my arguments on experimental testing of various IPC
systems without going deep in the reasons why the number are like
this, also because I don't have the necessary knowledge.

But the fact is that with temporary (in memory) data exchange file the
load time has been reduced by 40% against socket based QProcess
interface.

Regarding gitk we are at least one order of magnitude faster both with
QProcess and, more, with temporary files, so it's not a useful
reference in this case.

  Marco

P.S: I didn't experiment with popen(). Thanks for the hint, I will
