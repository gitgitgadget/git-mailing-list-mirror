From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Make git prune remove temporary packs that look like
 write failures
Date: Wed, 06 Feb 2008 14:43:37 -0600
Message-ID: <47AA1BF9.5030803@nrlssc.navy.mil>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>	 <alpine.LFD.1.00.0802051357420.2732@xanadu.home>	 <47A9E4F9.8050100@nrlssc.navy.mil>	 <e1dab3980802061059m5bf9c291s892da586248e229c@mail.gmail.com>	 <47AA0D60.60504@nrlssc.navy.mil> <e1dab3980802061157r36dfa8b9uab49af013cb8e963@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	David Steven Tweed <d.s.tweed@reading.ac.uk>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:45:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMr8S-0000dy-Fq
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110AbYBFUoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755870AbYBFUoL
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:44:11 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38149 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474AbYBFUoK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 15:44:10 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m16KhbEp014415;
	Wed, 6 Feb 2008 14:43:38 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 Feb 2008 14:43:37 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <e1dab3980802061157r36dfa8b9uab49af013cb8e963@mail.gmail.com>
X-OriginalArrivalTime: 06 Feb 2008 20:43:37.0872 (UTC) FILETIME=[F30D7100:01C86900]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15706001
X-TM-AS-Result: : Yes--13.712500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDYzOS03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDE2MC03MDIzNTgtNzAwNjI0LTcwOTI1MS03?=
	=?us-ascii?B?MDk1ODQtNzAyOTAxLTcwNDI1Ny03MDM3MzEtNzA4NTU4LTEyMTEx?=
	=?us-ascii?B?MC03MDU4NjEtNzA4MzI1LTcwOTA2NS03MDYyOTAtNzAzNzg4LTcw?=
	=?us-ascii?B?MTQ2MS03MDEyMzYtMTA1NzAwLTE0ODAzOS0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72850>

David Tweed wrote:
> On Feb 6, 2008 7:41 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> They use sprintf for the "%02x" part, but they use memcpy to copy the return
>> of get_object_directory() into a fixed string and then append onto that,
>> rather than repeatedly writing the same string over and over. Ok, there is one
>> instance in builtin-prune.c that repeatedly writes path, but builtin-prune-packed.c
>> does the memcpy thing.
> 

>So I don't think efficiency is an issue.

Yeah not performance critical, readability is definitely more important.

I just don't like repeatedly doing:

   sprintf(dst, "static string %s", s)

when the "static string" part doesn't change.

Either way it doesn't make much difference here.

-brandon
