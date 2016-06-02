From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Thu, 2 Jun 2016 16:30:13 +0100
Message-ID: <57505105.2000801@ramsayjones.plus.com>
References: <20160601235233.21040-1-sbeller@google.com>
 <574F800D.6070107@ramsayjones.plus.com>
 <xmqqy46ouorn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>, pclouds@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 17:30:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8UZk-0002qc-Tz
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 17:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341AbcFBPaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 11:30:20 -0400
Received: from avasout04.plus.net ([212.159.14.19]:55627 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbcFBPaS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 11:30:18 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout04 with smtp
	id 1rWE1t0045VX2mk01rWFbp; Thu, 02 Jun 2016 16:30:16 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=EBOSESyhAAAA:8 a=sLjBsqOmQhp_7wIV6AcA:9 a=pILNOxqGKmIA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqy46ouorn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296208>



On 02/06/16 06:46, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Not having given this much thought at all, but the question which comes
>> to mind is: can you use some other separator for the <attr>-s rather than
>> a comma? That way you don't need to quote them in the <value> part of the
>> <attr>-spec.
>>
>> (I dunno, maybe use ; or : instead?)
> 
> There are two kinds of comma involved in this discussion.
> 
>  * Multiple pathspec magic can be attached to augment the way
>    <pattern> selects paths. ":(<magic1>,<magic2>,...)<pattern>" is
>    the syntax, and <magicN> are things like "icase" (select the path
>    that matches <pattern> case-insensitively), "top" (<pattern> must
>    match from the top level of the working tree, even when you are
>    running the command from a subdirectory).  We added a new kind of
>    <magic> whose syntax is "attr:VAR=VAL" recently, which says "not
>    only <pattern> must match the path, in order to be selected, the
>    path must have the attribute VAR with value VAL".
> 
>    The comma that separates multiple magic is not something you can
>    change now; it has been with us since v1.7.6 (Jun 2011)
> 
>  * My example wanted to use the attr:VAR=VAL form to select those
>    paths that has one specific string as the value for whitespace
>    attribute, i.e. VAR in this case is "whitespace".  The value for
>    whitespace attribute determines what kind of whitespace anomalies
>    are considered as errors by "git apply" and "git diff", and it is
>    formed by concatenating things like "indent-with-non-tab" (starts
>    a line with more than 8 consecutive SPs), "space-before-tab" (a
>    SP appears immediately before HT in the indent), etc., with a
>    comma in between.
> 
>    The comma that separates various kinds of whitespace errors is
>    not something you can change now; it has been with us since
>    v1.5.4 (Feb 2008).
> 
> So using different separator is not a viable solution.

Ah, OK, makes sense. Note that I have not used 'pathspec magic' or
the attribute system in git (never felt/had the need)! ;-)

So, at risk of annoying you, let me continue in my ignorance a little
longer and ask: even if you have to protect all of this 'magic' from
the shell with '/" quoting, could you not use (nested) quotes to
protect the <value> part of an <attr>? For example:

    git ls-files ':(attr:whitespace="indent,trail,space",icase)'

[Hmm, I don't seem to be able to find documentation on the syntax
of these features (apart from the code, of course).]

ATB,
Ramsay Jones
