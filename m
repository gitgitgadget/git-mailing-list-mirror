From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 1/2] fast-import: test behavior of garbage after mark
 references
Date: Wed, 4 Apr 2012 00:43:17 -0500
Message-ID: <20120404054316.GB2460@burratino>
References: <20120401225407.GA12127@padd.com>
 <1333417910-17955-1-git-send-email-pw@padd.com>
 <1333417910-17955-2-git-send-email-pw@padd.com>
 <20120403140055.GC15589@burratino>
 <20120404004610.GA4124@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 07:43:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFJ0V-0008DF-LP
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 07:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428Ab2DDFnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 01:43:21 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57494 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab2DDFnU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 01:43:20 -0400
Received: by iagz16 with SMTP id z16so680070iag.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 22:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rz+1IzujjJyXneFu4KJHrDueTW0XeoVUbFxR6G9Vnzs=;
        b=EKMAs+smIKgb17d3ZYokS8H0JK0x4beZohDgiIbEqAJVlziwIUByEIUkRdPFFvTBio
         XgRkirWDlXxXVdtSrMhmt97lGmXgrwAgIQyQ++WiT+6x6uKTSres9kZt7OuvdmXKgwkt
         MYFlmVhchI5ja6wTFJuDJzoUmABxtx+5sAZiTG9R5TPwBQevdLrjF5A2w86RaKRXO4SD
         KJIY5wJweACUtWT7Y+9dhe5Jyf1ybJYWPYwKSCz4nl0IZITI1l3ph19E8tDAqw99JVBG
         x05ZX/hYlPgCbFQUL5jwWwnmhV9gKGAJ2KvfHNfdeSpwDrc5ebHunBlTFHs0D/xkXO4P
         5/2Q==
Received: by 10.50.6.167 with SMTP id c7mr579444iga.4.1333518200292;
        Tue, 03 Apr 2012 22:43:20 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gf4sm1253665igb.14.2012.04.03.22.43.19
        (version=SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 22:43:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120404004610.GA4124@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194679>

On Tue, Apr 03, 2012 at 08:46:10PM -0400, Pete Wyckoff wrote:
> jrnieder@gmail.com wrote on Tue, 03 Apr 2012 09:00 -0500:

>> Is this using "grep -q" to avoid repeating the same line in the output
>> twice?  It seems better to use plain grep or test_i18ngrep.
[...]
> What I want to test here is that the functionality works: do the
> right untranslated messages get printed.
>
> Changing the "Missing" to "missing" would require fixing the
> tests, and that seems okay.

Let me reiterate this a little then.

Suppose I mark the messages in fast-import.c with _() so they get
translated.  Then your tests will fail, so I have to tweak them.  Fine
--- the test tweaks take some time, but they're doable.  Nothing lost,
right?

No, something major would be lost.

Tests normally save later coders time, by giving immediate feedback
that they would normally only get by letting a feature be used over a
long time by real users.  They also dissuade people from changing
git's behavior without thinking carefully about the consequences ---
each broken test represents a class of script or user expectation that
is potentially being broken.

Similarly, a test that checks that git produces such-and-such exact
output is dissuading me from making certain behavior changes by adding
to the work needed to make them (I have to adjust tests, too).  So now
I am less likely to

 (1) reword the message to make it clearer in some way in response to
     user feedback

 (2) mark it for translation so the operator can see a message in her
     native language

How is making that hard in any way a good thing?

Relaxing the pattern addresses (1).  Using test_i18ngrep instead of
grep addresses (2).

Jonathan
