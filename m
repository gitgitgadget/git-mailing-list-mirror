From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 07/11] ref-filter: introduce align_atom_parser()
Date: Sat, 19 Dec 2015 17:05:53 +0530
Message-ID: <CAOLa=ZTvuGeKbstvWi939_VD2ciJf0Fhine7VjkDqi_DjPT_9Q@mail.gmail.com>
References: <1450279802-29414-1-git-send-email-Karthik.188@gmail.com>
 <1450279802-29414-8-git-send-email-Karthik.188@gmail.com> <CAPig+cR=dYnMfaHUYcq_kz8M+C1nCxOX=SN=_6+ep1aWvVCUow@mail.gmail.com>
 <CAOLa=ZQH4sb1e87Hrze_xThkH9fCKMzzFQQ106cXf3w83wr1aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 12:36:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAFoK-0001fb-Vg
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 12:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbbLSLgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 06:36:23 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34703 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932175AbbLSLgX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 06:36:23 -0500
Received: by mail-vk0-f42.google.com with SMTP id j66so79051782vkg.1
        for <git@vger.kernel.org>; Sat, 19 Dec 2015 03:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9isNvfRxrctNZ7+mPFXauxH1BUtzUbWSeuy5QCINIP4=;
        b=PIdQUWcTKV76hc0lKbaUNRi/NdXFw6/bQktWmEjotU7brkNg7dYpuIXeNDsiJxtaih
         WcRi6u5v3haLbKvo8a8iLpdbI4R2BKEZDdcQuJuL//c6e3knFIBZ9tbN0R/ZSBraOMvQ
         jBP0nllk2Y/3d7FgwjgZF6UNnhYQFe1xewn+k+erSA7Lvz7z98ZDbJwF3iVgShk2CCcB
         SeIYsSnEtFKn+/Bcn4qYEfUr8OKkbT58hF29S5Oa3e7J/JPkYrF0fDlec74fErmPDt2o
         hnH83HQXspWnjtkFlTkU0PdhMcE1uQE3uYn1roBvLDxIJELemAYA8Ih2WWHAGV8iNEQu
         HSsQ==
X-Received: by 10.31.142.16 with SMTP id q16mr5511486vkd.95.1450524982472;
 Sat, 19 Dec 2015 03:36:22 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Sat, 19 Dec 2015 03:35:53 -0800 (PST)
In-Reply-To: <CAOLa=ZQH4sb1e87Hrze_xThkH9fCKMzzFQQ106cXf3w83wr1aA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282744>

On Fri, Dec 18, 2015 at 11:20 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Dec 16, 2015 at 10:29 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce align_atom_parser() which will parse an "align" atom and
>> store the required alignment position and width in the "use_atom"
>> structure for further usage in 'populate_value()'.
>>
>> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -63,6 +69,49 @@ static void color_atom_parser(struct used_atom *atom)
>> +static void align_atom_parser(struct used_atom *atom)
>> +{
>> +       [...]
>> +       match_atom_name(atom->str, "align", &buf);
>> +       if (!buf)
>> +               die(_("expected format: %%(align:<width>,<position>)"));
>> +       [...]
>> +}
>> @@ -880,35 +924,7 @@ static void populate_value(struct ref_array_item *ref)
>>                                 v->s = " ";
>>                         continue;
>>                 } else if (match_atom_name(name, "align", &valp)) {
>
> Hmm, align_atom_parser() has already been called before we get here,
> right? And it has already invoked match_atom_name() and died if the
> argument to "align:" was missing, correct? If so, then this invocation
> of match_atom_name() in populate_value() is unnecessary and should be
> replaced with a simpler starts_with("align:").
>
> Plus, 'valp' is not used, aside from this unnecessary
> match_atom_name(), thus it can be removed as well.
>

WIll do. Thanks for noticing this. I missed it.

-- 
Regards,
Karthik Nayak
