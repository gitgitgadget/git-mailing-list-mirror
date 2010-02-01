From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC/PATCH 5/6] revert: add --ff option to allow fast forward
 when cherry-picking
Date: Mon, 01 Feb 2010 15:29:17 +0100
Message-ID: <4B66E53D.8050204@gnu.org>
References: <20100201074835.3929.11509.chriscool@tuxfamily.org>	 <20100201075542.3929.35967.chriscool@tuxfamily.org>	 <4B66B68C.7050505@gnu.org> <c07716ae1002010443p4e0443feke14e5f877584640f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 15:29:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbxHL-0003AM-JQ
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 15:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab0BAO3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 09:29:22 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:35507 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab0BAO3V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 09:29:21 -0500
Received: by bwz23 with SMTP id 23so117008bwz.21
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 06:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=6I37WzIGOnfQeZ7JuJJJWAAEg8CGR7tYCjNlfhJFK0c=;
        b=pJwHKH1XVE3Q/Yrv3z3rOubSwfz/Utzask9jCqNDHK70glNyLhEMH7g19YYWqh8Rl+
         MZPVn6/qQbq7QWb0Nxh4yTHlSqhXFxn1sj6CFHezNz55ave5TICYi15FKwGHzztzURGw
         DqgF0mU94OEkTfE1LnuWBsk3EmnGsjAsFmcdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=bnyVbhtguOBdBCVsqj46ni6+UGMLMc5BrvfwejWUQ/dw8LHVxcEUkfmNCpfy8ZAEt7
         Cwylm+ZEjbfguZIWfq3FMCoU5o1JcSrf496vfw3UYDs35AzwA6dayeKop6s1QkQomdzc
         /Cwcu9GrY9SrdC1YKkRnLe4+SzZvgU6Hu7Myo=
Received: by 10.204.25.130 with SMTP id z2mr2596934bkb.211.1265034560291;
        Mon, 01 Feb 2010 06:29:20 -0800 (PST)
Received: from yakj.usersys.redhat.com (93-34-208-53.ip51.fastwebnet.it [93.34.208.53])
        by mx.google.com with ESMTPS id 13sm2131265bwz.6.2010.02.01.06.29.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 06:29:18 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <c07716ae1002010443p4e0443feke14e5f877584640f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138611>

On 02/01/2010 01:43 PM, Christian Couder wrote:
> Maybe it could be the default, but in this case it should be made
> compatible with -n option (and perhaps other options) for backward
> compatibility, and this would probably need more involved changes.

A better objection is that GIT_COMMITTER_* is respected by |git 
cherry-pick" but not by "git cherry-pick --ff", and that even without 
setting the variables, "git cherry-pick" will pick a new commit date but 
"git cherry-pick --ff" wouldn't.  The latter, I think is the only 
difference that is worth pondering further.

My impression is that a user would never have any problem with 
fast-forwarding.  For scripts probably the same is true (the typical 
scenario for scripts is probably very similar to what "git rebase -i" 
does), but it can still be a potential backwards-incompatibility in case 
the script is *expecting* cherry-picking to generate a new SHA1.  How 
broken can we consider this expectation?


That said, to reply to your question, of course -n would disable it, and 
so would -x, -s and possibly -e.  But then, the same applies to --ff: 
your patch forbids "-n --ff", but -x, -s and -e would need the same 
treatment.

Note that "-e --ff" would error out; however if --ff would be the 
default, "-e" would probably choose between fast-forward and 
non-fast-forward depending on whether the commit message was edited.

Paolo
