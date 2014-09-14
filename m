From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] mailinfo: do not treat ">From" lines as in-body headers
Date: Sat, 13 Sep 2014 17:55:49 -0700
Message-ID: <CAPc5daWxZdi+JTTsznefPk2U+Q8uWWYuBUa-rJA4knDZzwU38w@mail.gmail.com>
References: <1410472786-14552-1-git-send-email-mark.einon@gmail.com>
 <1410472786-14552-5-git-send-email-mark.einon@gmail.com> <20140913093746.GD6600@mwanda>
 <20140913154556.GA12361@kroah.com> <20140913203645.GB24854@peff.net>
 <20140913204745.GA12291@msilap.einon.net> <20140913205751.GA17875@mwanda>
 <20140913210908.GG6549@mwanda> <20140913212504.GA25190@peff.net>
 <20140913225713.GB189120@vauxhall.crustytoothpaste.net> <20140914004725.GA28010@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Einon <mark.einon@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 14 02:56:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSy76-0006Tb-Qf
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 02:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbaINA4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 20:56:12 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34929 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbaINA4L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 20:56:11 -0400
Received: by mail-lb0-f179.google.com with SMTP id p9so2748803lbv.10
        for <git@vger.kernel.org>; Sat, 13 Sep 2014 17:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sQt8zxaCSRk+iA2QJIylMeZZo/ZruwGsE0LbbmhlAgo=;
        b=Ikcvq0b8rADjr18ZzlRRJcnWImEaTkgTzLtOKlbGNgXUs4wcMgFj+fCINfk+fBOGz6
         TdsQYQXdq1SnBNAHPL3dKfQFS2UxjjAf/4qfal/mRGT3EWLhAmwLIym44AVno/UyQgPM
         x56Sg9X97/svpRZ11KN7SmZlF5U/HhGAROih1KM07kGIxcCtAbuZB6vvXd8JcfhxcS1G
         n93TiP+eBMM9UqVfPH2stf1jQ7FEJZ1LnflcnfUUWGYEMosyAfPlVGcZrXijQR7QGbHC
         2bRmfN6LYC9LSv38DbhOqQi+Prd17IbzKJo9DVrAQYUb7mJB9qmAtrAGRnZVjzA0xRaS
         eDAA==
X-Received: by 10.112.35.138 with SMTP id h10mr16996724lbj.65.1410656169679;
 Sat, 13 Sep 2014 17:56:09 -0700 (PDT)
Received: by 10.112.97.177 with HTTP; Sat, 13 Sep 2014 17:55:49 -0700 (PDT)
In-Reply-To: <20140914004725.GA28010@peff.net>
X-Google-Sender-Auth: -C7IMshU7JwPqn_WPUfVOQAUhE0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256986>

On Sat, Sep 13, 2014 at 5:47 PM, Jeff King <peff@peff.net> wrote:
>
> On Sat, Sep 13, 2014 at 10:57:14PM +0000, brian m. carlson wrote:
>
> > I wonder if git send-email should do what mutt does in this case, which
> > is use quoted-printable encoding and encode the first F as =46 (as well
> > as any equals signs as =3D).  It looks like mailinfo.c already is
> > capable of handling that, and that would avoid the entire issue.
>
> That's not an unreasonable tactic. However, I think we'd still want to
> do something with mailinfo on the receiving end, similar to the patch I
> sent. We don't know that the sending side is necessarily send-email.

Hmm, isn't the ">" stuffing in front of a beginning-of-line "From " purely
a local matter of MUA that stores messages in (old-style) mbox format
where a line that begins with "From " is what defines the end of the
previous message? Why should send-email do anything when it sends
individual messages separately out?
