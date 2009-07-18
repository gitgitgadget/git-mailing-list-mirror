From: demerphq <demerphq@gmail.com>
Subject: Re: git silently ignores aliases of existing commands
Date: Sat, 18 Jul 2009 13:20:12 +0200
Message-ID: <9b18b3110907180420n67ec7fa1q4a0df2047f37435e@mail.gmail.com>
References: <4A611CE1.3080709@pobox.com>
	 <BLU0-SMTP9743008F68C14C8226D07BAE1F0@phx.gbl>
	 <4A6176E6.4060708@pobox.com>
	 <9b18b3110907180230p7fb432cdq56bfee794afc669e@mail.gmail.com>
	 <20090718104631.GA27307@coredump.intra.peff.net>
	 <9b18b3110907180355s5bf08f8did180caa0c55b3389@mail.gmail.com>
	 <20090718105855.GA29567@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael G Schwern <schwern@pobox.com>,
	Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 18 13:20:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MS7xx-0007lm-W3
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 13:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758169AbZGRLUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 07:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758168AbZGRLUN
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 07:20:13 -0400
Received: from mail-pz0-f203.google.com ([209.85.222.203]:55573 "EHLO
	mail-pz0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbZGRLUM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 07:20:12 -0400
X-Greylist: delayed 6587 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Jul 2009 07:20:12 EDT
Received: by pzk41 with SMTP id 41so53918pzk.33
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 04:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YRRUI7Qd/fb4HwuQn4oTKajdsy03hveJ/xytVVrMMlU=;
        b=YJM+Uup9yuPiH203tca5ER2LkHDZWvIF3RgkDQuqIecBzmcr27v8gCCQYiNOXcpEyU
         IYIfFKwFebztFHSbwF+ZSyhl1ohGo9gUq4pL65r3+mXthBfZXIeyirQpFlP/l4Sqs0/l
         MYZWHcW14Ukw3TrEqMVNQJO2zMlrYOMLVK8Zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cYcsnlanwQbg+80Q72cjIBN6qjnHr8lo6seicCAxWS2U79Bo4t6V96/CkY7RJ/Cfkw
         mIVzMyGefWwu4h7+AjJd3gKAE08BCGmFGbTNhCeyvTePRsklmIIYqL+NnhQOOmRmDzu0
         9OjStT0YRE5HPv9VCuUVwhB5iHtCPNgjC6RtQ=
Received: by 10.142.252.14 with SMTP id z14mr470221wfh.318.1247916012319; Sat, 
	18 Jul 2009 04:20:12 -0700 (PDT)
In-Reply-To: <20090718105855.GA29567@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123517>

2009/7/18 Jeff King <peff@peff.net>:
> On Sat, Jul 18, 2009 at 12:55:26PM +0200, demerphq wrote:
>
>> > The silentness makes it harder to diagnose problems, but even with a
>> > warning, we can break things by creating new commands. If you have an
>> > alias "foo" and we ship "git-foo" in a newer version of git, your alias
>> > will just stop working.
>>
>> That was my point. At least if there were warnings about this the risk
>> would be mitigated.
>
> I don't see how it's mitigated. You don't get any warning until _after_
> things are broken. So yes, it may help you diagnose the breakage, but
> presumably the fact that the command is doing something completely
> different would also alert you to the breakage.
>
> The real problem comes from scripted use, where you don't necessarily
> have a user reading warnings on stderr, or notice that some totally
> bogus code is being run (especially if said code happens not to produce
> a non-zero exit code).
>
> But perhaps that's what you meant, and I'm just nitpicking your
> language.

I think we are more or less in agreement, except maybe that i think
the situation would be marginally better if git detected this.

:-)

Seems an awkward position actually. Maybe a switch like
--ignore-command-aliases which would be used by all internal commands
when they expect to find another internal command would resolve it.
Then aliases of internal commands to control default switches could
actually be allowed to work, and there would not be the future
compatibility trap that there seems to be now.

cheers,
Yves



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
