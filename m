From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Wed, 17 Jan 2007 10:48:02 +0100
Message-ID: <200701171048.03686.jnareb@gmail.com>
References: <200701150144.56793.jnareb@gmail.com> <200701170024.10640.jnareb@gmail.com> <Pine.LNX.4.63.0701170948420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nikolai Weibull <now@bitwi.se>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 10:47:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H77OR-0000aP-AU
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 10:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbXAQJrj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 04:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbXAQJrj
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 04:47:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:39872 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173AbXAQJri (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 04:47:38 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1941666uga
        for <git@vger.kernel.org>; Wed, 17 Jan 2007 01:47:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dfrLpO8lXnZ2R86iObg0AEaxX2cJgUz/suVfrkz0VZM/oUEkc3+1uvLWdU2q2lKLzvnXQcAONDzvow1Seoq0wqM3/LR2JgSIi4om8jvzp+46HB+O2y6vSKgOuNPjV4Uz+P/ybWvTREe/+CinfLwv+OOpydpavAHnjOqZ6/68XPQ=
Received: by 10.67.121.15 with SMTP id y15mr9171233ugm.1169027256806;
        Wed, 17 Jan 2007 01:47:36 -0800 (PST)
Received: from host-81-190-20-200.torun.mm.pl ( [81.190.20.200])
        by mx.google.com with ESMTP id s7sm10152779uge.2007.01.17.01.47.36;
        Wed, 17 Jan 2007 01:47:36 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0701170948420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36992>

Johannes Schindelin wrote:
> 
> On Wed, 17 Jan 2007, Jakub Narebski wrote:
> 
>> Dnia wtorek 16. stycznia 2007 23:56, Johannes Schindelin napisa?:

>>> So, how about a "git repo-config --dump" which outputs a stream of NUL 
>>> separated keys and values? This should be really easy to "parse", and 
>>> there are no ambiguities: No key or value can contain a NUL.
>> 
>> Good idea, although "\n" would work as well as NUL.
> 
> No it would not:
> 
> 	[someSection]
> 		thisKey = has\na\nvalue\with\nseveral\nnewlines

$ fatal: bad config file line <nn> in <config>

The same with quoted:

 	[someSection]
 		qthisKey = "has\na\nvalue\with\nseveral\nnewlines"

There is no escaping besides escaping " and escape character
i.e. escaping \ in git config. Se "\n" would work as well as NUL.
(It is said explicitely that subsection names cannot contain "\n").

>> The only problem is with "key without value" case, i.e. something like
>> 
>>   [section]
>>   	noval
>> 
>> which shows as
>> 
>>   section.noval
> 
> but is equivalent to
> 
> 	[section]
> 		noval = true
> 
> Since it is by definition a boolean value.

But only for "git repo-config --bool --get section.noval" output.
Semantically equivalent to "true".

But without --bool it returns like it was "".

>> in "git repo-config -l" output (note missing '=' !), and I guess differs
>> for some case from
>> 
>>   [section]
>>   	noval = 
> 
> Yes, this is not a boolean. The difference is that the callback function 
> is called with NULL in the former case, and with "" in the latter.

-- 
Jakub Narebski
Poland
