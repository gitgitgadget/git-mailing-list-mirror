From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: rsync busy non-bare git repo 'source' to quiet
Date: Tue, 08 Mar 2011 17:00:59 -0600
Message-ID: <4D76B52B.8070307@gmail.com>
References: <il66rd$46u$1@dough.gmane.org> <20110308213959.GB5786@sigill.intra.peff.net> <4D76ABB1.9080001@gmail.com> <20110308223841.GA6648@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 09 00:01:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px5ty-0000Vn-78
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 00:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974Ab1CHXBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 18:01:08 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61929 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297Ab1CHXBH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 18:01:07 -0500
Received: by gyh20 with SMTP id 20so2205666gyh.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 15:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version
         :newsgroups:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=gN8tDxhB2RSZR0DQ91V4Nn4x9m4hY6b9+cDRZoAYy2Y=;
        b=DDpCXhey9nAR5L7a4S8mpC9F40J/mnxtVuRgz/pUnmuiIRRDM8ncM2mVnhescjUVuS
         gmWYFONe1bzZ7/KSM+UKU6KN+Bwmt1iX40DdngWUdnfSQtQT3qJ60UmBldjaU4qHrtSJ
         ZVtfppsprWs5HIBSi+bIngllKGXGXpMXdWy7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=wgUAOFl4O/mTZGbmATfO0lkXkcinC8CteCqhRTEumQuYSaskS52Var0nrRj1IPK/DI
         YvepE8gD6dWcPqVHKvoKP7xBqkafNSoFUloQ+bvr1xeh7U9yrF7NjOIdkL2/INdHNOxw
         +YJD3e1wrmNRK82cpCueBA9H61Wu817YkZQZM=
Received: by 10.100.126.2 with SMTP id y2mr2366765anc.10.1299625266737;
        Tue, 08 Mar 2011 15:01:06 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id c18sm932874ana.1.2011.03.08.15.01.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 15:01:06 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20110308223841.GA6648@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168715>

On 3/8/2011 4:38 PM, Jeff King wrote:
> On Tue, Mar 08, 2011 at 04:20:33PM -0600, Neal Kreitzinger wrote:
>
>> Rsync seems like a simpler solution and more accurate solution for
>> creating a copy of an ecosystem of interrelated git repos colocated on
>> the same box.
>
> Sure. It is simpler, but not atomic unless you do a multi-stage rsync.
>
>> A previous post in the newsgroup states:
>>> If you want your rsync backup to be fine, you need to follow some
>>> ordering.  You need to copy the refs first (.git/packed-refs and
>>> .git/refs/), then the loose objects (.git/objects/??/*), and then all
>>> the rest.  If files are copied in a different order while some write
>>> operations are performed on the source repository then you may end up
>>> with an incoherent repository."
>>
>> Would that work?
>
> If you do it in that order, the end result will be a consistent repo.
> But during the copy, the refs at the destination will point to objects
> you don't have. I don't know if that matters for your case.
>
We won't be trying to used the "destination" repos during the rsync. 
The workflow will be:
(1) I need to test a change to the goldbox change control menu system.
(2) I determine that my testbox "copy" of the change control menu system 
has repos that are too out-of-date for a good test, so I run rsync to 
make a fresh copy of the goldbox.
(3) After the rsync is finished, I pull over just the branch that 
contains my untested change menu scripts.  (this is the only git pull i 
do from goldbox to testbox.)
(4) I test the changes and see they are good.
(5) I merge the changes into the master branch of the change control 
menu non-bare repo on the goldbox.  The menu runs from the working tree 
so now they are live.

Since I won't be trying to access refs in the "destination" repos via 
git commandline or gui while the rsync is running, it sounds like it 
will be ok.  I can keep people from banging on the testbox.  I can't 
keep them from banging on the goldbox.

In regards to the working tree of a busy "source" repo, it sounds like 
it could end up not matching the index.  At the end of the script I 
could execute a "git reset --hard && git clean -f" on each non-bare repo 
as you suggested.  That would be pretty straightforward.

Thanks!

v/r,
Neal
