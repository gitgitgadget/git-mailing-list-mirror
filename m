From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/9] ref-filter: implement %(if), %(then), and %(else) atoms
Date: Sun, 4 Oct 2015 19:29:23 +0530
Message-ID: <CAOLa=ZRXvz+sAtMOmreri7QUCfwrusDQKNme4ke_8uaTkAoqiQ@mail.gmail.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
 <1443807546-5985-2-git-send-email-Karthik.188@gmail.com> <vpq8u7kb89o.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 04 16:00:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zijq6-0000Um-KK
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 16:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbbJDN7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 09:59:54 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33554 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbbJDN7x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 09:59:53 -0400
Received: by vkgd64 with SMTP id d64so83315347vkg.0
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Zts4ofOfGFyTIa2NMOrawK6fn3rHMUfww2K1ImfqraQ=;
        b=VG3edfaV3LeDs/tL4R1T+aq9Qh2oQxTnAuwg3+2wgOEy8gYVozgLPdoSCMmvAESsVX
         uajNP5cEf3wKM4wE5FyxaS3pB0Vz6z3slkZXQ8Ty0ntEULh6fDQyJIinNfrtfN+2bv4d
         fInOHnIqzqmNr1p0RW2LKWFLM1K04WQ0aEXnHDj9BeRQczrl/e9TWyHkAkJRHfgfsSIQ
         u2m/N2aXcHhjsGJeoS9vp+o8KvSS2nFCVrfqDoEhLlwI/YXjPY67JgGfkW+LVJ4+/Fef
         uLNGn5DsN2HTflCrPB/JyiabNFfhOOotlZ8lqifaXhPG47DpIHCOAh8bh/ERcEjzUyfH
         gllQ==
X-Received: by 10.31.50.214 with SMTP id y205mr16405003vky.77.1443967192466;
 Sun, 04 Oct 2015 06:59:52 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Sun, 4 Oct 2015 06:59:23 -0700 (PDT)
In-Reply-To: <vpq8u7kb89o.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278999>

On Sat, Oct 3, 2015 at 3:09 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Implement %(if), %(then) and %(else) atoms. Used as
>> %(if)..%(then)..%(end) or %(if)..%(then)..%(else)..%(end).
>
> I prefer ... to .., which often means "interval" as in HEAD^^..HEAD.
>

Seems good, will change.

>> If there is an atom with value or string literal after the %(if)
>
> I find this explanation hard to read, and ambiguous: what does "atom
> with value" mean?
>
>> then everything after the %(then) is printed, else if the %(else) atom
>> is used, then everything after %(else) is printed. If the string
>> contains only whitespaces, then it is not considered.
>
> "the string" is ambiguous again. I guess it's "what's between %(if) and
> %(then)", but it could be clearer. And it's not clear what "not
> considered" means.
>
> My take on it:
>
> Implement %(if), %(then) and %(else) atoms. Used as
> %(if)...%(then)...%(end) or %(if)...%(then)...%(else)...%(end). If the
> format string between %(if) and %(then) expands to an empty string, or
> to only whitespaces, then the string following %(then) is printed.
> Otherwise, the string following %(else), if any, is printed.
>

This (the one you sent again after Junio's suggestion, looks better),
I'll use this thanks.

>> +When a scripting language specific quoting is in effect,
>
> This may not be immediately clear to the reader. I'd add explicitly:
>
> When a scripting language specific quoting is in effect (i.e. one of
> `--shell`, `--perl`, `--python`, `--tcl` is used), ...
>

Makes sense.

>>  EXAMPLES
>>  --------
>
> This is just the context of the patch, but I read it as a hint that we
> could add some examples with complex --format usage to illustrate the
> theory above.
>

I was thinking about adding :

An example to show the usage of %(if)...%(then)...%(else)...%(end).
This prefixes the current branch with a star.

------------
#!/bin/sh

git for-each-ref --format="%(if)%(HEAD)%(then)* %(else)
%(end)%(refname:short)" refs/heads/
------------


An example to show the usage of %(if)...%(then)...%(end).
This adds a red color to authorname, if present

------------
#!/bin/sh

git for-each-ref
--format="%(refname)%(if)%(authorname)%(then)%(color:red)%(end)
%(authorname)"
------------

>> +     if (if_then_else->condition_satisfied && if_then_else->else_atom) {
> // cs && else
>> +             strbuf_reset(&cur->output);
>> +             pop_stack_element(&cur);
>> +     } else if (if_then_else->else_atom) {
> // !cs && else
>> +             strbuf_swap(&cur->output, &prev->output);
>> +             strbuf_reset(&cur->output);
>> +             pop_stack_element(&cur);
>> +     } else if (!if_then_else->condition_satisfied)
> // !cs && !else
>> +             strbuf_reset(&cur->output);
>
> This if/else if/else if looks hard to read to me. I had to add the
> comments above as a note to myself to get the actual full condition for
> 3 branches.
>
> The reasoning would be clearer to me as:
>
> if (if_then_else->else_atom) {
>         /*
>          * There is an %(else) atom: we need to drop one state from the
>          * stack, either the %(else) branch if the condition is satisfied, or
>          * the %(then) branch if it isn't.
>          */
>         if (if_then_else->condition_satisfied) {
>                 strbuf_reset(&cur->output);
>                 pop_stack_element(&cur);
>         } else {
>                 strbuf_swap(&cur->output, &prev->output);
>                 strbuf_reset(&cur->output);
>                 pop_stack_element(&cur);
>         }
> } else if (if_then_else->condition_satisfied)
>         /*
>          * No %(else) atom: just drop the %(then) branch if the
>          * condition is not satisfied.
>          */
>         strbuf_reset(&cur->output);
>

This looks neater thanks.

>> +static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
>> +{
>> +     struct ref_formatting_stack *new;
>> +     struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
>> +
>> +     if_then_else->if_atom = 1;
>
> Do you ever use this "if_atom"? It doesn't seem so in the current patch,
> and it seems like a tautology to me: if you have a struct if_then_else,
> then you have seen the %(if).
>

Yea I'll remove that.

>> +static int is_empty(const char * s){
>
> char * s -> char *s
>

will do.

>> +static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
>> +{
>> +     struct ref_formatting_stack *cur = state->stack;
>> +     struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
>> +
>> +     if (!if_then_else)
>> +             die(_("format: %%(then) atom used without an %%(if) atom"));
>
> You've just casted at_end_data to if_then_else. if_then_else being not
> NULL does not mean that it is properly typed. It can be the at_end_data
> of another opening atom. What happens if you use
> %(align)foo%(then)bar%(end)?
>

Nice catch, didn't see that possibility.

> One way to be safer would be to check that cur->at_end does point to
> if_then_else_handler. Or add information to struct ref_formatting_stack
> (a Boolean is_if_then_else or an enum).
>

Checking cur->at_end with if_then_else_handler seems good to me.

> Also, you need to check that if_then_else->then_atom is not 1.
>

Ah! multiple usage of the same atom.

>> +static void else_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
>> +{
>> +     struct ref_formatting_stack *prev = state->stack;
>> +     struct if_then_else *if_then_else = (struct if_then_else *)state->stack->at_end_data;
>> +
>> +     if (!if_then_else)
>> +             die(_("format: %%(else) atom used without an %%(if) atom"));
>
> Same as above, I guess (not tested) %(align)...%(else) is accepted.
>

Will change.

>> +     if (!if_then_else->then_atom)
>> +             die(_("format: %%(else) atom used without a %%(then) atom"));
>> +     if_then_else->else_atom = 1;
>> +     push_stack_element(&state->stack);
>
> So, while parsing the %(else)...%(end), the stack contains both the
> %(then)...%(else) part, and the %(else)...%(end).
>
> I'm wondering if we can simplify this. We already know if the condition
> is satisfied, and if it's not, we can just drop the %(then) part right
> now, and write to the top of the stack normally (the %(end) atom will
> only have to pop the string normally). But if the condition is not
> satisfied, we need to preserve the %(then) part and need to do something
> about the %(else).
>

I wanted to do something like this the problem is append_atom() and
append_literal()
would need to be informed about which part to ignore, and this moves
the code's logic
from the current handlers to append_atom() and append_literal(). Which I didn't
think was a nice way of doing this.

>> -     current->at_end(current);
>> +     current->at_end(&state->stack);
>> +
>> +     /*  Stack may have been popped, hence reset the current pointer */
>
> I'd say explicitly "... may have been popped within at_end, hence ..."
>

Will do.

-- 
Regards,
Karthik Nayak
