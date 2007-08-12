From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v4, ping] gitk: let you easily specify lines of context in diff view
Date: Sun, 12 Aug 2007 12:02:53 +0200
Message-ID: <AC6A824F-E268-41AE-823B-2C01D78FAF30@zib.de>
References: <11856503182381-git-send-email-prohaska@zib.de> <11868462503722-git-send-email-prohaska@zib.de> <18110.31705.747583.463206@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 12:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKAK6-0000Ub-BS
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 12:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759401AbXHLKFV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 06:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756742AbXHLKFV
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 06:05:21 -0400
Received: from mailer.zib.de ([130.73.108.11]:39273 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734AbXHLKFT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 06:05:19 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7CA29fo021684;
	Sun, 12 Aug 2007 12:04:42 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1ff88.pool.einsundeins.de [77.177.255.136])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7CA24Zb019615
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 12 Aug 2007 12:02:09 +0200 (MEST)
In-Reply-To: <18110.31705.747583.463206@cargo.ozlabs.ibm.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55670>


On Aug 12, 2007, at 5:17 AM, Paul Mackerras wrote:

> Steffen Prohaska writes:
>
>> Any chance to get this patch applied? It works for me.
>
> Some comments:
>
>> @@ -731,7 +732,16 @@ proc makewindow {} {
>>  	-command changediffdisp -variable diffelide -value {0 1}
>>      radiobutton .bleft.mid.new -text "New version" \
>>  	-command changediffdisp -variable diffelide -value {1 0}
>> -    pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
>
> Just add another pack command rather than extending this one.

Thanks. Didn't understand what pack does and thought it might be
needed to pack all at once into a 'single' pack.


>> +    label .bleft.mid.labeldiffcontext -text "      Lines of  
>> context: " \
>> +    -font $uifont
>
> This is hard to read because the continuation line isn't indented
> further that the first line.  Please indent continuation lines by an
> extra 4 spaces.

I fixed more of them. I typically work with a no-tab rule. Hope I
spotted all other places with wrong indent, too.


>> +# empty strings or integers accepted
>> +proc diffcontextvalidate {v} {
>> +    if {[string length $v] == 0} {
>> +	return 1
>> +    }
>> +    if {[string is integer $v]} {
>> +	if {$v > 0} {
>> +	    return 1
>> +	}
>> +    }
>> +    return 0
>> +}
>
> "string is integer" will already accept the null string and return 1.

replaced this by a regexp.


>> +proc diffcontextchange {n1 n2 op} {
>> +    global diffcontextstring diffcontext
>> +
>> +    if {[string is integer $diffcontextstring]} {
>> +        if {$diffcontextstring > 0} {
>
> Once again, "string is integer" returning 1 doesn't guarantee the
> string is non-empty.  Use "string is integer -strict" if you want
> that.

Ah, thanks, didn't know that.


>> +            set diffcontext $diffcontextstring
>> +		    reselectline
>
> Inconsistent indentation.

ok.


>> +set diffcontext 3
>> +
>
> It would be nice to save diffcontext in the ~/.gitkrc.

done.

Will send a patch in a minute.

	Steffen
