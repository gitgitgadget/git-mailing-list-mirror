From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Added support for dropping privileges to git-daemon.
Date: Sat, 19 Aug 2006 17:19:30 +0200
Message-ID: <e5bfff550608190819i3cade548g28b2c95fab172a49@mail.gmail.com>
References: <1155990772.6591@hammerfest>
	 <e5bfff550608190623j58de8c1cn6a9304249ee1ecb8@mail.gmail.com>
	 <20060819132922.GA6644@code-monkey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 19 17:20:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEScJ-0007AX-8S
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 17:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWHSPTd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 11:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWHSPTc
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 11:19:32 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:60847 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751459AbWHSPTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Aug 2006 11:19:32 -0400
Received: by py-out-1112.google.com with SMTP id n25so1602139pyg
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 08:19:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ST/Jym8qfOC05TnT82Srh2xwyRKhXItdQbz/47whSzmsEtKu8Wa1pRfWSfYxMBfW1eQQ/mr/hnzO3jMzmST8eZT0ppan5yJ+Qek8VNha8c2lS81Hr3BcnYWYlG0iITyoXv1wKdasBGnCwyCRnmdhzYG4LFzZEJqBgsmhNe2UAiw=
Received: by 10.35.45.1 with SMTP id x1mr8500998pyj;
        Sat, 19 Aug 2006 08:19:30 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 19 Aug 2006 08:19:30 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20060819132922.GA6644@code-monkey.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25725>

On 8/19/06, Tilman Sauerbeck <tilman@code-monkey.de> wrote:
> Marco Costalba [2006-08-19 15:23]:
> > >
> > >+       if (!user ^ !group)
> > >+               die("either set both user and group or none of them");
> > >+
> > >
> >
> > Just a  question. Why simply not
> >
> >       if (user ^ group)
>
> Because gcc doesn't like that:
>  error: invalid operands to binary ^
>

Interesting!

Indeed gcc it's right, operator ^ it's a bitwise operator, not a
logical one. So operands must be booleans (or numerical types in case
of C).

The trick is that operator '!' performs an implicit conversion to
integral on the 'user' and 'group' pointers.

BTW the following (very ugly) works.

         if ((int)user ^ (int)group)
