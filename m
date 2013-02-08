From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Improve 'git help' with basic user guide linkss
Date: Fri, 8 Feb 2013 21:43:38 -0000
Organization: OPDS
Message-ID: <6BC280F5827C4098BCB6276232DDE8E4@PhilipOakley>
References: <6D91D31A093D46869F43DD8D1012F0FB@PhilipOakley> <7vr4kqzfw5.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 22:43:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3vjZ-0007J3-El
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 22:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947151Ab3BHVn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 16:43:26 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:19173 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1947122Ab3BHVn0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2013 16:43:26 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsALAF5SFVFcHls+/2dsb2JhbABFjAmzdQICgQgXc4IaBQEBBAEIAQETGx4BASELAgMFAgEDFQELJRQBBBoGBxcGEwgCAQIDAYd6Cgi/O405GQNLglthA4gwhVeYcIMA
X-IronPort-AV: E=Sophos;i="4.84,630,1355097600"; 
   d="scan'208";a="62094629"
Received: from host-92-30-91-62.as13285.net (HELO PhilipOakley) ([92.30.91.62])
  by out1.ip07ir2.opaltelecom.net with SMTP; 08 Feb 2013 21:43:24 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215821>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, February 08, 2013 8:53 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> I'm looking at extending the 'git help' to include some information
>> for the basic user who isn't ready for the extensive man page
>> documentation for the various commands.
>
> We have pointers at the beginning of "git(1)" for that exact reason.
> I am not saying the documents pointed at from there are perfect, but
> shouldn't that approach work?

The problem for the new user is to find that page you need to know the
command 'git help git' which is unlikely. We know where to find it, they
don't.

My initial https://github.com/PhilipOakley/git/commit/e6217d simply 
updates
-  N_("See 'git help <command>' for more information on a specific 
command.");
+  N_("See 'git help <command>' for more information on a specific 
command.\n"
+     "Or 'git help <guide>', such as 'tutorial' for an introduction to 
Git.");
as a starter for the new users.

It's then a case of providing an option to show the common and other 
guides.

>
>> My real question is on the right approach to generating a list of
>> guides and including them into the git help options. I'm planning on
>> extending the command-list.txt file to include 'guides' and then
>> extending the generate-cmdlist.sh to generate a guides array in
>> common-cmds.h.
>
> Having a catalog of guide documents in help.o sounds like a good way
> to go, but I doubt "command-list" is a good place to store it.  It
> is about git subcommands, "git help -a" uses it to show the list of
> them, and the bash completion support uses the list via "git help -a".
>
> The common-cmds.h does not have to be the only avenue to add your
> catalog of guide documents to help.o. As a part of the build
> procedure, you can list Documentation/guides/ and generate an array
> definition into "guides.h", and add #include "guides.h" in help.c,
> for example.
Agreed in the sense I'd been thinking of doubling up the code but making 
use of the "command list" with its categories did appear to kill two 
birds with one stone. It could be that the shell script could simply 
generate the two .h files if appropriate.

>
>> I'm thinking of adding -g --guides and -c --commands options to
>> complement the existing -a --all (becomes both commands and guides)
>
> Complement is fine.  Contaminating -a with guides is probably not.

My view is that help --all (-a) is essentially incomplete as it 
currently doesn't provide all the help.
The -c option would provide just the commands for the command completion 
case.

>
>> I was expecting to update the user-manual. to become
>> gituser-manual.txt so that the existing 'git help user-manual' scheme
>> would discover it. The Tutorial and the User manual obviously(?)
>> being
>> the first port of call for the confused user.
>
> Again, we do have pointer to tutorial fairly prominently at the
> beginning of "git(1)".  Perhaps we want index.html that redirects to
> git.html or something?
