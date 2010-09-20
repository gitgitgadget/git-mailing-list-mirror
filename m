From: Artur Skawina <art.08.09@gmail.com>
Subject: Re: Find out on which branch a commit was originally made
Date: Mon, 20 Sep 2010 12:58:35 +0200
Message-ID: <4C973E5B.4090201@gmail.com>
References: <1jp42v5.w5dez21d3nlciM%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Mon Sep 20 12:58:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxe57-0007Bk-T7
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 12:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938Ab0ITK6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 06:58:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63032 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570Ab0ITK6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 06:58:40 -0400
Received: by eyb6 with SMTP id 6so1511757eyb.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 03:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        bh=cb4k9kZtg6ErhV2TqoTt5wsA393VSr4rOtMnm59ySC0=;
        b=JXtzevyhayJL5V5XTFyaUpW6X0BIZn1aQbWivsjaBQHmFWfhq24Lf+9g0HZIUBiarx
         xsxyKAAZwYImDw2bG7XStgcgYf/fFa2pR1IsVJOFyFTlauWYysMV7hlyXKY/nrfm8wfi
         sSd7c40Qcv93tZ47zuaeF25c+rxnsgBnbXQKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type
         :content-transfer-encoding;
        b=ddNpl5EyVrFJVUqqUjXc3uVESKF10z3JlZtY4zwekWsJ2g0JXd9v2lTGp5yYDjMQrc
         oB0ozbZqEN+6z1riqAhp+PHKPsMhy6ttgb4qXxW62ubHHVjIkxFzGQJbDO7LZ/KEvEyR
         Me+cMfXkqvGMbU1oygyBDBWsPdmwRkVqetpYw=
Received: by 10.213.75.139 with SMTP id y11mr6662790ebj.99.1284980318873;
        Mon, 20 Sep 2010 03:58:38 -0700 (PDT)
Received: from [172.19.43.221] (ip-89-174-121-164.multimo.pl [89.174.121.164])
        by mx.google.com with ESMTPS id v59sm10770718eeh.16.2010.09.20.03.58.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 03:58:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.9pre) Gecko/20100819 Lightning/1.0b2 Lanikai/3.1.3pre
In-Reply-To: <1jp42v5.w5dez21d3nlciM%lists@haller-berlin.de>
X-Enigmail-Version: 1.1.1
OpenPGP: id=DDEB1C43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156613>

On 09/20/10 10:12, Stefan Haller wrote:
> Seth Robertson <in-gitvger@baka.org> wrote:

>>          -AA-- subtopic
>>         /     \
>>        A---B---C topic
>>       /         \
>>  D---E---F---G---H---I---J---K---L---M---N master
>>                           \         /
>>                            O---P---Q another-topic
>>
>>
>> In the above example, the subtopic branch merge from AA to C prevents
>> you from finding out what branch B is on using the original script.
> 
> When you say "the original script", are you talking about Artur's
> one-liner or my script?
> 
> My script gives me exactly the information I want in all cases.  For a
> given command $1 and a target branch $2, it shows you all merges that
> were involved in bringing $1 into $2. For example:
> 
>   Called with "B" "master", it returns H

No, it will return both C and H, just like my one-liner; this will be
misleading, the user won't be able to figure out where 'B" came from
w/o looking at the graph, from output like:

$ git-show-merges-since B master
C..... Merge branch 'subtopic' into topic
H..... Merge branch 'topic'

The results for 'B' and 'AA' will be exactly the same.

For 'B', the 'C' merge should be omitted; skipping it because 'B'
comes in via first parent would probably work, but i can't turn that
into a one-liner right now...


On 09/20/10 07:47, Seth Robertson wrote:
> I agree 100% that the right answer is topic for B and master for F.
> 
> I know how to get topic for B.  Finding master (and not another-topic)
> for F is difficult because we have to know something that I don't know
> how to get git to tell me: when another-topic branch was created.
> Using git-rev-parse another-topic....master we know what commit
> another-topic and master diverged, but I cannot figure out a way to
> discover which branch was created at that point and which branch
> pre-existed (obviously for master we know, but if this was a
> supertopic branch we would not).  I thought about using merge
> direction for subsequent merges as a hint, but we don't know if the
> second branch has been permanently been merged or not, if there was a
> K->P merge and Q-M did not happen (yet) then we would give the wrong
> branch name.

Oh, if there would be no 'Q->M' merge and both branches would still
be "live", 'both' is certainly the right answer.

If 'another-topic' was merged into another branch (like in the example
graph) and is dead at this point, i think skipping it is the correct
decision -- there could be many such branches and presenting a long
list of candidates won't really help the user.

Given history as in the graph and a /live/ 'another-topic' -- hmm, 
if there are just a few such refs maybe showing them would be ok.

artur
