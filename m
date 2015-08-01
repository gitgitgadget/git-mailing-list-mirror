From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 02/11] ref-filter: add 'colornext' atom
Date: Sat, 1 Aug 2015 18:36:08 +0530
Message-ID: <CAOLa=ZQbH274PnydmvDQv77QCOQEPfVKViKkh0iEOMcpQ-PcMQ@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-2-git-send-email-Karthik.188@gmail.com>
 <CAPig+cTb3U2AHjr4wmQGezqHOED3zyYHPG54BjdCZObt=7Mu3w@mail.gmail.com>
 <vpqtwsmd53f.fsf@anie.imag.fr> <CA+P7+xpYg4wsJW8JOGHMsDohCUvcD=X-34wcGGvEQM8mEK3dbg@mail.gmail.com>
 <xmqqsi857h8d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"christian.couder@gmail.com" <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 15:06:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLWUu-0005By-6S
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 15:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbbHANGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 09:06:39 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33195 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbbHANGi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 09:06:38 -0400
Received: by oig1 with SMTP id 1so17159936oig.0
        for <git@vger.kernel.org>; Sat, 01 Aug 2015 06:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=skoI1RCP219Fog+36hWHWLTuZRseaiOX9pVl8OkXgS8=;
        b=Dj/3TV3s8jQna8ziv8/1VMJZF81pJ1QocCR2SGeQSmW+KFY6n1chDNMXfxA0w4SD5J
         Y2rCGhFX6mt8W7u/CCK7kXczDa8ycLHtGyFWIB6gqR+DRbk6WLdM1f8CyzghwFAqjc1U
         Ic1aK3V9pCp4JQn9PAAdZG9u4D/fCTgMqzzer7pyj0sCJR4edDYjrQJHNd1wT27C8n3U
         jnH3SyJ4VvhG8iIviWdpbR/HXl+U4D1KwmPv9zbzMUHZKhylpf23KDCvxSyuCCD8rs2T
         rQilePt7FKDiXSeqQpo8k9zVHHI8nfRsccmPrBmmZTzyDnHwNBSl1+Tx9ihfAU6AhLBm
         Jang==
X-Received: by 10.202.73.83 with SMTP id w80mr8047533oia.102.1438434397857;
 Sat, 01 Aug 2015 06:06:37 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sat, 1 Aug 2015 06:06:08 -0700 (PDT)
In-Reply-To: <xmqqsi857h8d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275119>

On Thu, Jul 30, 2015 at 9:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> On Wed, Jul 29, 2015 at 2:30 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>
>>>> Also, please explain here and in the commit message why this highly
>>>> specialized colorizer ('colornext'), is needed even though a more
>>>> general purpose one ('color') is already available.
>>>
>>> It is needed in the current form to allow
>>> %(colornext:blue)%(ifexists:[%s]) to color only the replacement of %s
>>> and not the [].
>>>
>>> But I now think that this would be more elegantly solved by Junio's
>>> %(if) %(endif) idea:
>>>
>>>   %(if:atom) [ %(color:blue)%(atom)%(color:reset) ] %(endif)
>>>
>>> (I added spaces for clarity)
>>
>> I agree, this style seems a lot more elegant and expressive while much
>> easier to understand. Same for doing this to the alignment atoms and
>> such as it solves the same problem(s) there.
>
> Do you mean something like these?
>
>     %(align:left,20) branch %(refname:short) %(end)
>     %(align:middle,20) branch %(refname:short) %(end)
>     %(align:right,20) branch %(refname:short) %(end)
>
> to replace and enhance %(padright:20)?
>
>> I can't speak to how easy it is to implement tho.
>
> Perhaps it would go like this:
>
>  * Instead of always emitting to the standard output, emit() and
>    print_value() will gain an option to append into a strbuf that is
>    passed as argument.  Alternatively, appending to strbuf could be
>    made the only output channel for them; show_ref_array_item() can
>    prepare an empty strbuf, call them repeatedly to fill it, and
>    then print the resulting strbuf itself.
>
>  * Things like %(if) and %(align) would do the following:
>
>    (1) Push the currently active strbuf it got from the calling
>        show_ref_array_item() to the formatting state;
>
>    (2) Create a new strbuf and arrange so that further output would
>        be diverted to this new one; and
>
>    (3) Push the fact that the diverted output will be processed by
>        them (i.e. %(if), %(align), etc.) when the diversion finishes
>        to the formatting state.
>
>  * When %(end) is seen, the currently active strbuf (i.e. the new
>    one created in (2) above for diversion) holds the output made
>    since the previously seen %(if), %(align), etc.  The formatting
>    state knows what processing needs to be performed on that from
>    (3) above.
>
>    - Pop the strbuf where the output of the entire %(if)...%(end)
>      construct needs to go from the formatting state;
>
>    - Have the processing popped from (3) above, e.g. %(if:atom) or
>      %(align:left,20), do whatever they need to do on the diverted
>      output, and emit their result.
>
> Both %(if) and the hypotherical %(align) can use this same
> "diversion" mechanism.  And the above would properly nest,
> e.g.
>
>     %(align:middle,40)%(if:taggerdate)tag %(end)%(refname:short)%(end)
>

This actually looks neat and good, I'll try implementing this :)

-- 
Regards,
Karthik Nayak
