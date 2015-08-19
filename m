From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v12 01/13] ref-filter: move `struct atom_value` to ref-filter.c
Date: Wed, 19 Aug 2015 20:59:44 +0530
Message-ID: <CAOLa=ZTuhUfXmqQdmGJ2u=5js23akgQWprDUWZYNJsd+=ncw5A@mail.gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
 <1439923052-7373-2-git-send-email-Karthik.188@gmail.com> <vpqy4h72up1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 19 17:30:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5Jl-0007HA-Tl
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbbHSPaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:30:15 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:32802 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbbHSPaO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:30:14 -0400
Received: by obbhe7 with SMTP id he7so7285070obb.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Pl1K/C7zuJW3yOpjIYzSR5MLqd+8rKP1QTCSc2QpkfI=;
        b=VRpNPrStI/+RtJ/ubCi2OLAzSYdHIapiDN9+Dl2MlYT+gdbIFpBU9NcS0a42WLtvA+
         8QzZSJnmP8tiazS/XVKrcxPqsy00cgRskJpErtpzmyDqbZxmYT3eQA39xPIj7SEY3VSS
         cx3MrFJ8bnbE0trkZAxIBW5YJMUR49kvyiWchpE6CkyxyBvp1VIQlwVmy8Jb3ntx0OM0
         sAKqMiTxvFklo3vGe6krVGarsSaJjcrGFUmarlrsX88vbLldPC6mhrYf3U4iewit3Z4M
         wA8821hKn3YqOxLJP/EuvBzrgrtbkacGPg+zgWg6ouv4754jo05R/ST7eIngUmmSHjTW
         +KPg==
X-Received: by 10.60.62.105 with SMTP id x9mr10911463oer.1.1439998213564; Wed,
 19 Aug 2015 08:30:13 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 19 Aug 2015 08:29:44 -0700 (PDT)
In-Reply-To: <vpqy4h72up1.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276195>

On Wed, Aug 19, 2015 at 8:26 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state **state)
>> +{
>> +     struct ref_formatting_state *current = *state;
>> +     if (!current->at_end)
>> +             die(_("format: `end` atom used without a supporting atom"));
>
> You error out on %(end) without %(align), but not on %(align) without
> %(end).
>
> You should probably check that the stack is empty at the end and error
> out otherwise.
>

You're right,

    if (state->prev)
        die(_("format: `end` atom missing"));

should do before printing.

-- 
Regards,
Karthik Nayak
