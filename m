From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 04 Jul 2006 16:07:11 -0700
Message-ID: <44AAF49F.6090008@gmail.com>
References: <44A9E6AE.10508@gmail.com> <7v3bdhoraa.fsf@assigned-by-dhcp.cox.net> <44AA0DAE.1060308@gmail.com> <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de> <7v8xn9gjh5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0607050021330.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jul 05 01:07:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxtzI-0006Oe-LJ
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 01:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWGDXHR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 19:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWGDXHR
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 19:07:17 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:56909 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932307AbWGDXHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 19:07:16 -0400
Received: by nz-out-0102.google.com with SMTP id o1so1128198nzf
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 16:07:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GnnahC0tqiisYpe+kNiosfo7E5KqTXIQ7A7h198rXL1ULSCv56nZKtLT6MQZwXBTXtBVELHxpdcO+wlX4Zre/RzSGswDCa4bJC4hU2RUI8FM9bBtXPWMMTg6WuKnFFZVYtIBVv+eQLw3yWCOtSE9aCE1x59Xfdu/VH5xM7P+dGk=
Received: by 10.36.118.1 with SMTP id q1mr5479380nzc;
        Tue, 04 Jul 2006 16:07:15 -0700 (PDT)
Received: from ?10.0.0.6? ( [69.160.147.208])
        by mx.gmail.com with ESMTP id 38sm3165064nza.2006.07.04.16.07.13;
        Tue, 04 Jul 2006 16:07:14 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0607050021330.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23328>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 4 Jul 2006, Junio C Hamano wrote:
> 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> We could introduce a time.maximumSkew variable, and just walk only 
>>> that much further when traversing the commits.
>> We could have had "commit generation number" in the commit
>> object header, and use that instead of commit timestamps for
>> these traversal purposes.  The generation number for a commit is
>> defined to be max(generation number of its parents)+1 and we
>> prime the recursive this definition by defining the generation
>> number for the root commit to be one.
> 
> Are you really, really sure this is a remedy? I, for one, am quite sure of 
> the opposite. What you propose is just another time scale, only this time, 
> it is not universally true (not even minus local incompetence to keep the 
> clock accurate).

It works[*] and it does what using the timestamp was trying to do. 
Namely, work from "more recent" (or "closer") commits toward "older" (or 
"farther") commits until you've gone past the point you care about.

It's a little late to be changing the structure of a commit and you'd 
have to deal with some size/scale issues, but it's do-able. A better 
idea may be to generate and keep the generation number on a per 
repository basis, and you'd be able to work around changing grafts.

[*] Grafts do _really_ nasty things to this. Just like clock skew does now.
