From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH 1/1] Improve error messages from 'git stash show'
Date: Tue, 16 Mar 2010 09:04:59 +0100
Message-ID: <4B9F3BAB.10608@isy.liu.se>
References: <1268691590-27100-1-git-send-email-hendeby@isy.liu.se> <7vbpepb2e9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 09:13:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrRuO-0000y1-AN
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 09:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757686Ab0CPIN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 04:13:28 -0400
Received: from muon.isy.liu.se ([130.236.48.25]:40859 "EHLO muon.isy.liu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064Ab0CPIN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 04:13:26 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Mar 2010 04:13:26 EDT
Received: from [192.168.13.34] (f050204154.adsl.alicedsl.de [78.50.204.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by muon.isy.liu.se (Postfix) with ESMTPSA id ADF8D7CD;
	Tue, 16 Mar 2010 09:05:01 +0100 (MET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9pre) Gecko/20100313 Shredder/3.0.4pre
In-Reply-To: <7vbpepb2e9.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-ISY-LIU-SE-MailScanner-Information: Please contact postmaster@isy.liu.se for more information
X-ISY-LIU-SE-MailScanner-ID: ADF8D7CD.A0EE0
X-ISY-LIU-SE-MailScanner: Found to be clean
X-ISY-LIU-SE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 6, ALL_TRUSTED -1.00)
X-ISY-LIU-SE-MailScanner-From: hendeby@isy.liu.se
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142336>

On 03/16/2010 12:17 AM, Junio C Hamano wrote:
> Gustaf Hendeby <hendeby@isy.liu.se> writes:
> 
>> The previous error message "fatal: Needed a single revision" is not
>> very informative.
>>
>> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
>> ---
>>  git-stash.sh |    8 ++++++--
>>  1 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-stash.sh b/git-stash.sh
>> index aa47e54..cf221c6 100755
>> --- a/git-stash.sh
>> +++ b/git-stash.sh
>> @@ -210,14 +210,18 @@ list_stash () {
>>  }
>>  
>>  show_stash () {
>> +	have_stash || die 'No stash found'
>> +
>>  	flags=$(git rev-parse --no-revs --flags "$@")
>>  	if test -z "$flags"
>>  	then
>>  		flags=--stat
>>  	fi
>>  
>> -	w_commit=$(git rev-parse --verify --default $ref_stash "$@") &&
>> -	b_commit=$(git rev-parse --verify "$w_commit^") &&
>> +	w_commit=$(git rev-parse --quiet --verify --default $ref_stash "$@") &&
>> +	b_commit=$(git rev-parse --quiet --verify "$w_commit^") ||
>> +		die 'Stash not found'
>> +
> 
> Because you checked have_stash upfront, an error detected here cannot be
> "stash not found".  It is something else, isn't it?

This case occurs when you do something like git stash foo, where foo is
no appropriate stash to show.  Would something like this be more
informative in the case of git stash foo:

Stash entry 'foo' could not be found

/Gustaf
