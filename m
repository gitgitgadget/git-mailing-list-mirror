From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] lock_packed_refs(): allow retries when acquiring
 the packed-refs lock
Date: Mon, 11 May 2015 12:26:23 +0200
Message-ID: <555083CF.8010205@alum.mit.edu>
References: <1430491977-25817-1-git-send-email-mhagger@alum.mit.edu> <1430491977-25817-3-git-send-email-mhagger@alum.mit.edu> <CAGZ79kZnhv+aW_GW8mBDyhfv_k54ScAFsHQz=8zfHBUJ8WrVUw@mail.gmail.com> <20150501182257.GA27728@peff.net> <55445E60.6010205@alum.mit.edu> <20150505192110.GD10463@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 11 12:26:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrkuy-0003I4-2W
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 12:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbbEKK0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 06:26:31 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55169 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753355AbbEKK03 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 06:26:29 -0400
X-AuditID: 1207440d-f79976d000005643-3e-555083d13909
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 2B.5A.22083.1D380555; Mon, 11 May 2015 06:26:25 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BAQNCA021460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 06:26:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <20150505192110.GD10463@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqHuxOSDU4P9VUYuuK91MFg29V5gt
	frT0MFts3tzO4sDisWBTqcez3j2MHhcvKXt83iQXwBLFbZOUWFIWnJmep2+XwJ3xfvFZtoLH
	UhUvOs4yNjDuE+1i5OSQEDCR2PzrITuELSZx4d56ti5GLg4hgcuMEltevWKHcM4xSWxZ38MC
	UsUroC1x++JqIJuDg0VAVaJ5UzRImE1AV2JRTzMTiC0qECTRem0qI0S5oMTJmU/AWkUEZCW+
	H97ICDKTWaCBUeLDgc1sIAlhgQSJHfe3Qi1bxiRx9d8asG5OAT2JHV8bmUFsZgF1iT/zLkHZ
	8hLNW2czT2AUmIVkySwkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopea
	UrqJERLQvDsY/6+TOcQowMGoxMPbcck/VIg1say4MvcQoyQHk5Iob1tVQKgQX1J+SmVGYnFG
	fFFpTmrxIUYJDmYlEV7ORqAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaD
	Q0mC93YTUKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KFrji4HxCpLiAdpbDNLO
	W1yQmAsUhWg9xagoJc7bBZIQAElklObBjYWlqVeM4kBfCvPygVTxAFMcXPcroMFMQIMd48AG
	lyQipKQaGCc4v/edMWGvFn+m05xH2qmzdxvoTlv6Ta2fN/hB5/uSD75/bAzE0pb0KugWBgl+
	VvN1m1XD0Cwz7WxWjFBqedqfCV1R1YY535XmJa259HXGw9LCtTtjMpM9OH8ePT/z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268766>

On 05/05/2015 09:21 PM, Jeff King wrote:
> On Sat, May 02, 2015 at 07:19:28AM +0200, Michael Haggerty wrote:
> 
>> 100 ms seems to be considered an acceptable delay between the time that
>> a user, say, clicks a button and the time that the button reacts. What
>> we are talking about is the time between the release of a lock by one
>> process and the resumption of another process that was blocked waiting
>> for the lock. The former is probably not under the control of the user
>> anyway, and perhaps not even observable by the user. Thus I don't think
>> that a perceivable delay between that event and the resumption of the
>> blocked process would be annoying. The more salient delay is between the
>> time that the user started the blocked command and when that command
>> completed. Let's look in more detail.
> 
> Yeah, you can't impact when the other process will drop the lock, but if
> we assume that it takes on the order of 100ms for the other process to
> do its whole operation, then on average we experience half that. And
> then tack on to that whatever time we waste in sleep() after the other
> guy drops the lock. And that's on average half of our backoff time.
> 
> So something like 100ms max backoff makes sense to me, in that it keeps
> us in the same order of magnitude as the expected time that the lock is
> held. [...]

I don't understand your argument. If another process blocks us for on
the order of 100 ms, the backoff time (reading from my table) is less
than half of that. It is only if another process blocks us for longer
that our backoff times grow larger than 100 ms. I don't see the point of
comparing those larger backoff numbers to hypothetical 100 ms expected
blocking times when the larger backoffs *can only happen* for larger
blocking times [1].

But even aside from bikeshedding about which backoff algorithm might be
a tiny bit better than another, let's remember that these locking
conflicts are INCREDIBLY RARE in real life. Current git doesn't have any
retry at all, but users don't seem to be noticeably upset.

In a moment I will submit a re-roll, changing the test case to add the
"wait" that Johannes suggested but leaving the maximum backoff time
unchanged. If anybody feels strongly about changing it, go ahead and do
so (or make it configurable). I like the current setting because I think
it makes more sense for servers, which is the only environment where
lock contention is likely to occur with any measurable frequency.

Michael

[1] For completeness, let's also consider a difference scenario: Suppose
the blocking is not being caused by a single long-lived process but
rather by many short-lived processes running one after the other. In
that case the time we spend blocking depends more on the duty cycle of
other blocking processes, so our backoff time could grow to be longer
than the mean time that any single process holds the lock. But in this
scenario we are throughput-limited rather than latency limited, so our
success in acquiring the lock sooner only deprives another process of
the lock, not significantly improving the throughput of the system as a
whole. (And given that the other processes are probably following the
same rules as we are, the shorter backoff times are just as often
helping them snatch the lock from us as us from them.)

-- 
Michael Haggerty
mhagger@alum.mit.edu
