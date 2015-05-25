From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/2] for-each-ref: re-structure code for moving to
 'ref-filter'
Date: Mon, 25 May 2015 23:29:29 +0530
Message-ID: <55636301.7060803@gmail.com>
References: <556317F8.2070609@gmail.com> <1432557943-25337-1-git-send-email-karthik.188@gmail.com> <xmqqegm4bmtg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	matthieu.moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 19:59:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ywwf5-0001UG-DQ
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 19:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbbEYR7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 13:59:35 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34251 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbbEYR7e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 13:59:34 -0400
Received: by pdbki1 with SMTP id ki1so31839205pdb.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4ybpclQL01H5EhSQwxurMsbvHH/M9SjRsE/fe9admDs=;
        b=GMbZjY2ec+dDHsogUQYAmxpkCKrSRtcIWyduPiZ2QW4MVK2s2QPtu37IiW4oizvSSR
         dOPVNXrvEbFEZKdMYiXh2Z/PzN12doHlxY2vSpXA2MVnupPBMzaTs18z6KRyc93sadMx
         wtaVa0byRdoc/iVc53j4RT5554NGA6zbwfCU/n+FbWaEFq1rrQxbs/maOMwFjL0Bye/V
         uJVfDLADjGxJI0TcOmc9F3YMefcFDAGDpd6vdpfxqy+SBW26dHZdESA4uMa12bbQFRDp
         LOgzWLdVgkbn2z4ytROqCxsSjCT9JL0eUdT6D1RF08wkE4wTEMn+3m2obdstnr+XLy+F
         9mig==
X-Received: by 10.66.66.65 with SMTP id d1mr41647426pat.22.1432576773772;
        Mon, 25 May 2015 10:59:33 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id ud3sm10656850pbc.10.2015.05.25.10.59.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2015 10:59:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqegm4bmtg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269849>

 >
> I do not see much point in renaming between these two.  The latter
> makes it sound as if this is only for "filtering" and from that
> angle of view is probably a worse name.  If you do not think of a
> better one, and if you are going to name the array that contains
> this thing "ref_list", calling "ref_list_item" would be following
> suit to what string-list did.
 >

Well I just wanted to keep it related to 'ref-filter', I think
'ref_list_item'
sounds better after seeing your point of view.

>
> I somehow had an impression that we are trying to move away from
> calling the name of objects as "sha1[]" as a longer term goal?  I do
> not think it is particularly a good idea to start using "struct
> object_id" in this series (it can be done after everything is done
> and you still have time left in GSoC), but I do not see how much
> value this interim renaming (because eventually we would change not
> just name but type, and the final name will _not_ be sha1[] but more
> closer to "object name") adds value.
 >

I did that to resemble whats usually being used in similar structures,
a simple grep of "sha1[20];" resulted in 344 uses.
I didn't know about the "we are trying to move away from calling the 
name of objects as "sha1[]"". Will leave it as objectname then.

>
> You didn't explain why you reordered the fields, either.  Were you
> planning to make the name[] field to flex-array to reduce need for
> one level of redirection or something?
>

Yes! exactly why the re-order, was going to rebase it and squash it in, 
if the code seemed to be up and running.


>
> I agree that "grab" part of "grab_ref_cbdata" sounds unprofessional,
> and using "ref_filter_" to signal that this callback data is about
> ref-filter API might be a good idea (I do not think the original is
> too bad, either, though).  I do not think you would use this struct
> anywhere other than as the callback data; you would want to end its
> name with "_cbdata", not just "_data", to make it clear why these
> two unrelated things are in a single struct (the only time these two
> concepts, operation and operatee, meet is when they need to be
> passed to an "apply operation to operatee" function; there is no
> such "this set of operatee always are for this operation"
> association between them---which is what I mean by 'two unrelated
> things').
>

sure, will do :) thanks for putting that out.

>
> It was perfectly good name as a file-scope static; within the
> context of 'for-each-ref' implementation, when every somebody says
> "atom", you would know it is those %(atomic-data-item) things, and
> parse_atom() would be a helper function to do so.
>
> But it is *WAY* too generic a name to make public, where you are
> naming things in the whole context of Git implementation.  If you
> used the word "atom" while discussing formatting done with "git
> for-each-ref" with somebody else, it would be unambiguously clear
> what you mean; you wouldn't say "I am writing a function to parse
> 'atoms' in Git"---that's too broad and you will get "'atom', in what
> sense?" in response.
>

>
> Ditto.
>

Yes, that does seem to be too vague for a public function name, will 
amend it.

>
> As long as this will stay private within the new ref-filter.c after
> the move, this name is OK.
>

That'll mostly stay private, if required will change the name along.

>
> I see fallouts from the two renamed fields in the above hunks.  Was
> the rename necessary?
>
> refinfo keeps two names (ref and object) and calling one "refname"
> made perfect sense (and calling other "objectname" did, too).  Has
> anything around its use changed to invalidate that rationale after
> the structure was renamed?
>

I guess it was unnecessary, my bad.

 >
> When we say 'flag', it is obvious that it is a "flag word", i.e. a
> word that holds collection of flags.  Otherwise, we would have named
> each "unsigned foo_flag : 1" with meaningful names.  Was it
> necessary to make the field name longer?
>

Just felt flags to be more descriptive, well "Otherwise, we would have 
named each "unsigned foo_flag : 1" with meaningful names. " makes sense.

> > @@ -688,7 +702,7 @@ static void populate_value(struct refinfo *ref)
> >                   v->s = xstrdup(buf + 1);
> >               }
> >               continue;
> > -        } else if (!deref && grab_objectname(name, ref->objectname,
> v)) {
> > +        } else if (!deref && grab_objectname(name, ref->sha1, v)) {
> >               continue;
>
> Mental note: grab_objectname() still remains, so I'd guess that it
> will not be moved from this file or it will stay private after it is
> moved.
>

It will be private.

 >
> Another mental note: it was a consistent naming for the function to
> grab objectname to store the result into objectname[] field.  Now it
> stores into sha1[] field.
>

yes, seems a bit off.

>
> Yuck; I can see what you are doing but can you imitate what the more
> experienced people (e.g. peff, mhagger) do when restructuring
> existing code and do things in smaller increments?  For example, I
> think it should be a separate preparatory patch, even before these
> renames of structures, fields and functions, to extract this helper
> function out of grab_single_ref() function.
>

Shall do so.

>
> And extracting this could be another separate preparatory step
> before renames (but I didn't look too closely).
>

Sure.

 >
> I won't be commenting on the remainder of the patch in this message,
> as I need to step out.  I see quite a many instances of the same
> "overly generic public names" in your "s/static //".
>

Will work on it, thanks for the suggestions.

-- 
Regards,
Karthik
