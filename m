From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 02/13] declare overflow during base128 decoding when 1 MSB nonzero, not 7
Date: Thu, 5 Apr 2007 16:08:55 -0700
Message-ID: <56b7f5510704051608g4bf9ffb7t9f94b532c7a0ebdf@mail.gmail.com>
References: <56b7f5510704051524p28eafc18mae3131ef13cdabfa@mail.gmail.com>
	 <7vr6qymo3r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 01:09:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZb4e-0000Sg-2n
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 01:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767405AbXDEXI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 19:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767275AbXDEXI5
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 19:08:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:35849 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766555AbXDEXI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 19:08:56 -0400
Received: by wr-out-0506.google.com with SMTP id 71so470476wri
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 16:08:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OKd7WlcpJ//J8WA6YeapsbRPX4yo1l+NPBuSBL0xcoP1WTfDokp609+M0iVx8P6SXCHYJqkz+in89ALBLm4ekSEf97HRuZFwfRkLTAXBn+7WJh39mUB0ft7mOih4Bsd6PbtiLqOSAXSePQG8h3ULz4dChvfaeCKbqo7evjf5J2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UEozFEwABfGlIgcgQv3KnrRjr/+7VyzaNu4b0niibT+xXjobVWvpHEAcun+OIlwnuNqdRt5W3uRj26mhVioh6YvG7XJcSjHoS2ZS52O8sLsLDyShSjz54+Z6N3ek2/EjKryffifqhH33+IvT+0c2s6rORI+5fTvsH08XbsR+bBY=
Received: by 10.115.108.1 with SMTP id k1mr971060wam.1175814535243;
        Thu, 05 Apr 2007 16:08:55 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 16:08:55 -0700 (PDT)
In-Reply-To: <7vr6qymo3r.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43882>

On 4/5/07, Junio C Hamano <junkio@cox.net> wrote:
> "Dana How" <danahow@gmail.com> writes:
> >                               ofs = c & 127;
> >                               while (c & 128) {
> >                                       ofs += 1;
> > -                                     if (!ofs || ofs & ~(~0UL >> 7))
> > +                                     if (!ofs || ofs & ~(~0UL >> 1))
> >                                               die("delta base offset overflow in pack for %s",
> >                                                   sha1_to_hex(entry->sha1));
> >                                       c = buf[used_0++];
> The line after these context does this:
>         ofs = (ofs << 7) + (c & 127);
> If you do not check the top 7 bits, wouldn't you miss overflow?

You are correct in all 4 cases --
this patch can be dropped from the set;
 it has no overlap in any context.

Concerning SEEK_SET,
you are correct: my unistd.h #define's SEEK_SET to 0.
But if someone edits this, the arg order might remain.

I will follow your commit text suggestions.

Let me think about your comment on 08/13.

Thanks!
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
