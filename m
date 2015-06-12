From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 03/12] for-each-ref: change comment in ref_sort
Date: Sat, 13 Jun 2015 02:52:08 +0530
Message-ID: <CAOLa=ZQwtaA0xRySnUtDQ6DUTqgCPM-7NM99EZucWDLzY-wCfw@mail.gmail.com>
References: <5579B253.4020804@gmail.com> <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
 <1434039003-10928-3-git-send-email-karthik.188@gmail.com> <xmqqy4joddul.fsf@gitster.dls.corp.google.com>
 <557B1B60.9020002@gmail.com> <xmqqpp50dcqy.fsf@gitster.dls.corp.google.com>
 <557B2516.7020609@gmail.com> <CAP8UFD3nsxX0XEVwxdMBRR8OQDu=ary6Bm2AD7wprAU0BC8tXA@mail.gmail.com>
 <xmqqh9qcd653.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 23:22:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3WPK-00037j-81
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 23:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbbFLVW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 17:22:29 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34815 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbbFLVW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 17:22:29 -0400
Received: by oiax69 with SMTP id x69so5714245oia.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 14:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=myoZNQj7cH3icUO2gLGf8LGpqq/gAeqwXLCCg6YOXgk=;
        b=lXnkTPqivVdifxQ9c3od+OFsL0jrE+n3cg75sJF9XdHc4Qhp/cbx3ahvQNWrna/FCt
         3H0O0tfyHya2uMznBop4/mBWf1ZxbTCwo7nx7COGfi0vr6OnkaVv3Xet/GC8u4tdJ03W
         MtYlxSx0MLFOFfHjBH6N0VDssrGu1LMBq+WGfuFUHi7ONEKQt/2yJJ1h0p5jqnxRqzXR
         d32bf9Cfrsa2KYPRKx4yQSkYCaey/KCWX+Y1MzG07djJBdV2O1IPD7HuUv204JjfvmQD
         5CoE746Gs64nh/ofpcNgzwYcWk5jVXzSLLOMgJ5cD1bAJOowi0uHXbjVauuAip3h5pUX
         nlGg==
X-Received: by 10.202.73.82 with SMTP id w79mr7547976oia.102.1434144148534;
 Fri, 12 Jun 2015 14:22:28 -0700 (PDT)
Received: by 10.182.28.5 with HTTP; Fri, 12 Jun 2015 14:22:08 -0700 (PDT)
In-Reply-To: <xmqqh9qcd653.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271524>

On Sat, Jun 13, 2015 at 1:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> I think it is needed later when "struct ref_sort" is moved into
>> ref-filter.h, because then the used_atom[] array is not moved.
>
> Now I am confused.  used_atom[] is the mechanism we use to give a
> small integer to each atom used in the %(placeholder) string, so
> that we do not have to refer to them as "placeholder" string and we
> do not have to call !strcmp() to compare for equality.  How can a
> field in ref_sort refer to it internally if used_atom[] is not
> visible?
>
> Indeed, ref-filter.c after the series does have used_atom[] and
> get_ref_atom_value() does use atom to index into it.  So these two
> lines do not make much sense to me.  I am puzzled.
>
> If by "moved" you are referring to the fact that the structure and
> its fields are exposed to the callers of the API while the
> implementation detail of the mechanism to give short integer to each
> used atom is not exposed to them, then I do agree that the comment
> to the structure field as the external API definition should not
> talk about used_atom[] array.
>
> Perhaps in 03/12, you can stop talking about the implementation
> (i.e. the value is used to index into used_atom[] to get to the
> original string) and instead start talking about what the value
> means to the callers (that are still internal to for-each-ref
> implementation), to make things better.
>
> Having said that, I am not sure if there is a sensible description
> for that field if you avoid exposing the implementation detail.
>
> You would probably want to start by asking what that value means.
> For (evantual) external callers, the number is what they get from
> parse_ref_filter_atom(); calling that function is the only way they
> can get an appropriate value to stuff in the field, and
> parse_opt_ref_sorting() is the most likely function external callers
> use to make that happen.
>
> "The number internally used to represent an attribute of a ref used
> when sorting the set of refs" would be one way to say what it is
> without exposing the implementation detail to the readers.
>
> But does that help anybody?  I doubt it.  It is mouthful for
> external users, and it is not concrete enough for implementors.
>
> So either
>
>  - treat ref-filter.h as information for API users, and not talk
>    about what it means at all, or
>
>  - treat ref-filter.h as information for both API users and API
>    implementors, and describe it as an index into used_atom[],
>    i.e. do not change anything.
>
> I'd say the latter is a more sensible way to go.  I think it is also
> OK to change this comment to "index into used_atom array (internal)"
> when ref-filter.h is created as an external API definition.

Like you said, the comment is still relevent to the code.
So I guess of the two options suggested by you the option of keeping the
comment and just adding "(internal)" while the code is moved to ref-filter.h
seems to be the best solution. This would eliminate the need for PATCH 03.

--
Regards,
Karthik
