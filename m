From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Mon, 04 Jun 2012 13:18:44 -0700
Message-ID: <7vhauqsue3.fsf@alter.siamese.dyndns.org>
References: <CALbm-Ea5ZkAGFyB2OETqe7vK7LE+yO0zSaa_+kFMXOhO-nMwMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 22:18:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbdjn-0008CR-M2
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 22:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458Ab2FDUSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 16:18:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52883 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757396Ab2FDUSr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 16:18:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 965A48D4F;
	Mon,  4 Jun 2012 16:18:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ixua3CeohHuGU2cjF5/IGROdWy0=; b=nP72eH
	cVVHAzB5iRZcuym3cQJplaAHhhGX3l0sozw6/FsyV9WHTrzZydKTAiSJYZFwPAse
	f1felaSfakbs4pKq8ZhCSm5ihjZGWD+UkHuRemusPbA9K4zNsFrXaNpCx6ysCpnh
	Fk5w3eJmwHZCJRBQyaozYp7MPLAxV+CVjC/qI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gYj+yuWkRP+HUbH2cukmgLTReEitwPVr
	bTI9sdggCSbMNW4cutfyZo+cRYhMEbka0Bwvd4GKA0qORWpwruXByn4jtdZXtjP7
	P1+J7C6t8HM6OlcJJaD2xtbiq59btovE6sqD+4Tdo8GXmsV9HOSDx8k59DoRdOv/
	0ClpjpWbfHk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DBF68D4E;
	Mon,  4 Jun 2012 16:18:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AA888D4D; Mon,  4 Jun 2012
 16:18:46 -0400 (EDT)
In-Reply-To: <CALbm-Ea5ZkAGFyB2OETqe7vK7LE+yO0zSaa_+kFMXOhO-nMwMQ@mail.gmail.com> (Stefan
 Beller's message of "Mon, 4 Jun 2012 17:40:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CD5CCAE-AE82-11E1-A5E1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199182>

Stefan Beller <stefanbeller@googlemail.com> writes:

> so I just pulled the new git v1.7.10.4 and tried to test it with
>> make test
> This yields this output:
> stderr http://pastebin.com/V8yuZFfi
> stdout http://dl.dropbox.com/u/6520164/git/maketest.txt
>
> In Test 1304 there is
> not ok - 2 Objects creation does not break ACLs with restrictive umask
>
> I am running Ubuntu 12.04 with Linux sb 3.2.0-25-generic #40-Ubuntu
> SMP Wed May 23 20:30:51 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux

Interesting. I've seen t1304 break from time to time.

I set the DEFAULT_TEST_TARGET to "prove", and when the test suite
finishes with this failure, I noticed t3600-rm and some other test I
do not recall also failed, with two extra files (actual and expect)
at the root of the TEST_OUTPUT_DIRECTORY (set to /dev/shm/testpen
via "--root=/dev/shm/testpen" option).

I the breakage does not happen reproducibly with any pattern other
than the above (I do not know if it never happens when test target
is set to "test", for example), so haven't looked (and will not
look) into it myself further than that.
