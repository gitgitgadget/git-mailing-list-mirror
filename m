From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH V3 0/2] specify commit by negative pattern
Date: Sun, 10 Jan 2016 13:25:42 -0000
Organization: OPDS
Message-ID: <87DF51336FE74635921A8C6857125F8B@PhilipOakley>
References: <xmqq37u82apv.fsf@gitster.mtv.corp.google.com> <1452392429-2578-1-git-send-email-ischis2@cox.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Duy Nguyen" <pclouds@gmail.com>,
	"Stephen P. Smith" <ischis2@cox.net>
To: "Stephen P. Smith" <ischis2@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 14:26:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIG0l-0001Tf-38
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 14:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756152AbcAJNZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2016 08:25:45 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:30257 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755914AbcAJNZo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jan 2016 08:25:44 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BKCABEW5JWPEAmFlxeGQEBAQELAQIBAQEBAYMKUm2HTYEMsT6CIYFmJIVlBAKBFDsSAQEBAQEBAQYBAQEBQSQbhC8FAQEBAQIBCAEBLh4BASEFBgIDBQIBAxUMJRQBBBoGBwMUBgESCAIBAgMBiBUMCrYHiUGGVoR/iCGBGwWNPzqJGgGBNoQMiXRKjFWFZIhtKQuEOj40AQEBhXkBAQE
X-IPAS-Result: A2BKCABEW5JWPEAmFlxeGQEBAQELAQIBAQEBAYMKUm2HTYEMsT6CIYFmJIVlBAKBFDsSAQEBAQEBAQYBAQEBQSQbhC8FAQEBAQIBCAEBLh4BASEFBgIDBQIBAxUMJRQBBBoGBwMUBgESCAIBAgMBiBUMCrYHiUGGVoR/iCGBGwWNPzqJGgGBNoQMiXRKjFWFZIhtKQuEOj40AQEBhXkBAQE
X-IronPort-AV: E=Sophos;i="5.20,548,1444690800"; 
   d="scan'208";a="82323539"
Received: from host-92-22-38-64.as13285.net (HELO PhilipOakley) ([92.22.38.64])
  by out1.ip02ir2.opaltelecom.net with SMTP; 10 Jan 2016 14:06:00 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283617>

From: "Stephen P. Smith" <ischis2@cox.net>
> Add support for negative pattern matching in  <at> ^{/<pattern>} style

Has this become mangled by replacing the '@' with ' <at> ' ?

When I look at the update to revisions.txt it doesn't look like its touching 
the '@' description.
Is this '@^' a new (for the documenation) combination. Or has the example 
confused me?

> revision specifiers. So now you can find the first commit whose message
> doesn't match a pattern, complementing the existing positive matching.
> e.g.:
>
>    $ git rebase -i  <at> ^{/!-^WIP}
>
> My use-case is in having a "work, work, work, rebase, push"-style
> workflow, which generates a lot of "WIP foo" commits. While rebasing is
> usually handled via "git rebase -i origin/master", occasionally I will
> already have several "good, but not yet ready to push" commits hanging
> around while I finish work on related commits. In these situations, the
> ability to quickly "git diff  <at> ^{/!-^WIP}" to get an overview of all
> changes "since the last one I was happy with", can be useful.
>
> This is the second version of the patch series. The previous attempt
> used the notation  <at> ^{/!WIP}, rather than  <at> ^{/!-WIP}, so the 
> "modifier"
> was the '!' character. Now, '!' is taken as an indicator that the
> pattern is to be interpreted differently, and '-' is taken as an
> indicator of how it is to be interpreted differently. This follows
> recent discussion with "Junio C Hamano" <gitster <at> pobox.com> and 
> much-less
> recent discussion archived at:
>
> http://thread.gmane.org/gmane.comp.version-control.git/40460/focus=40477
>
> In summary, '!' is to be used as an "escape hatch", for further
> extension of the "name commit by pattern" functionality. Theorised future
> extensions indicated things like "what was to be searched",
> e.g.:  <at> ^{/!(a=author)}.  With only two interpretations of the '!'
> leader, for now (including the '!!' literal notation), adding such a
> verbose form, such as ' <at> ^{/!(negative)foo}', seemed inappropriate at 
> this
> time. In the event that such verbose forms are ever implemented, this new
> form may act as a shorthand, for a basic case.
>
> Will Palmer (2):
>  test for '!' handling in rev-parse's named commits
>  object name: introduce '^{/!-<negative pattern>}' notation
>
> Documentation/revisions.txt | 11 +++++-----
> sha1_name.c                 | 20 ++++++++++++-----
> t/t1511-rev-parse-caret.sh  | 53 
> ++++++++++++++++++++++++++++++++++++++++++++-
> 3 files changed, 73 insertions(+), 11 deletions(-)
>
--
Philip 
