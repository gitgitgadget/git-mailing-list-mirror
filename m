From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 2/2] gitweb: Fix chop_str to allow for & characters in
 strings
Date: Tue, 02 Feb 2010 15:54:53 -0800
Message-ID: <4B68BB4D.20105@eaglescrag.net>
References: <1265147814-13284-1-git-send-email-warthog9@eaglescrag.net>	<1265147814-13284-2-git-send-email-warthog9@eaglescrag.net>	<1265147814-13284-3-git-send-email-warthog9@eaglescrag.net> <m3mxzr9pcz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:55:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcSaC-0002Ow-W8
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 00:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755840Ab0BBXy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 18:54:56 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:47005 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755828Ab0BBXyz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 18:54:55 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o12Nsr5J020359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 2 Feb 2010 15:54:54 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <m3mxzr9pcz.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Tue, 02 Feb 2010 15:54:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138789>

On 02/02/2010 03:43 PM, Jakub Narebski wrote:
> "John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:
> 
>> I'm unsure why this was placed in their originally, and it seems to
>> ultimately stem from code from before gitweb was merged into git core,
>> but there's an instance where git chops a string incorrectly based on
>> this.
>>
>> Specifically:
>>
>> 	API & protocol: support option to force written data immediately to disk
>>
>> from http://git.kernel.org/?p=daemon/distsrv/chunkd.git;a=commit;h=3b02f749df2cb1288f345a689d85e7061f507e54
>>
>> The short version of the title gets chopped to
>>
>> 	API ...
>>
>> where it should be
>>
>> 	API & protocol: support option to force written data...
>>
>> This reverts that specific problem.
>> ---
>>  gitweb/gitweb.perl |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 57771a0..4cc6d19 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -1382,7 +1382,6 @@ sub chop_str {
>>  		my $body = $1;
>>  		my $tail = $2;
>>  		if (length($tail) > 4) {
>> -			$body =~ s/&[^;]*$//;
>>  			$tail = "... ";
>>  		}
>>  		return "$body$tail";
> 
> I think it is a good change.  chop_str is meant to be used _before_
> HTML escaping (esc_html or equivalent) is to be applied; removed line
> looks like it was meant (badly) to always remove HTML entities
> fully... but those entities are only added later.
> 
> So now what is left is to come up with proper commit message, and add
> 
> Signed-off-by: John 'Warthog9' Hawley" <warthog9@kernel.org>
> Acked-by: Jakub Narebski <jnareb@gmail.com>
> 

There's a couple more lines, similar to that, ins chop_str.  The bug I
needed to fix didn't tickle those, so I made the smallest change
possible.  But those should probably be looked at as well.

- John 'Warthog9' Hawley
