From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH/RFC 09/10] ref-filter: introduce contents_atom_parser()
Date: Mon, 14 Dec 2015 01:06:09 +0530
Message-ID: <CAOLa=ZQ4wpeerP2x5dKy51hDosqWQ7wgasP-8hbbOU_ydm3N8A@mail.gmail.com>
References: <1447271075-15364-1-git-send-email-Karthik.188@gmail.com>
 <1447271075-15364-10-git-send-email-Karthik.188@gmail.com>
 <CAPig+cTbT60cWk+=6EARte68mmQ2xkS5xFgsgh0FbpoueFcBbg@mail.gmail.com> <CAPig+cTVqTc1S8gduLq3qiyuzJNb=LNQiXijEHwqPPzi1YU8UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 20:36:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8CRn-0006vh-Nj
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 20:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbbLMTgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 14:36:40 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33368 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbbLMTgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 14:36:39 -0500
Received: by vkca188 with SMTP id a188so143605456vkc.0
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jmTtJNV7jGSCQ+vq5HQMK4HI7gcrWoD2zXf1RfiBzhk=;
        b=fQSbiG1ZG9zf/bfChirMhR32ceYiglBihtVQOMlD8JFTUbMETgjcW5pl4A4doRwhdH
         LS5lmurHjgq0hC1sfdNo73u1LmPFYO5ZuwHi0lC2h7TD09vUTZv7a5vA4mQFoB5Rc+hw
         QnjGvugGz1qbsay2fq3T/8+hK92IWsq/wPDunobk30x8K8UDo3DwSCLd2vG396Isgfmo
         +RBypOA5IXgmik46O+OnNovAqVJOXxZH/OxWhAmApkrt4iF7/uy+IXhAfQ5uS4JjBvM4
         4VpNMWlTuiwj+f/PpModnHPB0jJ5PufErpkJsOB/Adh9F7PrXa3rKvXaFnlYU7A3X5FI
         VlBQ==
X-Received: by 10.31.155.23 with SMTP id d23mr19467662vke.146.1450035398514;
 Sun, 13 Dec 2015 11:36:38 -0800 (PST)
Received: by 10.103.97.199 with HTTP; Sun, 13 Dec 2015 11:36:09 -0800 (PST)
In-Reply-To: <CAPig+cTVqTc1S8gduLq3qiyuzJNb=LNQiXijEHwqPPzi1YU8UQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282346>

On Sun, Dec 13, 2015 at 10:11 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Dec 12, 2015 at 10:10 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Nov 11, 2015 at 2:44 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> +void contents_atom_parser(struct used_atom *atom)
>>> +{
>>> +       const char * buf;
>>> +
>>> +       if (match_atom_name(atom->str, "contents", &buf))
>>> +               atom->u.contents.all = 1;
>>> +
>>> +       if (!buf)
>>> +               return;
>
> Also, isn't this logic somewhat bogus? u.contents.all is set to 1 for
> both bare %(contents) and decorated %(contents:whatever). Then, below,
> you also set one of .body, .signature, .subject, or .lines if a
> decoration is specified. So, now you have both .all and one of the
> other attributes set to 1, which is rather nonsensical (if I
> understand correctly).
>

The problem is its not mutually exclusive here, the 'all' was supposed to
act as a way of checking if its a contents atom, since populate_value() doesn't
really check that again.

So if any of the others were selected we would implement %(contents:<value>)
else the bare %(contents:<value>) would be selected.

> If you change this to an enum as suggested in my previous email, then
> the problem goes away.
>

Yup. Will do. Thanks

-- 
Regards,
Karthik Nayak
