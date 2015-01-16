From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Thu, 15 Jan 2015 19:27:34 -0800
Message-ID: <BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>
References: <54B68D99.2040906@web.de> <xmqqmw5l9pje.fsf@gitster.dls.corp.google.com> <54B6C897.5030405@web.de> <20150114211712.GE1155@peff.net> <064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com> <xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com> <20150115222719.GA19021@peff.net> <xmqqa91j6537.fsf@gitster.dls.corp.google.com> <20150115235752.GB25120@peff.net> <xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com> <20150116013256.GA25894@peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 04:27:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBxZc-00071q-Np
	for gcvg-git-2@plane.gmane.org; Fri, 16 Jan 2015 04:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075AbbAPD1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 22:27:44 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34852 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069AbbAPD1n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 22:27:43 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so21545873pad.3
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 19:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=nlUqUKfS9fScFniqDDzN/D+x3nX4qterqIug8gu8E68=;
        b=N5YU31q1Ylp1JZiBvU8oEdjWxhA8aUsC20IZPCA2XlyXFdB3kNq/vEQUMOxkWKMiO7
         i2+MBScc1AElxGaSGfydN0M46K3q6A0nog11EHoHpc4D4JxqGImWoe5DEmBDWErcoCcr
         WCO5HaCwkkWYaa3lg2qbzncsfRy5+5IF0K+5f3WTrM6efktjh6my+FUJfyGaRAkJyPvu
         cfThYnucFjty0014Efsgy6tWwZY+vWL0Mw0t5DfT0LXQDFaUw/Q9ijoA+wxzVve+LVUR
         FWSlsoY9vo1i+OvT2u6iUCb2WXIF99fjigQOLMybQ4dII06BNd77uU7bF6ko6yLCOysv
         PfaQ==
X-Received: by 10.70.125.163 with SMTP id mr3mr19013641pdb.156.1421378863192;
        Thu, 15 Jan 2015 19:27:43 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id nj2sm2674685pbc.16.2015.01.15.19.27.41
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 15 Jan 2015 19:27:42 -0800 (PST)
In-Reply-To: <20150116013256.GA25894@peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262536>

On Jan 15, 2015, at 17:32, Jeff King wrote:

> On Thu, Jan 15, 2015 at 04:04:24PM -0800, Junio C Hamano wrote:
>
>> I wondered what 'perl -e 'print $>' would say in mingw, and if that
>> is portable enough, though.
>
> Good thinking. I guess the best way to find out is to convince  
> somebody
> from msysgit to try this patch. :)
>
> We may simply find that nobody there even has apache installed on  
> their
> box, and they do not run the http tests at all.
>
[...]
> We implement NOT_ROOT by checking perl's "$>" variable,
> since we cannot rely on the "id" program being available
> everywhere (and we would rather avoid writing a custom C
> program to run geteuid if we can).

Does it make a difference that id is POSIX [1]?

So the test "if [ $(id -u) = 0 ]" or similar ought to work.

"id -u" works for me in MSYS and cygwin (each appears to have it's own  
id.exe).

> +
> +test_lazy_prereq NOT_ROOT '
> +	uid=$(perl -e "print \$<") &&
> +	test "$uid" != 0
> +'

Does NO_PERL affect this?  Or is Perl always required to run the tests.

Also "$<" is real user id.  Don't you want effective user id ("$>"),  
that's what the comment says...

Both "$<" and "$>" work for me in MSYS and cygwin although if I run it  
from cmd.exe using strawberry perl, both "$<" and "$>" give 0.   
(There's no id.exe for cmd.exe unless it finds the cygwin/msys one.)

As long as NO_PERL is not also intended to affect "make test" either  
the perl or id version seems fine  to me (as long as it's Perl's "$>")  
since I doubt the tests would run with just cmd.exe. :)

-Kyle

[1] http://pubs.opengroup.org/onlinepubs/009604499/utilities/id.html
