From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/17] Peace with CRLF
Date: Mon, 4 Jan 2016 13:25:28 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601041244370.14434@virtualbox>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com> <1450303398-25900-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 13:25:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG4Cn-00061M-7q
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 13:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbcADMZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 07:25:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:49212 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455AbcADMZk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 07:25:40 -0500
Received: from virtualbox ([37.24.143.189]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MEWPx-1aRKj505wP-00FifE; Mon, 04 Jan 2016 13:25:30
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:37HBWAcYllt7MouZ8mSu1m2NacdTLYZDtKZL1iC/hhsYKFrGlIM
 Brw+nkhOuArM114uTwIqbrEkSaokXsjbQzn9IBvqV0KV7G1QK+gqRr1DF1jKEJUKJZlf+qt
 /OR5AFa9U6QiRuyOalcsCJbSgZhwNwI1tV8523EwDyOTVn/EAAaDOxXTuXy/9XVof7rLOmb
 OzEGqdEexOr+4YOQUqUYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1v52FbGgD/c=:pePIDwwLxaJqVEy6fCaoa2
 onGsRR09HEQTR6H1u601/D+BoMvawDifZAlY82dSpEDLA1r7SeYeQ7HIT1peThFau1XxGsvPA
 YrfC9ODWJRBjZkBD4PziMP8u8CgHQ81/mASmGcK86O2JAb2+LfkVSoGAmxtvTn/yuQAFToZQ4
 Oq3wSiubLDZbIyKeYGakGONfMxqBuFZLpyi8vALxt1YRrXT4rjsqydsUt2qMGDFzoua1JnLpf
 hBkc05vq98CfvWpXO9kIAZBWeMQTVFB1uZAOsi1EPd4bc03s2WoCUTlJSI2vkWXd4LlN22Q+G
 MjwUclS9L5xlYgI8Ncsi0R/LhiIJbqJVAcux+ytvDMr3ZKSHv00FAY8hrv1FNUuOhbe0Xy2Jj
 8mJGhgoZ/h5aP55KfAAoGGVRbrZN3QiJbGbTy0Bi47WOSY+tJh5O46oDCqB/3ta/Eq86ikMTb
 Du1fknPMrZbKgZRSkIiqI+ODEpnhq9mKn2rm8QS6VjeNQiJadccf/vB3FSFO6Jb5sydmYf7ZB
 KdqnDnIEnqybGBML3+vXaAud1XBjdL7To1k0+V97vMtEmQwSybUanNXIM1R7xzJDkrJC6Y8SS
 2wIXmACzra/wIBTVUH2NFEumcogeWYVUxCu/fLtp2Hoa/L2DbbXvudSTTTD3AciX31Yh9W8y9
 JpP5I/wCxDYbiACumGbBjtWps8KhMR1RT/jcBhknGu+u6AN3zXMfadeCztzKhqYgsZf5bRe3T
 6YmLoVvZcs/+RVcRp6MDsIxKNWCJqkiDTlLDdMiBfRwTeyB4I1wayg4C+U1eztBdTc5nCwfD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283298>

Hi Junio,

On Wed, 16 Dec 2015, Junio C Hamano wrote:

> I inspected all the callsites of this function to see if it is safe
> to use such an updated logic at these callsites, and did not find
> anything problematic.  I could update strbuf_getline() in place, but
> just to be extra careful, this series instead introduces another
> helper, strbuf_getline_crlf(), that is aware of this CRLF business,
> and convert the ones that are safe to update as we verify.
> 
>  * This series converts only the callers of strbuf_getline() that
>    would misbehave when fed a file with CRLF-terminated lines and
>    use the data with an unwanted CR appended at the end.  With the
>    update the code should work as intended with such a file, without
>    breaking the expected behaviour when working on a file with
>    LF-terminated lines.
> 
>  * Callers of strbuf_getline() that expect to only read from our own
>    output do not have to accommodate CRLF-terminated lines, but they
>    can be updated to do so safely if we do not rely on the ability
>    to express a payload that has CR at the end.  For example, the
>    insn sheet "rebase -i" uses typically ends each line with a
>    commit log summary that we ourselves do not read or use, so even
>    if the end-user on a platform with LF lines deliberately does
>    insert \r at the end of the line and strbuf_gets() removed that
>    \r from the payload, no unexpected behaviour should happen.
> 
>    This series does not touch them, but it may be a good GSoC
>    microproject to convert them to use strbuf_getline_crlf().
> 
>  * Callers of strbuf_getline() that call strbuf_trim() immediately
>    on the result before doing anything, or otherwise have logic that
>    tolerates whitespaces at the end of the line, can continue using
>    strbuf_getline() and will not misbehave on CRLF-terminated lines.
> 
>    This series does not touch them; converting them to use
>    strbuf_getline_crlf() would a good way to document them as
>    dealing with "text".  While doing so, they can also lose their
>    custom logic that happens to make CRLF-terminated lines work.
> 
>  * A caller of strbuf_getline() that wants to only see LF-terminated
>    lines (in other words, "ABC\r\n" must be treated as a line with 4
>    bytes payload on it, A B C and CR), would be broken if we replace
>    it with strbuf_getline_crlf().  This series does not touch them,
>    and no follow-up series should, either.

Thanks for the detailed explanation. I totally agree that (2) would make
for a good micro-project.

While I am pretty convinced that strbuf_getline() that retains a CR makes
no sense, it is obviously the correct thing to prove that rather than
assume it (after all, some caller might exploit strbuf_getline() for its
auto-growing capabilities even on a binary stream when it is known that it
cannot contain a 0x0a).

And please accept my gratitude for tackling this project.

Ciao,
Dscho
