From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v1 1/4] git-gui: remove duplicate entries from .gitconfig's gui.recentrepo
Date: Wed, 16 Dec 2015 23:41:16 -0000
Organization: OPDS
Message-ID: <B283141DAA2647EF9917F27A817CC7FA@PhilipOakley>
References: <3453668A49C94C2AA39911FC594AE151@PhilipOakley><1450105743-2432-1-git-send-email-philipoakley@iee.org><1450105743-2432-2-git-send-email-philipoakley@iee.org> <CAPig+cQ8=WKwew5GNqyAPFuYJDgM+ae6rxaJQg=jhrxn61rNbQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Pat Thoyts" <patthoyts@users.sourceforge.net>,
	"Alexey Astakhov" <asstv7@gmail.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 00:41:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9LhD-0004eJ-KQ
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 00:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197AbbLPXlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 18:41:19 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:28135 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753719AbbLPXlS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2015 18:41:18 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BgCAAa9nFWPMm3YwJeGQEBAg8BAQEBgwpSbYdNtBOECSGFZgQCgSlNAQEBAQEBBwEBAQFBJBuELwUBAQEBAgEIAQEZFR4BASELAgMFAgEDFQMCAgUhAgIUAQQIEgYHAxQGEwgCAQIDAYgJAwoMCqwnhlWGdQ2EUgSBAYVVhH2CU4UkL4EaBZZ8AYEyhAaGF4NUkl2BB4dbgyiBQD40hG4BAQE
X-IPAS-Result: A2BgCAAa9nFWPMm3YwJeGQEBAg8BAQEBgwpSbYdNtBOECSGFZgQCgSlNAQEBAQEBBwEBAQFBJBuELwUBAQEBAgEIAQEZFR4BASELAgMFAgEDFQMCAgUhAgIUAQQIEgYHAxQGEwgCAQIDAYgJAwoMCqwnhlWGdQ2EUgSBAYVVhH2CU4UkL4EaBZZ8AYEyhAaGF4NUkl2BB4dbgyiBQD40hG4BAQE
X-IronPort-AV: E=Sophos;i="5.20,438,1444690800"; 
   d="scan'208";a="813689478"
Received: from host-2-99-183-201.as13285.net (HELO PhilipOakley) ([2.99.183.201])
  by out1.ip01ir2.opaltelecom.net with SMTP; 16 Dec 2015 23:41:16 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282619>

From: "Eric Sunshine" <sunshine@sunshineco.com>
> On Monday, December 14, 2015, Philip Oakley <philipoakley@iee.org> wrote:
>> The git gui's recent repo list may become contaminated with duplicate
>> entries. The git gui would barf when attempting to remove one entry.
>> Remove them all - there is no option within 'git config' to selectively
>> remove one of the entries.
>>
>> This issue was reported on the 'Git User' list
>> (https://groups.google.com/forum/#!topic/git-users/msev4KsQGFc,
>> Warning: gui.recentrepo has multiply values while executing).
>
> s/multiply/multiple/

The original report has that mistake. I'll quote the thread title.
>
>> On startup the gui checks that entries in the recentrepo list are still
>> valid repos and deletes thoses that are not. If duplicate entries are
>
> s/thoses/those/
OK

>
>> present the 'git config --unset' will barf and this prevents the gui
>
> s/present the/present, then/

OK
[my first glance thought the change was to the 'prevents the' at the end...]
>
>> from starting.
>>
>> Subsequent patches fix other parts of recentrepo logic used for syncing
>> internal lists with the external .gitconfig.
>>
>> Reported-by: Alexey Astakhov <asstv7@gmail.com>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>> diff --git a/git-gui/lib/choose_repository.tcl 
>> b/git-gui/lib/choose_repository.tcl
>> index 75d1da8..133ca0a 100644
>> --- a/git-gui/lib/choose_repository.tcl
>> +++ b/git-gui/lib/choose_repository.tcl
>> @@ -247,7 +247,7 @@ proc _get_recentrepos {} {
>>
>>  proc _unset_recentrepo {p} {
>>         regsub -all -- {([()\[\]{}\.^$+*?\\])} $p {\\\1} p
>> -       git config --global --unset gui.recentrepo "^$p\$"
>> +       git config --global --unset-all gui.recentrepo "^$p\$"
>>         load_config 1
>>  }
--

Will re-roll to give Pat the opportunity to include in any 2.7 update.

Philip 
