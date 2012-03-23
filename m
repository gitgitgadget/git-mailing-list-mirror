From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: Re: [PATCH] Make 'cvs -n commit ...' not to commit
Date: Fri, 23 Mar 2012 15:02:04 -0400
Message-ID: <4F6CC8AC.4050907@giref.ulaval.ca>
References: <20120323131100.7262D440B33@melkor.giref.ulaval.ca> <7vhaxftb54.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 20:08:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB9qG-0002U2-KT
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 20:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab2CWTH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 15:07:59 -0400
Received: from serveur.giref.ulaval.ca ([132.203.7.102]:38445 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113Ab2CWTH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 15:07:59 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Mar 2012 15:07:59 EDT
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id 02F09102185;
	Fri, 23 Mar 2012 15:02:05 -0400 (EDT)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RHBoyafCSR2a; Fri, 23 Mar 2012 15:02:04 -0400 (EDT)
Received: from [132.203.7.22] (melkor.giref.ulaval.ca [132.203.7.22])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id D7C661020A6;
	Fri, 23 Mar 2012 15:02:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120215 Thunderbird/10.0.2
In-Reply-To: <7vhaxftb54.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193794>

On 03/23/2012 02:39 PM, Junio C Hamano wrote:
> ericc<eric.chamberland@giref.ulaval.ca>  writes:
>
>> Actually, doing a 'cvs -n commit' will _do_ the commit...
>> With this patch, it now goes through the code, but don't do the commit.
>
> OK.
>
>> A further progress would be to do the pre-commit hook is possible...

Sorry, I wanted to write:

"A further progress would be to do the pre-commit hook *if* possible..."

here, we are used to do "cvs -n commit" just to check if the "hooks" on 
the cvs server will fail or not...


>
> I understand that you tried to make the patch smaller by avoiding
> re-indenting, but this is *yucky*.
>
> It looks to me that the above part could be solved with:
>
> 	unless (...) {
> 		next;
> 	}
>
> I think the function being patched is too big.  Wouldn't it be better to
> have a refactoring patch to move the above per-path logic to a helper
> function that deals with a single path, and then insert the "omit call to
> that helper when run with -n" code in a separate patch?
>
> The same comment applies to the other hunk.
>
> Also I notice that the indentation used throughout the file is somewhat
> broken (e.g. "Emulate by running hooks/update" part is indented to 8
> columns, but earlier parts use 4 space indent).  The right structure for
> this change may be:
>
>   Patch 1: Fix indentation (and do nothing else) to uniformly indent with
>            HT;
>
>   Patch 2: Refactor this big funciton using a handful of helper functions
> 	  (and do nothing else);
>
>   Patch 3: Omit calls to these helper functions under -n option.
>
>

Ok you are right...  These were my very first lines in Perl... I just 
wanted to catch the attention of someone who is able to do the changes 
correctly... and in a more clean way than I...

Eric
