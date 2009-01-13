From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] make diff --color-words customizable
Date: Tue, 13 Jan 2009 01:52:23 +0100
Message-ID: <200901130152.24401.jnareb@gmail.com>
References: <87wsd48wam.fsf@iki.fi> <200901101436.48149.jnareb@gmail.com> <alpine.DEB.1.10.0901100950230.21891@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 01:53:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMXXS-0000jC-C6
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 01:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbZAMAw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 19:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbZAMAw3
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 19:52:29 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:36108 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbZAMAw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 19:52:28 -0500
Received: by ewy10 with SMTP id 10so11814017ewy.13
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 16:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7davojgDZ7o621YnD7LZjCOlHfUEYeB7FPQGNRlNqsQ=;
        b=ahrbjF8dVtB9buAPPeQrY+bbRM9mNVGvYBgXQBnF74nxdCFE/SNND7QqtIv7JOfeXn
         IRMNEnIXBz4d05+5b3ajRxHOJ+TXLjqfZPfeyCqKBxiCYlXaNKv13tYcZ/rzcVWlkQjs
         6XITLchWCyvEF5gFhL9vYyZwjtrDKwQr42iJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PS3vU9GvkGKUucmHz7+mDAMHVrecUsQel2+iL49EbrK5xkM9tXQrrfhyfQBXvXih3w
         IDhQvl5ZqGbosgAFb7uef7PFwYnlG5aM6Pu92DSLU9CvhwJvBKDk8j2lWrT83dzgFzZE
         oez6YmkioghCqUtgC+xxaIA1SFlkUimRMi04s=
Received: by 10.210.11.17 with SMTP id 17mr33643363ebk.113.1231807945441;
        Mon, 12 Jan 2009 16:52:25 -0800 (PST)
Received: from ?192.168.1.11? (abvj184.neoplus.adsl.tpnet.pl [83.8.207.184])
        by mx.google.com with ESMTPS id d27sm79216414nfh.69.2009.01.12.16.52.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Jan 2009 16:52:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.10.0901100950230.21891@alien.or.mcafeemobile.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105428>

On Sat, 10 Jan 2009, Davide Libenzi wrote:
> On Sat, 10 Jan 2009, Jakub Narebski wrote:
>> On Sat, 10 Jan 2009, Johannes Schindelin wrote:
>>> On Sat, 10 Jan 2009, Jakub Narebski wrote:
>>>> Thomas Rast wrote:
>>>> 
>>>>> --color-words works (and always worked) by splitting words onto one
>>>>> line each, and using the normal line-diff machinery to get a word
>>>>> diff. 
>>>> 
>>>> Cannot we generalize diff machinery / use underlying LCS diff engine
>>>> instead of going through line diff?
>>> 
>>> What do you think we're doing?  libxdiff is pretty hardcoded to newlines.  
>>> That's why we're substituting non-word characters with newlines.
>> 
>> Isn't Meyers algorithm used by libxdiff based on LCS, largest common
>> subsequence, and doesn't it generate from the mathematical point of
>> view "diff" between two sequences (two arrays) which just happen to
>> be lines? It is a bit strange that libxdiff doesn't export its low
>> level algorithm...
> 
> The core doesn't know anything about lines. Only pre-processing (setting 
> up the hash by tokenizing the input) and post-processing (adding '\n' to 
> the end of each token), knows about newlines. Memory consumption would 
> increase significantly though, since there is a per-token cost, and a 
> word-based diff will create more of them WRT the same input.

Is this core algorithm available as some exported function in libxdiff?
I mean would it be easy to replace default line tokenizer (per-line
pre-processing) and post-processing to better deal with word diff?

The other side would be to generate per-paragraph diffs (with empty
line being separator)...
-- 
Jakub Narebski
Poland
