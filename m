From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: recovering from "unordered stage entries in index" error
Date: Thu, 21 May 2015 16:56:44 +0700
Message-ID: <CACsJy8AS-9Cv6V=OKTckpnqd6OGsmvRy17TLoikT4QkA0sRofg@mail.gmail.com>
References: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "McHenry, Matt" <mmchenry@carnegielearning.com>
X-From: git-owner@vger.kernel.org Thu May 21 11:57:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvNEF-0004il-I1
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 11:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbbEUJ5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 05:57:18 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:36278 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbbEUJ5P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2015 05:57:15 -0400
Received: by iepj10 with SMTP id j10so4289428iep.3
        for <git@vger.kernel.org>; Thu, 21 May 2015 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=P45CqFS4udt2w3i1pD+LdMF4V3qcry4TUZvbZXDpb8E=;
        b=KObFm3/NfXWtu6DkDsiEOin9UnHZMCWNHKbDE0BOCnw6SCjQugwCyS8ewSXjL14hgi
         0tJSdLCAPsYsd4Y2hfn8iE2SmljpqxhI7/QaGf+tJKJDw/585HcRyt2hOUVGN+8Zft49
         xlCFqmk6wcpFqyaPNsluauN5vBl9ZqQFhXW5cnHEKlPjp48QjF4oCgFGadqwyN6tk8Kt
         hqJuwj6mzf+ZAZgpngMgUflIiPSDqxab/FwDa90fCF3SHYxcb69gp1GfMSDL5bAgDHSr
         C35JTi4C1xsg0ni3cpTgOAH9up4u+vzfqv4ri2sEWCFSrYBLvXXM0+Ct7Rsbl/WwEWqv
         Y3zQ==
X-Received: by 10.50.176.134 with SMTP id ci6mr10635908igc.27.1432202234899;
 Thu, 21 May 2015 02:57:14 -0700 (PDT)
Received: by 10.107.181.136 with HTTP; Thu, 21 May 2015 02:56:44 -0700 (PDT)
In-Reply-To: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269576>

On Tue, May 19, 2015 at 8:48 PM, McHenry, Matt
<mmchenry@carnegielearning.com> wrote:
>
>
>         I've just upgraded my git from 2.0.5 to 2.3.6, and I'm now unable to run 'git svn fetch' in one of my repositories:
>
> $ git svn fetch
> fatal: unordered stage entries in index

This message can be improved to show what entries have this problem.
But then I don't see any way to recover the index manually. ls-files
will die too. Perhaps we should be gentle in this case: show warnings
instead of aborting the program and internally reorder the index. I
think, unless you have multiple entries with the same stage, the
recovered index should run well. The broken index could be renamed to
index.broken or something for later analysis, or we forbid writing the
reordered index to disk.

Hmm?

> write-tree: command returned error: 128
>
>         'git status' shows a few untracked files but is otherwise clean.
>
>         It looks like this check was introduced in 15999d0be8179fb7a2e6eafb931d25ed65df50aa, with the summary "read_index_from(): catch out of order entries when reading an index file" (first appearing in 2.2.0).
>
>         Mailing list discussion looked like it implicated third-party tools.  I don't recall running any other tools on this repo; it doesn't do much day-to-day other than a long series of 'git svn fetch'es.  (But it's been around for a couple of years, so who knows.)
>
>         At any rate, what can I do to recover from this situation?  I tried to locate a path with multiple index entries like this, but got no results:
>
> $ git ls-files -s | cut -f 2-100 | sort | uniq -c | grep -v '^[ \t]*1 '
>
>         (I originally posted on SO at http://stackoverflow.com/questions/30264826/; I'll update that with any solutions that come up here, to ease future googling.)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




-- 
Duy
