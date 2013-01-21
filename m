From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [RFC/PATCH] add: warn when -u or -A is used without filepattern
Date: Mon, 21 Jan 2013 20:34:35 +0100
Message-ID: <CAA01CsqwuR+HTUWA+iqSamOcR0WBhwK0kfn5+80L95TZn-SRng@mail.gmail.com>
References: <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
	<1358769611-3625-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vwqv6fiz7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:34:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxN91-0004I7-9r
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 20:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150Ab3AUTeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 14:34:37 -0500
Received: from mail-qa0-f54.google.com ([209.85.216.54]:58305 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131Ab3AUTeg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 14:34:36 -0500
Received: by mail-qa0-f54.google.com with SMTP id p6so3181864qad.13
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 11:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=AIGGWRhkEI21O7rFhEAP6Vb1LnHWfOX3bKuP+dI4380=;
        b=WadxAyq2cTD66SHUBCj6mGWVoPVwzNLCmy3v96MeaOqBfb1VbJ98jl28+osqexGhMJ
         vj5gfAY/6SINm2Bn1aGdm1DYP157HXtg8H0flcAUZJ50F3Q7uSSfzAdCMrHLvrlGgdv4
         x90vCgK/Kzsbec9RdE43iIeqC465pkFoWfuiUjHCs06g5gQ1BwsQCcFykE6HnJpKDVx7
         oSdmlOJvw1J552VvGqOP6NtxHwk4SPd7Bb4NOsIzTXdKOeM8KjLIRB1bVS974BZNwPAi
         FaBeBx7I42IkYZGejwYkhe5drmdEY42Rl5805HQTTuxUjrBkRVstISBXyoXTftbenpeD
         RfPg==
X-Received: by 10.49.105.73 with SMTP id gk9mr23895990qeb.40.1358796875730;
 Mon, 21 Jan 2013 11:34:35 -0800 (PST)
Received: by 10.49.84.133 with HTTP; Mon, 21 Jan 2013 11:34:35 -0800 (PST)
In-Reply-To: <7vwqv6fiz7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214155>

On Mon, Jan 21, 2013 at 8:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Most git commands that can be used with our without a filepattern are
>> tree-wide by default, the filepattern being used to restrict their scope.
>> A few exceptions are: 'git grep', 'git clean', 'git add -u' and 'git add -A'.
>>
>> The inconsistancy of 'git add -u' and 'git add -A' are particularly
>> problematic since other 'git add' subcommands (namely 'git add -p' and
>> 'git add -e') are tree-wide by default.
>>
>> Flipping the default now is unacceptable, so this patch starts training
>> users to type explicitely 'git add -u|-A :/' or 'git add -u|-A .', to prepare
>> for the next steps:
>>
>> * forbid 'git add -u|-A' without filepattern (like 'git add' without
>>   option)
>>
>> * much later, maybe, re-allow 'git add -u|-A' without filepattern, with a
>>   tree-wide scope.
>>
>
> I have to wonder if "git add -p" and "git add -e" are the ones that
> are broken, and the migration suggested here is going in the wrong
> direction, though.  After all "add -p" and "add -e" are interactive
> by their nature, so it is a _lot_ easier to change their default
> behaviour in the name of "usability fix", "consistency fix", or
> whatever.  Wouldn't we achieve the same consistency across modes of
> "add" if we made them relative to the current directory?

Consistency is one issue. +1 for having consistent behavior. But even
if all "git add" modes work consistently on current subdirectory, they
will be inconsistent with other git command, for example "git status"
or "git diff". I think it'd be better to have all git command work the
same (is that possible? is there a list of all commands which work on
current dir vs those working on whole tree?). I believe changing all
commands to work on current subdir is not an option.

Another issue is usability. Can we definitely say which is better: add
all changes from current subdir, or add all changes from whole tree? I
don't know. At the moment I think whole tree is better. That's usually
what I want. If I want to add only some changes, I first list the
status or run diff, and then explicitly say what to add. OTOH "add" is
kind of dangerous command - adding content to index is not reversible
(i.e. if there already is a previous version in index with changes,
"add" will overwrite it). But at the same time, another "dangerous"
command, "git add -a" works on whole tree. I use it frequently and
never had any problem with it.

So, from me +1 on making all commands work on whole tree.

--
Piotr Krukowiecki
