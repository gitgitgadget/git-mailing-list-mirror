From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo
 operations
Date: Mon, 28 Jan 2013 00:10:06 -0800
Message-ID: <20130128081006.GA2434@elie.Belkin>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
 <1359290777-5483-2-git-send-email-hjemli@gmail.com>
 <7vk3qywiqf.fsf@alter.siamese.dyndns.org>
 <CAFXTnz6GTVgY4DK-FLELGF-Cb1=iNYyWcUsUiaUytGRx9Tr4Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 09:10:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzjnc-00079d-6E
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 09:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab3A1IKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 03:10:18 -0500
Received: from mail-da0-f42.google.com ([209.85.210.42]:63244 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823Ab3A1IKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 03:10:16 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so1137692dal.1
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 00:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=eIUqTQ+3OElhoImFfLCpDGDfdkbnSa/wFVQHHG5Ty8k=;
        b=vuZ49T0UOp4xjNGxUoD/ofhTHtJ4HFF19/aOTANizFmgE4qr+kDGRFxUMr8HaOyD1A
         c1oZhxBAzp/UoUBZBSIxcX7+COVGHylcZVNzpNjtvuxyL/hmVa9QyMD9HEh9CSSxVKai
         hM8261nAYCYf3T5WZJ3+B0GSmko7B7in0B5SvSnP02kwZaOjKfWRecLiJhNHZPRCYDLZ
         TVH/I8cuYbPGxv0hDyugRMfFrKtTQalVhpyym3lBYYFjo4ehe5Jadc2fBTZc+RhtgzXR
         tLEgPpRMxbs1hIrAyNQJ4DIPnFO1fMheSL+0CJ377JL+gPUSImsw0aFxB1XAYb5R5ZFa
         cXcw==
X-Received: by 10.68.241.232 with SMTP id wl8mr35259950pbc.144.1359360615807;
        Mon, 28 Jan 2013 00:10:15 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ai8sm5880842pbd.14.2013.01.28.00.10.13
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 00:10:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFXTnz6GTVgY4DK-FLELGF-Cb1=iNYyWcUsUiaUytGRx9Tr4Ow@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214818>

Hi,

Lars Hjemli wrote:

> [1] The 'git -a' rewrite patch shows how I think about this command -
> it's just an option to the 'git' command, modifying the way any
> subcommand is invoked (btw: I don't expect that patch to be applied
> since 'git-all' was deemed to generic, so I'll just carry the patch in
> my own tree).

As one data point, 'git all' also seems too generic to me but 'git -a'
doesn't.  Intuition can be weird.

So if I ran the world, then having commands

	git -a diff

and

	git for-each-repo git diff

do the same thing would be fine.  Of course I don't run the world. ;-)

[...]
>> One more thing that nobody brought up during the previous reviews is
>> if we want to support subset of repositories by allowing the
>> standard pathspec match mechanism.  For example,
>>
>>         git for-each-repo -d git diff --name-only -- foo/ bar/b\*z
>>
>> might be a way to ask "please find repositories match the given
>> pathspecs (i.e. foo/ bar/b\*z) and run the command in the ones that
>> are dirty".  We would need to think about how to mark the end of the
>> command though---we could borrow \; from find(1), even though find
>> is not the best example of the UI design.

In most non-git commands, "--" represents an end-of-options marker,
allowing arbitrary options afterward without having to worry about
escaping minus signs.  So in that spirit, if this weren't a git
command, I'd expect to be able to do

	for-each-repo -- git diff -- '*.c'

and have the second '--' passed verbatim to "git diff".

Unfortunately in git (imitating commands like "grep", I suppose), "--"
means "paths start here".  That means that with the git convention,
there is only one place to pass paths to a given command.

Tracing backwards: it would be really nice to be able to do

	git for-each-repo git grep -e foo -- '*.c'

or

	git -a grep -e foo -- '*.c'

For this practical reason, it seems that paths listed after the '--'
should go to the command being run.  On the other hand, if I wanted to
limit my for-each-repo run to repositories in two subdirectories of
the cwd, I'd be tempted to try

	git for-each-repo git grep -e foo -- src/ doc/

And if I wanted to limit to different file types in the repositories
under each directory, it would be tempting to use

	git for-each-repo git grep -e foo -- 'src/*.c' 'doc/*.txt'

Is there a convention that would be usable today that is roughly
forward-compatible with that?  (To throw an example out, requiring
that each pathspec passed to for-each-repo either starts with '*' or
contains no wildcards.)

Thanks,
Jonathan
