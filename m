From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] completion: fix args of run_completion() test helper
Date: Fri, 28 Sep 2012 12:49:25 -0700
Message-ID: <7vvceyj5bu.fsf@alter.siamese.dyndns.org>
References: <20120928100530.GL10144@goldbirke>
 <1348826975-2225-1-git-send-email-szeder@ira.uka.de>
 <1348826975-2225-2-git-send-email-szeder@ira.uka.de>
 <7vehlmm3ca.fsf@alter.siamese.dyndns.org> <20120928183840.GB10719@goldbirke>
 <7vzk4aj6ik.fsf@alter.siamese.dyndns.org>
 <20120928193008.GA3912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 28 21:49:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THgZF-0007PW-IK
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 21:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031218Ab2I1Ttf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 15:49:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47312 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030295Ab2I1Tta (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 15:49:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 766C18962;
	Fri, 28 Sep 2012 15:49:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nb1cw0yoVOutHLRIYwQwZBs2OcU=; b=q/+ibv
	5Oj23Ck4/LTGqEgFwr3h0D1+kEn/ik0u/TQWKihPxaONPq2fTgGAQaXGMdk0hKer
	WLEnxGNsFpfsR/yLaADX/0Vqi4SqfnL2AV0VEnpUtghQ9Z31l8GTblXt4jJxE6cr
	u/OXGpYzze4BHvARjlln1ZQtb9Vd5wODSigB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KNex5Rs6X/gu2OLLP0qa9YyWjRSCOrRP
	ZGerDmwvHfP3wtoVG1+4Vw2Uyqz5weF4ONeKi5lLnrmCjbVtYnkNR6nhP0s0tEb9
	k5yS8YGQYRfwKf21tP2r1lWMXqyjUbenGBXLcFPEdOlTe0+MidnIv+jfSeXKkjk6
	YYXwmrJ93wY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63F4D8961;
	Fri, 28 Sep 2012 15:49:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A30DB8960; Fri, 28 Sep 2012
 15:49:26 -0400 (EDT)
In-Reply-To: <20120928193008.GA3912@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 28 Sep 2012 15:30:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C0B2F6E-09A5-11E2-85C7-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206605>

Jeff King <peff@peff.net> writes:

> On Fri, Sep 28, 2012 at 12:23:47PM -0700, Junio C Hamano wrote:
>
>> >> > @@ -57,7 +57,7 @@ run_completion ()
>> >> >  test_completion ()
>> >> >  {
>> >> >  	test $# -gt 1 && echo "$2" > expected
>> >> > -	run_completion "$@" &&
>> >> > +	run_completion $1 &&
>> >> >  	test_cmp expected out
>> >> >  }
>> >> 
>> >> I can understand the other three hunks, but this one is fishy.
>> >> Shouldn't "$1" be inside a pair of dq?  I.e.
>> >> 
>> >> 	+	run_completion "$1" &&
>> >
>> > No.  $1 holds all words on the command line.  If it was between a pair
>> > of dq, then the whole command line would be passed to the completion
>> > script as a single word.
>> 
>> And these "words" can be split at $IFS boundaries without any
>> issues?  IOW, nobody would ever want to make words array in the
>> run_completion function to ['git' 'foo bar' 'baz']?
>
> It might be simpler to just convert test_completion into the
> test_completion_long I added in my series; the latter takes the expected
> output on stdin, leaving the actual arguments free to represent the real
> command-line. E.g., your example would become:
>
>   test_completion git "foo bar" baz <<-\EOF
>   ... expected output ...
>   EOF

I realize that the way my question was stated was misleading.  It
was not meant as a rhetorical "You would never be able to pass
['git' 'foo bar' 'baz'] with that interface, and the patch sucks."
but was meant as a pure question "Do we want to pass such word
list?".  "test_completion is almost always used to test completion
with inputs without any $IFS letters in it, so not being able to
test such an input via this interface is fine. If needed, we can
give another less often used interface to let you pass such an
input" is perfectly fine by me.

But I suspect that the real reason test_completion requires the
caller to express the list of inputs to run_completion as $IFS
separate list is because it needs to also get expected from the
command line:

>> >  test_completion ()
>> >  {
>> >  	test $# -gt 1 && echo "$2" > expected
>> > -	run_completion "$@" &&
>> > +	run_completion $1 &&
>> >  	test_cmp expected out
>> >  }

I wonder if doing something like this would be a far simpler
solution:

	test_completion ()
        {
		case "$1" in
                '')
			;;
		*)
			echo "$1" >expect &&
	                shift
                        ;;
		esac &&
                run_completion "$@" &&
                test_cmp expect output
	}
