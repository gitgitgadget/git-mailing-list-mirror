From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 0/6]
Date: Tue, 23 Jul 2013 22:26:47 +0100
Organization: OPDS
Message-ID: <68F84DC48FCA4226A8F3C00AC42A9598@PhilipOakley>
References: <1374561800-938-1-git-send-email-gitster@pobox.com><loom.20130723T113216-324@post.gmane.org> <7v8v0x874x.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 23:26:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1k6N-0001c4-Tk
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 23:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933708Ab3GWV0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 17:26:32 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:7076 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932956Ab3GWV0b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jul 2013 17:26:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvYNANjz7lFZ8YYB/2dsb2JhbABbgwY1iRe4DwQBAwGBEhd0gh8FAQEEAQgBAS4eAQEhCwIDBQIBAxUBCyUUAQQIEgYHFwYBEggCAQIDAYdtAwkKr1wNiF6NEoIBaoMZbgOIcoYNhneDEop+hSaDFTs
X-IPAS-Result: AvYNANjz7lFZ8YYB/2dsb2JhbABbgwY1iRe4DwQBAwGBEhd0gh8FAQEEAQgBAS4eAQEhCwIDBQIBAxUBCyUUAQQIEgYHFwYBEggCAQIDAYdtAwkKr1wNiF6NEoIBaoMZbgOIcoYNhneDEop+hSaDFTs
X-IronPort-AV: E=Sophos;i="4.89,730,1367967600"; 
   d="scan'208";a="417270964"
Received: from host-89-241-134-1.as13285.net (HELO PhilipOakley) ([89.241.134.1])
  by out1.ip04ir2.opaltelecom.net with SMTP; 23 Jul 2013 22:26:30 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231062>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Tuesday, July 23, 2013 7:26 PM
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> Junio C Hamano <gitster <at> pobox.com> writes:
>>
>>>
>>> This is mostly unchanged since the previous round, except that
>>>
>>>  * The option is spelled "--force-with-lease=<ref>:<expect>".
>>>    Nobody liked "cas" as it was too technical, many disliked
>>>    "lockref" because "lock" sounded as if push by others were
>>>    excluded by it while in fact this is to fail us.
>>
>> Perhaps "--force-gently" ? :-)

Or "--force-carefully" to better indicate the safety / care that is 
being applied?

>
> Hmph.  But we usually use "gently" to mean "do not give the end user
> an error message--the caller handles the error itself".
>
> While the option lets you break the usual "must fast-forward" rule,
> it is more precise in that the remote ref must be pointing at not
> just any ancestor of what you are pushing, but has to be at the
> exact commit you specify.
>
> E.g. if you have built one commit on top of the shared branch, and
> try to push it with "push --cas=pu:HEAD^ HEAD:pu" (because you know
> one commit before the tip is where you started from), your push will
> be rejected if somebody else did an equivalent of "reset HEAD~3" on
> the receiving end (perhaps because the top commits recorded some
> material inappropriate for the project).  Your new commit is still a
> decendant of that rewound tip, and usual "must fast-forward" rule
> would accept the push, but with "push --cas=pu:HEAD^ HEAD:pu", you
> will notice that somebody wanted to rewind the tip and pushing your
> work that contains these dropped commit contradicts with that wish.
>
> So I dunno.
> --
