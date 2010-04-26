From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/3] pretty: add conditional %C?colorname
 placeholders
Date: Sun, 25 Apr 2010 23:14:12 -0500
Message-ID: <20100426041411.GB30566@progeny.tock>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <20100426021347.GA29669@progeny.tock>
 <20100426032642.GA14421@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 26 06:13:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6FhL-0007Ey-Ot
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 06:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849Ab0DZENX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 00:13:23 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:43143 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab0DZENX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 00:13:23 -0400
Received: by qyk9 with SMTP id 9so16698473qyk.1
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 21:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7nv1zEDCN8v3vI9ukkSdAB8SXQZuSJMWd3q4KQpbatg=;
        b=dcnMK1xJN5XJIPF/wtoSuFiova6CAOybbs1J5GM5PsSjx54u4DnoPB9WUupPraI6yx
         G9AXnQgo61b+yDHLrq52XVAqxXMuxdDYHJizcDn2DLLe7EZsbQK0uqQmthvjYEa19yh7
         gRx3sjajcezZkyvg1Zi3e+tLdF0Kik5Dz+hN8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JTceyq3tU3MEZxAIUNgsDZOGXs5iupVnpxKqalgQEXIhdxG3YnhloeA+4HP7ZwEz+P
         QRCnr1OcADJwJi9e+Znb2hol8/GvlMXY+FWCFmL+SGh5SD5m7RekLm4W+uoJF9ej4yXC
         5pmfFmps82VlPNSRNknxaQHhrb3oD3ysxrG44=
Received: by 10.224.87.19 with SMTP id u19mr1042902qal.8.1272255201841;
        Sun, 25 Apr 2010 21:13:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2771677iwn.3.2010.04.25.21.13.20
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 21:13:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100426032642.GA14421@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145788>

Jeff King wrote:

> I am a little nervous that we would be breaking scripts that pipe the
> colorized output for later display to the user. Right now doing
> something like[1]:
> 
>   log=`git log --format=%Cred%h`
>   test "x$log" != x && echo "foo: $log"
> 
> colorizes, but we would be breaking it. And for new values like
> %C(diff.commit), we are not breaking anything (because it is a new
> syntax), but a script like the one above may want to convert, and there
> is no way to say "respect the color _config_, but don't respect
> isatty(1)". Saying "--color" doesn't work, because it overrides the
> color config. We can cheat a little with GIT_PAGER_IN_USE, but that will
> have funny interactions with pager.color.

Very interesting.  I think the natural solution (for new colors) would
be a --color=config option, which would require parsing options before
checking configuration.

Does this sound sane?

Jonathan
