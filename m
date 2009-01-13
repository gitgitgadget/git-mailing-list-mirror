From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG/RFH] gitweb: Trouble with ref markers being hyperlinks because of illegally nested links
Date: Tue, 13 Jan 2009 01:13:54 +0100
Message-ID: <200901130113.54517.jnareb@gmail.com>
References: <200901120215.13668.jnareb@gmail.com> <cb7bb73a0901111859q3a166d92k5176b27af2c4d256@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 01:15:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMWwN-0007Vu-2e
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 01:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbZAMAOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 19:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752246AbZAMAOE
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 19:14:04 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:20208 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbZAMAOB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 19:14:01 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1389290eye.37
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 16:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FLzFR+4fRJgn4aG4f3w4b1L11ZkTWuOEHmFMVtgEpDY=;
        b=Xi5BantwswD8jZ0t0FSOKPzDqfvKZXj/kdKmsAA4g7J9aFmjpJ1sAlEe0NQ+H679n8
         Wo/NVPzGXxzuFe9CJeOAGzf9lEdJkuSCGD1KV1ZI5p8jKEMp8cM8zsYTVshnaYr1+Qap
         UhyA/uoRN/CG54TQJLJ8hPbtbaqhm0lmtucaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LkXCXMHiBOBOp2jE7H3ewObl8kf5t+jO0ij0brVeYsFlOVfchKC7DrYp43OfKLJNo3
         qyCLSVHN+s0Y+CigM7HuPfTyr0mJPXBAZxQXxlvVcm86tylBmqXyoIfsAXHskqIQKEV4
         iD8UST/38vLorm0Dv3LSrtK7S3QNFFg5Pa2oQ=
Received: by 10.210.16.10 with SMTP id 10mr34129707ebp.7.1231805639726;
        Mon, 12 Jan 2009 16:13:59 -0800 (PST)
Received: from ?192.168.1.11? (abvj184.neoplus.adsl.tpnet.pl [83.8.207.184])
        by mx.google.com with ESMTPS id 32sm94034107nfu.61.2009.01.12.16.13.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jan 2009 16:13:58 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0901111859q3a166d92k5176b27af2c4d256@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105422>

On Mon, 12 Jan 2009, Giuseppe Bilotta wrote:
> On Sun, Jan 11, 2009 at 8:15 PM, Jakub Narebski <jnareb@gmail.com> wrote:

> > Commit 4afbaef by Giuseppe Bilotta (gitweb: ref markers link to named
> > shortlogs) turned ref markers for tags and heads into links to
> > appropriate views for the ref name.
> >
> > Unfortunately the code didn't take into account the fact that nesting
> > links (A elements) is illegal in (X)HTML:
> >
> >  12.2.2 Nested links are illegal
> >
> >  Links and anchors defined by the A element must not be nested;
> >  an A element must not contain any other A elements.
[...]

> > What is more complicated is the issue of ref marker from
> > git_print_header_div e.g. in 'commit'/'commitdiff' view, and in 'log'
> > view.  There link is made into block element using "display: block;"
> > CSS rule (div.title, a.title), so that you can click _anywhere_ on the
> > header block.  This breaks layout even worse, making hyperlinked ref
> > marker text appear *below* header div:
> >
> >  -----------------------------------------------------------
> >  |_Merge branch into maint_ []                             |
> >  -----------------------------------------------------------
> >  _maint_
> >
> > To preserve current layout and behavior it would be needed to do some
> > deep HTML + CSS positioning hackery, perhaps with additional link block
> > without any text... But I don't know exactly how to do this; all [few]
> > experiments I did failed.
> >
> > I see possible the following alternate solutions:
> >  * Ignore this issue (e.g. if it does not affect modern browsers)
> 
> That would be my current choice until we find a better solution.

By the way, how common this error is? Could you check if _your_ web
browser (Firefox, Internet Explorer, Opera, Konqueror, Safari, Chrome)
does show this bug or not, please?

> >  * Revert 4afbaef (we lose feature, but how often used is it?)
> >  * Always use quirks mode, or check browser and use quirks mode if it
> >    would break layout
> >  * Use extra divs and links and CSS positioning to make layout which
> >    looks like current one, and behaves as current one, but is more
> >    complicated.
> 
> I'm asking on #html, hopefully I'll get some interesting idea to try for this.

I have found _a_ solution. Perhaps not the best one, but it works.
And IMHO gives / can give even better visual.

Current version (line wrapped for better visibility):
  <div class="header">
  <a class="title" href="...">GIT 1.6.1
  <span class="refs"> 
    <span class="tag indirect" title="tags/v1.6.1">
    <a href="...">v1.6.1</a>
    </span>
  </span>
  </a>
  </div>

Current CSS (relevant part):
  a.title {
  	display: block;
  	padding: 6px 8px;
  }

Current rendering:
  -----------------------------------------------------------
  |_GIT 1.6.1_ []                                           |
  -----------------------------------------------------------
  __v1.6.1__


Proposed code (line wrapped for better visibility, with CSS embedded,
which would change in final version of course). Only parts of style
related to positioning are shown.
  <div class="header">
  <a href="..." style="float: left; margin: 6px 1px 6px 8px;">GIT 1.6.1</a>
  <div style="float: left; margin: 6px 1px;">
    <span class="refs"> 
      <span class="tag indirect" title="tags/v1.6.1">
      <a href="...">v1.6.1</a>
      </span>
    </span>
  </div>
  <a href="..." style="display: block; padding: 6px 8px;">&nbsp;</a>
  </div>

Rendering with proposed code:
  -----------------------------------------------------------
  _|_GIT 1.6.1_ [_v1.6.1_]                                 |_
  -----------------------------------------------------------

I guess that instead of additional DIV element, we could use DIV for
.refs, or use "float: right" style with SPAN element. I have not
checked if other variations works: this one does.

What do you think?
-- 
Jakub Narebski
Poland
