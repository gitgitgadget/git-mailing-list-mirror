From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Thu, 03 Sep 2015 16:47:19 +0200
Message-ID: <vpq8u8nh85k.fsf@anie.imag.fr>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-8-git-send-email-Karthik.188@gmail.com>
	<vpq8u8ptcjq.fsf@anie.imag.fr>
	<CAOLa=ZTB_uMvKjU=f9UgmvOmeZD4YtFL_Gv1+VvZAgDV-6WYDA@mail.gmail.com>
	<vpq7fo8ol7i.fsf@anie.imag.fr>
	<CAOLa=ZRiGg1snfsi_mxQYq-wV6Zz4cTkxum47dRowp1XopQejw@mail.gmail.com>
	<CAOLa=ZRSbixzcNyF_s2E+oHMJsG7SuKizb5WHHk5Dmj-OKEetw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 16:47:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXVnb-0002pE-NC
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 16:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431AbbICOr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 10:47:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51276 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756402AbbICOrY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 10:47:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t83ElHbW002367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 3 Sep 2015 16:47:18 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t83ElJL1018122;
	Thu, 3 Sep 2015 16:47:19 +0200
In-Reply-To: <CAOLa=ZRSbixzcNyF_s2E+oHMJsG7SuKizb5WHHk5Dmj-OKEetw@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 3 Sep 2015 19:19:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 03 Sep 2015 16:47:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t83ElHbW002367
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441896438.43133@xzkr3MIPEdY1Q5XA73+Bjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277208>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Thu, Sep 3, 2015 at 7:04 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>                         struct strbuf s = STRBUF_INIT;
>>>                         if (strtoul_ui(valp, 10, &v->u.contents.lines))
>>>                                 die(_("positive width expected contents:lines=%s"), valp);
>>> -                       append_lines(&s, subpos, sublen + bodylen - siglen, v->u.contents.lines);
>>> +                       append_lines(&s, subpos, bodypos + bodylen - subpos, v->u.contents.lines);
>>>                         v->s = strbuf_detach(&s, NULL);
>>>                 }
>>>         }
>
> append_lines(&s, subpos, bodylen + bodypos - subpos - siglen,
> v->u.contents.lines);
>
> We need to eliminate the signature if existing also.

Indeed. I thought body did not include the signature.

I'd write it as

  bodylen + bodypos - siglen - subpos

or even

  char *contents_end = bodylen + bodypos - siglen;
  ...
  append_lines(&s, subpos, contents_end - subpos, ...);

to make it self-explanatory.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
