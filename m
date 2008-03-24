From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] filter-branch.sh: support nearly proper tag name
 filtering
Date: Mon, 24 Mar 2008 13:37:23 -0500
Message-ID: <47E7F4E3.8050406@nrlssc.navy.mil>
References: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil> <47E298A5.6050508@nrlssc.navy.mil> <alpine.LSU.1.00.0803201812560.4124@racer.site> <7vr6e01xja.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241152050.4353@racer.site> <7viqzc18j9.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803241609540.4353@racer.site> <47E7D818.7090501@nrlssc.navy.mil> <alpine.LSU.1.00.0803241745240.4353@racer.site> <47E7DFAD.4060209@nrlssc.navy.mil> <alpine.LSU.1.00.0803241812230.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 19:39:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdrZN-0001H9-0x
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 19:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758254AbYCXSiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 14:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759111AbYCXSiK
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 14:38:10 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:54849 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757638AbYCXSiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 14:38:09 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2OIbPuW029629;
	Mon, 24 Mar 2008 13:37:25 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Mar 2008 13:37:24 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LSU.1.00.0803241812230.4353@racer.site>
X-OriginalArrivalTime: 24 Mar 2008 18:37:24.0965 (UTC) FILETIME=[1AA9C950:01C88DDE]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes--15.025000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtMTEzOTIyLTcwMDYzMC03MDA5OTktNzAxNDU1LTcwMDc4Mi03?=
	=?us-ascii?B?MDIwMTYtNzA5NTg0LTcwMjYwOS03MDM1MjktNzA5MTg1LTEzNjA3?=
	=?us-ascii?B?MC03MTA5ODktNzA1MTAyLTcwMDc1Ni03MDEyMzYtNzEwODQyLTcw?=
	=?us-ascii?B?Mzg1MS03MDc3NTAtNzA4MjU3LTcwNDQyNS03MDA3MDEtMTA2NDcw?=
	=?us-ascii?B?LTcwNjgyMy03MDE3NDctNzAxMjAyLTcwNTkwMS0xNDgwMzktMTQ4?=
	=?us-ascii?B?MDUxLTIwMDQz?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78075>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 24 Mar 2008, Brandon Casey wrote:
> 
>> Johannes Schindelin wrote:
>>
>>> On Mon, 24 Mar 2008, Brandon Casey wrote:
>>>
>>>> So right now, tags matching the refspec are rewritten. They are 
>>>> currently rewritten with a lightweight tag.
>>> That is unintended.  My understanding of a tag was always that it is 
>>> something immutable.  I mean, _really_ immutable.  If you released a 
>>> certain version, then that is tagged.  You must not rewrite the tag.  
>>> Ever.
>> Then what is the intended behavior for --tag-name-filter?
> 
> To be honest, I wanted to rip that part out before posting the initial 
> filter-branch patches, and forgot/was too lazy.
> 
> IMO there should be clean semantics first, and a default mode that does 
> _not_ rewrite tags at all first.

There isn't really a "default" mode for --tag-name-filter, a script must
always be supplied. The name of the option (--tag- _name_ -filter) implies
that it is intended for changing the names of tags. If the user decides
not to change the name, then I think the user would expect the old tag to
be replaced.

So the user could choose to:

          Rewrite tag ref: --tag-name-filter cat
                        or
 Give new tags a new name: --tag-name-filter 'sed -e s/$/.new/'
                        or
       Save original tags: --tag-name-filter 'sed -e s/$/.orig/'
     Then create new ones: --tag-name-filter 'sed -e s/\.orig$//' [plus additional filtering]

More precise control over tag filtering should probably have an option
with a different name like --tag-filter, at which point --tag-name-filter
could be deprecated.

-brandon
