From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/5] pathspec: record labels
Date: Mon, 16 May 2016 10:16:55 -0700
Message-ID: <CAGZ79kZsVH3mE0zXu9wSWgit3QZ_CiKZqg-TQdyWnZw6D9=Cgw@mail.gmail.com>
References: <20160513231326.8994-1-sbeller@google.com>
	<20160513231326.8994-6-sbeller@google.com>
	<xmqqk2iw78aq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 19:17:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2M8b-0002xS-CD
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 19:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbcEPRQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 13:16:57 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34437 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbcEPRQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 13:16:56 -0400
Received: by mail-io0-f180.google.com with SMTP id 190so218106597iow.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=tBCpYT6z3IQ+AySdh620mbVL6C5y6+U6TDmwe6ayb2M=;
        b=KzRv+mKvj1gZ1ukeXVGWEf0cR1VRdS3Lfg8JJTlY0p2zbNRS7ck0+j3NUCMKet7gNF
         1zbugkkV7yGTNkaELuSnphFXFjSoM6RVF8W+U0GyV06oxit8C5Al0Wj+g+pbTI6+2gR6
         y7kpvXs9iiOriSezDXnAXFcUlr/TWMwQxelRGLdYI7kn4gZywYdHSMZNvHXXMpIrLoZH
         soxtSuVkhBX6kPhtcNPDjHt+o1ufQguXAxMzqMvIZuXY37UFB1GXP7cE8T/TXzJiGH8f
         NLkLUT5+J4EefGiHqa34s1v3+KNZ7Md+qHJuU8xOgjIV7O+CWn3dgM6PlfXZrpr9pUCv
         Z5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=tBCpYT6z3IQ+AySdh620mbVL6C5y6+U6TDmwe6ayb2M=;
        b=e+G0TdNrLEUWaDblvY17GaBKSyC5fCVXhtV8f6m7On1YTeinBBgbWqEmQ9kdycRY86
         7A8jPCAePGJMgaIEYh+IkDeg2uMpnsjT/hPsLEXXJA65my69IzrG3l1PtFnrVKbA04bX
         Ipq/kl68PoqF71NNHbG2h15+fcWtrMtPT8w0UKJ1c8qPEuTRvCuGBKzl0Gm3Ii9RnK36
         +C2ZXsT3kuD5juUrLQblbA0BTMbwMOWddMIHvGK8O1JyYZacKBYX1Vvzv0u1YC31kPP+
         4FWQh4Wf033AhyzFstZpZUP3tTDhWHomdNSs5NmVyZASwjQX17ZeSz8iIVNucLX90oEL
         FqBw==
X-Gm-Message-State: AOPr4FWZrobkhtzAuO5C61b/y+MDXLgGaw4K+WWg9WgV2xHP99e7PmBzs8Uou8S9vR+m6MkL6/3gk8ky6Ozrpr4w
X-Received: by 10.36.107.129 with SMTP id v123mr9659139itc.52.1463419015263;
 Mon, 16 May 2016 10:16:55 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 10:16:55 -0700 (PDT)
In-Reply-To: <xmqqk2iw78aq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294756>

On Sat, May 14, 2016 at 12:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Labels were originally designed to manage large amount of
>> submodules, the discussion steered this in a more general
>> direction, such that other files can be labeled as well.
>
> s/other files/any path/.
>
>> Labels are meant to describe arbitrary set of files, which
>> is not described via the tree layout.
>
> Let's avoid "are meant to", which is merely to give you an excuse to
> say "it was meant to ... but the implementation did not quite achieve
> that goal".
>
>     The "label" attribute can be attached to paths, and the pathspec
>     mechanism is extended via the new ":(label=X)pattern/to/match"

I wasn't sure about whether we want to have '=' or ':' as the separator
of "label" and its values. The prefix which is passed around uses
a colon instead of equal sign, so I thought consistency would be neat
there. But as that is only internal, we can be inconsistent to a new
public feature, so '=' seems better for the labeling system.

>     syntax to filter paths so that it requires paths to not just
>     match the given pattern but also have the specified labels
>     attached for them to be chosen.
>
> or something?
>
>> +Attaching labels to path
>> +~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +`label`
>> +^^^^^^^^^^
>> +By the value of this attribute you can specify a list of arbitrary strings
>> +to be attached to a path as labels. These labels can be used for
>> +easier paths matching using pathspecs (linkgit:gitglossary[1]).
>> +It is recommended to use only alphanumeric characters, dashes and
>> +underscores for the labels.
>
> Make this recomendation stronger to requirement.  It is always
> possible to loosen it later, but once we allow random things even
> with a warning, it gets impossible to take them back. Users will say
> "Even though we got a warning, it used to correctly filter; now Git
> is broken and my setup does not work."

I'll change the text here with s/recommended/required/ and error out
for that.

But still we do not enforce it early enough. Some crazy upstream may
add some labels which do not follow the requirements and then
tell downstream to run a command like `git foo "(label=!@#$)".
and then downstream curses at upstream as well as Git.

>
> s/habe/have/

done

>
>> +     if (ATTR_TRUE(check.value))
>> +             ret = 1; /* has all the labels */
>
> So this is "pretend that I have all the labels under the sun".
>
>> +     else if (ATTR_FALSE(check.value))
>> +             ret = 0; /* has no labels */
>
> I do not see a value in this.  What difference does it have compared
> to having a "label=" that explicitly says "I do not have one"?  What
> is your answer to an end-user question "When should I say 'label='
> and when should I say '!label'?"
>
> Just forbid it for now; we may find a better use for it later.

I don't think we want to die in that code as it is in the data already.
If we were to die in that case, you cannot query any path with
labels any more if asking for any kind of label.

>
>> +     else if (ATTR_UNSET(check.value))
>> +             /*
>> +              * If no label was specified this matches, otherwise
>> +              * there is a missing label.
>> +              */
>> +             ret = (required_labels->nr > 0) ? 0 : 1;
>
> Hmm, I can see that this is making things more complicated to
> explain and understand, but I cannot see what the expected use case
> is.
>
> Unless there is any compelling use case, I'd say we should forbid it
> for now.

We need to allow the UNSET case, as otherwise you'd need to label
any path if using labels? In the next iteration I'll go with

        if (ATTR_TRUE(check.value))
                ret = 1; /* has all the labels */
        else if (ATTR_FALSE(check.value))
                die(_("Label attributes must not be unset"));
        else if (ATTR_UNSET(check.value))
                ret = 0; /* has no labels */
        else {
                ...
>
>> +     else {
>> +             struct string_list_item *si;
>> +             struct string_list attr_labels = STRING_LIST_INIT_DUP;
>> +             string_list_split(&attr_labels, check.value, ',', -1);
>> +             string_list_sort(&attr_labels);
>
> Filter out a non-compliant label values here, so that they are
> ignored from day one.  That way you would not have to deal with "I
> know I got the warning, but it used to work and you broke it" later.

So you're saying we should not die(...) but just ignore those labels?

>
>> +             ret = 1;
>> +             for_each_string_list_item(si, required_labels) {
>> +                     if (!string_list_has_string(&attr_labels, si->string)) {
>> +                             ret = 0;
>> +                             break;
>> +                     }
>> +             }
>> +             string_list_clear(&attr_labels, 0);
>> +     }
>> +
>> +     return ret;
>> +}
>
>> +static void validate_label_name(const char *label)
>> +{
>> +     if (check_valid_label_name(label))
>> +             warning(_("Label '%s' discouraged. Recommended label names start "
>> +                     "with an alphabetic character and use only alphanumeric "
>> +                     "characters, dashes and underscores."), label);
>> +}
>
> Instead of returning void, parrot the return value from
> check_valid_label_name().
>
>> +             /* The label token may have no argument, so no trailing ':' */
>
> Why close the door for future pathspec magic "labelfoo" by being
> unnecessarily[*1*] lenient?
>
>     [*1*] Does ":(label)" mean anything useful, and is there a good
>           reason why it should behave differently from ":(label:)"?

ok fixed.

>
> Unless there is a good reason why users would want ":(label)", I'd
> say we should make it a syntax error.
>
>> +             if (skip_prefix(copyfrom, "label", &body)) {
>> +                     struct strbuf sb = STRBUF_INIT;
>> +                     skip_prefix(body, ":", &body);
>> +                     strbuf_add(&sb, body, nextat - body);
>> +                     if (!item->labels) {
>> +                             item->labels = xmalloc(sizeof(*item->labels));
>> +                             string_list_init(item->labels, 1);
>> +                     } else
>> +                             die(_("multiple labels not supported in pathspec magic"));
>
> I am NOT suggesting to make this enhancement in the prototype to
> allow us experiment with submodule selection use case, but this is
> an obvious place to allow
>
>         :(label=A B):(label=C D)
>
> to mean ((A & B) | (C & D)) by making item->labels an array of set
> of labels.
>
> And no, I do not think arbitrary boolean expression is too complex
> to understand to the end-users, especially if we have to stay within
> the pathspec magic syntax.  And my gut feeling is that it is not
> worth it to support anything more complex than "OR of these ANDed
> ones".

That makes sense.

>
>> +                     string_list_split(item->labels, sb.buf, ' ', -1);
>> +                     string_list_remove_empty_items(item->labels, 0);
>> +                     strbuf_release(&sb);
>> +                     continue;
>
> The data structure to record the "required labels" is shared
> knowledge between this function and the has_all_labels() and nobody
> else knows it is done with string_list, so I think this is a good
> balance between expediency and future optimization possibilities (I
> am anticipating that linear search of string list would be found as
> performance bottleneck).
>
>> @@ -447,6 +490,12 @@ void parse_pathspec(struct pathspec *pathspec,
>>               if (item[i].nowildcard_len < item[i].len)
>>                       pathspec->has_wildcard = 1;
>>               pathspec->magic |= item[i].magic;
>> +
>> +             if (item[i].labels) {
>> +                     struct string_list_item *si;
>> +                     for_each_string_list_item(si, item[i].labels)
>> +                             validate_label_name(si->string);
>
> Reject a request to use a label that does not validate here.

done.
