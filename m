From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: use new Git::Repo API, and add optional caching
Date: Tue, 15 Jul 2008 03:50:10 +0200
Message-ID: <487C0252.4030804@gmail.com>
References: <4876B223.4070707@gmail.com> <200807150114.44402.jnareb@gmail.com> <487BE7C4.2050207@gmail.com> <200807150252.52604.jnareb@gmail.com> <487BFA67.3020304@gmail.com> <alpine.LSU.1.00.0807150326050.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 15 03:51:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIZhE-0007Y0-39
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 03:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732AbYGOBuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 21:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756360AbYGOBuQ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 21:50:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:37855 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173AbYGOBuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 21:50:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2200044fgg.17
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 18:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=uMFreSDkwfpe41e69QDGD1lDyXMlRlYVloWvfHv7VdE=;
        b=SH+63nT4Qaor3TWXz69FkFWYTm7fwsFIAenq6TwL0Zlngx7yX/JhR57tM9esDeQQcY
         hysBL4AQT6aiYe9dW/9KDx3/PLqKlIVg53Sb0DG8Zf/ueCxPYCSmktDd4Mkga2aRr0iS
         rV4WiE96ny+Bzry3mSHnfFm5/5/ovRUlvYC0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=MfUMI+jaqaKU0PW/rYlWMnRqowE6A5eGFKC9LaxseZFJROb3C4L2whMAsqEToJaa+s
         PohEi8yq/2syrPg09YWXawgwIEYqg8UWvpFI3U4pk1TYnPL/X3V54Ki/h5s5z459IPA3
         T9Bb9S71oNz7q6bBxxCeYUd6QHOk1t9E8XHIY=
Received: by 10.86.23.17 with SMTP id 17mr15223886fgw.32.1216086613584;
        Mon, 14 Jul 2008 18:50:13 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.226.181])
        by mx.google.com with ESMTPS id 3sm4371770fge.3.2008.07.14.18.50.11
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jul 2008 18:50:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <alpine.LSU.1.00.0807150326050.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88497>

Johannes Schindelin wrote:
> Wasn't the main page (i.e. the projects list) the reason why kernel.org 
> has its own little caching mechanism in the first place?
> 
> And did Pasky not report recently that repo.or.cz got substantially less 
> loaded with some caching of its own?

Yes, you need *some* caching mechanism.  Once you have that, it's fine,
at least if the page cache is hot.  (The x-thousand stat calls that my
caching implementation issues don't actually take that much time; I
suspect the ~1000 calls to memcached are the more expensive [and
optimizable] part, though I'd have to benchmark that.)

Mainline vs. my caching implementation (both with hot page cache) on
odin3.kernel.org:

$ time wget -qO/dev/null http://localhost/git-lewiemann/vanilla/
real    0m3.070s
$ time wget -qO/dev/null http://localhost/git-lewiemann/
real    0m0.719s
