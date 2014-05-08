From: John Keeping <john@keeping.me.uk>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is
 misleading
Date: Thu, 8 May 2014 22:38:06 +0100
Message-ID: <20140508213806.GA19464@serenity.lan>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 23:38:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiW1I-0002Uc-Vp
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 23:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbaEHViV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 17:38:21 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:58574 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbaEHViU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 17:38:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 276F1CDA5BF;
	Thu,  8 May 2014 22:38:20 +0100 (BST)
X-Quarantine-ID: <xHAl9zB1dA2X>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xHAl9zB1dA2X; Thu,  8 May 2014 22:38:19 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 4183ACDA54E;
	Thu,  8 May 2014 22:38:17 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 3510E161E0A0;
	Thu,  8 May 2014 22:38:17 +0100 (BST)
X-Quarantine-ID: <3sy9svmJrdKV>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3sy9svmJrdKV; Thu,  8 May 2014 22:38:16 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 929FC161E27D;
	Thu,  8 May 2014 22:38:13 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248452>

On Thu, May 08, 2014 at 01:52:38PM -0700, Junio C Hamano wrote:
> I am tempted to say "blame that is run without the --porcelain
> option is a end-user facing Porcelain, and people should not be
> reading its output in their scripts" and change the behaviour of the
> "-b" option to instead show something like this instead:
>     
>     ^cc29195 (Unknown        2014-04-18 11:21:43 -0700 103) 
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
>     ^cc29195 (Unknown        2014-04-18 11:21:43 -0700 105)         test...
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
>     ^cc29195 (Unknown        2014-04-18 11:21:43 -0700 107)         test...
> 
> which shows the commit object name, its bottom-ness and the
> timestamp, or even
> 
>              (                                         103) 
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
>              (                                         105)         test...
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
>              (                                         107)         test...
> 
> which does away with the misleading information altogether.
> 
> I myself is leaning towards the latter between the two, and not
> overriding "-b" but introducing another "cleanse the output of
> useless bottom information even more" option.

I'd be tempted to leave the SHA-1 to indicate "sometime before" but
delete the author and date (I also think it looks a bit nicer to omit
the opening parenthesis):

    ^cc29195                                           103) 
    7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
    ^cc29195                                           105)         test...
    7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
    ^cc29195                                           107)         test...


On a slight tangent, I tried this in a fairly young repository and got
this (with master at v2.0.0-rc2-4-g1dc51c6):

$ git blame Makefile | head -5
7a3fc144 (John Keeping      2013-12-26 17:37:53 +0000   1) REL_VERSION = v0.2
5c9829f9 (John Keeping      2013-07-29 17:03:26 +0100   2) 
5c9829f9 (John Keeping      2013-07-29 17:03:26 +0100   3) # The default target is...
^f7fae99 (John Keeping      2013-03-24 17:14:40 +0000   4) all::
^f7fae99 (John Keeping      2013-03-24 17:14:40 +0000   5) 

f7fae99 is the initial commit in the repository, so shouldn't the last
two lines blame to that, not a non-existent ancestor?
