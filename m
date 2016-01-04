From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 01/17] strbuf: make strbuf_getline_crlf() global
Date: Mon, 4 Jan 2016 13:25:35 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601041255110.14434@virtualbox>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com> <1450303398-25900-1-git-send-email-gitster@pobox.com> <1450303398-25900-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 13:25:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG4Cr-00065G-Cg
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 13:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbcADMZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 07:25:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:52644 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598AbcADMZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 07:25:41 -0500
Received: from virtualbox ([37.24.143.189]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LqiJO-1ZksK23bfe-00eIqf; Mon, 04 Jan 2016 13:25:36
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1450303398-25900-2-git-send-email-gitster@pobox.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:SNHWZcuPQfCsorGY8bj71UKmNbTOLhGVKzzvw39mMgKHsByrZWf
 PgQf/hPStVsjJzu6bXXNikFrpqm/BM+fC1E6EZraNBlsnsdmU2+J/KaWiXBslWEdsKBJxNl
 XwFolX4DlwMHZqS6oi8QxBL4A9WCCeVWxq2Y7+poHu5kqM2FnKt/4+GxY9U5rSEHs9jT8hw
 VJY2etHMKR3NjfA++8Kfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2JdqEe/Fr28=:DMpFq2yp0lIRdHcm5CQBMz
 5Er/ZI5/81BgUD2s/q/4aoLeTQvyF/jJBznFhetMN9CPAISuwM7y2m80ZRYZVVlHaUiiZLcCQ
 QkxhCUaCKTwTcD34+J1vcozUMJ9lYKbwWRS8M7TKoyUp2jXSQa/SM7XdIcqCsHLsopfkIUqyf
 2zdTWZERDDk2VD7wbpSMdT9tTlUhfb9/PCLMWNZGzKwhWdUxSFOh6XYhYGjGn2Fy87NPKFU6N
 sf4x5j27zs1EvINNlbtEI7ZRyXDNQ6P/15WqqTxLzDPFeiSXi20jP8oYpZ5UEParYSh4H7nw6
 O7qVyZHw2OwDlvUQ3pywlRFOah2xbe8HvGg+eHK7kHF3sktgHgWlHXReiNg/1TKsJI31x9P2o
 O2NtOTuqDNgWgTbJlWhLqV+ULCrEpHbTz3JcA7aAwb8jCeIUReJHtUbRgXxDnUlANGWzmHyR0
 hb6Kc0o/zEBJ+brGqfd40RQghwxUHn6h7UzjJbeU20/F7yRbz9+qkWWnsyEJYel5w8YEvB9HV
 8m6y+DzrreXzSeW2Q3+uPJPUW5UClTCCVFXSXLjxi5emR1d/qpJZ2T+BL2FpDvreE5CukTHyq
 r3Fa6f9M/fr9uCkFdTnIy++cqOOlAc9FJ8a+o6JgIXYsu0+IFeIXuVqcR9iIZmO/0BHt7WrDS
 CZwjR5uzwBRWW+xfe9TxlnFXqE7HcqqtMx3fbAQy8T5IjvhawDmIxGdNzedajM/R3QOa+DRHm
 b5kFQPpa6N7h8DPdvm3WhdrJyCB5AQ+vDMx5cTWZUcET0p02xwGhTLVxfqXrEjja/xxPGkI6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283299>

Hi Junio,

On Wed, 16 Dec 2015, Junio C Hamano wrote:

> Often we read "text" files that are supplied by the end user
> (e.g. commit log message that was edited with $GIT_EDITOR upon
> 'git commit -e'), and in some environments lines in a text file
> are terminated with CRLF.  Existing strbuf_getline() knows to read
> a single line and then strip the terminating byte from the result,
> but it is handy to have a version that is more tailored for a "text"
> input that takes both '\n' and '\r\n' as line terminator (aka
> <newline> in POSIX lingo) and returns the body of the line after
> stripping <newline>.
> 
> Recently reimplemented "git am" uses such a function implemented
> privately; move it to strbuf.[ch] and make it available for others.

... While at it, we fix the formatting of the strbuf_getline() function.

Ciao,
Dscho
