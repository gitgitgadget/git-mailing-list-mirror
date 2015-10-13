From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to rebase when some commit hashes are in some commit messages
Date: Tue, 13 Oct 2015 14:29:57 +0100
Organization: OPDS
Message-ID: <AD64941D9533442AB025BE27FF8F08AF@PhilipOakley>
References: <561C1132.3090606@orange.fr><vpqsi5fx2gr.fsf@grenoble-inp.fr><561CC5E0.7060206@orange.fr> <20151013160004.11a103942062ee09c53bd235@domain007.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	<git@vger.kernel.org>
To: "Konstantin Khomoutov" <kostix+git@007spb.ru>,
	"Francois-Xavier Le Bail" <devel.fx.lebail@orange.fr>
X-From: git-owner@vger.kernel.org Tue Oct 13 15:30:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlzeb-0002cp-2l
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 15:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbbJMNaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 09:30:00 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:3656 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751904AbbJMNaA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 09:30:00 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2ADLgBwBh1WPFc7FlxeGQECAQGDCIFChlttuDODE4IKdQQEAoFATQEBAQEBAQcBAQEBQSQbQQEBAwGDWgUBAQEBAwgBAS4eAQEhCwIDBQIBAxUDCSUUAQQaBgcDFAYBEggCAQIDAYghtBGNCgErhnWEfoUNgyGBFAWNDjqITgGBHo1TkWiEWYNvgnMBHYFVPTMBgX9ogiKBZwEBAQ
X-IPAS-Result: A2ADLgBwBh1WPFc7FlxeGQECAQGDCIFChlttuDODE4IKdQQEAoFATQEBAQEBAQcBAQEBQSQbQQEBAwGDWgUBAQEBAwgBAS4eAQEhCwIDBQIBAxUDCSUUAQQaBgcDFAYBEggCAQIDAYghtBGNCgErhnWEfoUNgyGBFAWNDjqITgGBHo1TkWiEWYNvgnMBHYFVPTMBgX9ogiKBZwEBAQ
X-IronPort-AV: E=Sophos;i="5.17,678,1437433200"; 
   d="scan'208";a="560998777"
Received: from host-92-22-59-87.as13285.net (HELO PhilipOakley) ([92.22.59.87])
  by out1.ip03ir2.opaltelecom.net with SMTP; 13 Oct 2015 14:29:57 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279500>

From: "Konstantin Khomoutov" <kostix+git@007spb.ru>
> On Tue, 13 Oct 2015 10:50:40 +0200
> Francois-Xavier Le Bail <devel.fx.lebail@orange.fr> wrote:
>
>> >> For example, if I rebase the following commits, I would want that
>> >> if the commit hash 2222222... become 7777777...,
>> >> the message
>> >> "Update test output for 2222222222222222222222222222222222222222"
>> >> become
>> >> "Update test output for 7777777..."
>> >>
>> >> Is it possible currently? And if yes how?
>> >
>> > AFAIK, it's not possible other than by editing the message by hand.
>>
>> It seems to me useful to be able to do it. Can we hope a new option?
>
> How do you think this could be practically implemented?
>
> A couple of things which immediately spring to my mind:
>
> To begin with, you are free to specify just a few first characters of
> the commit name you're referring to.  So the alogrythm which finds the
> relevant commits them has to be smart to somehow avoid misfires.  Or
> have knobs to tune it (like -M of `git log`).
>
> OK, suppose that this is solved through the usage of some agreed-upon
> keywords in the commit message.  Say, you adopt a policy to put
> something like
>
>  X-Refers-To: 2dd8a9d9bb33ebffccb2ff516497adc8535bcab4
>
> in your commit message to make the finder tool happy.
>
> Now think how exactly it should work.  First, any commit at all might
> mention the name of the target commit in its commit message.  Okay,
> let's suppose there will be some way to somehow prune the possible DAG
> down.  Then what happens if the commit to change is a part of the chain
> of commits reachable from some branch other than that you're rebasing?
> Automatically rebasing it would rewrite that commits and all commits
> "after" it -- possibly resulting in what the "Recovering from upstream
> rebase" part of the git-rebase(1) manual page deals with.
>
> Having said that, the feature you're after appears to me to be a
> sensible thing to have but the possibility of its generic implementation
> appears to be moot.
>
> Note that to deal with narrow simple cases (all possibly affected
> commits leave on the same branch you're rebasing, and come later than
> the rebase's anchor) you could write a script which uses `git log` to
> find those commits which need special care.

My tuppence is that the only sha1's that could/would be rewritten would be 
those for the commits within the rebase. During rebasing it is expected that 
the user is re-adjusting things for later upstream consumption, with social 
controls and understandings with colleagues.

Thus the only sha1 numbers that could be used are those that are within the 
(possibly implied) instruction sheet (which will list the current sha1s that 
will be converted by rebase to new sha1's).

It should be clear that the sha1's are always backward references (because 
of the impossibility of including a forward reference to an as yet 
un-created future commit's sha1).

The key question (for me) is whether short sha1s are accepted, or if they 
must be full 40 char sha1's (perhaps an option). There are already options 
for making sure that short refs are not ambiguous.

It sound to me like a sensible small project for those that have such a 
workflow. I'm not sure if it should work with a patch based flow when 
submitting upstream - I'm a little fuzzy on how would the upstream 
maintainer know which sha1 referred to which patch.

Philip 
