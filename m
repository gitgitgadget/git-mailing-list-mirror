From: Vikrant Varma <vikrant.varma94@gmail.com>
Subject: Re: [PATCH 1/2] help: add help_unknown_ref
Date: Thu, 02 May 2013 03:56:06 +0530
Message-ID: <5181967E.9020601@gmail.com>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com> <1367407327-5216-2-git-send-email-vikrant.varma94@gmail.com> <7vppxa5z01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 02 00:26:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXfTf-0004TN-Ni
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 00:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759445Ab3EAW0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 18:26:16 -0400
Received: from mail-da0-f49.google.com ([209.85.210.49]:33838 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218Ab3EAW0O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 18:26:14 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so820788daj.22
        for <git@vger.kernel.org>; Wed, 01 May 2013 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=FcEZu7lKa3ecu7+TQGCfhxNdlEROZJyfTpRa1iPb6KE=;
        b=QIf0Ygn13u8c7uL7V4bcxbAI7cc2ZgWWOSMWGOr5trwjqmVK6ipW6o7v3RK6/qB/g3
         vv6n6FRVEsiZN1Oba7RTEeMkf4SHvQVQR38exwtOBtEvr+p4lUl00q82X4HUmTTH15HR
         PmPciUJPeT77QWyWgWah/HMqGlvBipj4f2+5fh9QXRzU9cYjmeBqfVe4yvO3Efg1gu4e
         bnVXOwmvlLm/syfGrPEISL00faZZ62LLUipQnhU6ub0C1o2zBpYsRTa8BjqTB17cj4Sv
         a8/SPdjh9lBJMBer16kDN2EOQdMjaOKDaIb57X3cSxZ1/uGMra0GERdT17zViJdd3alU
         whpw==
X-Received: by 10.66.216.136 with SMTP id oq8mr6863783pac.161.1367447174378;
        Wed, 01 May 2013 15:26:14 -0700 (PDT)
Received: from [192.168.1.109] (triband-mum-59.183.180.112.mtnl.net.in. [59.183.180.112])
        by mx.google.com with ESMTPSA id kr7sm5250646pab.23.2013.05.01.15.26.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 15:26:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7vppxa5z01.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223157>

On 02-05-2013 00:05, Junio C Hamano wrote:
> If you step back a bit, you would notice two things.
>
>   (1) Saying 'foo' when the user means 'origin/foo' is hardly the
>       only (or even the most common) kind of mistake that the code
>       you need to add to 'git merge' would encounter and could help
>       the user with.

Yes. I like your suggestion of using levenshtein.c, similar to what's 
been done in help.c:help_unknown_cmd. However, where do you draw the 
line? Do you also suggest 'remotes/origin/foo' for 'remotes/foo'? Also, 
which would you then prioritize for 'foo': 'fob' (this is local) or 
'origin/foo'? In other words, what kind of mistakes are you looking to 
correct -  typos, or forgetful omissions, or both and something more?

>   (2) "merge" is not the single command that user may make this kind
>       of mistake the command could help and use the same helper.
>       "git branch myfoo foo" may want to suggest "origin/foo", for
>       example.  I just typed "git checkout mater", which could have
>       been easily corrected to "git checkout master" with a mechanism
>       like this.
>

Of course, once the suggestion mechanism is in place, it can be used to 
replace unfriendly die()s in every command that takes a ref.

>
> An asterisk sticks to the parameter name, not type
>
> Indent with two HT, not HT followed by a run of SPs.
>
> An overlong line can and should be split
 >
 > Do not add trailing blank lines.
 >

Thanks, will fix this.

> When you consider the point (2) above, it becomes clear why this
> message does not belong to a helper function with a bland and
> generic name "help unknown ref".
>
> This API is misdesigned.  A possible alternative that may be better
> reusable would be to have a helper that is used to come up with a
> list of suggestions and make the caller responsible for emitting the
> error message.
>

Yes, I think a better name is needed, I was trying to follow along the 
lines of help_unknown_cmd.

However, making the caller responsible for printing the suggestions may 
not be the best alternative. Borrowing from the way help_unknown_cmd 
works, in help_unknown_ref we could:
1) check if autocorrect is on, returning the corrected refname to the 
calling function, otherwise
2) print an error message, a list of suggestions, and exit()

I think this makes for a clean and reusable API, and requires changing 
one line of code in every function that currently calls die().
