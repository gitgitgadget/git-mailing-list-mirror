From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/3] Unconfuse git clone when two branches at are HEAD.
Date: Mon, 9 Sep 2013 23:20:41 +0100
Organization: OPDS
Message-ID: <CBB3BFF2B74D4A768238512FBF1CD6E7@PhilipOakley>
References: <20130906155204.GE12966@inner.h.apk.li><6649DD0E3B6B4CE59D330217786B6B05@PhilipOakley><xmqqfvthyfui.fsf@gitster.dls.corp.google.com><94A71512041A4F9BB402474DB385E310@PhilipOakley><xmqqwqmsvdfh.fsf@gitster.dls.corp.google.com><531DBE1FF66D4356AEE6AEE5C2FE9389@PhilipOakley><xmqqk3ir6wu3.fsf@gitster.dls.corp.google.com><5425F66B510F423EA685BCEF40EF8FA7@PhilipOakley> <xmqqr4cy5a2z.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Andreas Krey" <a.krey@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 00:20:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ9oz-0008WL-PD
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 00:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875Ab3IIWUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 18:20:34 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:40412 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755807Ab3IIWUd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Sep 2013 18:20:33 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApgGADtJLlJOl3GZ/2dsb2JhbABbgweJcbktCYEmF3RpgSEWAQQBAQUIAQEuHgEBGgcLAgMFAgEDFQELJRQBBBoGBxcGEwgCAQIDAYU4B4ITI8M3j2uDJIEAA4h9hhKaTIMhOw
X-IPAS-Result: ApgGADtJLlJOl3GZ/2dsb2JhbABbgweJcbktCYEmF3RpgSEWAQQBAQUIAQEuHgEBGgcLAgMFAgEDFQELJRQBBBoGBxcGEwgCAQIDAYU4B4ITI8M3j2uDJIEAA4h9hhKaTIMhOw
X-IronPort-AV: E=Sophos;i="4.90,874,1371078000"; 
   d="scan'208";a="440736782"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip02ir2.opaltelecom.net with SMTP; 09 Sep 2013 23:20:31 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234384>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Monday, September 09, 2013 3:44 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> One is to extend the ref format such that
>>  <sha1> refs/heads/Test:HEAD
>> would be considered a valid indicator of a symref relationship
>> (i.e. using the typical 'colon' style). It would be appended after 
>> the
>> regular refs, so all the existing refs are still transported.
>>
>> The point is that while it produces an error, it doesn't stop the
>> cloning, and the error message
>> "error: * Ignoring funny ref 'refs/remotes/origin/Test:HEAD' locally"
>> gives a pretty clear statement of intent to those with older versions
>> of git.
>
> Cute.  If it does not stop any of these:
>
>        git ls-remote such.bundle
> git clone such.bundle
>        git fetch such.bundle
> git fetch such.bundle master ;# if 'master' branch is in it
>        git ls-remote such.bundle
>        git ls-remote such.bundle master ;# if 'master' branch is in it
>
> even if some of them may give error messages, I think that may be a
> workable escape hatch.
>
These look to work OK. Not sure If I've properly covered all the 
options.

A nice feature is that ls-remote will find the fake ref !

$ git ls-remote /c/gitBundleTest1/RepoHEADnomaster.bundle Test:HEAD
41ccb18028d1cb6516251e94cef1cd5cb3f0bcb5        refs/heads/Test:HEAD

It's only the clone that barfs (so far) (which could be 'fixed').

Obviously, if it can be made to work, one check would be that the two 
refs (HEAD and refs/heads/wherever) point to the came commit before 
generating the HEAD symref.

Philip 
