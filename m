From: Matthieu Moy <matthieu.moy@imag.fr>
Subject: Re: [PATCH v9 03/11] ref-filter: implement an `align` atom
Date: Sun, 09 Aug 2015 10:00:17 +0200
Message-ID: <368C34E3-F245-45AD-847B-0866C61295DA@imag.fr>
References: <CAOLa=ZRnnMBKpsq1ANBVgF2=xwK=A2EsPKKrGS0R4mZ8iATKfA@mail.gmail.com> <1438800854-19901-1-git-send-email-Karthik.188@gmail.com> <CAPig+cTOzZ0RFd2eu43rYQDnsXmfswbRx3=vN41BJf_BHON7tA@mail.gmail.com> <CAOLa=ZT+hCgM+mL2vQknwUjaxG9Mr4C2Qir=aa==Fv9CebYwLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 10:00:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOLX6-0002EX-02
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 10:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932863AbbHIIAf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Aug 2015 04:00:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48196 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754328AbbHIIAe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 04:00:34 -0400
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7980M3r020721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 9 Aug 2015 10:00:22 +0200
Received: from [10.160.38.49] ([37.160.143.115])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id t7980LID006631
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 9 Aug 2015 10:00:22 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAOLa=ZT+hCgM+mL2vQknwUjaxG9Mr4C2Qir=aa==Fv9CebYwLg@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 09 Aug 2015 10:00:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7980M3r020721
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1439712026.28246@gUf3egprbMewha856IO82A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275529>



Le 8 ao=C3=BBt 2015 09:03:03 GMT+02:00, Karthik Nayak <karthik.188@gmai=
l.com> a =C3=A9crit :
>On Fri, Aug 7, 2015 at 9:34 AM, Eric Sunshine <sunshine@sunshineco.com=
>
>wrote:
>> On Wed, Aug 5, 2015 at 2:54 PM, Karthik Nayak <karthik.188@gmail.com=
>
>wrote:
>>> Implement an `align` atom which will act as a modifier atom and
>align
>>> any string with or without an %(atom) appearing before a %(end) ato=
m
>>> to the right, left or middle.
>>>
>>> It is followed by `:<type>,<paddinglength>`, where the `<type>` is
>>> either left, right or middle and `<paddinglength>` is the total
>length
>>> of the padding to be performed. If the atom length is more than the
>>> padding length then no padding is performed. e.g. to pad a
>succeeding
>>> atom to the middle with a total padding size of 40 we can do a
>>> --format=3D"%(align:middle,40).."
>>>
>>> Add documentation and tests for the same.
>>
>> I forgot to mention in my earlier review of this patch that you
>should
>> explain in the commit message, and probably the documentation, this
>> this implementation (assuming I'm understanding the code) does not
>> correctly support nested %(foo)...%(end) constructs, where %(foo)
>> might be %(if:), %(truncate:), %(cut:), or even a nested %(align:),
>or
>> some as yet unimagined modifier. Supporting nesting of these
>> constructs will require pushing the formatting states onto a stack
>(or
>> invoking the parser recursively).
>>
>>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
>Good point, I have been working on this parallely and it works for now=
,
>I'll send that with the %(if) and %(end) feature. But for now, it
>should be
>documented and added in the commit message.
>
>Using a linked list of sorts where whenever a new modifier atom is
>encountered
>a new state is created, and once %(end) is encountered we can pop that
>state
>into the previous state.

Good, but keep in mind that this is not needed to port tag/branch, and =
your GSoC end soon. So keep your priorities in mind... IMHO, the nestab=
le implementation can wait.=20

Cheers,

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
