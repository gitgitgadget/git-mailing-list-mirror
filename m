From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/2] test_terminal: check that TTY prerequisite is
 declared
Date: Thu, 14 Oct 2010 15:37:21 -0500
Message-ID: <20101014203721.GA28958@burratino>
References: <20101014030220.GB20685@sigill.intra.peff.net>
 <20101014030505.GC5626@sigill.intra.peff.net>
 <20101014031642.GB14664@burratino>
 <20101014033448.GB28197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <jrk@wrek.org>
X-From: git-owner@vger.kernel.org Thu Oct 14 22:41:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Ubi-0003Bw-IP
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 22:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023Ab0JNUkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 16:40:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36694 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755925Ab0JNUkw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 16:40:52 -0400
Received: by wwj40 with SMTP id 40so98576wwj.1
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=L67T8dB5WcOn5YNw/YSHKvIxuGW2m0oIqzCPCtxdU6o=;
        b=hnQ10hJT3UGI1hkOiYsFCgO/1XobwRtGBAy56o7Rlsn95BiFqsaZqUjfp6k8HfoF3W
         1y0BooTIZNT7MeaUr/5MztveR6/2K4A+3aZoWxl2SRBL4IA8U9XZo1tDMqsjlEfxlYd7
         tkX46ANB3OZaZeff2Qn86bAGezqL45HvbIVW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aju74t4/ubmZ9sL7/jSTMgY2CWlMNaq+CTalUxwGHvCZaOPN4oJC7OJp2h8u/seIZg
         2PO/AlVn1+hNFyHSnhh/Oz/vfwWrOtXJRPDenZJE59/fvSfDDovhxSfkhfj+HAlfgwZ/
         R2GuevMwXNSrleK4eGi/IUUgdjnbG2F41PGyk=
Received: by 10.216.59.131 with SMTP id s3mr2903804wec.71.1287088850467;
        Thu, 14 Oct 2010 13:40:50 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id l14sm2254000weq.35.2010.10.14.13.40.47
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 13:40:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101014033448.GB28197@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159071>

Jeff King wrote:
> On Wed, Oct 13, 2010 at 10:16:42PM -0500, Jonathan Nieder wrote:

>> Missing TTY prerequisite.  (Do you think test_terminal should check
>> $prereq to prevent this?)
>
> Oops, good catch. I think we should already catch it, as test_terminal
> will not be defined at all in the no-tty case. We could print a nicer
> message, but

I rather meant something like this.

Patch 1 exposes the internal $prereq variable from
test_expect_(success|failure).  Maybe it should be called
GIT_TEST_something to avoid trampling other programs' namespaces?  Not
sure.

Patch 2 introduces some magic autodetection so people that never run
tests without -v can still notice the missing TTY prereqs.

Jonathan Nieder (2):
  test-lib: allow test code to check the list of declared prerequisites
  test_terminal: catch use without TTY prerequisite

 t/t7006-pager.sh |   20 ++++++++++++--------
 t/test-lib.sh    |   26 +++++++++++++++++++-------
 2 files changed, 31 insertions(+), 15 deletions(-)

-- 
1.7.2.3
