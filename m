From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH 00/11] Sequencer Foundations
Date: Mon, 11 Apr 2011 14:25:23 +0530
Message-ID: <20110411085521.GB28959@kytes>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
 <alpine.LNX.2.00.1104101445460.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 10:56:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Cuu-0000Z8-LA
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 10:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970Ab1DKI4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 04:56:11 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45976 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab1DKI4L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 04:56:11 -0400
Received: by iyb14 with SMTP id 14so5406042iyb.19
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 01:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KBEtcmIiaxKD+IM/ikftUJlh+q/HG988dBE0X0s2cKo=;
        b=SGL5ZrYIe0mq0o2AlRUX3Ky2VozhsvobTdQpa8krWKMpMtvcmnBR6aXGQiuA7PnV4z
         JFDXQfNP5nPFN7DM+3+D7bDeJXer25MFHzFVfYgmABPZCrHHjZCI+YN3C1djFN+DrPoG
         3v5F/RnoblTMtCQ6fSKHMnsRvOaLKmeyoYHxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=L1KeSsxUHTCqKDuP8Thn5zJSeHMFvFQ8TiL0NfSTrcOBeuwQEgKwF0J5UF2OwlAIM9
         VrrvSlmNJq0bAAh0AFIcb7543fVVLdpdlCTybSSI47hPI+COwFmJRO0M10Gzt38URvKK
         l3zhSWx09jaF5gdJMvWjiTYn3c0XAf4Uv0wmo=
Received: by 10.42.152.71 with SMTP id h7mr7838270icw.440.1302512170583;
        Mon, 11 Apr 2011 01:56:10 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id i20sm4086207iby.48.2011.04.11.01.56.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2011 01:56:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1104101445460.14365@iabervon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171315>

Hi Daniel,

Daniel Barkalow writes:
> > Please note that 10/11 is not related to this series, but seems to be
> > a minor nit that's required to make all existing tests pass.
> 
> That looks like an actual bug that only doesn't matter currently because 
> the function is never called with enough junk on the stack.

Fixing this bug was one is one of the hidden motives of the patch I
send out just afterward [1].

> > 0. Is the general flow alright?
> 
> I suspect it would be easier to review some of this with certain things 
> squashed together; one patch that changes all of the variable references 
> to what you want them to be is easier to understand than one that moves 
> statics to function arguments, one that moves statics to struct fields, 
> etc. Likewise, when you're converting some of the die() calls to error(), 
> it's easier to review the patch if all of the die() calls that aren't 
> changed in that patch don't get changed later in the series.

Agreed -- I'll post a reworked series shortly.  Jonathan was finding
it hard to follow as well.

> > 1. Is it okay to use this kind of adaptive error handling (calling
> > 'die' in some places and returning error in other places), or should
> > it be more uniform?
> 
> I think it should be systematic but not necessarily uniform. You should be 
> able to give a guideline as to how to decide which to use (and you should 
> probably actually give the guideline, so future developers make consistent 
> choices). I think of "die" as being ideally for situations where the 
> program can't understand what has happened well enough to know what to do 
> about it.

Jonathan concurs.  Where should I document this?

> > 2. In 11/11, I've used cmd_revert and cmd_rerere.  This is highly
> > inelegant, mainly because of the command-line argument parsing
> > overhead.  Re-implementing it using more low-level functions doesn't
> > seem to be the way to go either: for example, 'reset --hard' has some
> > additional logic of writing HEAD and ORIG_HEAD, which I don't want to
> > duplicate.  Should I work on reworking parts of 'rerere.c' and
> > 'revert.c', or is there some other way?
> 
> (ITYM cmd_reset here)

Yeah, sorry.

> I think rerere.c should get a rerere_clear(). I think it would make sense 
> to implement the reset locally; the abort ought to be undoing exactly 
> those things that you did, and I'm not actually sure the ORIG_HEAD is 
> entirely appropriate. You ought to be able to use cleanup functions that 
> correspond to the functions you used to make the mess in the first place.

Good suggestion -- rerere_clear is done [2]; now I have to figure out
if it makes sense to write a library for reset.

-- Ram

[1]: http://article.gmane.org/gmane.comp.version-control.git/171267
[2]: http://article.gmane.org/gmane.comp.version-control.git/171314
