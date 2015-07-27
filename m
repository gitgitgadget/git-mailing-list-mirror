From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 02/11] ref-filter: make `color` use `ref_formatting_state`
Date: Mon, 27 Jul 2015 21:32:21 +0530
Message-ID: <CAOLa=ZS2xEegWfoObXub8KMrvjw_7K-Wd9x8E7kKAZtdt8M+=Q@mail.gmail.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
 <1437982035-6658-1-git-send-email-Karthik.188@gmail.com> <1437982035-6658-2-git-send-email-Karthik.188@gmail.com>
 <vpqa8uhaht3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 27 18:02:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJkrh-0000w0-5z
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 18:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbbG0QCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 12:02:52 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33044 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbbG0QCv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 12:02:51 -0400
Received: by obdeg2 with SMTP id eg2so62994026obd.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 09:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eOUQRg6ucD9GaFpy3GaVdGiNCoc2nV7ufRu1F1mCNXA=;
        b=sGl1MbxE0ZNaHU7OPpVAWFWHtpO8oe97er0VtHeUlLXRBZckixj9pnZfE6lO+vWtIj
         T39i+2v1kt4X/hX408dbIRoOVPU6YBvZanefRpjFAR921xhD2WVvi4CWutcbGeGf7Oqs
         mPVA61emmTKsjsdJAzZ/pSHnNFEDVYjoFhM1CjSofR/yXLSX7/7wwte/vYldlgt7JhUA
         WxetKZUvxtf8wagdZggRL+7HFS5e+xeO66RuW9EaXmhapy+Kl7RcsMlVQMp3UcanzHgs
         8JSy8F3L6uJb/9H7yuUCoPl1X75gplJDEqqEDeCcPAvV/CMRhUwLFIEh0gUEo4OjXoOt
         i12Q==
X-Received: by 10.60.62.105 with SMTP id x9mr28281087oer.1.1438012970866; Mon,
 27 Jul 2015 09:02:50 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 27 Jul 2015 09:02:21 -0700 (PDT)
In-Reply-To: <vpqa8uhaht3.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274688>

On Mon, Jul 27, 2015 at 6:17 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Make the `color` atom a pseudo atom and ensure that it uses
>> `ref_formatting_state`.
>
> Actually, I think this is an incorrect change.
>
> Previously, %(color:...) was taking effect immediately, and after this
> patch, it takes effect starting from the next atom.
>
> Try this:
>
> git for-each-ref --format '%(color:red)red %(color:reset)normal'
>
> Before your patch, I get 'red' as red, and 'normal' as normal. After
> your patch, I get no color at all, since %(color:...) just stores
> information that is never used because I have no real atom.
>
>> --- a/ref-filter.h
>> +++ b/ref-filter.h
>> @@ -19,11 +19,13 @@
>>  struct atom_value {
>>       const char *s;
>>       unsigned long ul; /* used for sorting when not FIELD_STR */
>> -     unsigned int pseudo_atom : 1; /*  atoms which aren't placeholders for ref attributes */
>> +     unsigned int pseudo_atom : 1, /*  atoms which aren't placeholders for ref attributes */
>> +             color : 1;
>>  };
>
> As a consequence of the remark above, I think the name and comment of
> the field are misleading. There are 3 kinds of atoms:
>
> * Placeholders for ref attributes
>
> * Atoms that take action immediately, but that are not ref attributes
>   like %(color)
>
> * Atoms that only act as modifiers for the next atom. Perhaps they could
>   be called "prefix atoms" or "modifier atoms".
>

Thats right, Junio and I missed out the second part and overlapped it
over with the
third part. Thanks for seeing it through.

-- 
Regards,
Karthik Nayak
