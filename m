From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: make git checkout safer
Date: Wed, 03 Jun 2015 10:32:40 -0700
Message-ID: <xmqqlhg0y9xj.fsf@gitster.dls.corp.google.com>
References: <loom.20150603T104534-909@post.gmane.org>
	<20150603090654.GD32000@peff.net>
	<loom.20150603T110826-777@post.gmane.org>
	<20150603093514.GF32000@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ed Avis <eda@waniasset.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 19:32:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0CX1-0006Az-ND
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 19:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbbFCRco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 13:32:44 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35252 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbbFCRcm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 13:32:42 -0400
Received: by igbyr2 with SMTP id yr2so118818981igb.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JRjITiryzc/mt6rYfOpy1r0DIDf4UkVADigDwmjOhlU=;
        b=cQL6QPKiQi7ULXl6a0QINrw6ZwzhAAywg2Anxt5TyP4BlJ4jV9rCr1cH9nqodeW4WH
         5Ay9cPAyr5HbtJsrcFTH8XhedzlinUoCe8rCDO+1GDnd4hjmGDRHkzQHrsrCoSRd8lFF
         3E9WbLyUo/NgTMJ4TOuyKiuHQFpm5kglB1KYXD85JzLwwFj2Jsz6s/XHEeNZAtweWCkm
         /945k3m8mhK5XI5/IUXtRxPB99PN/woT8ixyiOmvmH1tANXKd/0xtPLHGU0ndqo2431q
         7QasQtQ4wtjfXOdJkBi4WOcsADovfOJkKs2MVvKa31GUUmGCtpbddtVxUzEu8bS5lDZA
         PVDw==
X-Received: by 10.107.10.89 with SMTP id u86mr41496969ioi.79.1433352761838;
        Wed, 03 Jun 2015 10:32:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id k16sm12613718igf.19.2015.06.03.10.32.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jun 2015 10:32:41 -0700 (PDT)
In-Reply-To: <20150603093514.GF32000@peff.net> (Jeff King's message of "Wed, 3
	Jun 2015 05:35:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270704>

Jeff King <peff@peff.net> writes:

> If we want to introduce more safety here, I'd be inclined to perform the
> operation by default, but give a better escape hatch. For example, by
> creating a loose object for any file we're about to overwrite, and
> possibly writing an entry into a log.

Can we borrow the ideas from other tools that have similar
characteristics, I wonder.

"git checkout $paths" (and you can give "." for $paths to mean
"everything") is akin to "cp -R $elsewhere/$path ." to restore the
working tree copies from somewhere else.

"Ouch, 'git checkout .'  overwrote what was in my working tree" is
exactly the same kind of confusion as "I ran 'cp -r ../saved .' and
it overwrote everything".  As you said in your initial response,
that is what the command is meant for.

What does that similar command outside world, "cp", have for "more
safety"?  'cp -i' asks if the user wants to overwrite a file for
each path; perhaps a behaviour similar to that was the original
poster wanted to see?
