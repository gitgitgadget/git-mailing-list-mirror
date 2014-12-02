From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: tests do not work with gpg 2.1
Date: Tue, 02 Dec 2014 13:55:31 +0100
Message-ID: <547DB6C3.5010704@drmicha.warpmail.net>
References: <xmqqr3wpo8yl.fsf@gitster.dls.corp.google.com> <20141127213224.GA27443@dispater.uplinklabs.net> <54784503.80108@drmicha.warpmail.net> <20141128165009.GA4728@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Steven Noonan <steven@uplinklabs.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 13:55:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvmzS-0007U4-Rj
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 13:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbaLBMzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 07:55:35 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48498 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754485AbaLBMze (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 07:55:34 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id F421C20C5F
	for <git@vger.kernel.org>; Tue,  2 Dec 2014 07:55:33 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 02 Dec 2014 07:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=0p6t6k8muzU7vkRQ9uwO08
	xsH9U=; b=nCv6osG3u84AA7Sn//basMxAPLYDV596NOwhR4dJPsOW5G+1kWB+LE
	Y0Md1m7QjzzH+IgELob3PZnlyX8dxEejWpXKboJG9ncXYr5BI6w1nxmiik2Q8EFN
	1FCA6Tkwzush/4nEyF3h6PgsXNjvL7rqbWi1yRwXgv9yXncj774Q8=
X-Sasl-enc: n72/TKTyr7pfRyBZqTm9wNwuNZ2Dr/az6hogjhNsoWp0 1417524933
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 3F0A96800CB;
	Tue,  2 Dec 2014 07:55:33 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20141128165009.GA4728@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260566>

Jeff King schrieb am 28.11.2014 um 17:50:
> [updated subject, as this is not specific to the v2.2.0 release at all]
> 
> On Fri, Nov 28, 2014 at 10:48:51AM +0100, Michael J Gruber wrote:
> 
>> Are you running gnome_keyring_deamon by any chance? It think it runs by
>> default in Gnome, claims to offer gpg_agent functionality but does not
>> seem to do so fully. I.e., its presence may keep gpg2.1 from starting
>> its own gpg-agent. But gpg2.1 ("gnupg modern branch") needs a new
>> gpg-agent which knows how to handle secret keys for gpg2.1.
>>
>> (I may take a shot at trying, but I'm on Fedora - they're slow and
>> special in all things gpg/crypto. And compiling gpg2.1 means compiling
>> all the bits and pieces that monster consists of these days...)
> 
> I'm not running the gnome daemon (I do normally run gpg-agent, though),
> and I can reproduce.

You get the passphrase prompt, Steven didn't, if I understood correctly.
You can continue successfully by hitting OK, Steven coudn't hit anything...

> I wanted to try experimenting today with making sure GPG_AGENT_INFO was
> unset in the environment. But despite nothing changing (i.e., before I
> even cleared that variable), I'm getting totally different results.
> 
> Now when I run t4202, I get no agent prompt, and just:
> 
>     ok 40 - dotdot is a parent directory
>     
>     expecting success: 
>             test_when_finished "git reset --hard && git checkout master" &&
>             git checkout -b signed master &&
>             echo foo >foo &&
>             git add foo &&
>             git commit -S -m signed_commit &&
>             git log --graph --show-signature -n1 signed >actual &&
>             grep "^| gpg: Signature made" actual &&
>             grep "^| gpg: Good signature" actual
>     
>     Switched to a new branch 'signed'
>     gpg: skipped "C O Mitter <committer@example.com>": No secret key
>     gpg: signing failed: No secret key
>     error: gpg failed to sign the data
>     fatal: failed to write commit object

That is how things turned for Steven, afaik.

> And then a subsequent run gives me:
> 
>     rm: cannot remove '/home/peff/compile/git/t/trash directory.t4202-log/gpghome/private-keys-v1.d/19D48118D24877F59C2AE86FEC8C3E90694B2631.key': Permission denied
>     rm: cannot remove '/home/peff/compile/git/t/trash directory.t4202-log/gpghome/private-keys-v1.d/E0C803F8BC3BCC4990E174E05936A7636E888899.key': Permission denied
>     rm: cannot remove '/home/peff/compile/git/t/trash directory.t4202-log/gpghome/private-keys-v1.d/FCFAC48BF12AC0FCC32B69AB90AA7B1891382C29.key': Permission denied
>     rm: cannot remove '/home/peff/compile/git/t/trash directory.t4202-log/gpghome/private-keys-v1.d/D50A866904B91C0C49A3F6059584F4A09807D330.key': Permission denied
>     FATAL: Cannot prepare test area
> 
> It seems that it creates the private-keys directory without the 'x' bit:
> 
>     $ ls -ld trash*/gpghome/private-keys-v1.d
>     drw------- 2 peff peff 4096 Nov 28 11:45 trash directory.t4202-log/gpghome/private-keys-v1.d/
> 
> So that's weird, and doubly so that it is behaving differently than it
> was last night. Obviously _something_ must have change. Maybe something
> related to the state of my running agent, I guess.
> 
> -Peff
> 

I think if you unset GPG_AGENT_INFO, gpg2.1 thinks there is no agent,
starts it's own and talks to it via a socket directly (no env variable).
Now that one seems come with different options (regarding pinentry) so
that it can't even ask you for a passphrase.

That private-keys directory is from the first run of gpg2.1 on a pre-2.1
GPGHOME. It converts the old secring db to that new dir of entries and
uses that instead.

Regarding the umask: That may actually be fallout from

e7f224f (t/lib-gpg: make gpghome files writable, 2014-10-24)

where I didn't expect directories to be present in gpghome. Maybe i
should change

chmod 0700 gpghome
chmod 0600 gpghome/*

to

chmod -R o+w gpghome/

though I felt somehow safer with the explicit permissions.

Michael
