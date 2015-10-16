From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to rebase when some commit hashes are in some commit messages
Date: Fri, 16 Oct 2015 09:01:07 +0100
Organization: OPDS
Message-ID: <84D417D967EA4E31B0AD471329E9577C@PhilipOakley>
References: <561C1132.3090606@orange.fr><vpqsi5fx2gr.fsf@grenoble-inp.fr><561CC5E0.7060206@orange.fr> <20151013160004.11a103942062ee09c53bd235@domain007.com> <AD64941D9533442AB025BE27FF8F08AF@PhilipOakley> <561F597B.8090102@orange.fr> <alpine.DEB.1.00.1510151134250.31610@s15462909.onlinehome-server.info>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Konstantin Khomoutov" <kostix+git@007spb.ru>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Git List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Francois-Xavier Le Bail" <devel.fx.lebail@orange.fr>
X-From: git-owner@vger.kernel.org Fri Oct 16 10:01:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmzx6-0002ry-Vz
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 10:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbbJPIBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 04:01:10 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:26351 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751560AbbJPIBI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2015 04:01:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DOCACfrSBWPF0MFlxeGQECBIMGgUKGWm24BoYUBAQCgTJNAQEBAQEBBwEBAQFBP4QhBQEBAQECAQgBAS4eAQEhCwIDBQIBAxUDCSUUAQQaBgcDFAYBEggCAQIDAYgIAwoMtmqMYQELIIZ2hH6CUII9gyGBFAWNSIhVAYEeqAyCdB2BVj0zhWcBAQE
X-IPAS-Result: A2DOCACfrSBWPF0MFlxeGQECBIMGgUKGWm24BoYUBAQCgTJNAQEBAQEBBwEBAQFBP4QhBQEBAQECAQgBAS4eAQEhCwIDBQIBAxUDCSUUAQQaBgcDFAYBEggCAQIDAYgIAwoMtmqMYQELIIZ2hH6CUII9gyGBFAWNSIhVAYEeqAyCdB2BVj0zhWcBAQE
X-IronPort-AV: E=Sophos;i="5.17,687,1437433200"; 
   d="scan'208";a="801034719"
Received: from host-92-22-12-93.as13285.net (HELO PhilipOakley) ([92.22.12.93])
  by out1.ip01ir2.opaltelecom.net with SMTP; 16 Oct 2015 09:01:06 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279738>

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi Francois-Xavier,
>
> On Thu, 15 Oct 2015, Francois-Xavier Le Bail wrote:
>
>> On 13/10/2015 15:29, Philip Oakley wrote:
>>
>> > Thus the only sha1 numbers that could be used are those that are
>> > within the (possibly implied) instruction sheet (which will list the
>> > current sha1s that will be converted by rebase to new sha1's).
>>
>> Yes.
>
> So what happens for commits that are in the pick list but then end up not
> being rewritten at all, e.g. when a patch has been applied upstream (and
> the --cherry logic did not detect that) and then you end up with a "No
> changes to commit"? And what if a patch ends up in merge conflicts and the
> user just skips it? And what if the referenced commit is to be picked
> *afterwards* due to the commits being reordered?

My policy (bikeshed) for these style of occurrences would be that such 
'disappeared sha1 refs' should be considered as equivalent to a 'merge 
conflict' "known"<>"unknown", and drop the user into the appropriate review 
code path so the user can fix it up.

A sha1 ref can only 'disappear' if it was known before hand, that is, it 
must have been reachable from the tip of the original rebase.

Only those commits between the original rebase tip and its merge-base with 
the destination (e.g. --onto) are candidates for re-write. When taken along 
with the minimum (config) length for a sha1 it should be pretty robust to 
false positives.

In the case of --orphan branch rebasing one does get left and right roots 
for the 'merge-base' which is a particular corner case.

>
> It would appear that the strategy you propose is still too ill-defined to
> make for a robust feature.
>
> Ciao,
> Johannes
>
> P.S.: The recommended way to refer to a commit is not only using the SHA-1
> but also mentioning the one-line, and even the date. That way, even
> rebased commits can found most of the time. This is not fool-proof, by
> far, of course, but still better than trying to rewrite a SHA-1 and
> failing.
>

In terms of re-writing a quoted --one-line ref, the tool must also be told 
(config option) the few valid quoting commands the user wishes to re-write, 
so that if the sha1 is part of a full quote then the whole quote can be 
replaced by a fresh quote of the updated commit (especially in the --onto 
case).
