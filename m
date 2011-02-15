From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 1/2] Introduce CHERRY_HEAD
Date: Tue, 15 Feb 2011 17:08:59 -0600
Message-ID: <20110215230859.GB17812@elie>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com>
 <1297805034-3512-2-git-send-email-jaysoffian@gmail.com>
 <20110215221832.GA826@elie>
 <7v4o84nbuh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 00:09:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpU1A-0008IS-9I
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 00:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab1BOXJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 18:09:07 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59587 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab1BOXJF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 18:09:05 -0500
Received: by qyj19 with SMTP id 19so2836807qyj.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 15:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RPypxsA61g69Osu9FL+j+5xPfaSjqrCUbKCKbI3ZwUA=;
        b=pxYl4GcAyk/9FNFOmFUguS0LYxsmVkoqS92+jTPgLBpoxSDSsgksCynZh3NshPlf19
         T6BCnQLwJMwMdxiJEgfuRBUb5GgLmIVt1crxmGfikBeV/nhYfkWTHF2/NhOO7XbeM5ik
         PyZI6DJhXKEDTJEn5ldB3m3Fq3LF0lwFta094=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JIbpYJDktJOsB6f2f2llKv9jVLH+wVvUDDGeTyg5zm52YtFNhxs2Jy003esyo5qVEf
         vIOLfKtny06R4tv9U2B1fFMnRj0ySoV/v5cM9BDYFy4NVu3zh0ArWCGlSlv3mbFFfKON
         H+JQz6ONnAFqk1CYoQtFnhBI5OjSLRDvEMoVQ=
Received: by 10.224.89.15 with SMTP id c15mr1272783qam.91.1297811345160;
        Tue, 15 Feb 2011 15:09:05 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id r20sm1491177vcf.34.2011.02.15.15.09.03
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 15:09:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v4o84nbuh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166896>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> I wonder if cherry-pick shouldn't also write MERGE_MSG or similar so
>> that gets taken care of automatically?  That would also allow options
>> like -x and -m to work better.
>
> Hm, that probably is a good idea.

Turns out it already does. :)

>> +++ b/Documentation/git-cherry-pick.txt
>> @@ -16,6 +16,25 @@ Given one or more existing commits, apply the change each one
[...]
>> +When it is not obvious how to apply a change, the following
>> +happens:
>> +
>> +1. The current branch and `HEAD` pointer stay at the last commit
>> +   successfully made.
>> +2. The `CHERRY_HEAD` ref is set to point at the commit that
>> +   introduced the change that is difficult to apply.
>> +3. Paths in which the change applied cleanly are updated both
>> +   in the index file and in your working tree.
>> +4. For conflicting paths, the index file records up to three
>> +   versions, as described in the "TRUE MERGE" section of
>> +   linkgit:git-merge[1].  The working tree files will include
>> +   a description of the conflict bracketed by the usual
>> +   conflict markers `<<<<<<<` and `>>>>>>>`.
>
> What happened to the `=======`?  I thought you were copying and pasting
> from the said section.

Hmm, maybe as a temporary cop-out:

	What it is not obvious how to apply a change, the following
	happens:

	1. The current branch ...
	...
	3. Paths in which the change applied cleanly are updated both
	   in the index file and in your working tree.
	4. For conflicting paths, the index file and working tree
	   files record a description of the conflict, as described
	   in the "TRUE MERGE" section of linkgit:git-merge[1].

I didn't want to copy and paste wholesale to avoid dull reading and to
avoid the two copies falling out of sync.  Maybe there should be a
page on conflicts and their resolution for git-merge(1),
git-rebase(1), git-cherry-pick(1), and git-revert(1) to refer to?
