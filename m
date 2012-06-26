From: Michael Horowitz <mike@horowitz.name>
Subject: Re: git-p4: Jobs and skipSubmitEdit
Date: Tue, 26 Jun 2012 01:07:49 -0400
Message-ID: <CAFLRbootAje0BvLOYiH2xOagfUsQ+a_d+9YeTuG1C0a1Pg__Rg@mail.gmail.com>
References: <CAFLRbop2aETNp0-6AdvSTx7Jmh7epYZ6rQc6hhFHbxZrGdEo9g@mail.gmail.com>
	<20120624202445.GA27664@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 07:07:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjO0I-00025Y-FT
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 07:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175Ab2FZFHu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jun 2012 01:07:50 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36836 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab2FZFHt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2012 01:07:49 -0400
Received: by dady13 with SMTP id y13so6287175dad.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 22:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TABk9TZ6e3jV9j0FgOBQ2sLG0uxLTbyo9fdMU8KDmWg=;
        b=U81GdALnNjr4jPOsfTidTWvp8cSvngZTmMNg2js16DAg/SuxmiZerM+7t0oZjb5tkR
         BqKswHQFc3KRkziv3kpf3fqkpXMMSroqc1E1xomQFzOVQeNqkphCM8/wd+5w8VUeQr7a
         tumwMBno1nv36bA31waswsnQwAWJUunJf6sxwY10EliA8v4XmmSyp5YWOOIz5Vnf8J2P
         ASeNhkegYcAFGydKCcCPMmrsVVqKY25a0CwxJJnjAVB3HIk4ThRFiYPdi0qdMcVcmiM4
         RpoP7vI2NFK4Wzm9V1uJXTSdffmbBETMja7nSoKgxJcrwdCqPJADKXyhNEwZywMJerDs
         gRyA==
Received: by 10.68.220.231 with SMTP id pz7mr47106839pbc.110.1340687269122;
 Mon, 25 Jun 2012 22:07:49 -0700 (PDT)
Received: by 10.68.44.73 with HTTP; Mon, 25 Jun 2012 22:07:49 -0700 (PDT)
In-Reply-To: <20120624202445.GA27664@padd.com>
X-Google-Sender-Auth: xRGOZWj1EjXAI_TRRLH4ww5NgkE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200630>

Well, "Jobs:" is the only thing I use.  Everything else is filled in
automatically by git-p4.

Yeah, so "Jobs:" appears once on a line by itself, and then multiple
lines tabbed in of whatever the Job ids are, in our case they are JIRA
issue numbers.  So, it might look like:

Jobs:
    PROJECTNAME-123
    PROJECTNAME-456

I think that if someone is using git-p4 and they have "Jobs:" at the
beginning of a line by itself in a git commit message, then it is safe
to stop pre-pending tabs to the lines from there on.  It can also be
an option to turn this behavior on.

Mike


On Sun, Jun 24, 2012 at 4:24 PM, Pete Wyckoff <pw@padd.com> wrote:
> mike@horowitz.name wrote on Fri, 22 Jun 2012 12:15 -0400:
>> I've written a git prepare-commit-msg hook to do what the Perforce
>> JobsView would essentially do, so I can include the jobs directly in
>> my git commit message, and then use git-p4.skipSubmitEdit=3Dtrue, so=
 I
>> can just push things into Perforce directly from git without ever
>> being prompted by Perforce.
>>
>> Problem is that this doesn't work, because git-p4 tabs in the entire
>> commit message to put it in the "Description:" section of the Perfor=
ce
>> changelist, and my "Jobs:" ends up tabbed in, and it it required by
>> Perforce to be at the beginning of the line. =A0The submit ends up
>> failing, because "Jobs:" is required. =A0I am forced to turn off
>> skipSubmitEdit and edit the message to remove the tab from the "Jobs=
:"
>> line each commit.
>>
>> Is there any option to make this work right, or does the git-p4 not
>> support this?
>
> This is a great idea, and something I've thought would be useful
> too. =A0There's no code to handle it currently, but it shouldn't be
> too hard.
>
> I'm imagining that special strings in the git commit are hoisted
> up out of the description when building the p4 change message,
> as you describe. =A0Are there any more than "Jobs:"? =A0Is it just
> a single instance that might appear?
>
> An easy way to do this is to change prepareLogMessage to alter
> or add a Jobs line. =A0Unless we decide this needs to be more
> general.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-- Pete
