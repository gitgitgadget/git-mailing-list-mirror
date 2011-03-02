From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 2/7] fetch/pull: Add the 'on-demand' value to the --recurse-submodules
 option
Date: Wed, 02 Mar 2011 11:02:58 -0500
Message-ID: <4D6E6A32.7030908@xiplink.com>
References: <4D6D7A50.5090802@web.de> <4D6D7ADA.6090302@web.de> <4D6E699D.3040000@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 02 17:02:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuoVM-000720-1X
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 17:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753827Ab1CBQCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 11:02:19 -0500
Received: from smtp112.iad.emailsrvr.com ([207.97.245.112]:44623 "EHLO
	smtp112.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1CBQCT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 11:02:19 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp51.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id A28E6208EE;
	Wed,  2 Mar 2011 11:02:18 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp51.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id CDF0C209D2;
	Wed,  2 Mar 2011 11:02:17 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <4D6E699D.3040000@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168317>

On 11-03-02 11:00 AM, Marc Branchaud wrote:
> On 11-03-01 06:01 PM, Jens Lehmann wrote:
>> Until now the --recurse-submodules option could only be used to either
>> fetch all populated submodules recursively or to disable recursion
>> completely. As fetch and pull now by default just fetch those submodules
>> for which new commits have been fetched in the superproject, a command
>> line option to enforce that behavior is needed to be able to override
>> configuration settings.
> 
> Strictly speaking, this patch should add the 'on-demand' value to the first
> patch's --submodule-default option.  Perhaps I'm being a bit too uptight
> though...
> 
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>> ---
>>  Documentation/fetch-options.txt |   16 +++++++--
>>  Documentation/git-pull.txt      |    2 +-
>>  builtin/fetch.c                 |   22 ++++++++++--
>>  git-pull.sh                     |    3 ++
>>  submodule.c                     |    8 +++-
>>  submodule.h                     |    2 +-
>>  t/t5526-fetch-submodules.sh     |   71 +++++++++++++++++++++++++++++++++++++++
>>  7 files changed, 114 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
>> index ae22f75..f28c0b1 100644
>> --- a/Documentation/fetch-options.txt
>> +++ b/Documentation/fetch-options.txt
>> @@ -65,9 +65,19 @@ ifndef::git-pull[]
>>  	specified with the remote.<name>.tagopt setting. See
>>  	linkgit:git-config[1].
>>
>> ---[no-]recurse-submodules::
>> -	This option controls if new commits of all populated submodules should
>> -	be fetched too (see linkgit:git-config[1] and linkgit:gitmodules[5]).
>> +--recurse-submodules[=yes|on-demand|no]::
>> +	This option controls if and under what conditions new commits of all
> 
> Nit: Remove "all" from the above line.
> 
>> +	populated submodules should be fetched too. It can be used as a
>> +	boolean option to completely disable recursion when set to 'no' or to
>> +	unconditionally recurse into all populated submodules when set to
>> +	'yes', which is the default when this option is used without any
>> +	value. If 'on-demand' is used, it will only recurse into those
>> +	submodules where new commits have been fetched in the superproject
>> +	(also see linkgit:git-config[1] and linkgit:gitmodules[5]).
> 
> Nit: Replace that last sentence with
> 
> 	Use 'on-demand' to only recurse into a submodule when the
> 	superproject retrieves a commit that updates the submodule's
> 	reference.

Doh!  That should read:

	Use 'on-demand' to only recurse into a populated submodule when the
	superproject retrieves a commit that updates the submodule's
	reference.

		M.
