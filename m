From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 02/11] ref-filter: add 'colornext' atom
Date: Thu, 30 Jul 2015 09:17:06 -0700
Message-ID: <xmqqsi857h8d.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-2-git-send-email-Karthik.188@gmail.com>
	<CAPig+cTb3U2AHjr4wmQGezqHOED3zyYHPG54BjdCZObt=7Mu3w@mail.gmail.com>
	<vpqtwsmd53f.fsf@anie.imag.fr>
	<CA+P7+xpYg4wsJW8JOGHMsDohCUvcD=X-34wcGGvEQM8mEK3dbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"christian.couder\@gmail.com" <christian.couder@gmail.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 18:17:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKqWD-0000cs-2R
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 18:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbbG3QRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 12:17:11 -0400
Received: from mail-pd0-f195.google.com ([209.85.192.195]:33355 "EHLO
	mail-pd0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbbG3QRI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 12:17:08 -0400
Received: by pdbmj9 with SMTP id mj9so2334595pdb.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 09:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=hpIjSugV/XXGaRq48GAYJL4k3tTezWPKzo6/AlZSArQ=;
        b=02DqHDRWSI2rB2W6VmMfe01ldD6csSUGdN5Sd0zs+yC10k20wOC9ObcX5KioC+dyv1
         cEuCC6a7SwAffhZZUcy1FUcCMquYtvO1KEg6IeWs4iJwsgdFKdw4F5U+UpAMZ51J43G4
         rEhkK5YmIhQ6BdIyoWt++40ELg0+cSgp8Abxall1AGd4FN+nw1SGdvQFZxMcXfpgw7Ch
         aA2vKDOElphEJ+R6CdFHjyssm5xXL6Z9xS2vrJLLhRtg8L81z8VL4rcrM6fZ2zpbs8dV
         8QwGrXJAMCISbbzE815vYvCniRsmzQxufY3TTYxx3yfMY0HT6qdQfuFBDotxTJ4rr3D2
         bxbg==
X-Received: by 10.70.132.135 with SMTP id ou7mr108121755pdb.112.1438273028516;
        Thu, 30 Jul 2015 09:17:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:106d:d8d6:d21e:17fe])
        by smtp.gmail.com with ESMTPSA id xs13sm3032668pac.3.2015.07.30.09.17.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 Jul 2015 09:17:07 -0700 (PDT)
In-Reply-To: <CA+P7+xpYg4wsJW8JOGHMsDohCUvcD=X-34wcGGvEQM8mEK3dbg@mail.gmail.com>
	(Jacob Keller's message of "Wed, 29 Jul 2015 21:27:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275017>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Jul 29, 2015 at 2:30 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> Also, please explain here and in the commit message why this highly
>>> specialized colorizer ('colornext'), is needed even though a more
>>> general purpose one ('color') is already available.
>>
>> It is needed in the current form to allow
>> %(colornext:blue)%(ifexists:[%s]) to color only the replacement of %s
>> and not the [].
>>
>> But I now think that this would be more elegantly solved by Junio's
>> %(if) %(endif) idea:
>>
>>   %(if:atom) [ %(color:blue)%(atom)%(color:reset) ] %(endif)
>>
>> (I added spaces for clarity)
>
> I agree, this style seems a lot more elegant and expressive while much
> easier to understand. Same for doing this to the alignment atoms and
> such as it solves the same problem(s) there.

Do you mean something like these?

    %(align:left,20) branch %(refname:short) %(end)
    %(align:middle,20) branch %(refname:short) %(end)
    %(align:right,20) branch %(refname:short) %(end)

to replace and enhance %(padright:20)?

> I can't speak to how easy it is to implement tho.

Perhaps it would go like this:

 * Instead of always emitting to the standard output, emit() and
   print_value() will gain an option to append into a strbuf that is
   passed as argument.  Alternatively, appending to strbuf could be
   made the only output channel for them; show_ref_array_item() can
   prepare an empty strbuf, call them repeatedly to fill it, and
   then print the resulting strbuf itself.

 * Things like %(if) and %(align) would do the following:

   (1) Push the currently active strbuf it got from the calling
       show_ref_array_item() to the formatting state;

   (2) Create a new strbuf and arrange so that further output would
       be diverted to this new one; and

   (3) Push the fact that the diverted output will be processed by
       them (i.e. %(if), %(align), etc.) when the diversion finishes
       to the formatting state.

 * When %(end) is seen, the currently active strbuf (i.e. the new
   one created in (2) above for diversion) holds the output made
   since the previously seen %(if), %(align), etc.  The formatting
   state knows what processing needs to be performed on that from
   (3) above.

   - Pop the strbuf where the output of the entire %(if)...%(end)
     construct needs to go from the formatting state;

   - Have the processing popped from (3) above, e.g. %(if:atom) or
     %(align:left,20), do whatever they need to do on the diverted
     output, and emit their result.

Both %(if) and the hypotherical %(align) can use this same
"diversion" mechanism.  And the above would properly nest,
e.g.

    %(align:middle,40)%(if:taggerdate)tag %(end)%(refname:short)%(end)
