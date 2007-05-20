From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Sun, 20 May 2007 22:55:17 +0200
Message-ID: <e5bfff550705201355x7025cef1lb1bcf0566cfffc3f@mail.gmail.com>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
	 <7vabvzq0bb.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550705200334pef694cn1a7842c23e2672f5@mail.gmail.com>
	 <7vabvzoij8.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550705200545kcf1f7f9n4f3f6d7d25955e1@mail.gmail.com>
	 <7v1whbmjel.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550705201156m244e1cf0v7e6b3ab43fa3b47b@mail.gmail.com>
	 <7vd50vl30r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 22:55:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpsRE-0000rc-IX
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759398AbXETUzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 16:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759468AbXETUzU
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:55:20 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:33245 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759114AbXETUzS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:55:18 -0400
Received: by nz-out-0506.google.com with SMTP id z3so128671nzf
        for <git@vger.kernel.org>; Sun, 20 May 2007 13:55:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JAFfFyceie3I4+76vAiDv2QZecX+4TYdlKEqerO7d9uAFYhc/7MYic+P01btI4EVyV6QGsxmvI7FLz7I8zu/yvV9E9LTPIJWKP/emHLALT7f6PF/FEkTt+RkEciIlSdJP/97h2wR2Bn/5IrWbKdu1vNNBxYU9MbJwX6Nuimk+vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VQW38me8c3mIGg7mldYmdTGXWEw3363HYYkGxDM8DaVZcznJQ6AcMaowPe4Uk6Tr3rFGilqolP8CfUX/NFQNeLgk/HtP6cQme68PdWVjcsy9u6e6MhEEQbD48rthTd2zZcpM6mhVz8HnzPEZilwG8uFvv2UagOcCqnOYqCqOUsA=
Received: by 10.114.198.1 with SMTP id v1mr2260667waf.1179694517510;
        Sun, 20 May 2007 13:55:17 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 20 May 2007 13:55:17 -0700 (PDT)
In-Reply-To: <7vd50vl30r.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47915>

On 5/20/07, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> >> >               if (offset >= 0) {
> >> > +
> >> > +                     if (desc->size - oldsize - offset == 0) /* end of file? */
> >> > +                             newsize -= trailing_added_lines;
> >> > +
> >> >                       int diff = newsize - oldsize;
> >> >                       unsigned long size = desc->size + diff;
> >> >                       unsigned long alloc = desc->alloc;
> >>

>
> Sorry I forgot to mention that that is "trivial" so there is no
> reason to resend.  I don't expect me doing much git stuff for
> the rest of the day, but you'll hear from me about this patch
> later (hopefully it would appear on 'next' -- we'll see).
>

Ok. Thanks for your help.

P.S: I don't find a trivial way to avoid adding more lines then
removed, the shortest trick I can find is

int eof = (desc->size - oldsize - offset == 0);
int diff = newsize - oldsize - eof * trailing_added_lines;
unsigned long size = desc->size + diff;
unsigned long alloc = desc->alloc;

newsize -= eof * trailing_added_lines;


But is not as elegant as the original.
