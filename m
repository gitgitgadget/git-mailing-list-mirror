From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 1/2 v3] mergetool: use path to mergetool in config var mergetool.<tool>.path
Date: Thu, 18 Oct 2007 09:52:12 +0200
Message-ID: <923DDB10-C9E9-4797-9FC1-D31DEEBE75B7@zib.de>
References: <11926413722362-git-send-email-prohaska@zib.de> <11926413723666-git-send-email-prohaska@zib.de> <20071018052724.GA27813@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 09:51:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiQ9i-0000jx-LS
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 09:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761791AbXJRHur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 03:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761757AbXJRHur
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 03:50:47 -0400
Received: from mailer.zib.de ([130.73.108.11]:43456 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761699AbXJRHuq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 03:50:46 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9I7ogg6011662;
	Thu, 18 Oct 2007 09:50:42 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9I7of57001686
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 18 Oct 2007 09:50:41 +0200 (MEST)
In-Reply-To: <20071018052724.GA27813@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61500>


On Oct 18, 2007, at 7:27 AM, Shawn O. Pearce wrote:

> Steffen Prohaska <prohaska@zib.de> wrote:
>> This commit adds a mechanism to provide absolute paths to the
>> external programs called by 'git mergetool'.  ...
> ...
>> @@ -297,17 +297,38 @@ do
>>      shift
>>  done
>>
>> +valid_tool() {
>> +	case "$1" in
>> +		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff |  
>> gvimdiff)
>> +			;; # happy
>> +		*)
>> +			return 1
>> +			;;
>> +	esac
>> +}
> ...
>> +    test -n "$merge_tool" || valid_tool "$merge_tool" || {
>
> Wouldn't an empty $merge_tool string be caught above in the
> valid_tool function where it falls through and returns 1?
> So isn't test -n here redundant?

Sharp eyes, thanks.


Correct is

test -z "$merge_tool" || valid_tool "$merge_tool" || {

No merge tool or a valid merge tool is allowed at this place.
If the tool's already empty there's no need to tell the user
that it will be reset to empty.

I'll send a v4 version.

	Steffen
