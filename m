From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] help.c: add a compatibility comment to cmd_version()
Date: Fri, 19 Apr 2013 00:00:07 +0100
Organization: OPDS
Message-ID: <046DF03A85924057935F3EB1064DC27B@PhilipOakley>
References: <1366144405-61438-1-git-send-email-davvid@gmail.com><3D6BDB8830FC44A38B1AC508488049C0@PhilipOakley><7vvc7mhzok.fsf@alter.siamese.dyndns.org><EAD161814DB34F5AAC61A9EF06873314@PhilipOakley> <7vehe8d7bq.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "David Aguilar" <davvid@gmail.com>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 01:00:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxoK-0007gH-6F
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080Ab3DRXAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 19:00:05 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:59578 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753557Ab3DRXAE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Apr 2013 19:00:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvQNACV6cFFZ8Yje/2dsb2JhbABQgwY2iHC3ZwQBAwGBBhd0ghoFAQEEAQgBAS4eAQEhBQYCAwUCAQMVAQslFAEEGgYHFwYTCAIBAgMBA4d6Cgi+MI1hGjNfC4JtYQOIT4NCgjKJZ4VWgwKHGYMMO4Ev
X-IronPort-AV: E=Sophos;i="4.87,504,1363132800"; 
   d="scan'208";a="426148562"
Received: from host-89-241-136-222.as13285.net (HELO PhilipOakley) ([89.241.136.222])
  by out1.ip01ir2.opaltelecom.net with SMTP; 19 Apr 2013 00:00:02 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221701>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Thursday, April 18, 2013 1:13 AM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> How about
>>    * E.g. git gui uses the extended regular expression "^git version
>> [1-9]+(\.[0-9]+)+.*"
>>    * to check for an acceptable version string.
>>
>> The ERE is from git-gui.sh:L958.
>
> That is exactly the kind of guarantee we do _not_ want to give.
>

So you are trying to avoid giving _any_ "guarantee" about what visible 
manifestation a user may obtain about a system that passes the test 
suite we have set out. I was hoping we could give a basic minimum 
indication of the expected style of the version string for a git which 
*passes* our tests. But like you say, it doesn't form a real guarantee - 
caveat emptor still applies.

>> ... Hence my suggestion of the basic test that a "passing" git
>> would produce a consistent version string.
>
> I have been assuming that you are trying to avoid an exchange like
> this one we had in the past:
>
> 
> http://thread.gmane.org/gmane.comp.version-control.git/216923/focus=217007
>
In a sense yes. As David noted, others do attempt to trust us via our 
current version string format. I thought it worthwhile (given my earlier 
'mistake' in 216923/focus=216925) to suggest such a basic indication of 
our current string style.

> I also have been assuming that you are pushing to limit the possible
> versioning scheme, but I do not know what that extra limitation
> would achieve in the real world.
>
> By sticking to the pattern "git gui" happens to use, "git gui" may
> be able to guess that the next version of Git says it is verison
> "1.8.3".  That is the _only_ thing your "test" buys.
>
> But having parsed the "1.8.3" substring out of it, "git gui" does
> not know anything about what 1.8.3 gives it.  As far as it is
> concerned, it is a version whose "git version" output it has never
> seen (unless it has been kept up to date with the development of
> Git).

You are focusssing on the wrong side of issue (from my viewpoint).
If my earlier patch had gone in, it would have passsed our tests but not 
played nicely with the community tools. That would have been IMHO a 
regression, so from my viewpoint I believed it was worth having a test 
to avoid such a 'regression'.

>
> By matching against "git version [1-9]+(\.[0-9]+)+", it is accepting
> that future versions may break assumptions it makes for some known
> versions (which is warranted) and all future versions (which is
> unwarranted) of Git.  Maybe the version 2.0 of Git adds all changes
> in the directory "d", including removals, when you say "git add d",
> but it may have assumed that with Git version 1.5.0 or newer, saying
> "git add d" would result in added and modified inside that directory
> getting updated in the index, but paths removed from the working
> tree will stay in the index.

If it was a gross incompatibility then (a) we are likley to be 
signalling it for a while, and (b) other tools would need updating as 
well, and they would hope that they could 'read' the version in a 
consistent style. We would also still have the choice of changing our 
existing string style, which would explicitly signal a change via the 
test fail.

>
> The only thing the scripts that read from the output of "git
> version" can reliably tell is if it is interacting with a version of
> Git it knows about.  If it made any unwarranted assumption on the
> versions it hasn't seen, it has to be fixed in "git gui" _anyway_.
>
> Of course, we would not change the output of "git version"
> willy-nilly without good reason, but that is a different topic.
Ah. I thought it was the [original] topic. I was calibrating the 
willy-nillyness ;-)

>
> So I do not know what you want to achieve in the real world with
> that extra limitation on the "git version" output format.
>
> Maybe you are proposing something else.  I dunno.
I was just using a slightly different philosophical approach.

> --
Philip
