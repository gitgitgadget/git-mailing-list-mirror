From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Sun, 30 Aug 2015 17:59:16 -0400
Message-ID: <CAPig+cRUJa3hRk4utH6A8iHv6y2=XukTkiLWFet4dkeEw1sLzA@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-5-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
	<CAOLa=ZRZ6RcRm6ERR=NVzng17qJx+1N8iGThuo=xQhEszJQ90w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 23:59:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWAdH-0000Ec-Hi
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 23:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbbH3V7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 17:59:18 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34859 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbbH3V7R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 17:59:17 -0400
Received: by ykbu129 with SMTP id u129so29506031ykb.2
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 14:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=f5DAz9ODNq46SaVQZRWnwKd/KAhvyA4HK5M74x1ULe8=;
        b=tsf+LV00CdMo/0obAMNjW3Fu3Y5Cfd7DqWsewc+VXyfdsBrXXKT6omJcvcryVHkEyq
         InFlokNkQpWwrxM8oVJ1rOJzc+qtAmpAcmxK5UUV3fo/kgAM2tO61OHSTjaeXtmBM/pM
         q48gREaRkdwJ5MpMA4LmgW3FAeQ71CIdApdg1uSluUDXjkdSA4aqO/lLrM/nchAozqv6
         5x2tDC+E9APnG9IXVarxx94eAbNd2LQQFpdZ1wRV9lqx9P+5HvYxaD0dHrGFIZw0nPO+
         1knFH0zLSQalvuMYAJKcQNMt6jVg+/AkL4zWKag9F1hHiCVxv0sq4nkXKnuP2EQkOW1X
         E1qA==
X-Received: by 10.129.134.3 with SMTP id w3mr17725254ywf.48.1440971956707;
 Sun, 30 Aug 2015 14:59:16 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 30 Aug 2015 14:59:16 -0700 (PDT)
In-Reply-To: <CAOLa=ZRZ6RcRm6ERR=NVzng17qJx+1N8iGThuo=xQhEszJQ90w@mail.gmail.com>
X-Google-Sender-Auth: IFaxULSmlfNyBg86XzVq5m31W0E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276840>

On Sun, Aug 30, 2015 at 10:57 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Sun, Aug 30, 2015 at 8:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> +struct align {
>>> +       align_type position;
>>> +       unsigned int width;
>>>  };
>>>
>>>  #define REF_FORMATTING_STATE_INIT  { 0, NULL }
>>> @@ -69,6 +79,8 @@ struct ref_formatting_state {
>>>
>>>  struct atom_value {
>>>         const char *s;
>>> +       struct align *align;
>>
>> Why does 'align' need to be heap-allocated rather than just being a
>> direct member of 'atom_value'? Does 'align' need to exist beyond the
>> lifetime of its 'atom_value'? If not, making it a direct member might
>> simplify resource management (no need to free it).
>
> But it does, since we carry over the contents of align from atom_value to
> cb_data of ref_formatting_stack and that holds the value until we read
> the %(end)
> atom hence it seemed like a better choice to allocate it on the heap

So, you're saying that the 'atom_value' instance no longer exists at
the point that processing of %(end) needs to access the alignment
properties? If so, then heap allocation make sense. Thanks.
