From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] build dashless "test-bin" directory similar to
 installed bindir
Date: Sat, 28 Nov 2009 11:44:39 -0800
Message-ID: <7vtywefn88.fsf@alter.siamese.dyndns.org>
References: <1259433537-3963-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1259433537-3963-4-git-send-email-mmogilvi_git@miniinfo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Sat Nov 28 20:44:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NETE1-00079B-TX
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 20:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbZK1Top (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 14:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZK1Top
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 14:44:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbZK1Top (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 14:44:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A597C831D5;
	Sat, 28 Nov 2009 14:44:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fLsx5CDhNSc+9JDtWPvDsoak4OE=; b=iS+wTS
	KX6NTEKkTj//rE0JFPAl5JEPMfUoCGBfFvypNtDjrI9n6h72YOE4OWGyAuZDFjvf
	6b/oC5q4fuoyFfOjiDxBfkAwDFPuuD1UYdATk975pWzU8Ha5Xq/tiQZo/LPo/u04
	0wT9obkWNWY0mDxrI5oLzFoWl6ODLGSanaXos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fdcN+3I6bvba6rJbD1Iivhv8Me6pEGHC
	H0HtcEyoX8oV5rB/BsnaoXQW/dtKyQxQaapBQ9KANf0Trt+E/Q/vLvVWCS0oU0RA
	HhNmJqRG9h56eT4a1lGJfP7fpuNGvj5EmyDYeu0hiFaVtbl6ouUUQtwP2PCOVYFi
	ljxPidT5JMc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3E27831D4;
	Sat, 28 Nov 2009 14:44:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67452831C9; Sat, 28 Nov
 2009 14:44:41 -0500 (EST)
In-Reply-To: <1259433537-3963-4-git-send-email-mmogilvi_git@miniinfo.net>
 (Matthew Ogilvie's message of "Sat\, 28 Nov 2009 11\:38\:56 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7B0A39C4-DC56-11DE-B330-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133970>

Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:

> The new test-bin directory contains wrapper scripts for executables that
> will be installed into the standard bindir.  It explicitly does not
> contain most dashed-commands.  The scripts automatically set environment
> variables to run out of the source tree, not the installed directory.

Even though I haven't tried the series, I like most of the things I see in
this series.

 - Patch #1 and #2 are good and are independent from the later patches, as
   without them running tests with GIT_TEST_INSTALLED would not work.

   By the way, 6720721 (test-lib.sh: Allow running the test suite against
   installed git, 2009-03-16) failed to document the feature in t/README.
   Could you please fix this while you are at it?

 - Running tests before installation in an environment slightly closer to
   the final installation (i.e. lacks dashed commands in the $PATH during
   the time tests are run) is a good direction to go.

 - I like the Makefile changes that uses these new BINDIR_PROGRAMS_NEED_X,
   TEST_PROGRAMS_NEED_X.  Parameterizing commands listed in the actions
   part is good.

 - It certainly is _possible_ to add $(pwd)/test-bin to $PATH instead of
   the established practice of using GIT_EXEC_PATH for every day/permanent
   use without installation, but I doubt we should _encourage_ it for a
   few reasons:

   . The set-up will force one extra exec due to the wrapper; this is good
     for the purpose of running tests, but unnecessary for a set-up for
     every day/permanent use by people, compared with the already working
     approach.  The user needs to change an environment variable _anyway_
     (either GIT_EXEC_PATH with the traditional approach, or PATH with
     your patch).

   . The new component to be added to $PATH shouldn't be named "test-bin/"
     if it is meant for every day/permanent use.

   . Advertising this forces the Makefile build test-bin/ contents from
     "all" target.  I think test-bin/ should only depend on "test" (iow,
     after "make all && make install" there shouldn't have to be "test-bin"
     directory.

   I would rather treat it an unintended side-effect that you can add that
   directory to the $PATH.  It is designed to work in such an environment
   (otherwise the tests won't exercise the version of git they are meant
   to test), but I do not think it is _meant_ to be _used_  by end users
   that way.  And an unintended side-effect does not have to be mentioned
   in INSTALL (especially with the directory name with "test" in it).
