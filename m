From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 01:59:57 +0200
Message-ID: <200809100159.59060.jnareb@gmail.com>
References: <20080909132212.GA25476@cuci.nl> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 02:01:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdD9E-0002XM-2M
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 02:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbYIJAAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 20:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbYIJAAI
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 20:00:08 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:55104 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbYIJAAG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 20:00:06 -0400
Received: by gxk9 with SMTP id 9so12261601gxk.13
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 17:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=w+/pPqcYSfJQFXJIVBwu+3g6pWu7al6io6n2PNV+dmo=;
        b=JSFLpHwppabxugxII9B9SLrdOShX+g7KwC1J6n3mskuzbschdrKiERZT6H5QmJ12AQ
         ddteGCVBhD1/O+TmDySBAuVFf3ftseTdKobwT5tSwrxoc9UI9Q2YjBySD4wgtp3gKGZX
         gw9J7encPSJP93q170TlTY/O5++xSKH3gefCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=I1jv/UeHyl54DrBvQ7YCk+kkOCZqWDkUWC0iAptIkEQrbTqU5uGbLQOLJBAMTqTpO1
         HxFUknlRshAP2r4BW4h+lFCRhf9Xxm0drgLWp7rbI02cd3o/tAHeJd26qxuGA3GgwrDY
         0biLLvPmuIz0L/WMuYkp2OsOtn3946N+TNYcM=
Received: by 10.86.65.11 with SMTP id n11mr383208fga.64.1221004804207;
        Tue, 09 Sep 2008 17:00:04 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.199.71])
        by mx.google.com with ESMTPS id 4sm7703016fgg.4.2008.09.09.17.00.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 17:00:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95469>

Linus Torvalds wrote:
> On Tue, 9 Sep 2008, Stephen R. van den Berg wrote:
>> Jakub Narebski wrote:
>>>"Stephen R. van den Berg" <srb@cuci.nl> writes:
>>>> The definition of the origin field reads as follows:
>> 
>>>> - There can be an arbitrary number of origin fields per commit.
>>>>   Typically there is going to be at most one origin field per commit.
>> 
>>> I understand that multiple origin fields occur if you do a squash
>>> merge, or if you cherry-pick multiple commits into single commit.
>>> For example:
>>> $ git cherry-pick -n <a1>
>>> $ git cherry-pick    <a2>
>>> $ git commit --amend        #; to correct commit message
>> 
>> Correct.
> 
> Quite frankly, recording the origins for _any_ of the above sounds like a 
> horribly mistake.

Actually the above is _not_ a good example for using 'origin', and why
using 'origin'; just a bit convoluted example of multiple 'origin'
headers.

> All those operations are commonly used (along with "git rebase -i") to 
> clean up history in order to show a nicer version.
> 
> The whole point of "origin" seems to be to _destroy_ that.

If I understand correctly the point is to record those 'origin' headers
for git-revert (when 'origin'-ed commit is somewhere in the history),
and for git-cherry-pick from other long lived branch and thus require
additional option to git-cherry-pick to record 'origin' (denoting that
you this is "true" cherry-pick, and not reordering of commits and
cleaning up a history, better done with interactive rebase).

/me is playing advocatus diaboli here, 'cause I'm not that convinced
to necessity of this feature.

-- 
Jakub Narebski
Poland
