From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/WIP/PATCH v2] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Sun, 15 Jun 2008 20:01:34 +0200
Message-ID: <200806152001.34350.jnareb@gmail.com>
References: <200806141447.28052.jnareb@gmail.com> <1213487844-685-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 20:02:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7wYl-0006i4-In
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 20:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758763AbYFOSBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 14:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758735AbYFOSBl
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 14:01:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:63964 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758686AbYFOSBk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 14:01:40 -0400
Received: by ug-out-1314.google.com with SMTP id h2so286566ugf.16
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 11:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9mOSpleR2NfpTuJFHVTDN5BC4RRBpEi+4IIqBBHVNYc=;
        b=Pudbl9/sNxGx/HUwsIu3I8Y+4cKii0/95LZxkzDOsllNE3/bBY5+DSK9b8WZWvxbRk
         mXigsHs/iGl3N59BnfvJAEzta3Fmxq8x2EprUjXfjTqXzFIMrYeJsw1F2LwMhqYkjPc6
         /XNfoZCkQDsjXHFpreDeY05zrwMc0D50xkbJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KqBY5CBsPSzw3UK8mPpA4u3rTZo7TbqwBlm44ZogC7Gw1VYBQGWfPMs0Q/1M/HJ7M3
         HLb66RONkwN506yK+zurICNIdbVZWFAuEHLNHZ6LSnu5/jbAvNGvjfh6cXl2znn27Dep
         uhECHsrCj6bSw4fige4axBNSKrjBuVDupFi/8=
Received: by 10.67.88.12 with SMTP id q12mr4844898ugl.54.1213552896592;
        Sun, 15 Jun 2008 11:01:36 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.223.105])
        by mx.google.com with ESMTPS id u1sm6836986uge.75.2008.06.15.11.01.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 11:01:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1213487844-685-1-git-send-email-LeWiemann@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85104>

Lea Wiemann wrote:

> Changed since v1:

> - Use test_external instead of test_external_without_stderr so that
>   the test doesn't fail if there is output on stderr.
> 
>   Discarding and restoring STDERR (proposed in a recent message)
>   doesn't work with Mechanize, as Mechanize somehow seems to save the
>   STDERR handle and reuse it, so subsequent calls to Mechanize keep
>   using the discarded STDERR.  (The discard/restore functions work
>   fine in other test modules, it's really just Mechanize here.)

Actually I think it is CGI module itself catching and redirecting
STDERR from Perl to logfile, and WWW::Mechanize::CGI having to catch
and redirect all stderr of invoked application, but I'm not sure.


What should we think about now, I guess, is
1.) Should we put all tests in one file, or should they be split
    according to what do they test?  For example separate tests
    for correct 4xx and 5xx responses for requests for non-exiting
    objects, and for not permitted views.

2.) What invariants should we test, beside obvious HTML validation
    using HTML::Lint (by the way, is there some Perl module for RSS,
    Atom and OPML validation?).  Checking for example if all items
    are listed in a 'tree' view, or if all inner links (#link) are
    valid would be a good start... pity that Mechanize modules don't
    have very good documetation.

3.) What invariants you want to test for your caching efforts, e.g.
    checking (not necessary with TWM::CGI) if cached output matches
    non-cached, with exception of marking output as cached?

-- 
Jakub Narebski
Poland
