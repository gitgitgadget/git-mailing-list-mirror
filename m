From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH] git-send-email: Add a --cc-nobody option
Date: Tue, 18 Sep 2007 09:01:55 -0400
Message-ID: <31e679430709180601h15d0d315ub13bfd2c6763f181@mail.gmail.com>
References: <11901157221792-git-send-email-felipebalbi@users.sourceforge.net>
	 <5e4707340709180550w3211e95fqd9fd648aab8ce78a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, ae@op5.se,
	"Felipe Balbi" <felipe.lima@indt.org.br>
To: "Alex Unleashed" <unledev@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 15:02:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXciI-0000sO-Ja
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 15:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbXIRNB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 09:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbXIRNB5
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 09:01:57 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:41245 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbXIRNB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 09:01:56 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2405826wah
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 06:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=o9BazaqCr6M9FGYtm7ZOamVuu3nuaQWeQx4D2j6W1Fo=;
        b=BKGvje7x2YzXgOAqDglCZ7sZyGhDo1eqmHGPBGQwGhFCt70xoVjkADaUBw8jVwHPuSjsYsy8C7+rAII9IJ16mtwwqlniD+6p3a+Ilu/Rs3ipKtg2S62a6IHvS/OwEVZGIYVehgcXiHb0HWXwCvg/04W+v4JCVvwBJ4gtuiFOWUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ncmYaRLBgPK4lcIy3Y2b+yx7e/+t7Mk/P3jI49wjLUnmE4UyCnnRY/tLA1JCbYm8iZQYIBXCTXWT5TwrOBL0laoSstj+BGF2K4nZKm+v5Jjne5Bgj21n5Al9gXpn9R+rbBMcYVjAwUm3GY9ZwSb6m5oDTMJKPCdO3M0LXuyo5Kk=
Received: by 10.115.74.1 with SMTP id b1mr653869wal.1190120515412;
        Tue, 18 Sep 2007 06:01:55 -0700 (PDT)
Received: by 10.114.61.4 with HTTP; Tue, 18 Sep 2007 06:01:55 -0700 (PDT)
In-Reply-To: <5e4707340709180550w3211e95fqd9fd648aab8ce78a@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 451e9725cfa3e5db
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58600>

hi,

On 9/18/07, Alex Unleashed <unledev@gmail.com> wrote:
> On 9/18/07, felipebalbi@users.sourceforge.net
> <felipebalbi@users.sourceforge.net> wrote:
> > From: Felipe Balbi <felipe.lima@indt.org.br>
> >
> > This patch adds a --cc-nobody option to avoid sending emails
> > to everybody but the ones listed by --to option.
> >
> > Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
>
> I wrote a similar patch a couple months ago, but they differ slightly,
> maybe the code has changed somewhat:
> http://marc.info/?l=git&m=118200193310898&w=2
>
> --cc-nobody sounds better to me.
>
> >                                 } elsif (/^(Cc|From):\s+(.*)$/) {
> > -                                       if (unquote_rfc2047($2) eq $sender) {
> > -                                               next if ($suppress_from);
> > +                                       if (unquote_rfc2047($2)) {
> > +                                               next if ($cc_nobody);
> > +                                       }
> > +                                       elsif (unquote_rfc2047($2) eq $sender) {
> > +                                               next if ($suppress_from|$cc_nobody);
> >                                         }
> >                                         elsif ($1 eq 'From') {
> >                                                 $author = unquote_rfc2047($2);
>
> Here you could probably skip the whole branch if you check $cc_nobody
> first of all.

Yeah, I tested this one too but when sending emails I was changing all
those From lines to my address, which means every mail I was sending
the patch would take my authorship.

So it looked better guaranteeing the authorship

>
> > @@ -707,7 +715,7 @@ foreach my $t (@files) {
> >                         }
> >                 } else {
> >                         $message .=  $_;
> > -                       if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc) {
> > +                       if (/^(Signed-off-by|Cc): (.*)$/i && $signed_off_cc && !$cc_nobody) {
>
> Minor, but almost the same here.

sanity

>
> Alex
>


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
