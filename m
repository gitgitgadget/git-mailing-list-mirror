From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4 (fetch.c L588)
Date: Fri, 23 Aug 2013 20:51:05 +0100
Organization: OPDS
Message-ID: <0AED97BABBFA43DAAE14B8355C81AE3B@PhilipOakley>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com> <33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley> <85C8141E5DAD94428A121F706995A31F010F116FDADE@MX1.net.tbe.com> <2A02F37CE50C4BE38860C7D36F1F14CC@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Koch, Rick \(Subcontractor\)" <Rick.Koch@tbe.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 21:51:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCxNy-00089O-Pc
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 21:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101Ab3HWTvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 15:51:01 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:11947 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756486Ab3HWTvA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Aug 2013 15:51:00 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtgLABO8F1JOl3GZ/2dsb2JhbABXA4MHiWK3EgQEAYEfF3SCHwUBAQQBCAEBHREeAQEhBQYBAQMFAgEDFQELHgcUAQQaBgcGEQYTCAIBAgMBA4dnCrZ3jzeBKQsFGIMLfAOId4YQmkGDHzuBNQ
X-IPAS-Result: AtgLABO8F1JOl3GZ/2dsb2JhbABXA4MHiWK3EgQEAYEfF3SCHwUBAQQBCAEBHREeAQEhBQYBAQMFAgEDFQELHgcUAQQaBgcGEQYTCAIBAgMBA4dnCrZ3jzeBKQsFGIMLfAOId4YQmkGDHzuBNQ
X-IronPort-AV: E=Sophos;i="4.89,944,1367967600"; 
   d="scan'208";a="420844517"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip04ir2.opaltelecom.net with SMTP; 23 Aug 2013 20:50:58 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232831>

From: "Philip Oakley" <philipoakley@iee.org>
Sent: Monday, August 19, 2013 10:46 PM
> From: "Koch, Rick (Subcontractor)" <Rick.Koch@tbe.com>
>
>> Ran CPPCheck 1.5.6 on Windows-XP.
>
> Hi Rick,
> Thank you for the clarification.
> Normal practice on the list is to use Reply All, so everyone can 
> participate in the discussion.
>
> It looks like most of the reports are false positives. My bikeshedding 
> thought would be that it is common in Git to inspect all the call 
> sites such that they don't create the various problems, rather than 
> protect against the problems within the various functions, which may 
> be a cause of the reports (i.e. different philosophical approach to 
> checking).
>

I have double checked the reported:
    "wrongPrintfScanfArgNum(CppCheck) \git-master\builtin\fetch.c
    fetch.c 588".

                        fprintf(stderr, " x %-*s %-*s -> %s\n",
                                TRANSPORT_SUMMARY(_("[deleted]")),
                                REFCOL_WIDTH, _("(none)"), 
prettify_refname(ref->name));


At first it did look like there were not enough parameters to satisfy 
the "%-*s" format strings, given that the second invocation has an 
obvious width. This is the only usage within the prune_refs function.

A little further looking shows that the "%-*s" format is used 
extensively in the wider fetch.c and that the TRANSPORT_SUMMARY(), macro 
returns two values as required by the fprintf.

Inaddition  those other invocations aren't flagged showing that this is 
a false positive, and is a good example for feeding back to CPPCheck (If 
you wish Rick) as an example so they can see what went wrong.

Does CPPCheck give more details of 'why' it thinks the other faults are 
present? (e.g. the double pointer checks which can be tricky)

> regards
>
> Philip
> ---
>
> v/r
>
> Roderick (Rick) Koch
> OSF - Information Assurance
> Team Teledyne / Sentar Inc.
> Work: 256-726-1253
> Rick.Koch@tbe.com
>
>
> -----Original Message-----
> From: Philip Oakley [mailto:philipoakley@iee.org]
>
> From: "Koch, Rick (Subcontractor)" <Rick.Koch@tbe.com>
> Sent: Monday, August 19, 2013 6:09 PM
>>I'm directing to this e-mail, as it seems to be the approved forum for
>>posting Git bugs. We ran CPPCheck against Git v.1.8.3.4 and found 24
>>high risk bugs. Please see the attachment xlsx.
>
>>Is there a method to post to the Git community to allow the community
>>to review and debunk as faults positive or develop patches to fix 
>>lists
>>code files?
>
>>v/r
>
>>Roderick (Rick) Koch
>>Information Assurance
>>Rick.Koch@tbe.com
>
> What OS version / CPPCheck version was this checked on?
>
> In case other readers don't have a .xlsx reader here is Rick's list in 
> plain text (may be white space damaged).
>
> I expect some will be false positives, and some will just be being too 
> cautious.
>
> Philip
>
> description resourceFilePath fileName lineNumber
>      nullPointer(CppCheck) \git-master\builtin\add.c add.c 286
>      wrongPrintfScanfArgNum(CppCheck) \git-master\builtin\fetch.c 
> fetch.c 588

False positive.

>      nullPointer(CppCheck) \git-master\builtin\ls-files.c ls-files.c
> 144
>      nullPointer(CppCheck) \git-master\builtin\merge.c merge.c 1208
>      doubleFree(CppCheck) \git-master\builtin\notes.c notes.c 275
>      nullPointer(CppCheck) \git-master\builtin\reflog.c reflog.c 437
>      uninitvar(CppCheck) \git-master\builtin\rev-list.c rev-list.c 342
>      uninitvar(CppCheck) \git-master\builtin\rev-list.c rev-list.c 342
>      uninitvar(CppCheck) \git-master\compat\regex\regcomp.c regcomp.c
> 2803
>      uninitvar(CppCheck) \git-master\compat\regex\regcomp.c regcomp.c
> 2802
>      uninitvar(CppCheck) \git-master\compat\regex\regcomp.c regcomp.c
> 2805
>      memleakOnRealloc(CppCheck) \git-master\compat\win32\syslog.c 
> syslog.c 46

True report.

>      uninitvar(CppCheck)
> \git-master\contrib\examples\builtin-fetch--tool.c 
> builtin-fetch--tool.c
> 419
>      uninitvar(CppCheck) \git-master\fast-import.c fast-import.c 2917
>      nullPointer(CppCheck) \git-master\line-log.c line-log.c 638
>      nullPointer(CppCheck) \git-master\mailmap.c mailmap.c 156
>      uninitvar(CppCheck) \git-master\merge-recursive.c 
> merge-recursive.c 1887
>      uninitvar(CppCheck) \git-master\notes.c notes.c 805
>      uninitvar(CppCheck) \git-master\notes.c notes.c 805
>      deallocret(CppCheck) \git-master\pretty.c pretty.c 677
>      resourceLeak(CppCheck) \git-master\refs.c refs.c 3041
>      doubleFree(CppCheck) \git-master\sequencer.c sequencer.c 924
>      nullPointer(CppCheck) \git-master\sha1_file.c sha1_file.c 125
>      doubleFree(CppCheck) \git-master\shell.c shell.c 130
>
>
> --
Philip 
