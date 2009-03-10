From: Mike Gaffney <mr.gaffo@gmail.com>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line
 lengths)
Date: Mon, 09 Mar 2009 23:46:50 -0500
Message-ID: <49B5F0BA.3070806@gmail.com>
References: <49B5AF67.6050508@gmail.com> <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 05:49:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgtuO-0002wf-Lq
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 05:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbZCJEqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 00:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbZCJEqm
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 00:46:42 -0400
Received: from 9a.26.1243.static.theplanet.com ([67.18.38.154]:39279 "EHLO
	rubble.crucialcrossbar.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750843AbZCJEql (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 00:46:41 -0400
Received: from [70.230.183.79] (helo=[192.168.1.123])
	by rubble.crucialcrossbar.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <mr.gaffo@gmail.com>)
	id 1LgtrI-00069h-0y; Mon, 09 Mar 2009 22:46:28 -0600
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rubble.crucialcrossbar.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112778>

Junio,
	Just spent about 30 minutes replying to your points until the last one
made most moot. I agree that putting the info into the url will fix the bug, 
which I have never seen (see #3 below), and make the howto easier to read. So a 
few things I wanted to discuss or ask for help on:

1) Note that I'm not a C guy so:

Junio wrote:
>> +static const char *curl_http_username = NULL;
>> +static const char *curl_http_password = NULL;
>> +
> Please do not introduce new initializations of static variables to 0 or
> NULL.  As a clean-up, before your patch, you can send in a patch to fix
> existing such initializations.

I'm not sure what you mean here. Should I just declare them as:
static const char *curl_http_password; ?

Also do you mean that during after the patch phase they get changed to:
static const char *curl_http_password = NULL; ?

Or do you mean that I can send in a patch to fix other static variables
(not mine) which are being initialized to NULL?

2) Being that I'm not a big C guy, I'm not sure the best way to go about 
parsing the username out of the URL to pull it into a variable to pass
to CURLOPT_USERPASS. Any advice from the community would be greatly
appreciated.

3) From my experience with curl, many of the options do
not work the same across versions or platforms. For example, the new
CURLOPT_USERNAME/PASSWORD options worked fine in 7.19.4 on cygwin but not
on FC9, which is why I used the older USERPWD. Also, my curl never prompted
me for the password when I supplied a username in the URL which is what 
prompted me to do this patch in the first place. As such, I think it is
better to pull the username & password prompting logic into git make this 
stable and fix the bug. 

4) I'm not really impressed that file permissions actually make the .netrc
file a secure option. However, it's already in there and would break
backwards compatibility to take it out. I also realize that there is a need
for automated builds to be able to pull the source. So I would like to add a nice 
warning section to the http docs explaining the repercussions of using it.

Thanks for the help,
	Mike
