From: Nix <nix@esperi.org.uk>
Subject: Re: [PATCH 2/2] Support sizes >=2G in various config options accepting 'g' sizes.
Date: Mon, 05 Sep 2011 14:56:10 +0100
Message-ID: <87ty8rm6th.fsf@spindle.srvr.nix>
References: <1315223155-4218-1-git-send-email-nix@esperi.org.uk>
	<1315223155-4218-2-git-send-email-nix@esperi.org.uk>
	<CAGdFq_gFNHq9Cgv4F4Q6VQ=G7odfUJ5pUFWn=OYE-BfXzP=Enw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 05 15:56:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Zeu-0005s0-Ek
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 15:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046Ab1IEN4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 09:56:15 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:49881 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab1IEN4O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 09:56:14 -0400
Received: from esperi.org.uk (nix@spindle.srvr.nix [192.168.14.15])
	by mail.esperi.org.uk (8.14.4/8.14.3) with ESMTP id p85DuALl006529;
	Mon, 5 Sep 2011 14:56:10 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.14.4/8.12.11/Submit) id p85DuAWL031571;
	Mon, 5 Sep 2011 14:56:10 +0100
Emacs: because idle RAM is the Devil's playground.
In-Reply-To: <CAGdFq_gFNHq9Cgv4F4Q6VQ=G7odfUJ5pUFWn=OYE-BfXzP=Enw@mail.gmail.com>
	(Sverre Rabbelier's message of "Mon, 5 Sep 2011 15:49:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-DCC-STAT_FI_X86_64_VIRTUAL-Metrics: spindle 1245; Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180744>

On 5 Sep 2011, Sverre Rabbelier said:

> Heya,
>
> On Mon, Sep 5, 2011 at 13:45, Nix <nix@esperi.org.uk> wrote:
>> 32-bit platforms with no type larger than 'long' cannot detect this
>> case and will continue to silently misbehave, but the misbehaviour
>> will be somewhat different and more useful, since bigFileThreshold was
>> also being mistakenly treated as a signed value when it should have
>> been unsigned.
>
> Is it not possible to detect that the target value won't fit in the
> max size of an int when parsing the config value?

Well, we're parsing longs, not ints. If sizeof(long)>sizeof(int), or we
have long long and sizeof(long long)>sizeof(int), then we can always
detect overflows when saving into the appropriate type: but if we don't
have long long, or if we have neither strto(u)ll() nor strto[ui]max(),
we could only detect overflow by looking at the raw text string and
checking it by hand to see if it would fit. I judged this pointless
extra complexity for a very rare edge case (machines with neither
strot(u)ll() nor strto[ui]max() are generally quite old and people
aren't going to be specifying sizes in gigabytes on such machines
anyway.)

-- 
NULL && (void)
