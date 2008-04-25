From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/11] Add tests for git cat-file
Date: Fri, 25 Apr 2008 11:06:46 -0700
Message-ID: <7vk5ilq05l.fsf@gitster.siamese.dyndns.org>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
 <1208978273-98146-2-git-send-email-aroben@apple.com>
 <20080425065614.GA5758@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Roben <aroben@apple.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Apr 25 20:08:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpSLR-00057p-0q
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 20:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764862AbYDYSHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 14:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763639AbYDYSHA
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 14:07:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764172AbYDYSG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 14:06:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ADFB42C88;
	Fri, 25 Apr 2008 14:06:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B4AB02C83; Fri, 25 Apr 2008 14:06:48 -0400 (EDT)
In-Reply-To: <20080425065614.GA5758@untitled> (Eric Wong's message of "Thu,
 24 Apr 2008 23:56:29 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80343>

Eric Wong <normalperson@yhbt.net> writes:

> Adam Roben <aroben@apple.com> wrote:
>> 
>> Signed-off-by: Adam Roben <aroben@apple.com>
>> ---
>>  t/t1006-cat-file.sh |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 101 insertions(+), 0 deletions(-)
>>  create mode 100755 t/t1006-cat-file.sh
>> 
>> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>> new file mode 100755
>> index 0000000..15741d9
>> --- /dev/null
>> +++ b/t/t1006-cat-file.sh
>> @@ -0,0 +1,101 @@
>> +#!/bin/sh
>> +
>> +test_description='git cat-file'
>> +
>> +. ./test-lib.sh
>> +
>> +function echo_without_newline()
>
> The "function " keyword is a bashism and not needed, this breaks
> my test run with dash as /bin/sh (same thing in t1007).
>
>> +{
>> +    echo "$@\c"
>
> I guess we have different bash versions/options, because this breaks for
> me in bash (3.1dfsg-8 from Debian etch).  It would need -e to handle to
> handle escape sequence, but that's a bashism, too.
>
> Use printf "$@" here instead.

Looking at the callers, I do not think you want that.  I would suggest
something defensive like:

	printf '%s' "$*"
