From: Xidorn Quan <quanxunzhen@gmail.com>
Subject: Re: [PATCH] credential-osxkeychain: support more protocols
Date: Mon, 27 May 2013 21:57:01 +0800
Message-ID: <CAMdq69_=21de4FvGkp0bFtZjNOttkwXOxjvhM0yZi5gyj0-V9g@mail.gmail.com>
References: <1369641431-44504-1-git-send-email-quanxunzhen@gmail.com> <CAEBDL5W4sLB0R1ZOspb-yQzmyTCE7Y1HeC2KZ69F8R28fJY7_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Mon May 27 15:57:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugxvn-0004fr-10
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 15:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627Ab3E0N5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 09:57:42 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:62996 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932366Ab3E0N5m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 09:57:42 -0400
Received: by mail-vc0-f171.google.com with SMTP id m17so4693388vca.16
        for <git@vger.kernel.org>; Mon, 27 May 2013 06:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Nv8vSaS47slm96CtlGkpq2eBGTMudWjEdg+Wyi05q8Y=;
        b=oJTajtAWkJ5A1vHqZ3n8U6i7wCyQMcSbI51Nmf/ZVl/jd163sAs1OMrnY2kxMPWnLB
         /B2NciCxj0XmudMopXd4IUg/hq75B+7bBkCUADo0e9MTGIfJ4DAAnQAR7jr4jaZlR9XU
         RLJjoovnJdZZuksJvQoGRMBbTSqM4PxH45WR/l55nlRhMYzp2Xl5bPe2zhk1WKBj6rmJ
         70wRvTimhH5O6SUz+rD4Qddls8HNGeXYXRlW8ZgD9Qer3KLDm64f8Z2AvfS82CkkkVww
         KnHA3GbP9odQUnF3G81vewUMK6amKS+5VATqdVXHgsfxpmDNwVv6oleiYBlZpf7ckPku
         Xysw==
X-Received: by 10.52.228.129 with SMTP id si1mr12970265vdc.79.1369663061440;
 Mon, 27 May 2013 06:57:41 -0700 (PDT)
Received: by 10.52.34.230 with HTTP; Mon, 27 May 2013 06:57:01 -0700 (PDT)
In-Reply-To: <CAEBDL5W4sLB0R1ZOspb-yQzmyTCE7Y1HeC2KZ69F8R28fJY7_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225588>

On Mon, May 27, 2013 at 6:27 PM, John Szakmeister <john@szakmeister.net> wrote:
>
> On Mon, May 27, 2013 at 3:57 AM, Xidorn Quan <quanxunzhen@gmail.com> wrote:
> > Add protocol ftp, smtp, and ssh for credential-osxkeychain.
> > ---
> >  contrib/credential/osxkeychain/git-credential-osxkeychain.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> > index 3940202..4ddcfb3 100644
> > --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> > +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> > @@ -127,10 +127,16 @@ static void read_credential(void)
> >                 *v++ = '\0';
> >
> >                 if (!strcmp(buf, "protocol")) {
> > -                       if (!strcmp(v, "https"))
> > +                       if (!strcmp(v, "ftp"))
> > +                               protocol = kSecProtocolTypeFTP;
> > +                       else if (!strcmp(v, "https"))
> >                                 protocol = kSecProtocolTypeHTTPS;
> >                         else if (!strcmp(v, "http"))
> >                                 protocol = kSecProtocolTypeHTTP;
> > +                       else if (!strcmp(v, "smtp"))
> > +                               protocol = kSecProtocolTypeSMTP;
> > +                       else if (!strcmp(v, "ssh"))
> > +                               protocol = kSecProtocolTypeSSH;
> >                         else /* we don't yet handle other protocols */
> >                                 exit(0);
>
> This looks pretty good, except the last one raises a question.  I'm
> using Mac OS X, and ssh already interacts with keychain to get my SSH
> key password.  Is this mainly for password logins via SSH?  Assuming
> that's the case:
>
> Signed-off-by: John Szakmeister <john@szakmeister.net>
>
> -John

I thought that SSH password logins can benefit from it, but I just
found that it is wrong because it seems that SSH client is responsible
for authenticating. Consequently, supporting SSH here is useless.
I will remove that lines and send this patch again.

Since it is the first time I submit a patch to git, I am not very
familiar with the convention here. Should I send the modified patch
to the maintainer directly? And what information should I append to
my patch before it can get merged?

--
Xidorn Quan
