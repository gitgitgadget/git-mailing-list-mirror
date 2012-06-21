From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] submodule: Tolerate auto/safecrlf when adding .gitmodules
Date: Thu, 21 Jun 2012 21:06:28 +0200
Message-ID: <4FE370B4.60404@web.de>
References: <cover.1340202515.git.brad.king@kitware.com> <eebc8b3692f8fcb95cf75278f7c9f9982e8f2cd6.1340202515.git.brad.king@kitware.com> <4FE20DD3.6040607@web.de> <4FE21133.2030001@kitware.com> <20120620191132.GB31520@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 21 21:07:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shmiv-0002VZ-5G
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 21:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759929Ab2FUTHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 15:07:11 -0400
Received: from mout.web.de ([212.227.17.11]:59287 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759873Ab2FUTHG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 15:07:06 -0400
Received: from [192.168.178.48] ([91.3.170.98]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0LbrQm-1S0zhL3MMG-00jQrK; Thu, 21 Jun 2012 21:06:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <20120620191132.GB31520@sigill.intra.peff.net>
X-Provags-ID: V02:K0:t7oLJqUBqZe4QYLUoLp/r+aCFBojC+KUJKw9bbM5EYE
 4JXVUDaXQfA9Ndo1S0jQqODJz3IJTkFV5V7br/Omg0kbqHadns
 6xXYlVa1caA4sxWaA444kshhLFRVjBXIgGFySoE2ak9sX1JLEZ
 VKy21VO+Dha9iNw9Oco3Ki92HQQZg7cgVHDth1TUOfq6wn1uVa
 PpSdoBITKmM6uoyNMvAfA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200414>

Am 20.06.2012 21:11, schrieb Jeff King:
> The only sane thing is to have a canonical in-repo representation.
> Fortunately we already have the infrastructure for that, and in theory
> it should be as easy as adding ".gitmodules text" to our built-in
> gitattributes (you could even do "eol=lf", but I don't see a reason not
> to respect the native line endings in the working tree, given that git
> can handle the CRLFs just fine).
> 
> I say "in theory" there because I am not sure whether specifying a file
> as definitely text via attributes will actually suppress the safecrlf
> check or not. IMHO, it should, since safecrlf is really about preventing
> false positives via autocrlf or text=auto.

A quick test shows that unfortunately theory differs from practice here.
Adding ".gitmodules text" to the built-in gitattributes lets the test
Brad wrote still fail. You have to use ".gitmodules eol=lf" to make it
pass. I stopped digging deeper at this point.

> I don't see any reason for each individual repo to have to add these
> attributes manually. This is a git-specific file, and the format is
> dictated by git. We know that it's a text file, so why not help out the
> user? We should possibly do the same thing for .gitattributes and
> .gitignore.

I really like this approach. (And in the long run would like to see a
ini-file aware merge driver being used for the .gitmodules file too,
which would just merge submodules added in different branches instead
of producing a conflict)
