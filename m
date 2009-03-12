From: =?ISO-8859-1?Q?Johan_S=F8rensen?= <johan@johansorensen.com>
Subject: Re: [PATCH] Introduce a filter-path argument to git-daemon, for doing 
	custom path transformations
Date: Thu, 12 Mar 2009 20:06:25 +0100
Message-ID: <9e0f31700903121206m3adbabacra655c5d340365f43@mail.gmail.com>
References: <49B7DFA1.4030409@viscovery.net>
	 <1236852820-12980-1-git-send-email-johan@johansorensen.com>
	 <alpine.DEB.1.00.0903121218000.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 12 20:08:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhqG9-00024f-TU
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 20:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbZCLTGa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 15:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754035AbZCLTGa
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 15:06:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:47268 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790AbZCLTG3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 15:06:29 -0400
Received: by nf-out-0910.google.com with SMTP id d21so596032nfb.21
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 12:06:25 -0700 (PDT)
Received: by 10.210.131.6 with SMTP id e6mr40462ebd.64.1236884785501; Thu, 12 
	Mar 2009 12:06:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903121218000.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113106>

On Thu, Mar 12, 2009 at 12:29 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

(all my comments below refer to my latest patch)

> More importantly, you might want to point out the security concerns o=
f
> running a script with the full permissions of git-daemon. =A0(AFAICT =
from
> your patch you are not dropping any privileges at any point.)

Do you really think this is needed? It doesn't seem like running the
hook scripts does anything more than trusting the script author and
permissions of the hook scripts (?). I see the path-filter script
exactly the same way, with the exception of having to double-check the
user supplied path the script receives.

> Which brings me to another idea: we have quite a few places in Git wh=
ere
> we use regular expressions. =A0Would they not be enough for your use =
case?

Hmm, please do elaborate on your idea. If you mean being able to
supply a bunch of regexp mappings when starting the daemon then it
wouldn't cut it for me; I'm in need of something more dynamic.

>> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon=
=2Etxt
>> index 36f00ae..efd1687 100644
>> --- a/Documentation/git-daemon.txt
>> +++ b/Documentation/git-daemon.txt
>> @@ -71,6 +72,18 @@ OPTIONS
[snip]
> Please keep the lines shorter than 81 characters.

I believe the longest line I've added in the docs is 77.

> But there is more: what about concurrent accesses?

The external path-filter script is run from the execute(), which is
forked+exec'ed for each incoming connection to the daemon, so that
would mean a concurrency of one in that child-process, unless I've
missed something in the code path?

>> + =A0 =A0 read(filter_cmd.out, result, sizeof(result) - 1);
>
> No error checking?
>
> BTW we do have strbuf_read(), which would solve your "static char *"
> problem nicely.

I'm using strbuf_read() now, but this being my very first git patch, I
may have misunderstood the api slightly?

> And your code would be even easier to read if your
> run_path_filter_script() would never return NULL, but the unchanged p=
ath
> instead.

Done.

Thanks for giving my patch the run-through. I'm still curious to hear
what people think about the idea in general though!

>
> Ciao,
> Dscho
>

Cheers,
JS
