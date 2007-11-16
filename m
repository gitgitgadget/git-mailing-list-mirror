From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Fix t7004 which fails with retarded sed
Date: Fri, 16 Nov 2007 20:15:33 +0100
Organization: glandium.org
Message-ID: <20071116191533.GA7624@glandium.org>
References: <20071116165944.GB29272@glandium.org> <1195233971-12288-1-git-send-email-mh@glandium.org> <6E925AF7-FCCB-4793-936F-7BC513272E75@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Fri Nov 16 20:16:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It6gF-00089r-HL
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 20:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338AbXKPTQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 14:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbXKPTQ0
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 14:16:26 -0500
Received: from vawad.err.no ([85.19.200.177]:52785 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbXKPTQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 14:16:25 -0500
Received: from aputeaux-153-1-42-198.w82-124.abo.wanadoo.fr ([82.124.6.198] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1It6fs-0007mz-BQ; Fri, 16 Nov 2007 20:16:22 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1It6f7-00020r-M9; Fri, 16 Nov 2007 20:15:33 +0100
Content-Disposition: inline
In-Reply-To: <6E925AF7-FCCB-4793-936F-7BC513272E75@lrde.epita.fr>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: (score 5.0): Status=No hits=4.9 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65242>

On Fri, Nov 16, 2007 at 06:58:21PM +0100, Benoit Sigoure wrote:
> On Nov 16, 2007, at 6:26 PM, Mike Hommey wrote:
>
>> Brown paper bag fix to avoid test failure with retarded sed. The test
>> by itself didn't catch what it was supposed to, anyways.
>>
>> So now, we test whether the editor gets at least an empty line, some
>> commented lines, and doesn't get anything else.
>>
>> Signed-off-by: Mike Hommey <mh@glandium.org>
>> ---
>>  t/t7004-tag.sh |    4 +++-
>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> index 096fe33..3813f23 100755
>> --- a/t/t7004-tag.sh
>> +++ b/t/t7004-tag.sh
>> @@ -1007,7 +1007,9 @@ test_expect_failure \
>>  test_expect_success \
>>  	'message in editor has initial comment' '
>>  	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
>> -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
>> +	grep -e "^$" actual > /dev/null 2>&1 &&
>> +	grep -e "^#" actual > /dev/null 2>&1 &&
>> +	! grep -e "^[^#]" actual > /dev/null 2>&1
>>  '
>>
>>  get_tag_header reuse $commit commit $time >expect
>
> If your system has a retarded `sed', it will most likely also have a 
> brain-dead `/bin/sh' which doesn't handle `! command'.  So I suggest you 
> rewrite the last line as:
>   grep -ve "^[^#]" actual > /dev/null 2>&1

A whole lot of the test suite uses `! command', which is why i chose to
use it.

Mike
