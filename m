From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Sat, 20 Mar 2010 21:10:55 +0800
Message-ID: <41f08ee11003200610n2c7c9684l6ca200cffdfdb434@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <alpine.DEB.1.00.1003201209260.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 14:11:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsySQ-0007tS-7r
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 14:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036Ab0CTNK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 09:10:57 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:34483 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab0CTNK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 09:10:56 -0400
Received: by qyk9 with SMTP id 9so2379887qyk.1
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 06:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=luWUdGIoDaoAEP8g/8+gFJhVhPPvR1CtlB5soWA+2zo=;
        b=cfsdxx4pClvniegl+j835LaQRBBcOfHaCP2ut1cAiJvbRuV98I+3gNqIR43+PlE1QW
         tr/F1SuUsEQDR5fJClhVK6EaIjUwR9e/XDZ8wGDH8/q+T/+iqNgIsD8m/BqSzYXKIKqu
         J5BMw7+9kME/xYiWsBk5bJvXidB6epvrDPVMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=QlFyJw8p0WB/o0BXr1JCAZq6seX3gQR0lJx9tQwk4x5asA/bhALwt/6PCZBvQYteKk
         Re6khSDE4L+MsMO8YtwkSomzlwjG4PPkXzS7C26lMzOpmWmwqX5NxIdfDs2rZBdVxu2h
         RUgBDGsx1LD4zmd864ekI/sCGxur0KqUIWof8=
Received: by 10.229.38.69 with SMTP id a5mr492650qce.15.1269090655090; Sat, 20 
	Mar 2010 06:10:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1003201209260.7596@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142706>

Hi Johannes,

    Thank you very much for your advice!

>
> I like it very much already! You obviously put in a substantial amount of
> time to learn intricate details about the way Git operates, and what is
> already available.
>
> And you also provided a patch (unrelated to line-level history browser),
> so you proved that you actually cloned Git, and that you can actually
> patch it and use Git itself to send a patch to this list.

I am very happy you like it.

>
> I think that that might be good for starters, but one could imagine that
> an integration into "git log" might be even better, so that gitk can use
> this without any further changes.

So, I think add some new options to 'git log' is preferred.

>
> It would be good if the code looked harder after failing with the simple
> strategy, such as looking for code removed in other files, fuzzy matching
> (optional), and looking for code duplication (i.e. literal copying, or
> slightly modified copying).
>
> The fuzzy matching might be necessary to catch things like a Java class
> moving from one file into another (and changing its name): the first line
> changes, but not completely.

That's really a good idea.
So, when the program reach the end of the history thread of some
changes of line range, it should not stop immediately. It then should
make a harder code search and try to find whether the new add lines of
code is moved to there or just copied from other place to there. And
these kind of search should use fuzzy matching instead of exact string
matching.

But notice that, detect code movement in one commit is much efficient
than detecting code copy. So, I think we should add an option to
control whether we detect such kind of code copy. By default, we
detect code move but not code copy. How do you think about this?

> Just have a look at the word-level diff (--color-words):
>
> http://repo.or.cz/w/git/dscho.git/blob/bc1ed6aafd9ee4937559535c66c8bddf1864bec6:/diff.c#l382
>
> You will see that there is a function fn_out_diff_words_aux(), which is
> passed to xdi_diff_outf(). That latter function calls xdiff such that the
> former function receives a complete line at a time. And this is what I
> would suggest doing in the line-level log, too.

I have look over the function fn_out_diff_words_aux, this function
parse each line of a memory diff. We can use it to detect the diff
hunk head and find the line change. If you think the performance is
acceptable, I think using this callback mechanism is all right.

Regards!
Bo
-- 
My blog: http://blog.morebits.org
