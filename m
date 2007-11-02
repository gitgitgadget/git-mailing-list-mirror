From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: New features in gitk
Date: Fri, 2 Nov 2007 17:50:47 +0100
Message-ID: <e5bfff550711020950w3b628f24k767127c1ffc54510@mail.gmail.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	 <alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
	 <18212.13862.637991.30536@cargo.ozlabs.ibm.com>
	 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
	 <18217.41899.54812.227152@cargo.ozlabs.ibm.com>
	 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
	 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
	 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
	 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 17:51:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inzjg-00005u-Su
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 17:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbXKBQut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 12:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbXKBQut
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 12:50:49 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:47244 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbXKBQus (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 12:50:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so850918rvb
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wjzZXMkIclBXAEkLXFo2h7kJYqro1dGQXQlaeNJwqsE=;
        b=IgKui9detDmV8UALS36vB4lUKpNo9upoW3Hji759mnpjxi0PZuTrLghonTyQarHFode9JhVacRM+MzIVWiD+fsdvZ//sCo6gzSZ3hCeD23gXz0u8JBvh4qGvz5RiXocBHfoFhsuewEwimq0iu+VIBgT96RvSeIZNKkURUeHC6kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LTu9qxA78nCqLN8EChNFo/AogHq67V7uimVJUizgnhDxn3NGAEZWwDPNmwh5L7b791INLx0Mm28cj9USposiyxyLYcypA07jQytU8EcrUdG8MGcb6Tq4FzodMzqu/L3NLY02WPTzeLcVPtrX08mGGICWRK1IFaa55My36mcAI8s=
Received: by 10.141.145.11 with SMTP id x11mr976769rvn.1194022247904;
        Fri, 02 Nov 2007 09:50:47 -0700 (PDT)
Received: by 10.141.203.3 with HTTP; Fri, 2 Nov 2007 09:50:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63143>

On 11/2/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> But it will *notice* when it gets the wrong answer, though, and can reset
> and start over!
>
> IOW, I might be able to do something that
>
>  - prints out the commit info per line
>
>  - prepends each line with a line number
>
>  - goes back to an earlier line 'n' when it notices that it needs to
>    output a commit before a previous commit (or when it notices that a
>    commit that it had already output was actually not supposed to show up)
>
> and with something like that, I could make git give you incremental
> output.
>

Yes. That's would be easier to implement. Better yet do not give line
numbers I already push back each revision sha in a vector according to
arrival order. It's a stack like storing.

So would be nice if 'git log --restarting' would work like this:

- Output the normal stream of commits according to git log arguments.
No line numbers, no fancy additional stuff.

- If '--topo-order' or something similar was given git log checks if a
wrong output occurs, as example because it founds a revisions that
should have been already put out say 'n' revisions before the last
outputted one.

- In the above case git log outputs a side-band data of "uhhuh, I screwed
up, I restart from 'n' revisions before the last one outputted".

- Then ouput _again_ the stream starting from 'n' revisions earlier.
Note that not only the new offending revision is trasmitted but *all
the revisions* from the out of order one to the remaining.

Given a vector of 'k' arrived revisions, for me it's far easier simply
to flush the 'n' tail items in the sha vector and restart again then
_insert_ in the vector the new out of order one.

This is because parsing alghoritm is based on an 'append new stuff'
approach, not 'insert in the middle', so better flush all the tail
also if probably the big part of retrasmitted revisions would remain
the same.


Marco

P.S: The out of bound information should be commit data aligned and
could take advantage of the fact that an sha always starts with an
alphanumeric char value [0..9 a..f]

IOW instead of the commit sha this signal could write something like

'Restarting  from -12'

and parsing knows that an sha cannot start with an 'R'. Please note
that 'instead of the commit sha' it means in the _exact_ place where
sha is expected and this is not predefined but depends on the git-log
arguments, so that as example

$git log --with-restart

would output:

commit 6959893b0b65ebc68ce2fb524a8ec15a26ca4972
Merge: 452b800... d279fc1...
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Oct 31 23:53:55 2007 -0700

    Merge branch 'sp/mergetool'

    * sp/mergetool:
      mergetool: avoid misleading message "Resetting to default..."
      mergetool: add support for ECMerge
      mergetool: use path to mergetool in config var mergetool.<tool>.path

commit Restart from -7
commit 3e4bb087a18435b12eb82116e93af2887578e816
Merge: 5fb1948... 136e631...
Author: Junio C Hamano <gitster@pobox.com>
Date:   Thu Nov 1 17:09:08 2007 -0700

    Merge branch 'maint'



while

$git log --with-restart --pretty=oneline

would output

6959893b0b65ebc68ce2fb524a8ec15a26ca4972 Merge branch 'sp/mergetool'
Restart from -7
3e4bb087a18435b12eb82116e93af2887578e816 Merge branch 'maint'
5fb19486e6f4b6d31f33f5a1eab970b244fa2d08 Merge branch 'bk/maint-cvsexportcommit'


In this way this side band info became compatible with _any_ git-log
output format as long as the format foreseens the output of the
revision sha.
