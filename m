From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v9 03/11] ref-filter: implement an `align` atom
Date: Sun, 9 Aug 2015 13:40:16 +0530
Message-ID: <CAOLa=ZS4GKkzMZvSRiK6FdL1OjJ=MdKkQt7Mxb2sT0-LPX9V-A@mail.gmail.com>
References: <CAOLa=ZRnnMBKpsq1ANBVgF2=xwK=A2EsPKKrGS0R4mZ8iATKfA@mail.gmail.com>
 <1438800854-19901-1-git-send-email-Karthik.188@gmail.com> <CAPig+cTOzZ0RFd2eu43rYQDnsXmfswbRx3=vN41BJf_BHON7tA@mail.gmail.com>
 <CAOLa=ZT+hCgM+mL2vQknwUjaxG9Mr4C2Qir=aa==Fv9CebYwLg@mail.gmail.com> <368C34E3-F245-45AD-847B-0866C61295DA@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <matthieu.moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Aug 09 10:10:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOLh5-00018u-28
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 10:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932911AbbHIIKz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Aug 2015 04:10:55 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34905 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932912AbbHIIKr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Aug 2015 04:10:47 -0400
Received: by obbop1 with SMTP id op1so105450027obb.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=u6R1Tp6DFf1PwsEH5KSesfnpAVaeX2e0rit//bL0WYk=;
        b=MmCZv/PskNI/eBNuT813iprQJUbTIgrP6Zq9FFxxuyko0wdKPwMeWAqXjM8ns/Gf9Y
         +PJB4ysBPv4bx/TyFjOIAiInOn/SkVX3qaszYdIG+WwlGPgwr4H6YWbyIkAk3QK8uNQY
         zvw3ZSlgIUFmyRutsvhBaijZjdprDoLfUCL/8qG4CF1T4DQuP4/hnA3jvhGfI8Xcaqtd
         YUee56p2WrKmkJmYb6/05/hhy61ITxGNibRknF4eG3yGGD1799o5gCPantG27LTD9Fuk
         TLZYOcUzJUq4nfDNxEPoVjjJv1g528eOW+1A26v3ebeO0zrp8IAwGGtyjzq60xy52kCZ
         aVxQ==
X-Received: by 10.60.42.230 with SMTP id r6mr15358925oel.9.1439107846068; Sun,
 09 Aug 2015 01:10:46 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sun, 9 Aug 2015 01:10:16 -0700 (PDT)
In-Reply-To: <368C34E3-F245-45AD-847B-0866C61295DA@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275532>

On Sun, Aug 9, 2015 at 1:30 PM, Matthieu Moy <matthieu.moy@imag.fr> wro=
te:
>
>
> Le 8 ao=C3=BBt 2015 09:03:03 GMT+02:00, Karthik Nayak <karthik.188@gm=
ail.com> a =C3=A9crit :
>>On Fri, Aug 7, 2015 at 9:34 AM, Eric Sunshine <sunshine@sunshineco.co=
m>
>>wrote:
>>> On Wed, Aug 5, 2015 at 2:54 PM, Karthik Nayak <karthik.188@gmail.co=
m>
>>wrote:
>>>> Implement an `align` atom which will act as a modifier atom and
>>align
>>>> any string with or without an %(atom) appearing before a %(end) at=
om
>>>> to the right, left or middle.
>>>>
>>>> It is followed by `:<type>,<paddinglength>`, where the `<type>` is
>>>> either left, right or middle and `<paddinglength>` is the total
>>length
>>>> of the padding to be performed. If the atom length is more than th=
e
>>>> padding length then no padding is performed. e.g. to pad a
>>succeeding
>>>> atom to the middle with a total padding size of 40 we can do a
>>>> --format=3D"%(align:middle,40).."
>>>>
>>>> Add documentation and tests for the same.
>>>
>>> I forgot to mention in my earlier review of this patch that you
>>should
>>> explain in the commit message, and probably the documentation, this
>>> this implementation (assuming I'm understanding the code) does not
>>> correctly support nested %(foo)...%(end) constructs, where %(foo)
>>> might be %(if:), %(truncate:), %(cut:), or even a nested %(align:),
>>or
>>> some as yet unimagined modifier. Supporting nesting of these
>>> constructs will require pushing the formatting states onto a stack
>>(or
>>> invoking the parser recursively).
>>>
>>>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>>
>>Good point, I have been working on this parallely and it works for no=
w,
>>I'll send that with the %(if) and %(end) feature. But for now, it
>>should be
>>documented and added in the commit message.
>>
>>Using a linked list of sorts where whenever a new modifier atom is
>>encountered
>>a new state is created, and once %(end) is encountered we can pop tha=
t
>>state
>>into the previous state.
>
> Good, but keep in mind that this is not needed to port tag/branch, an=
d your GSoC end soon. So keep your priorities in mind... IMHO, the nest=
able implementation can wait.
>
> Cheers,
>

Agreed, but it was just something I had already worked on. Probably
will push that series after GSoC :)


--=20
Regards,
Karthik Nayak
