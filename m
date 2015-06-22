From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Mon, 22 Jun 2015 15:01:50 +0200
Organization: gmx
Message-ID: <80dac4a49123c6e4ddc905c74d63d44e@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
 <xmqq1th77829.fsf@gitster.dls.corp.google.com>
 <95e42f21de69ab5299c03ce6ad107037@www.dscho.org>
 <xmqqoakb5sk2.fsf@gitster.dls.corp.google.com>
 <558643CA.6000303@alum.mit.edu>
 <xmqqioahj849.fsf@gitster.dls.corp.google.com>
 <3faa92b10274ce8cfebe340761f73505@www.dscho.org>
 <xmqq1th4kdeq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 15:02:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z71Mg-0001gf-7J
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 15:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826AbbFVNCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 09:02:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:53515 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567AbbFVNCG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 09:02:06 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M04uG-1YoX6a3rCe-00uIK2; Mon, 22 Jun 2015 15:01:52
 +0200
In-Reply-To: <xmqq1th4kdeq.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:zjgIqtUU7cqXzNO1A2FXcmu3eH53gJOgevU/rj2N0eBpuhP6yg5
 LAxOKTFAc1prRfmSXo4EEf+sgpNsz2yeXt94JnMJXq319te0sHhB1+yTWdFZARneTsUQnmy
 ccRkBkgvPi+6Uf+kwKIBpGs7mC6UOIJBgF2b9TxwFbw/w6ZsFnrUmADFLoStvkJDgK8aFjJ
 5U/qQ+mWEEic7Y1QpiilQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272337>

Hi Junio,

On 2015-06-21 22:35, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> On 2015-06-21 19:15, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>> That's brilliant.
>>>
>>> Just to make sure I am reading you correctly, you mean the current
>>> overall structure:
>>>
>>> [...]
>>
>> The way I read Michael's mail, he actually meant something different:
>> if all of the blob-related errors/warnings are switched to "ignore",
>> simply skip unpacking the blobs.
> 
> That is how I read his mail, too.
> 
> But because IIRC we do not check anything special with blob other
> than we can read it correctly, my description of "overall structure"
> stayed at a very high conceptual level.  The unpacking may happen at
> a much higher level in the code, i.e. it comes way before this part
> of the logic flow:
> 
>         if ("is bad_blob ignored?")
> 		;
> 	else if (! "is the blob loadable and well-formed?") {
> 
> in which case "is bad blobs ignored?" check may have to happen
> before we unpack the object.
> 
> And I do not suggest introducing yet another BAD_BLOB error class; I
> would have guessed that you already have an error class for objects
> that are not stored correctly (be it truncated loose object, checksum
> mismatch in the packed base object, or corrupt delta in pack).

Sadly, there is no BAD_BLOB class. The reason is that we actually perform no test on blobs, as you pointed out, except for the implicit one: read it as a blob object.

And reading them even only partially would still imply a lot of I/O, taking away much of the performance improvement I wanted to achieve here.

Further, please note that the `--quick` option *solely* impacts `git fsck`, not `git receive-pack`, because we actually really skipped everything except the connectivity test.

To allow this discussion to be resolved without further ado, I therefore renamed the `--quick` option to `--connectivity-only`, as even I realize that there is not much of a check left if not even author or committer lines are tested.

Ciao,
Dscho
