From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 00/10] port branch.c to use ref-filter's printing options
Date: Fri, 09 Oct 2015 10:22:49 +0200
Message-ID: <vpqpp0ojvs6.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<vpqr3l5zgst.fsf@grenoble-inp.fr>
	<CAOLa=ZQvB_S2-nw8hOABt7aQJOWJXvfK1U2zurpnZmaAgJNnGA@mail.gmail.com>
	<vpq8u7dp9qr.fsf@grenoble-inp.fr>
	<CAOLa=ZQOO9BjoTj1B-b=kUviL=617F7y46BeX1sOXpeHcatFVQ@mail.gmail.com>
	<xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 10:23:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkSxG-0005aq-TY
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 10:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933725AbbJIIXC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2015 04:23:02 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60628 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933626AbbJIIW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2015 04:22:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t998MmhH031964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 9 Oct 2015 10:22:48 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t998MnUG018885;
	Fri, 9 Oct 2015 10:22:49 +0200
In-Reply-To: <xmqq4mi1rywu.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 08 Oct 2015 11:35:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 09 Oct 2015 10:22:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t998MmhH031964
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444983772.75594@j8CsaB+eQufxDKGBFufiBQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279303>

Junio C Hamano <gitster@pobox.com> writes:

> Then used_atom[] could become something like
>
>     struct {
>     	const char *str; /* e.g. "align:position=left,32" */
> 	struct {
>         	const char *part0; /* everything before '=' */
>                 const char *part1; /* optional */
> 	} *modifier;
>         int modifier_nr;
>     } *used_atom;

If the goal is to prepare as much as possible when parsing the format
string, I'd even push it one step further and have stg like

     struct {
     	const char *str; /* e.g. "align:position=left,32" */
 	union {
         	struct {
			int position;
			enum { left, right, center } kind;
		} align;
                struct {
                	....;
                } objectname;
        int modifier_nr;
     } *used_atom;

Just a thought, I'm not sure how useful this would be, and this may be
too much change for this series (so it may deserve a separate topic).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
