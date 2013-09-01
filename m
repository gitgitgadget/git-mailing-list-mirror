From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 01/11] replace: forbid replacing an object with one of a different type
Date: Sun, 1 Sep 2013 20:26:28 +0100
Organization: OPDS
Message-ID: <9D27EE89D9994C0997D19E0C0AF7493F@PhilipOakley>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org><20130831191215.26699.18957.chriscool@tuxfamily.org><7D7C5D53BA544AAD92B05DF9635926C8@PhilipOakley> <20130901.135321.1182162250658468787.chriscool@tuxfamily.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <gitster@pobox.com>, <git@vger.kernel.org>, <trast@inf.ethz.ch>,
	<j6t@kdbg.org>
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Sep 01 21:26:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGDHx-0005vo-OW
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 21:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756290Ab3IAT0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 15:26:17 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:24928 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752894Ab3IAT0R (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Sep 2013 15:26:17 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: An0MAB+UI1JOl3GZ/2dsb2JhbABagweJa7d+BAQBgR0XdGgBAYEfAQEUAQQBAQQBCAEBLh4BASELAgMFAgEDDgcMJRQBBBoGBxcGEwgCAQIDAYU4BwGCEhkKuSuPf4MkgQADiH2GEoUMlUCBOimBPjs
X-IPAS-Result: An0MAB+UI1JOl3GZ/2dsb2JhbABagweJa7d+BAQBgR0XdGgBAYEfAQEUAQQBAQQBCAEBLh4BASELAgMFAgEDDgcMJRQBBBoGBxcGEwgCAQIDAYU4BwGCEhkKuSuPf4MkgQADiH2GEoUMlUCBOimBPjs
X-IronPort-AV: E=Sophos;i="4.89,1002,1367967600"; 
   d="scan'208";a="435766474"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip03ir2.opaltelecom.net with SMTP; 01 Sep 2013 20:26:15 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233590>

From: "Christian Couder" <chriscool@tuxfamily.org>
> From: "Philip Oakley" <philipoakley@iee.org>
>>
>> Sorry for not replying earlier in the series.
>>
>> From: "Christian Couder" <chriscool@tuxfamily.org>
>>> Users replacing an object with one of a different type were not
>>> prevented to do so, even if it was obvious, and stated in the doc,
>>> that bad things would result from doing that.
>>>
>>> To avoid mistakes, it is better to just forbid that though.
>>>
>>> If one object is replaced with one of a different type, the only way
>>> to keep the history valid is to also replace all the other objects
>>> that point to the replaced object.
>>
>> Isn't this a recursion problem? Taken in that order one unravels the
>> whole DAG.
>>
>> However if considered in the reverse direction, one can replace an
>> existing object within the DAG with a carefully crafted alternative 
>> of
>> the same type, but which then wrongly references other dangling
>> objects which are then replaced by objects which have the right type
>> (this last replacement requires -f force).
>
> I am not sure I understand what you are saying.
>
> Anyway in a previous version of this patch I tried to be more explicit
> about this, but Junio basically said that he found no value in
> discussing this more explicitely...

I would agree that it's not worth discussing it more explicitly.

My comment was more about the direction of the line of reasoning which I 
felt was a bit Catch 22 when starting from an existing complete DAG (no 
garbage) and attempting to replace an object with another of a different 
type and still have a valid DAG.  The construction of the replacement 
items needs to be in the right order if one of the replacements is of 
the 'wrong' type (such a construction requires the creation or uses, and 
ultimately replacement of, extraneous objects that aren't (yet) in the 
DAG).

But as already been said that's a problem for the user of the --force 
option ;-)

Philip

>
> Thanks,
> Christian.
> 
