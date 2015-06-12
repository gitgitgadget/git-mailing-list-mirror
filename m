From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 03/12] for-each-ref: change comment in ref_sort
Date: Fri, 12 Jun 2015 13:27:20 -0700
Message-ID: <xmqqh9qcd653.fsf@gitster.dls.corp.google.com>
References: <5579B253.4020804@gmail.com>
	<1434039003-10928-1-git-send-email-karthik.188@gmail.com>
	<1434039003-10928-3-git-send-email-karthik.188@gmail.com>
	<xmqqy4joddul.fsf@gitster.dls.corp.google.com>
	<557B1B60.9020002@gmail.com>
	<xmqqpp50dcqy.fsf@gitster.dls.corp.google.com>
	<557B2516.7020609@gmail.com>
	<CAP8UFD3nsxX0XEVwxdMBRR8OQDu=ary6Bm2AD7wprAU0BC8tXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 22:27:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3VY0-0006SX-Vd
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 22:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbbFLU1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 16:27:24 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34052 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbbFLU1X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 16:27:23 -0400
Received: by iebmu5 with SMTP id mu5so31109387ieb.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=f2BwQG3hqK6nv7o+CCIqVq87kSqRDDrn6f/0lPTZG0c=;
        b=cfQBxkjBHKY9eM5hE9rb+aZevOFiXlDDXGN+kP60+zMXxkUka7hROPsBh99R4ULfS1
         hEusI+nMrtsTM0o4tRPdHtKGSiE7LdE9DZCQuTjpbkcOeNrumMeXQQHQi3TVxZvjlscZ
         4BSVyw0voPzImUcZVzgLrzOlKopkKi1o/tcuK4tuTvbtweBSbbBFxeEXKjA8bPFJHdbh
         4AsZ0dCL+Nf0ZTrhZGzUSYPQLq1HNtgiX9Z5NKFaYV6aWL/4owYsgC40vBd8+fZ1k9dP
         reYmV6MaChC3+AJ1msYrBULnrc1W7+ZEqc9xa1E1uRSnkMpiybzHSimHxzMrUG20JOV7
         oAiw==
X-Received: by 10.107.169.157 with SMTP id f29mr20397594ioj.74.1434140842710;
        Fri, 12 Jun 2015 13:27:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a12d:7c00:b954:bc66])
        by mx.google.com with ESMTPSA id qh9sm1856818igb.20.2015.06.12.13.27.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 13:27:21 -0700 (PDT)
In-Reply-To: <CAP8UFD3nsxX0XEVwxdMBRR8OQDu=ary6Bm2AD7wprAU0BC8tXA@mail.gmail.com>
	(Christian Couder's message of "Fri, 12 Jun 2015 21:49:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271518>

Christian Couder <christian.couder@gmail.com> writes:

> I think it is needed later when "struct ref_sort" is moved into
> ref-filter.h, because then the used_atom[] array is not moved.

Now I am confused.  used_atom[] is the mechanism we use to give a
small integer to each atom used in the %(placeholder) string, so
that we do not have to refer to them as "placeholder" string and we
do not have to call !strcmp() to compare for equality.  How can a
field in ref_sort refer to it internally if used_atom[] is not
visible?

Indeed, ref-filter.c after the series does have used_atom[] and
get_ref_atom_value() does use atom to index into it.  So these two
lines do not make much sense to me.  I am puzzled.

If by "moved" you are referring to the fact that the structure and
its fields are exposed to the callers of the API while the
implementation detail of the mechanism to give short integer to each
used atom is not exposed to them, then I do agree that the comment
to the structure field as the external API definition should not
talk about used_atom[] array.

Perhaps in 03/12, you can stop talking about the implementation
(i.e. the value is used to index into used_atom[] to get to the
original string) and instead start talking about what the value
means to the callers (that are still internal to for-each-ref
implementation), to make things better.

Having said that, I am not sure if there is a sensible description
for that field if you avoid exposing the implementation detail.

You would probably want to start by asking what that value means.
For (evantual) external callers, the number is what they get from
parse_ref_filter_atom(); calling that function is the only way they
can get an appropriate value to stuff in the field, and
parse_opt_ref_sorting() is the most likely function external callers
use to make that happen.

"The number internally used to represent an attribute of a ref used
when sorting the set of refs" would be one way to say what it is
without exposing the implementation detail to the readers.

But does that help anybody?  I doubt it.  It is mouthful for
external users, and it is not concrete enough for implementors.

So either

 - treat ref-filter.h as information for API users, and not talk
   about what it means at all, or

 - treat ref-filter.h as information for both API users and API
   implementors, and describe it as an index into used_atom[],
   i.e. do not change anything.

I'd say the latter is a more sensible way to go.  I think it is also
OK to change this comment to "index into used_atom array (internal)"
when ref-filter.h is created as an external API definition.
