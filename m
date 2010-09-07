From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: guarding everything with test_expect_success (Re: [PATCH 6/7]
 t1303 (config): style tweaks)
Date: Tue, 7 Sep 2010 01:12:13 -0500
Message-ID: <20100907061213.GU1182@burratino>
References: <4C85357A.8090000@web.de>
 <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de>
 <20100907014135.GA1182@burratino>
 <20100907015317.GG1182@burratino>
 <20100907043050.GA13291@sigill.intra.peff.net>
 <20100907051218.GO1182@burratino>
 <20100907055636.GA30357@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 07 08:14:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsrRh-0006yB-EF
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 08:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446Ab0IGGON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 02:14:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34998 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab0IGGOL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 02:14:11 -0400
Received: by iwn5 with SMTP id 5so5011994iwn.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 23:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=t1iXU7W+WF9i2jcZYScuB08x9grn4fO8Eeq7oql9a8g=;
        b=RLNEQIxPa+CKVjT6l7GUoNf+1fGt0dXMpdQ9oPouCrK5+I1bo8a08cLBKmk0HhS163
         hhcidcZADKi8/QipdgLao8MMmV54biuvODHHGSNGQF1e4r8BQZm7eI9Ugg0bSgdpwCMQ
         rDJrk19XCPWqwt6zP8lEW4s1U0UznCRfyZcUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ldx5OsUGOj5dF0xeD71M0tpS2j4/JbeP+Xy8JgPoe00FxVLzP2/iHPahnn/CDVnrA7
         Dhn+qjGUbtBT7gm1tQdZHNc07xMWW3XrDHDm4lSRwgfyQYTWxigzKadp2Xj9ll1m3lQp
         38KboSp8JKkyhyseuv9/QGE17yaAmycZx/srg=
Received: by 10.231.190.203 with SMTP id dj11mr7471508ibb.93.1283840051392;
        Mon, 06 Sep 2010 23:14:11 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm6789514ibk.21.2010.09.06.23.14.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 23:14:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100907055636.GA30357@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155682>

Jeff King wrote:

> Perhaps we could refactor it into a
> set of two functions that keep state? E.g., something like:
> 
> test_start 'setup'
> cat >expect <<EOF
> ... whatever ...
> EOF
> test_end success
> 
> test_start 'description'
> git frob >actual &&
> test_cmp expect actual
> test_end success
> 
> where test_start would set up >&3 and >&4 as usual, and test_end would
> check $? and report the status. The biggest problem I see is that we
> never have the actual shell script snippet as a string, so we don't have
> a way of printing it for "-v" (or on failure). Hmm.

FWIW I don't mind this idea (to be used as an alternative to
test_expect_success when quoting issues get ugly).  Maybe the harness
could fetch the snippet by parsing $0?  (Sorry, couldn't resist.
Something simpler might be possible: e.g., a special

test_expect_success 'description' - <<\test_end
cat >expect <<EOF
... whatever ...
EOF
test_end

syntax.)

>> I don't know: I think
>> 
>> 	cat >expect <<-\EOF &&
>> 	...
>> 	EOF
>> 
>> is pretty readable.  The problem with sticking to
>
> Yeah, I almost mentioned that, but for some reason in the back of my
> mind <<- is not actually portable. Perhaps I am just thinking of the
> fact that perl does not support it.

I seem to remember some language where the here documents would snip
some well determined constant amount of whitespace from the enclosed
lines.  Unfortunately in the shell, that is not the rule: <<- just
trims out all the leading tabs.

So when expected output includes leading tabs, it is ugly again.

	q_to_tab <<-\EOF
	Like this:

	Q1. indented line
	Q2. second indented line
	EOF
