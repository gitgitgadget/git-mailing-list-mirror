From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Sun, 17 Aug 2008 09:57:36 +0100
Message-ID: <e5bfff550808170157m45532428y3956e5d0d92e97d9@mail.gmail.com>
References: <20080808211318.GA4396@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Aug 17 10:58:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUe64-0005dw-4c
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 10:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbYHQI5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 04:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbYHQI5i
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 04:57:38 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:58938 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbYHQI5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 04:57:37 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1020648waf.23
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 01:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=MKBgPhvtyvguo1l/ogtKlr7+zh6rTNz95tKX2u1Sr1A=;
        b=brgho0tZ7g+UXu9rQ2PL7XXrKFSPiv2z2Qs6/A3/9MpNCp9Mi7TU9zedoybsl6tn4a
         VjoemXnMmYLp3+oP6QenfqKbKgxp5+7LMpkSfjRxBNWHIhMDswuJBirmvPdFQSZavvSY
         RajCi4G4cnyzCQFkD3M/MUdXmY8Q5NVk33FPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=i15Bf/90fYKrr2ctZQHdFwXfuYlpQNsWnma1jG2vedQIVjtkwaeJp8L8Kj0d0vCacm
         Xhcp1j1TWiZxSw3fFUs0OFv+LQnAhdus7TAKcBpgoI6BvE4sEfMEHWY2B9rh8pzOTYMV
         KzIc9vNOwTSBSmujYglTeDd6LXLV60vNCe140=
Received: by 10.114.81.1 with SMTP id e1mr4094153wab.11.1218963456701;
        Sun, 17 Aug 2008 01:57:36 -0700 (PDT)
Received: by 10.114.174.5 with HTTP; Sun, 17 Aug 2008 01:57:36 -0700 (PDT)
In-Reply-To: <20080808211318.GA4396@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92586>

On Fri, Aug 8, 2008 at 10:13 PM, Jan Hudec <bulb@ucw.cz> wrote:
> Hello Marco and others,
>

Hi Jan,

  sorry to reply so late but I just returned from holiday (no PC there
due to it was severely forbidden by my boss aka wife :-)


> I've been thinking about some refactoring of QGit since some time. And to be
> sure I don't screw up things too hard in the process, I thought about adding
> a test suite infrastructure first (and add some test cases for each think
> just before refactoring it).
>

That's interesting. I have NO experience on test suites for GUI
applications (command line applications like git I would think are
easier to setup some tests suite for)


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

This is not a cons IMHO if it helps in separating tests from sources.

As I said I am no expert, but I would try to

- Let the test suite be easily stripped/not compiled for the
publishing (remember that we have to produce also that little
qgit_install.exe file used on *that* OS)

- Let the test be compiled only on demand (during developing I just
want to compile and run as few things as possible: C++ is already
quite bad in that regard and I don't want the situation get worst. BTW
I consider C++ slow compile times the biggest and probably only
drawback of C++ against C for big projects)

- Try to find some literature/reference before starting coding. As I
said I am no expert of GUI testing, so I would probably try to find
some Qt projects that use it and see/ask the developers how they
managed to do that and what are the problems. Then try to be stick to
known best practice (read someone that has DONE that in a REAL
project, not someone that has WRITTEN about that in a paper or a
vendor marketing/documentation)

Anyhow I'm really interested in this thing, and hope to see your work
soon. Please feel free to drop me a line for any help you think I can
give you.

Bye
Marco
