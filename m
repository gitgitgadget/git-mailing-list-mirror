From: Lance Linder <llinder@gmail.com>
Subject: Re: git-p4 move/delete errors
Date: Fri, 9 Jul 2010 16:20:21 -0500
Message-ID: <F94DAB9A-A06D-46ED-9AAA-EDE850365054@gmail.com>
References: <AANLkTinN0Av1CO7mZU-QKeApq43UmEykUV093eyTtKQN@mail.gmail.com> <AANLkTikPHJuf5JUe096BWTWO_oF9u3gNlVNuw7Ik32WQ@mail.gmail.com> <AANLkTin7eMFXT1FwZ2ojcAYgqIMSYnkz-uCoRlHvV6Tm@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Thomas Berg <merlin66b@gmail.com>, git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 23:21:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXL0g-0002w3-EE
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 23:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab0GIVVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 17:21:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42371 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab0GIVVO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 17:21:14 -0400
Received: by iwn7 with SMTP id 7so2629712iwn.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=5cYlabWs7VDQEbvClBai7XoTBtgQliNDC1aSXBpLv7g=;
        b=sfBH1uyF4erwZiNMOEn7tRtJhwdblrATp360qNO/Ka6pnC08q70vosgDimQk7DlmiR
         kpF8y+IxSJhIwNAPNWXUOCwackILam3AWNzJP6PQS/OWaetDh+sU8Tg6nYiBUpMIVH39
         qm9e07zboh/rYH51AdmWByirq/P3QCgBUREKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=nzv9kFd6wD72/DRJw6qGr7gw0hDNJGxunq1I1ekQx7YsZiEII3KaS0YPjA2+ObSsxR
         HYivlLE4lLOFA37dCYnFWa1vcA0XCq/AbVYEWHP8MQO0EtOSFs46usWWHBCJckqumaYm
         5FHcOkV/L2wJ7LltwiKA58MhoEXFKL7LPK9Sg=
Received: by 10.231.59.83 with SMTP id k19mr10522562ibh.178.1278710424291;
        Fri, 09 Jul 2010 14:20:24 -0700 (PDT)
Received: from hanuman.int.medicomdigital.com (gateway.medicomdigital.com [75.146.145.33])
        by mx.google.com with ESMTPS id e8sm5895289ibb.20.2010.07.09.14.20.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jul 2010 14:20:23 -0700 (PDT)
In-Reply-To: <AANLkTin7eMFXT1FwZ2ojcAYgqIMSYnkz-uCoRlHvV6Tm@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150688>

Thanks for the tip about keyword expansion. Fortunately for me we don't use those.

When I was trying to debug this the problem seemed to be that the original file is removed from the local Perforce workspace before the p4 diff command is issued. I am not sure how the server upgrade caused this behavior but it was the only thing that changed when I first started seeing the error.

Lance

On Jul 9, 2010, at 3:21 PM, Tor Arvid Lund wrote:

> On Fri, Jul 9, 2010 at 5:05 PM, Thomas Berg <merlin66b@gmail.com> wrote:
>> Hi,
>> 
>> On Fri, May 28, 2010 at 2:30 AM, Lance Linder <llinder@gmail.com> wrote:
>>> Until recently I have been successfully using git-p4 with much joy and
>>> happiness. Then suddenly git-p4 submit started throwing "Command
>>> failed: p4 diff -du ..." when ever I delete or move a file.
>>> 
>>> We recently upgraded our perforce server ( Rev.
>>> P4D/NTX86/2009.2/238357 (2010/03/15) ). It was about this time that
>>> the problem came up. First thing I did of course was upgrade to the
>>> latest version of git ( now on 1.7.1 ) but the problem still persists.
>>> Next I updated my p4 client ( Rev. P4/MACOSX104U/2009.2/238357
>>> (2010/03/15) ) but still same problem. All other submits work fine as
>>> long as there are not any deletions or moves.
>> [...]
>>> 
>>> Anyone else seeing these issues?
> 
> Hi. Are any of you using Perforce's "keyword expansion" stuff? I mean
> the thing where you put a:
> 
> $Id$
> 
> keyword in a file, and it expands to something like:
> 
> $Id: //depot/test/main.c#10 $
> 
> If I do that (and, unfortunately, people at my $dayjob do do that),
> I'm almost sure that this is the error I got... The reason seems to be
> that when git imports the file from P4, the keyword expansions get
> stripped off (as in: reset to just $Id$). And then the p4 diff fails
> if the $Id$ type lines are included in the diff. When deleting a file,
> all lines are included in the diff...
> 
> It hasn't itched me hard enough that I have tried hard to solve it
> (unfortunately). I simply do deletes from P4 instead of git-p4 :-/
> 
> -Tor Arvid-
> 
>> Indeed, we just upgraded our Perforce server too, and now I'm getting
>> this exact error. Did you find a solution to the problem?
>> 
>> If not I'm very interested in solving it. Seems like the p4 diff
>> command has changed behaviour and broken the git-p4 script.
>> 
>> Cheers,
>> Thomas
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
