From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Wed, 3 Oct 2007 08:50:18 +0100
Message-ID: <200710030850.19614.andyparkins@gmail.com>
References: <20071002155800.GA6828@coredump.intra.peff.net> <200710021916.44388.andyparkins@gmail.com> <20071002191104.GA7901@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 09:50:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icz07-0005rm-7f
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 09:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbXJCHu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 03:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbXJCHuZ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 03:50:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:11445 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbXJCHuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 03:50:25 -0400
Received: by ug-out-1314.google.com with SMTP id z38so72789ugc
        for <git@vger.kernel.org>; Wed, 03 Oct 2007 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=KWW6oPd1Loyz5vPHwAjXpAM5ocaZ8d3wjfwekpSpY0I=;
        b=WKRZwLu/xsd1JcL+YOsdhC4aexTJBEnvEskFhdLcVmjcYYu27gGhs9s/JL11iLcTHnRQMSS8IYPzuveyYRkZt1zA9MHCxmwJfh3OX73Km4nPWR4Fk5OtBbOgx41lKo66I3WzEO6bCl5+oC10cQXLOOLHkH9VqtI40EC1FX4tvpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JNOkhrM57DBsI6sBUJo3bNE5GlhiXDfdlnKy3KiXkBXJJ/mizGklxvO11UIkGt2mQUPbBf9iWPRdARylbg7tLPRSSuXOi9N0k+OAv6IlzFwMccOrHK1gJSdVIuUqw4uADPnrL1tv+cjk9ftG2bn/Tyojv4pcZ/cC219XLNXldDc=
Received: by 10.66.242.19 with SMTP id p19mr173905ugh.1191397822606;
        Wed, 03 Oct 2007 00:50:22 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id z37sm112156ikz.2007.10.03.00.50.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Oct 2007 00:50:21 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20071002191104.GA7901@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59804>

On Tuesday 2007 October 02, Jeff King wrote:

> > -		if (prefixcmp(head, "refs/heads/"))
> > -			die("HEAD not found below refs/heads!");
> > -		head += 11;
> > +		if (prefixcmp(head, PATH_REFS_HEADS))
> > +			die("HEAD not found below " PATH_REFS_HEADS "!");
> > +		head += STRLEN_PATH_REFS_HEADS;
>
> This slightly changes the message (extra "/"), but I don't think that is
> a big deal...

Actually, I felt that was an improvement.  Personally I always like paths 
shown to a user to have the trailing slash so that they can be clear that it 
is a path not a file.

> > -	strcpy(path + len, "refs");
> > +	strcpy(path + len, PATH_REFS);
> >  	safe_create_dir(path, 1);
> > -	strcpy(path + len, "refs/heads");
> > +	strcpy(path + len, PATH_REFS_HEADS);
> >  	safe_create_dir(path, 1);
> > -	strcpy(path + len, "refs/tags");
> > +	strcpy(path + len, PATH_REFS_TAGS);
> >  	safe_create_dir(path, 1);
>
> ...but here it's not immediately obvious if the extra trailing "/" is
> OK. Looks like the path just gets handed off to system calls trhough
> safe_create_dir, and they are happy with the trailing slash. But it is a
> behavior change.

It's been a while, but at the time I did it I think I checked 
safe_create_dir() to be sure that it was happy with trailing slashes.

> I find the 'PATH_REFS_TAGS "%s"' (with a space) you used earlier a
> little easier to read.

Okay.

> > -	if (len < 5 || memcmp(name, "refs/", 5))
> > +	if (len < STRLEN_PATH_REFS || memcmp(name, PATH_REFS,
> > STRLEN_PATH_REFS))
>
> I imagine this was one of the times you mentioned before where prefixcmp
> would be more readable. I would agree.

It is.   A patch to fix these is in my pending list.

> > -	strcpy(posn, "/objects/");
> > +	strcpy(posn, "/" PATH_OBJECTS);
> >  	posn += 9;
>
> should be posn += 1 + STRLEN_PATH_OBJECTS ?

Well spotted.  Fixed.

> > -	url = xmalloc(strlen(repo->base) + 64);
> > -	sprintf(url, "%s/objects/pack/pack-%s.idx", repo->base, hex);
> > +	url = xmalloc(strlen(repo->base) + STRLEN_PATH_OBJECTS + 56);
> > +	sprintf(url, "%s/" PATH_OBJECTS "pack/pack-%s.idx", repo->base, hex);
>
> The '56' is still quite hard to verify as correct ("/" + "pack/pack-" +
> ".idx" + "\0"). But I wonder if trying to fix that will just make it
> harder to read (perhaps a comment is in order?).

I put a comment above the other changes like this in the same file, but 
thought I was being overly verbose putting it in every single time.  I'm 
happy to copy the comment around in the file though.

> Or maybe using a strbuf here would be much more obviously correct?
>
> > -	url = xmalloc(strlen(base) + 31);
> > -	sprintf(url, "%s/objects/info/http-alternates", base);
> > +	url = xmalloc(strlen(base) + STRLEN_PATH_OBJECTS + 23);
> > +	sprintf(url, "%s/" PATH_OBJECTS "info/http-alternates", base);
>
> Also a potential strbuf. Ther are more of this same form, but I'm not
> going to bother pointing out each one.

I was trying, as far as I could, to leave the code unchanged.  If strbuf would 
be better I think I'd rather do it with another patch after this.

> Man that was tedious. But I think every other change is purely
> syntactic, so there shouldn't be any bugs.

It really was wasn't it?  :-)   While I was trying to find that bug that you 
caught yesterday I thought I was going blind.  I have this to say though: 
thank heaven for git's colourised diffs.  Those that think coloured output is 
just for prettiness sake should try that review with and without.

Thank you for expending so much effort on this, it is appreciated.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
