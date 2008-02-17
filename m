From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined at config time
Date: Sun, 17 Feb 2008 08:59:31 +0100
Message-ID: <FBA2E61E-5CAF-49E3-A917-ACDD10586928@zib.de>
References: <20080216185349.GA29177@hashpling.org> <CD749541-1B3B-4EA7-82A5-0DFC67B953BE@zib.de> <20080217002029.GA504@hashpling.org> <alpine.LSU.1.00.0802170045210.30505@racer.site> <20080217005620.GB504@hashpling.org> <7vbq6g758h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 09:00:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQeRb-0007he-Cg
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 09:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbYBQH7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 02:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753036AbYBQH7l
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 02:59:41 -0500
Received: from mailer.zib.de ([130.73.108.11]:41245 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947AbYBQH7k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 02:59:40 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m1H7wueZ002174;
	Sun, 17 Feb 2008 08:59:16 +0100 (CET)
Received: from [192.168.178.21] (brln-4db95475.pool.einsundeins.de [77.185.84.117])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m1H7wYo5009283
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 17 Feb 2008 08:58:34 +0100 (MET)
In-Reply-To: <7vbq6g758h.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74101>


On Feb 17, 2008, at 2:15 AM, Junio C Hamano wrote:

> Charles Bailey <charles@hashpling.org> writes:
>
>> On Sun, Feb 17, 2008 at 12:46:15AM +0000, Johannes Schindelin wrote:
>>>
>>> So you'd rather have the end users do the same work for the same  
>>> tool over
>>> and over again?
>>
>> I'm sorry, I should have made myself clearer. I disagree that the
>> approach of adding new tool support to the source code as and when  
>> they
>> are encountered is optimal. I believe that it is preferable to have a
>> solution that allows users to configure, rather then code, support  
>> for
>> their own tools that do not to have native support.
>>
>> I do not disagree that there is benefit to having a wide range of
>> tools that are supported natively.
>>
>> I thought I made a reasonable argument for this in the rest of my
>> email that you took the headline from, but evidently I came across as
>> muddled.
>
> I do not understand why people are so upset about this.  I think
> the approach Charles's patch takes is reasonable, with example
> configurations to coax a few of his tools to be driven by
> mergetool as backends, that demonstrate the customizing
> framework works well.

I am not upset at all and I really appreciate Charles work for
adding a generic mechanism.  I was just wondering why not taking
the direct way of adding tools to git-mergetool one by one until
we eventually have a rather complete list of supported tools.
This would be the easiest solution for end users if their
preferred tool is supported.  It is also easier to add support
for a specific tool than a generic mechanism.

Maybe it is sufficient to refactor "git mergetool" to make it
really easy to add another tool.  Our users are developers who
should know how to add a new tool directly to git mergetool if
they find some guidance in the source.

I see two benefits of the direct approach

  - the source code of git mergetool could be kept simpler without
    a generic configuration mechanism for unknown tools.

  - users would be forced to integrate their tool into git mergetool
    and hopefully they would send patches and eventually we'd have
    rather complete arge number of tools supported.
    (I know at least one case where this pressure helps and I expect
     to see patches that we would not see if a generic mechanism
     was available.)


> It of course would also be good to throw in the native support
> for the tools he used as examples but I'd say that they are
> topics of separate patches.


I believe this is more important than a generic mechanism.

However, I am not opposed to a generic mechanism, ...


On Feb 17, 2008, at 1:20 AM, Charles Bailey wrote:
>>
>> I don't believe that git installs a system config by default, but one
>> idea I had was to rip out all of the native tools support in git
>> mergetool and replace it with a list of predefined custom tools
>> configs. This would put all merge tools on an equal footing and  
>> should
>> make extra tool support patches simpler and easier to integrate. This
>> doesn't have any legs without a system default config, though.

... but I am slightly opposed to this idea.  Note that at least
in one case there is a trick needed to launch the tool.  Such a
trick can easily be coded if the tool is directly added in
"git mergetool"; but it would be much harder to capture by a
generic mechanism via config variables.  The example I mean is
opendiff that needs to be piped to cat (opendiff ... | cat).
Otherwise opendiff detaches FileMerge and returns immediately
without waiting for the user to complete the merge.

		Steffen
