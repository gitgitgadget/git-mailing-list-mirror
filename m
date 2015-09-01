From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Tue, 1 Sep 2015 20:43:56 +0530
Message-ID: <CAOLa=ZQfHViZa15SD-PZOr_AZqAEnN9RJ9ouPhUoEMUfSd56Gw@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-5-git-send-email-Karthik.188@gmail.com> <CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
 <CAOLa=ZTHtps2gJb9asSzG_4NOwx_xiA7OuCzjW=BTTFfkaYoQg@mail.gmail.com>
 <CAPig+cQF=1FPFP_7Bn2m2J+ay5ZupG25USWc9LT9SqO1=VDZvg@mail.gmail.com>
 <CAOLa=ZS53BNNvnYv2TU6xQbEihi1GiKBaEEZ=KT6p_gDBR9Y9Q@mail.gmail.com>
 <CAPig+cRAYeF0ZDn5FsHioZr1g4pH3Ay69_3KDb8ZF1USZxzcEg@mail.gmail.com>
 <vpqpp235pvg.fsf@anie.imag.fr> <CAPig+cRig+zk=D1SDF7wBHuQgcQqb-4cHkmeVgLs5BaWzk9WRg@mail.gmail.com>
 <CAOLa=ZQV63ZETPswEPYjSMrXcZAK+W-Jek+Psq7wtmSsQHtb3g@mail.gmail.com> <vpqk2sa1dyp.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 01 17:14:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWnGa-0008Iq-Qc
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 17:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbbIAPO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 11:14:28 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35243 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbbIAPO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 11:14:27 -0400
Received: by obuk4 with SMTP id k4so1744233obu.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WeQ4RC5e8BWgB8/xbnlS4+vn71hG4fbNhztPKZtohmY=;
        b=IfnwhujumzsyeT1MIiWlI8oMJEjBFrpMaY4M0/uXznwHmIcRjdb6Oa6JabjCLTP/L3
         2JFLQfYwhI/8CMr9aUrmYkwNBBqxfljMv3k7hJGZ3sguXOmvNZE5fQvH2I65WlpHV1Id
         pHiFQvsCmVOgjRnxrsmdxtEcMzRAFhppiWIlW2sGhRtBZNtY7XvZCcuPXGVoKrt/Zfif
         rkKYnxI80PEtop2B5E8gGPmJBEGNeC8i6x8B2QSu5L0/vFpC+UohDflpDPKHhBMc5yz2
         OaO003r2KU0AkEM2wp0fG5vCQ0rXADZvBjfUZL1QtZjuuRheP+fN1I7L9w0QhrxOypCz
         GctA==
X-Received: by 10.182.171.35 with SMTP id ar3mr16683845obc.57.1441120466028;
 Tue, 01 Sep 2015 08:14:26 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 1 Sep 2015 08:13:56 -0700 (PDT)
In-Reply-To: <vpqk2sa1dyp.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276983>

On Tue, Sep 1, 2015 at 6:41 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Like this:
>>
>>  else if (skip_prefix(name, "align", &valp)) {
>>             struct align *align = &v->u.align;
>>             struct strbuf **s;
>>
>>             if (valp[0] != ':')
>>                 die(_("format: usage %%(align:<width>,<position>)"));
>>             else
>>                 valp++;
>>             ......
>>             ........
>> }
>
> Checking the string's correctness as you read it seems good to me, yes.
>
> But as you say, you should make this a bit more generic, for example by
> putting your "if/else" in a helper function, that other atoms could use.

Okay then, I'll keep that in mind :)

-- 
Regards,
Karthik Nayak
