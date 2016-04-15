From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 0/2] implement better chunk heuristics
Date: Fri, 15 Apr 2016 12:08:10 -0700
Message-ID: <CA+P7+xq7JqerLizg_5RLNGuWPaQL8QWUisjZm=ENcdaE7ZPMDg@mail.gmail.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
 <CAGZ79kbCHA3L6mUfYn6OfVXLDEyhv70PwxXo-YHP_QZXXAB8ig@mail.gmail.com> <CAGZ79kZs33sJj+DPSS4FPoJTLqbCLpvSe_h9UUQM-dBe=8ExKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 21:08:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar96Y-0007gd-U0
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbcDOTIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:08:31 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35331 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbcDOTIa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:08:30 -0400
Received: by mail-io0-f170.google.com with SMTP id g185so143922494ioa.2
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wyXNmzp4Fo64ybXy4GyOcL3dyFbGMoMM4tn3yE5zR5Q=;
        b=NNi4sJLbybDJD/Uvtrmu9RDFQHT2q0xlwwaOn+9m4w/dit7cSHE2VC/i4NH+yoXFow
         zEr9zGtfI4SmfJcDnao5VlMoYGIKqitPhvjjgaOnRIVMMyIOrLiccrwr6FnAcIvbdCUw
         AfCLRbq5RuuOD480XmEgCJ7L8lpcAbFQp++qnu8v71OYdb7HT2UNlhGceH61dLFkae2A
         4dQNKqIGMdywFowTZ3sDP68PXY++Kynzj8kVjcdQqrcoblyRWN1CdLZPmcr6j0GLRrpu
         d4U3vGtYNC+k7mt1LJUDVO2K4xw77qgknDJXKRd2EXVAg8aEJAGFesi91TLXqheGAg7T
         jKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wyXNmzp4Fo64ybXy4GyOcL3dyFbGMoMM4tn3yE5zR5Q=;
        b=VMaiWz4d9ywQuXIt8q3bVADLk+XOAiwt3iB7PlasZk340yoh1Poda++YdT38rvb7om
         Cp5U3gmPDnjtSqf5M/z1AnRaVxHAw18BxrBSgBQjqOvIIEejK1zRR/OrlssiYt/ZmVq6
         n6KPtDRK3hfE1byH2e+5faK5QMuaMB5qqGjYI/2oalPel123828oP6h8T2TwVUYABhrG
         3phGSY+Xz97kYzN6tXW44QpFGqkqmsznN3Ww/pF+lRvxB4uHVECX24dVi3V6SVcWiRmz
         gARO38Io/9EZ6ln59xuGm+VzEQCSg/DMvwF/CldD/wO4E7IPYRmCeSkg/MPxxLtYC1nR
         Ggmg==
X-Gm-Message-State: AOPr4FXTFylV3umMlg9oZWQWBflchfS3/dSqklSBFRXBTF7A2C6341fZsIyQTFKEnJG2R/jBsBzyB/tDxsivSg==
X-Received: by 10.107.166.195 with SMTP id p186mr24491112ioe.146.1460747309694;
 Fri, 15 Apr 2016 12:08:29 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 15 Apr 2016 12:08:10 -0700 (PDT)
In-Reply-To: <CAGZ79kZs33sJj+DPSS4FPoJTLqbCLpvSe_h9UUQM-dBe=8ExKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291635>

On Fri, Apr 15, 2016 at 10:10 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Apr 15, 2016 at 10:02 AM, Stefan Beller <sbeller@google.com> wrote:
>>> @@ -458,11 +458,11 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>>                          * the group.
>>>                          */
>>>                         while (ixs > 0 && xdl_hash_and_recmatch(recs, ixs - 1, ix - 1, flags)) {
>>> +                               emptylines += is_emptyline(recs[ix - 1]->ptr);
>>> +
>>>                                 rchg[--ixs] = 1;
>>>                                 rchg[--ix] = 0;
>>>
>>> -                               has_emptyline |=
>>> -                                       starts_with_emptyline(recs[ix]->ptr);
>>
>> How is this fixing the segfault bug?
>> From my understanding ix should have the same value here as ix-1 above.
>>
>>>                                 /*
>>>                                  * This change might have joined two change groups,
>>>                                  * so we try to take this scenario in account by moving
>>> @@ -492,9 +492,6 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>>                                 rchg[ixs++] = 0;
>>>                                 rchg[ix++] = 1;
>>>
>>> -                               has_emptyline |=
>>> -                                       starts_with_emptyline(recs[ix]->ptr);
>>> -
>>
>> Or would this fix the segfault bug?
>> I think we would need to have the check for empty lines
>> in both loops to be sure to cover the whole movable range.
>
> Actually we would only need to have the empty line count in the second loop as
> the first loop shifted it as much up(backwards) as possible, such that
> the hunk sits on one
> end of the movable range. The second loop would iterate over the whole
> range, so that
> would be the only place needed to count.

I agree that we can drop the first part and I am testing it now.

Thanks,
Jake
