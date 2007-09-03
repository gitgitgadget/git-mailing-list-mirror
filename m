From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Fix file name quoting in simplified out patch detection for --cc output
Date: Mon, 3 Sep 2007 11:52:51 +0200
Message-ID: <200709031152.51373.jnareb@gmail.com>
References: <200709022222.13865.jnareb@gmail.com> <7vabs4oaxh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 12:52:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS9XH-0007Na-LY
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 12:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbXICKv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 06:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754191AbXICKv4
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 06:51:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:7004 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645AbXICKvz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 06:51:55 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1173352nfh
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 03:51:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TKvQMsoQL8bmypuFWWb4Tdaiv+xUxIGxBj9Whk4i9Hq93yAi1nPysFkTn7/AtIH8gKxljWAp4xszoe47WsVlaRl06iEgA7p6MRXglgVurpl8vyHU3o5KtRtpBNcDy1LYoih8/NJnFOzzRp0lDPiMOxSi7jZd1V0vZU4kwiWzIio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ExSo4C8mE4mLOkgPwAe/mnt1OEhNJLTXnTso7Pyhb4xv4kP/bu28S4XQ1kokoIhHrqA+LWA6jGcd7ikUgIuwQuZcDKU3HKvzp5vfCCkdWTyif9xHUcX0tmsvhRIyltWHG2zHaqByKBPC2Ecy473KzAMA1xaL/EwrVxC463ofsh8=
Received: by 10.78.183.15 with SMTP id g15mr3111598huf.1188816713913;
        Mon, 03 Sep 2007 03:51:53 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id p30sm1044865hub.2007.09.03.03.51.51
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Sep 2007 03:51:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vabs4oaxh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57465>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 8c1e02c..5d424e5 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -3140,8 +3140,8 @@ sub git_patchset_body {
> >  			# compact combined diff output can have some patches skipped
> >  			# find which patch (using pathname of result) we are at now
> >  			my $to_name;
> > -			if ($patch_line =~ m!^diff --cc "?(.*)"?$!) {
> > -				$to_name = $1;
> > +			if ($patch_line =~ m!^diff --cc ("?.*"?)$!) {
> > +				$to_name = unquote($1);
> >  			}
> 
> This patch obviously makes sense, but I wonder why you use the
> form m!foobar! here, instead of far simpler to read /foobar/
> form?

Consistency (kind of). For the ordinary diff output I use m!regexp!
instead of simpler /regexp/ to avoid 'leaning toothpicks' syndrome:

  m!^diff --git "?a/.*"? "?b/.*"?!

But as it is now not near, then I guess /regexp/ would be better...

-- 
Jakub Narebski
Poland
