From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] Add proof-of-concept %[w(width,in1,in2)<<any-string>>%] implementation
Date: Sat, 17 Oct 2009 00:19:59 +0200
Message-ID: <200910170020.01756.jnareb@gmail.com>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com> <m33a5jfc6p.fsf@localhost.localdomain> <7v3a5jupr7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 00:19:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myv8X-0007cd-Oh
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 00:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbZJPWSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 18:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbZJPWSq
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 18:18:46 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:57850 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbZJPWSq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 18:18:46 -0400
Received: by fxm18 with SMTP id 18so2975259fxm.37
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 15:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PzNfWLpKD1l8NdM1H+VcjETML80gFE5wpGlEUKFQHhs=;
        b=skW0EKFxN6F5ZI01jM64PPmsGcv/7gPUnkSKWicF4nEODuxTEdz9sBZESXSqcTjwLu
         mNbgQcgcgM4EIaHaFonZ9XBEE0D2cJrp+116tq1kqfGtixGKRnsMoiFCyoeXLkvLbGmh
         peDwq+fmmV+/aD5uRTQ6JfOUD38k2a8IYMLTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=kwaSwZyfGY5LAoO1Aq4UTRV+S47gU4+hjXKWMDTd42PZ+ti/PUR2rqI9+hdA28tsCq
         pkkGxyDzfgywvK5ajxwC+xcR7rmjxF3RXKUp0rENJTFsmct22TRx3v/nEfDxAO7t2FY2
         rtixy3zVCTgIba6RFamsQzUIA9otoWry/Kwvg=
Received: by 10.204.10.6 with SMTP id n6mr1883745bkn.27.1255731529410;
        Fri, 16 Oct 2009 15:18:49 -0700 (PDT)
Received: from ?192.168.1.13? (absh57.neoplus.adsl.tpnet.pl [83.8.127.57])
        by mx.google.com with ESMTPS id 14sm280891bwz.9.2009.10.16.15.18.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Oct 2009 15:18:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v3a5jupr7.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130531>

On Fri, 16 Oct 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > I don't remember what were original parameters to w(72,4,8) means...
> 
> "man git-shortlog" look for -w.

Thanks.  So those would be:

-w[<width>[,<indent1>[,<indent2>]]]::
        Linewrap the output by wrapping each line at `width`.  The first
        line of each entry is indented by `indent1` spaces, and the second
        and subsequent lines are indented by `indent2` spaces. `width`,
        `indent1`, and `indent2` default to 76, 6 and 9 respectively.

I think better solution might be to give _string_ to use for initial and
subsequent indent rather than number of spaces... well, at least more
generic one, allowing one to use e.g. "\t" (TAB) character to indent,
or indent in the following way:

 * Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
   tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
   veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
   commodo consequat. [...]

But even with original w(<width>,<indent1>,<indent2>) we can get output
of bare "git log" using pretty format... well, almost; it would be the
same if there was ability to put infinite width, and there doesn't seem
to be specifier for the whole, unchanged commit message (subject,
unwrapped + separating lines + body).

-- 
Jakub Narebski
Poland
