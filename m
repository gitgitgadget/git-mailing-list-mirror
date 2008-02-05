From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Fix bug in parse_color that prevented the user from
 changing the background colors.
Date: Tue, 5 Feb 2008 20:58:56 +0200
Message-ID: <20080205205856.76a7cd45.tihirvon@gmail.com>
References: <47A89E2A.9010905@kergoth.com>
	<20080205203940.1dcff0ce.tihirvon@gmail.com>
	<b6ebd0a50802051045t4949df68u7e405ea618403a31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Chris Larson" <clarson@kergoth.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 19:59:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMT1E-0006M4-6S
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 19:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbYBES7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 13:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbYBES7L
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 13:59:11 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:45110 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbYBES7J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 13:59:09 -0500
Received: by wa-out-1112.google.com with SMTP id v27so41092wah.23
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 10:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=2/V7q3bnJM697PGxaNB3QJDfUv3T+Qvi6J+a7mQsYoY=;
        b=AM3KgsdCR7M20TLaNEIqE/+72GDC2vw0o17l+snXTazqSQkw+SMXfY3QD6HwCQKk/6t6OMlnWqMvrSKUkPdmv+tsnslBRIwE4a1OKrPgpS81AFRiL+Wxgd1oH0URziUVfdiVO1hdYgKEdQdF10sfRrl9S3TqkiUDrZTBu1zdkvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=yHn0nQW9GLgq5bxjmFYfJfbGhd7HWScpFr0dJSGeCf+zKokwdlxkAK4hgBTlOlgZB7vo/1z+NK/pVmELIevzOD7mmkqJag492zUXc/vDp5HFl0KXjlLXVYJkMZg5ADdS5NIcVMORtPpNxFr+tNoRtEUtlerTaBZHph4AJIbb+cw=
Received: by 10.114.184.7 with SMTP id h7mr2444440waf.28.1202237948570;
        Tue, 05 Feb 2008 10:59:08 -0800 (PST)
Received: from garlic.home.net ( [85.23.16.168])
        by mx.google.com with ESMTPS id h6sm116494nfh.30.2008.02.05.10.59.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Feb 2008 10:59:06 -0800 (PST)
In-Reply-To: <b6ebd0a50802051045t4949df68u7e405ea618403a31@mail.gmail.com>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72678>

"Chris Larson" <clarson@kergoth.com> wrote:

> On Feb 5, 2008 11:39 AM, Timo Hirvonen <tihirvon@gmail.com> wrote:
> 
> > Chris Larson <clarson@kergoth.com> wrote:
> >
> > unable to convert the string in its entirety into an integer.
> > > -    if (*name && !*end && i >= -1 && i <= 255)
> > > +    if (*name && i >= -1 && i <= 255)
> > >          return i;
> > >      return -2;
> > >  }
> >
> > My bug, sorry. I should have tested more.
> >
> > I think this new code accepts "7bold" (didn't test).  Maybe you should
> > do something like this instead:
> >
> >        if (*name && (!*end || isspace(*end)) && i >= -1 && i <= 255)
> 
> 
> Indeed, I should have tested more too :)  Just starting to mess with the
> codebase, surprised at how clean it is (though I probably shouldn't be).

OK, did some testing.

The old code accepted attribute before color (bold red). With your patch
that "bold" is treaded as fg color -1 and red as bg color, so you need
that (!*end || isspace(*end)) test.

> > Untested of course.  BTW, your patch is whitespace corrupted.
> >
> 
> Unsurprising... sometimes I really hate gmail :|  Anyone know if there's a
> way to post with gmail without hosing the patch, or should I switch to a
> non-web based solution?

I don't know.  Maybe attachment is the only way.
