From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Test script style (Re: [PATCH 08/18] git notes merge: Initial
 implementation handling trivial merges only)
Date: Wed, 6 Oct 2010 23:37:21 -0500
Message-ID: <20101007043721.GD2285@burratino>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
 <1285719811-10871-9-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bebarino@gmail.com, gitster@pobox.com,
	avarab@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 06:40:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3iHX-0006WB-Np
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 06:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab0JGEkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 00:40:31 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52889 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab0JGEka (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 00:40:30 -0400
Received: by gxk9 with SMTP id 9so133412gxk.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 21:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=F/ZGIk9Lnw42BUBcQDWwbg5HjcTjLfWKsrHIhM/YVXU=;
        b=hYvpdsQh2ADyj2fpiFaatTpNs3YjP9yCrNA3pxiUZox6q0nPPCWENK6IBtBF98DDQv
         sW8QDdbPXlSMXH1u/t5MWagM32Q4iOPMlGrseib5fi9Xvv8nBkbhKVMsP2X6PG//SAGZ
         7rtlDfMcukWVkrqjprcDcbkhUQI9c3TAPibVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iilKdRAJWoJxXrOQOPMyrGEbSfSlq+M2VZ267mE/UiH1OuQte7BqqXbMoEh4OAsetV
         xFtsuFRFhmPruXIAZoosWiQZIfqztF1hcgRVV+nYo6lpNChyvtiHTG8CD3beEDcyrsIj
         kUbKd08Z5IcN1U5mikV2vCuj4GHrQ3ND6w4tw=
Received: by 10.101.67.8 with SMTP id u8mr358648ank.40.1286426428051;
        Wed, 06 Oct 2010 21:40:28 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id c32sm1014962anc.1.2010.10.06.21.40.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 21:40:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285719811-10871-9-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158367>

Johan Herland wrote:

> This initial implementation of 'git notes merge' only handles the trivial
> merge cases (i.e. where the merge is either a no-op, or a fast-forward).

Mm, sounds like a nice thing to have anyway.

Now to digress: some generalities about test scripts.  This will
probably be very tedious.  I'm writing it as groundwork before
reviewing your test (since I don't feel on solid ground about this
topic at all).

More focused thoughts on other aspects of the patch will follow in a
separate message.

First:

	See http://thread.gmane.org/gmane.comp.version-control.git/155596/focus=155673
	If you don't like what you see, no need to read the rest
	of this message. :)

Motivation:

	Not being the best of shell script readers (or writers,
	for that matter), I need all the help from stylistic cues
	I can get.  Old test scripts have a consistent style
	generally, but newer ones are starting to diverge from
	one another.

A rough test format:

	#!/bin/sh
	#
	# Copyright (c) 2010 ...
	#

	test_description='...
	. ./test-lib.sh
	. ...

	constant data
	function definitions

	setup }
	test  }
	test  } repeat as necessary
	test  }

	test_done

Test description:

	test_description = 'One-line description

	Some words or diagrams describing the invariants (e.g., history)
	maintained between tests'

Constant data:

	Simple commands to produce test vectors, expected output, and
	other variables and files that it might be convenient to have
	unchanged available throughout the test script.

	Because not guarded by a test assertion, this section would
	not include any git commands, nor any commands that might fail
	or write to the terminal.  So: this section might use
	"cat <<\", "mkdir -p", "cp", "cp -R", "mv", "printf", "foo=",
	"unset", and "export", but not much else.

Function definitions:

	Tests can define functions inside a test_expect_success block,
	too, but the generally useful functions would go up front with
	the constant data.

Setup:

	test_expect_success '(setup | set up) ...' '
		Commands to set up for the next batch of tests.
		Can rely on previous setup and can do just about
		anything.
	'

Tests:
	test_expect_success|failure '... some claim...' '
		Commands to test that claim.
		Could do all sorts of things, as long as they do not
		disturb the invariants established by the
		constant_data and setup sections.
	'

What is not present:

	A test in this style would not include any commands except for
	test_done outside a test assertion after the first
	test_expect_success.

This is meant to be a sort of compromise between what t/README says
("Put all code inside test_expect_success and other assertions") and
what people actually do.  I have no problem with people doing
something else --- in fact, some tests would not make any sense in
this style.  In general, if a person is writing maintainable tests
that do not slow down "make test" by much, it does not make much sense
to put new obstacles in her way.

What I expect is that new tests would be easier to read and extend in
this style, since to get started, all a person has to pay attention to
are the setup commands.  So a potential collaborator could say "if you
use this structure, it will make my life easier".

Thoughts?  Would it make sense to eventually put something like this
in t/CodingStyle or nearby?
