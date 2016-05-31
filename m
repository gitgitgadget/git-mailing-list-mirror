From: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v5] upload-pack.c: use parse-options API
Date: Tue, 31 May 2016 11:53:54 +0200 (CEST)
Message-ID: <766819198.192241.1464688434974.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160527141628.1677-1-Antoine.Queru@ensimag.grenoble-inp.fr> <20160530145347.15643-1-antoine.queru@ensimag.grenoble-inp.fr> <xmqqd1o38i0m.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, peff@peff.net,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 31 11:47:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7gGN-0005YN-81
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 11:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756962AbcEaJq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 05:46:59 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:48039 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756877AbcEaJq6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 05:46:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 8F8AF2073;
	Tue, 31 May 2016 11:46:55 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EyoK_zfDbGfO; Tue, 31 May 2016 11:46:55 +0200 (CEST)
Received: from zm-int-mbx6.grenet.fr (zm-int-mbx6.grenet.fr [130.190.242.145])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 7631B2071;
	Tue, 31 May 2016 11:46:55 +0200 (CEST)
In-Reply-To: <xmqqd1o38i0m.fsf@gitster.mtv.corp.google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: upload-pack.c: use parse-options API
Thread-Index: csGTAmQek88acxj7yUWGT8R404pWhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295966>

Hello Junio, thanks for your answer. The next version (and hopefully the last)
will come fast.

> > From: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>
>
> Don't you want to be known to the project as the email that matches
> your Signed-off-by: line?

Thanks for noticing it, it will be updated.
  
> > +--[no-]strict::
> >  	Do not try <directory>/.git/ if <directory> is no Git directory.
> 
> Not a new problem, but "is no Git ..." may technically be correct,
> but it would be easier to read if phrased "is not a Git ..." or
> something like that.
> 
> 	I am NOT asking _you_ to change/fix that in this patch.  It
> 	is just a note for "a low hanging fruit" for people to pick
> 	up with a separate patch.
> 

Ok, so this will not be changed.
 

> > diff --git a/upload-pack.c b/upload-pack.c
> > index dc802a0..083d068 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -14,8 +14,12 @@
> >  #include "sigchain.h"
> >  #include "version.h"
> >  #include "string-list.h"
> > +#include "parse-options.h"
> >  
> > -static const char upload_pack_usage[] = "git upload-pack [--strict]
> > [--timeout=<n>] <dir>";
> > +static const char * const upload_pack_usage[] = {
> > +	N_("git upload-pack [options] <dir>"),
> > +	NULL
> > +};
> 
> Output from "git grep -e '\[option' -e '\[<option' -- \*.c" tells me
> that "[<options>]" would be more in line with the established
> convention than "[options]".
> 
> 	I personally wish if all these hits from the above grep
> 	consistently spelled it as "[options]", because there is not
> 	much gained by enclosing the word in <> to highlight it as a
> 	placeholder.  An argument that "it is done for uniformity
> 	with descriptions for other non option arguments, i.e. not
> 	to special case 'options'" would not hold water, e.g. in
> 
>         builtin/merge.c:        N_("git merge [<options>] [<commit>...]"),
> 
> 	<options> is still special-cased in that it implies multiple
> 	things, unlike "<commit>..." notation that has to explicitly
> 	say that can have multiple.  [<options>...] would have been
> 	justifiable with the "make it uniform with non-option args",
> 	though.
> 
> 	BUT this patch is not about "make usage string better"
> 	patch, so I do NOT want you to switch upload-pack's usage
> 	string to use the "options is special anyway, so let's not
> 	waste two display columns with enclosing <>" convention.
> 
> So, in conclusion, "git upload-pack [<options>] <dir>".
>

Ok, so it will be fixed. I didn't notice this convention, my goal 
wasn't to change it, my bad.  
