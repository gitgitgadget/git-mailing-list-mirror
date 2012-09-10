From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 4/4] Add a function string_list_longest_prefix()
Date: Mon, 10 Sep 2012 19:48:07 +0200
Message-ID: <504E27D7.8010505@op5.se>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu> <1347169990-9279-5-git-send-email-mhagger@alum.mit.edu> <7vbohfser4.fsf@alter.siamese.dyndns.org> <504DBA62.3080001@alum.mit.edu> <7v1ui9q21a.fsf@alter.siamese.dyndns.org> <20120910163310.GE9435@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 10 19:48:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB85t-00018r-H7
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 19:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab2IJRsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 13:48:13 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48904 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab2IJRsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 13:48:12 -0400
Received: by lbbgj3 with SMTP id gj3so1378292lbb.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 10:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=VQ9XIviBTqZF6b84q1bRzXMg0ii9JukXQamWCv8KHdo=;
        b=TEfCBtWWPVGp4uhhwAq2/pKEiyLitjRdHZfwTNV+yhgH0vDT/AN5WSwUzst70TTWit
         2mid+y31e6p35N+Crwjd8/sQpbOFZSoLqMKOFrqFC7fQs8Z49qQ8AjJySV1m/EKpi0CP
         X3e/QlB2z1SKchcoFgpLY6g4xx8u7+O7MP6dj1D+ooYaNuJeD2aoWOJnWogEQdv18pvJ
         4PiVyTN/lBKIytNqYwwtfQWj+G//kkcbQeotih2C+lOPGC35qf5FDBML7ReN0A0yWx7r
         pICGhNG9292rh8c/kfbalrX2QD+UjHrV4eGQe4GrIMYMSKxAAvlqDBcLH0yzX2nsEQRv
         JBWg==
Received: by 10.152.135.147 with SMTP id ps19mr13387755lab.52.1347299291020;
        Mon, 10 Sep 2012 10:48:11 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id b1sm3741142lbi.2.2012.09.10.10.48.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Sep 2012 10:48:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
In-Reply-To: <20120910163310.GE9435@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQm2u0q73jrXPnUkO9QP+MwQRIASfGCPId+5OIEqNTVxLwW4XCeqbkEdWZlCt/eu8H/G70ax
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205155>

On 09/10/2012 06:33 PM, Jeff King wrote:
> On Mon, Sep 10, 2012 at 09:24:17AM -0700, Junio C Hamano wrote:
> 
>>> While we're on the subject, it seems to me that documenting APIs like
>>> these in separate files under Documentation/technical rather than in the
>>> header files themselves
>>>
>>> - makes the documentation for a particular function harder to find,
>>>
>>> - makes it easier for the documentation to get out of sync with the
>>> actual collection of functions (e.g., the 5 undocumented functions
>>> listed above).
>>>
>>> - makes it awkward for the documentation to refer to particular function
>>> parameters by name.
>>>
>>> While it is nice to have a high-level prose description of an API, I am
>>> often frustrated by the lack of "docstrings" in the header file where a
>>> function is declared.  The high-level description of an API could be put
>>> at the top of the header file.
>>>
>>> Also, better documentation in header files could enable the automatic
>>> generation of API docs (e.g., via doxygen).
>>
>> Yeah, perhaps you may want to look into doing an automated
>> generation of Documentation/technical/api-*.txt files out of the
>> headers.
> 
> I was just documenting something in technical/api-* the other day, and
> had the same feeling. I'd be very happy if we moved to some kind of
> literate-programming system. I have no idea which ones are good or bad,
> though. I have used doxygen, but all I remember is it being painfully
> baroque. I'd much rather have something simple and lightweight, with an
> easy markup format. For example, this:
> 
>    http://tomdoc.org/
> 
> Looks much nicer to me than most doxygen I've seen. But again, it's been
> a while, so maybe doxygen is nicer than I remember.
> 

Doxygen has a the very nifty feature of being able to generate
callgraphs though. We use it extensively at $dayjob, so if you need a
hand building something sensible out of git's headers, I'd be happy
to help.

libgit2 uses doxygen btw, and has done since the start. If we ever
merge the two, it would be neat to use the same.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
