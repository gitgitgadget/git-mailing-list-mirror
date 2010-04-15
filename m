From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Thu, 15 Apr 2010 11:07:32 +0200
Message-ID: <201004151107.33892.jnareb@gmail.com>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk> <7viq7toh12.fsf@alter.siamese.dyndns.org> <20100415065700.GA27542@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 15 11:07:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2L2Z-0001nj-7r
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 11:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745Ab0DOJHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 05:07:08 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:59259 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab0DOJHF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 05:07:05 -0400
Received: by bwz25 with SMTP id 25so1229607bwz.28
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 02:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4isR6Rr8rsZ0+AjWopa8yUBrYCgbKaoW6kjqQj7+cQE=;
        b=j0u5loXEeGhPSwc+aW9j8tQ4dLrprdwGuRF2iEBtlpXB9UlQszHwjfVOqTdFHQ9N43
         FtrOTKBG3SLg4OJZMbAKCXrs1MP6KWU+oR+28i12HTAV8DvCyG85JieqDFlG5T7N5b4K
         QrLhvnVI2l2gP9LZHhigvnLODnpXmHlRh4zWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FaFmy6JCmIMHiaXb5lQ5t67/zdFKvCqsdp9WUVAFBGrCj0+okfgyn9JDBLHWRmFZNU
         Tqb2xYV6L2tGxTLO3H/3EMgagrtTDJntS1hj2v3J32e2t4JDJou/lDrQVu9VIvmlhaxN
         64RKsLyIy7zUJwo42iDnkprlP1zrjA1IzWcbQ=
Received: by 10.204.15.1 with SMTP id i1mr9698819bka.207.1271322421282;
        Thu, 15 Apr 2010 02:07:01 -0700 (PDT)
Received: from [192.168.1.13] (abvo40.neoplus.adsl.tpnet.pl [83.8.212.40])
        by mx.google.com with ESMTPS id 15sm1007202bwz.0.2010.04.15.02.06.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 02:07:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100415065700.GA27542@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144964>

On Thu, 15 April 2010, Jeff King wrote:
> On Wed, Apr 14, 2010 at 02:34:01PM -0700, Junio C Hamano wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:
> > 
> > > Well, this whole idea started with the fact, that "git status --short"
> > > was hard (or impossible) to parse unambigously by scripts[1], and even
> > > "git status --porcelain -z"[2] is not that easy to parse[3].
> > 
> > And you apparently seem to agree with that claim, but I don't.  I think
> > Jeff (who did the --porcelain stuff; by the way, why did we lose him from
> > Cc list?) has already said that he is open to an update.
> 
> I haven't seen any evidence that status --porcelain (or its -z form) is
> impossible to parse unambiguously. I don't even think it's that hard,
> but it certainly could be easier. But more importantly, from looking at
> the output it's not necessarily _obvious_ how to parse it correctly
> (e.g., whitespace as value and as field separator, syntax of "-z"
> depends on semantics of field contents).

Well, IMVHO output of "git status --short" / "git status --porcelain"
(without '-z') is very hard to parse.  Even assuming that in the case
of ambiguity filenames are quoted (which also means that in the case of
ambiguity whether they are quoted they must be quoted), the fact that
separator between source and destination filename in the case of rename
detection is " -> " (if I understand it correctly), and neither of ' '
(SPC), '-' nor '>' is replaced by escape sequence means that one needs
to detect where quoted filename begins and where ends.  This means
either parsing character by character, taking into account quoting and
escaping (e.g. '\\', '\"' etc.), or using 'balanced quote' regexp like
the one from Text::Balanced, e.g.:  (?:\"(?:[^\\\"]*(?:\\.[^\\\"]*)*)\")

What was the reason behind choosing " -> " as separator between pair[1]
of filenames in rename, instead of using default "git diff --stat" format
i.e. 'arch/{i386 => x86}/Makefile' for "git status --short" which is
meant for end user, and for "git status --porcelain" the same format 
that raw diff format, i.e. with TAB as separator between filenames,
and filename quited if it contains TAB (then TAB is relaced by '\t',
and does not appear in filename, therefore you can split on TAB)?

IMVHO "git status --porcelain -z" format is not easy to parse either.
(The same can be said for "git diff --raw -z" output format.)  You
can't just split on record separator; you have to take into account
status to check if there are two filenames or one.

[1] A question: we have working area version, index version, and HEAD
    version of file.  Isn't it possible for *each* of them to have 
    different filename?  What about the case of rename/rename merge
    conflict?
> 
> The approach I proposed was to leave it be and document it a bit better.
> Adding some format that is close but subtly different is just going to
> lead to more confusion.

Well, the proposed '-Z' output format, in the OFS="\0", ORS="\0\0"
variant, would be very easy to parse.  If I understand it correctly
it is also one of available format in outputification^W in this series.

> 
> But since Julian was willing to do the JSON work, I think that is a much
> nicer approach. It's not subtly different; it's very different and way
> easier to read and parse. And I'm really happy with the way he has
> structured the code to handle multiple output formats. It keeps the code
> much cleaner, and it should silence any "but YAML is better than JSON is
> better than XML" debates.

I really like this outputification ;-) too.

Although if possible I'd like to have it wrapped in utility macros,
like parseopt, so one does not need to write output_str / output_int
etc.... but currently it is very, very vague sketch of an idea, rather
than realized concept.

> 
> Even with Julian's patches, we should still better document the regular
> and "-z" forms. Eric promised to send some patches this week; I'm hoping
> he is still interested in doing so after seeing a better solution arise.
> :)

-- 
Jakub Narebski
Poland
