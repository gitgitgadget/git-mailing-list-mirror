From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Fri, 8 Aug 2008 16:00:57 -0700
Message-ID: <1621f9fa0808081600i51bcaaedtc22a7a85947ba400@mail.gmail.com>
References: <20080808211318.GA4396@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>, git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Aug 09 01:02:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRayB-0002RG-Fn
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 01:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbYHHXA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 19:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbYHHXA7
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 19:00:59 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:19189 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbYHHXA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 19:00:58 -0400
Received: by yw-out-2324.google.com with SMTP id 9so568727ywe.1
        for <git@vger.kernel.org>; Fri, 08 Aug 2008 16:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jAyH9K0vN1AWZ5y14tRP+Skp3u+DZ91Nwj2BDq0/qpE=;
        b=wqGhFBQPH2Fw29YsEyV6mgt/LAuqt8hPdDWxCQkmtovehcLzyjOW9DwpuLe4HwgZIc
         GN7xbEQMczRJ43BqNi/EODpRfXCnWRa5GTmLeslCLLVECWqLpX0W2fLIq8GJxKS/qilk
         quIw7sgJ3KHnbZH8cyaKpvczZHpXfKOVl80y8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jcss9e9tdrf1+N0mLsNxJOIyaBigzkdPORFygr+ZI0sSQEeZj3oR9TYUx8U+6qVl+/
         rKYMhzEdfg0cbMnHU4jjYfm/9n/oq1tHCibO3QNVv98yvao5iNinEiL+3VXX+5C5LjYe
         DWKPqk/EdOuZc92XcYtdOuiWhMY6HEm1gvipE=
Received: by 10.150.229.16 with SMTP id b16mr2889765ybh.23.1218236457125;
        Fri, 08 Aug 2008 16:00:57 -0700 (PDT)
Received: by 10.150.228.18 with HTTP; Fri, 8 Aug 2008 16:00:57 -0700 (PDT)
In-Reply-To: <20080808211318.GA4396@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91724>

On Fri, Aug 8, 2008 at 2:13 PM, Jan Hudec <bulb@ucw.cz> wrote:
> Hello Marco and others,
>
> I've been thinking about some refactoring of QGit since some time. And to be
> sure I don't screw up things too hard in the process, I thought about adding
> a test suite infrastructure first (and add some test cases for each think
> just before refactoring it).
>
> The problem is, that implementing unittests means I need to compile
> 2 separate binaries -- qgit itself and the test -- using most (but not all)
> of the same sources. I see two ways to do it, so I'd like to ask which you
> consider cleaner:
>
>  1. Reorganize stuff so that a (static) library is created from all the
>    sources except qgit.cpp and than qgit.cpp is linked to this library to
>    create qgit and the tests are linked with it to provide the test runner.
>
>    Pros:
>     - The .pro files should remain reasonably simple.
>     - The sources are only compiled once.
>    Cons:
>     - Need to split the src directory to two, so bigger moving stuff around.
>
>  2. Put the list of sources into file included in the src.pro and include it
>    in the tests.pro file too.
>
>    Pros:
>     - No libraries and stuff
>     - Less moving stuff around.
>    Cons:
>     - The sources actually get compiled twice, once for the tests and once
>       for the qgit binary.
>     - Paths to the sources need to be manually adjusted after including into
>       the .pro files, making the .pro files rather ugly.
>
> There seems to be no solution requiring less changes to the projects, because
> qmake can only create one library or executable per directory and including
> files from other directory is not supported to well.
>
> I've already done the later (have patch series ready), but I am now thinking
> that I should probably redo it the first way. What do you think. Does it make
> sense to do that?
>
> --
>                                                 Jan 'Bulb' Hudec <bulb@ucw.cz>
> --

Maybe you can have a look at QTestLib. But it won't solve your
buildsystem issues. You'll need one .pro per test. (I have one .pro
per test plus one directory per test). There's probably other ways to
using it.

http://doc.trolltech.com/4.4/qtestlib-manual.html#qtestlib
