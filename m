From: Manfred Rudigier <manfred.rudigier@omicron.at>
Subject: RE: GIT archive invocation with SHA sum
Date: Fri, 17 Aug 2012 16:20:17 +0200
Message-ID: <95DC1AA8EC908B48939B72CF375AA5E30147317325@alice.at.omicron.at>
References: <95DC1AA8EC908B48939B72CF375AA5E301473171E4@alice.at.omicron.at>
 <7vboiavv7r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 16:20:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2NPj-0002Pd-Qs
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 16:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757086Ab2HQOUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 10:20:34 -0400
Received: from ns.omicron.at ([212.183.10.25]:38795 "EHLO ns.omicron.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756427Ab2HQOUd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2012 10:20:33 -0400
Received: from counter.omicron.at ([212.183.10.29])
	by ns.omicron.at (8.13.1/8.13.1) with ESMTP id q7HEKIkr003647;
	Fri, 17 Aug 2012 16:20:23 +0200
Received: from mary.at.omicron.at (mary.at.omicron.at [172.22.100.48])
	by counter.omicron.at (8.14.4/8.14.4) with ESMTP id q7HEKIHg025814;
	Fri, 17 Aug 2012 16:20:18 +0200
Received: from alice.at.omicron.at ([172.22.100.49]) by mary.at.omicron.at
 ([172.22.100.48]) with mapi; Fri, 17 Aug 2012 16:20:18 +0200
Thread-Topic: GIT archive invocation with SHA sum
Thread-Index: Ac18SRoqN/Hb9K6eQUGdOjsIfUJbpwAM4nUQ
In-Reply-To: <7vboiavv7r.fsf@alter.siamese.dyndns.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: de-DE, en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203615>

Junio C Hamano [mailto:gitster@pobox.com] writes:

>> I have read that this restriction was made for some kind of security
>> reason, and one possibility would be to add a config option on the
>> server repo to turn off this safety check. As we manage the git repos
>> ourselves, this would be perfectly ok for us.
>>
>> What is the current status of this - is there already such a config option?
>
>No, there isn't.
>
>I am no going to say that such a change will never happen, but you may want
>to rethink the way you transfer the source material to your build system,
>especially your build system is rebuilding each and every versions of the
>software.
>
>I can understand that the use of "git archive" can give you a way to start from
>an empty directory and build afresh for every version, but it is stupid to
>_transfer_ the full copy of the source material
>300 times over the network in order to rebuild 300 versions a day, all of which
>will be quite similar to each other (after all, the difference between them will
>be limited by the productivity of your workforce).

Our build system creates an embedded firmware image similar to OpenEmbedded or OpenWrt. There all components (including boot loader, kernel, busybox and many other third party components) are compiled during nightly builds. Each component has its own GIT repository on the server and our build system references those components via SHA-1 sums. Many of those components do almost NEVER change (we do not update the Linux kernel every day), so most of this code must only be fetched once using git archive.

>Fortunately, it is quite simple to fix.  You can maintain a single bare repository
>on the build machine (i.e. the one you currently run "git archive --remote"
>on), and run "git fetch --mirror" against the machine that hosts the repository
>(i.e. the one you currently run "git archive --remote" against) to keep it up to
>date.  That way, you should be able to drastically cut the amount of the
>network traffic from the source repository and the build server.

I know that I could workaround this by mirroring all repositories locally, but it is much more convenient to use git archive right away. I agree that once the repos are mirrored, there is less traffic on the network, but traffic has not been an issue for us so far. Also, a complete mirror of all involved repositories will be much larger than just the exported tar archives (e.g. Linux kernel repo is 770MB, while the tar.gz is just 96MB).

It was a really nice feature of GIT and it is just too bad that it is no longer available.

Regards,
Manfred
