From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Thu, 31 Jan 2013 09:03:26 -0800
Message-ID: <CAJo=hJv0aqLpitnRJ6WKdPCETT6YgX5Njpv44DAYUg_KALhf=g@mail.gmail.com>
References: <20130129091434.GA6975@sigill.intra.peff.net> <20130129091610.GD9999@sigill.intra.peff.net>
 <7vy5fbq48t.fsf@alter.siamese.dyndns.org> <7vtxpzq2uv.fsf@alter.siamese.dyndns.org>
 <20130130071209.GD11147@sigill.intra.peff.net> <7vboc6mzpf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 18:04:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0xYX-0001aZ-51
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 18:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077Ab3AaRDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 12:03:48 -0500
Received: from mail-ia0-f175.google.com ([209.85.210.175]:65464 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918Ab3AaRDq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 12:03:46 -0500
Received: by mail-ia0-f175.google.com with SMTP id r4so4165548iaj.34
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 09:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=k4OFPiJLFM9DyfkwfCvyTv+KYKCFKDcOREZBhZG1Mfo=;
        b=Wd9jAQd1TF1JjC3EO2BkfvBbupXyMfNKZFxEHJB140VSVpfX0rhuEqlrkA7/diDz5+
         xUPg7F4udwHp7kR4nGtyai6UojRiyeDep13MggQQ1TdWIA8ZtFQxLtpC8XHK03p5W0Ob
         gv028cN93JKRdj345Q7YGRXKe+MCpkTuRZ/Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=k4OFPiJLFM9DyfkwfCvyTv+KYKCFKDcOREZBhZG1Mfo=;
        b=WIMt8M708/heLxzo66YFGf9rou/L9gtbIXR5/DKJk7O9gQij0YmxA0OhjwYyKmj8nD
         nyz5HVyXKKFMb9R6LeTkjcQ3WYfWqo6X6j3Meo+7+kwGxMeHcYnQdHzMtbH5WTOaGZrW
         nazV6yDHOMXwy9Girtobv8KBCuMIOo3MULmamLj6mpLG6rKKAQPc10nXcJ3bvHZqSdys
         5pMXrOx0j5XSJd6qGBppAl0WQohScvF32Af0r6z1C0Ds3D45DYjHcjrqVNgpjtK7vYiH
         md8k7GqnzciN/ndEv9S0VrcvlGYf4xQ0KRIY6KkHixbcckArN6nglV4zOSTgnntz9R+L
         +F2Q==
X-Received: by 10.50.163.35 with SMTP id yf3mr1738098igb.60.1359651826158;
 Thu, 31 Jan 2013 09:03:46 -0800 (PST)
Received: by 10.64.170.100 with HTTP; Thu, 31 Jan 2013 09:03:26 -0800 (PST)
In-Reply-To: <7vboc6mzpf.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmyaTtEsXLhhO2hB5w3SoFH/v0iWY9r3QhrPwKCQaEKzGwME8PYtYg+vkfOfkdnAMPoxkig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215127>

On Wed, Jan 30, 2013 at 7:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>>>From this:
>>
>>> Then it will be very natural for the extension data that store the
>>> commit metainfo to name objects in the pack the .idx file describes
>>> by the offset in the SHA-1 table.
>>
>> I guess your argument is that putting it all in the same file makes it
>> more natural for there to be a data dependency.
>
> It is more about the "I am torn on this one" I mentioned earlier.
>
> It would be more "logical" if this weren't tied to a particular
> pack, as the properties of a commit you record in this series do not
> depend on which pack the commit is in, and such a repository-global
> file by definition cannot be inside anybody's .idx.
>
> But if we split the information into separate pieces and store one
> piece per .idx for implementation reasons, it is crazy not to at
> least consider it a longer term goal to put it inside .idx file.
>
> Of course, it is more convenient to store this kind of things in a
> separate file while experimenting and improving the mechanism, but I
> do not think we want to see each packfile in a repository comes with
> 47 auxiliary files with different suffixes 5 years down the road.

Arrrrgggh.

Right now we are in the middle of refactoring the JGit reachability
bitmap implementation to store it into a separate file and get it out
of the .idx file. This work is nearly completed. So this thread is
great timing. :-)

I think Junio is right about not wanting 47 different tiny auxiliary
files for a single pack. We are unlikely to create that many, but
right now there are proposals floating around for at least 2 new
auxiliary files (commit cache and reachability bitmaps). So its not
impossible that another will be discovered in the future.

Junio may be right about the hole in the index file for git-core. I
haven't checked the JGit implementation, but I suspect it does not
have this hole. IIRC JGit consumes the index sections and then expects
the pack trailer SHA-1 to be present immediately after the last table.
This happens because JGit doesn't use mmap() to load the index, it
streams the file into memory and does some reformatting on the tables
to make search faster.

If we are going to change the index to support extension sections and
I have to modify JGit to grok this new format, it needs to be index v3
not index v2. If we are making index v3 we should just put index v3 on
the end of the pack file.
