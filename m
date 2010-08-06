From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [RFC] struct *_struct
Date: Thu, 05 Aug 2010 20:57:13 -0700 (PDT)
Message-ID: <4c5b8819.4f3fdc0a.14ad.22b1@mx.google.com>
References: <20100804150843.GA2762@localhost.localdomain>
	<7vaap2fafm.fsf@alter.siamese.dyndns.org>
	<AANLkTin_6gaYF++N2GBgDsedfo7mY7yG5H99=-DxCa5E@mail.gmail.com>
	<20100805224321.GA22430@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 05:57:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhE3g-0000bA-G6
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 05:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933721Ab0HFD5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 23:57:17 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59125 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933532Ab0HFD5P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 23:57:15 -0400
Received: by vws3 with SMTP id 3so5764727vws.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 20:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:subject:from
         :to:cc:in-reply-to:references:mime-version:content-type;
        bh=Ycp4b4Csfmc/bdIkupTQWMgzxLsJQqrH0BQdUzcBTtk=;
        b=eMp5C7LoglQO76vkGgfE420AjHRjAoJW0qkFPa7HgZ/FPJBHjdHxi3wCDjEHFgljyd
         JsrppLZVotvVfbxGVeaIFYP/Pgb3Jbd+jnqMlZRQkkz/Q8cO1NdMNb33W2SEbErD2419
         uOZALG13Q5ETyLIh6LYu+ELe7OuqpIvvmItqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:subject:from:to:cc:in-reply-to:references
         :mime-version:content-type;
        b=wnVlHICAtrv45UpbmIPFZYU3q0mgFai8A1ltSMMyAsdyhazWHFT0uzjU8toP0dqtXF
         x+896uKiAUpQuHNb+KYaZ4Kdccinvn2N/LfZQ3++E7mnjbiGVhF0rAV2aq/aLQi/0KbV
         qiSYVW05MJeTZWqQVXFRYRtoPSjwmQsyQiys4=
Received: by 10.220.98.193 with SMTP id r1mr7920449vcn.89.1281067034636;
        Thu, 05 Aug 2010 20:57:14 -0700 (PDT)
Received: from gmail.com (load-me-in-a-browser-if-this-tor-node-is-causing-you-grief.riseup.net [77.109.139.87])
        by mx.google.com with ESMTPS id a15sm428738vci.9.2010.08.05.20.57.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 20:57:13 -0700 (PDT)
In-Reply-To: <20100805224321.GA22430@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152762>

On Wed, Aug 4, 2010 at 14:24, Junio C Hamano <gitster@pobox.com> wrote:
>>> I hate... "typedef foo struct foo"

On Thu, Aug 05, 2010 at 11:20:14AM -0500, Michael Witten wrote:
>> How come?

On Thu, Aug 5, 2010 at 17:43, Jared Hance <jaredhance@gmail.com> wrote:
> In my opinion, it creates ambiguity. If I have
>
>    typedef struct foo foo;
>
> And I have "foo" used in a code snippet, it is much less easier to see
> if foo is being used in the type context or if its an instance, since
> I like to do
>
>    struct foo foo;
>
> which reads much less well as:
>
>    foo foo;
>
>
> Its also much less easier to grep though to find all the places the
> type is used. If I do
>
>    $ git grep "foo"
>
> I will end up with the instances and the struct type. whereas I can do
>
>    $ git grep "struct foo"
>
> to find (most|all) of the types, depending on whether the code uses
> decent practices (there shouldn't be a second space between struct and
> foo, or a newline between them).
>
> I could also use a similar regular expression to find all the
> instances (ie, all the instances of foo that aren't prefixed with
> struct).

Those are valid points, but I'm not sure they have a practical basis;
your problems are largely solved by capitalization conventions
(which essentially provide shorter replacements for `struct '):

    typedef struct { /* ... */ } Foo;
    Foo foo;

Unfortunately, such conventions don't enjoy the benefit of semantic
protection. However, language-aware source navigation tools (like ctags)
should be able to solve that problem and are probably more efficient
in navigation time than grepping.

Moreover, the form:

    foo foo;

is probably not that problematic in practice; it's presence is likely
to be short lived for 2 reasons:

    * Subjectively : everyone thinks it looks awful.
    * Objectively  : It's technically constrained.

The typedef declaration:

    typedef /*type*/ foo;

introduces the typedef name `foo' into the `ordinary identifier'
name space; consequently, the declaration:

    foo foo;

cannot even occur in the same scope as the typdef, and when
it does occur in an inner scope, it hides the original typdef
name `foo' for all subsequent inner scopes:

    typedef struct {char x;} foo;

    foo foo;         // error: attempt to redeclare `foo'.
    foo a;

    int main()
    {

      foo foo;       // OK; hide typedef name with variable `foo'
      foo b;         // error: `foo' is not a type.

      {

        foo c;       // error: `foo' is not a type.

        typedef struct {char x;} foo;   // OK; hide variable `foo'

        foo foo;     // error: attempt to redeclare `foo'
        foo d;

        d = a;       // error: anonymous structs are always different types.

        {
          foo foo;   // OK; hide typedef name with variable `foo'
          d = foo;   // OK; same type
          foo e;     // error: `foo' is not a type.
        }

        {
          foo foo;   // OK; hide typedef name with variable `foo'
          d = foo;   // OK; same type
          foo f;     // error: `foo' is not a type.
        }

      }

    }

Sincerely,
Michael Witten
