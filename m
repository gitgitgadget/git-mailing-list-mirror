From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Modified test-lib.sh to output stats to
 /tmp/git-test-results
Date: Sun, 08 Jun 2008 11:53:37 -0700
Message-ID: <7vabhvkbbi.fsf@gitster.siamese.dyndns.org>
References: <1212933875-29947-1-git-send-email-sverre@rabbelier.nl>
 <m3tzg4vvgw.fsf@localhost.localdomain>
 <bd6139dc0806080745i2ff2489bv70a1596bcc83f700@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Git list" <git@vger.kernel.org>
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 20:54:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Q2K-0001Ob-Nn
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 20:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbYFHSxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 14:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbYFHSxr
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 14:53:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34545 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbYFHSxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 14:53:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B3983CA8;
	Sun,  8 Jun 2008 14:53:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D1AA23CA7; Sun,  8 Jun 2008 14:53:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 38338C08-358C-11DD-B826-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84309>

"Sverre Rabbelier" <srabbelier@gmail.com> writes:

> On Sun, Jun 8, 2008 at 4:42 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> "Sverre Rabbelier" <sverre@rabbelier.nl> writes:
>>
>>> Because writing to the current directory is not possible, we write to /tmp/.
>>> Suggestions for a better location are welcome.
>>
>>> +     test_results_path="../test-results"
>>
>> Errr... it looks like you forgot to update commit message.
>
> Yeah, I intended to fix that when amending the original commit, but I
> forgot. I thought I couldn't write to the current dir, but instead I
> was writing to /t/trash, which of course gets deleted after every
> test. Obviously outputting to ../test-results fixed that.

Some tests may chdir around and when you hit test_done they may not be in
the directory directly under t/ anymore.  I'd say that such a test is
ill-mannered, but we would want to protect ourselves against such mischief
somehow.

Also, this won't be an immediate issue, but we may want to lift the
".NOTPARALLEL" limitation in t/Makefile sometime in the future.  A handful
tests need to be adjusted for this change, as they currently refer their
test vectors in t/tXXXX/ as ../tXXXX, and with such a change, we would run
each test in "t/trash directory/t$$" where $$ is the pid, or something
like that.  A single "test-results" file everybody races to append would
become unwieldy at that point.  Something to keep in mind.
