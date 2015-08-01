From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 04/11] ref-filter: add 'ifexists' atom
Date: Sat, 1 Aug 2015 12:14:54 +0530
Message-ID: <CAOLa=ZQ1zShO8tKz9Zug4eUrZxKNGkaqaWd=hcz7KMzJp1pAiQ@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
 <xmqq8ua0f9lk.fsf@gitster.dls.corp.google.com> <CAOLa=ZTUJHnXWJyr0wp0CZgR9S1pBxCEsGRiDPsJdUyzTZaZUw@mail.gmail.com>
 <xmqqy4hy973q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 08:45:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLQY0-00044A-Ii
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 08:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbbHAGp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 02:45:28 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33919 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbHAGp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 02:45:27 -0400
Received: by oigu133 with SMTP id u133so5748785oig.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 23:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r2KX4EadBl2SucyRqaDLF3u5sMvcbuObbvvnp1b14EE=;
        b=m6M/PfERiAvsom2wOBF3Z8tTmL4LKf9qrZAXSJer5Z5HIkwtjSdPfLlNbxAb3yo/A1
         6oBoxCvz+bKmK/0R9gnbXZtTKgX9OeLU2qkVjJsNnPhlQeklGarmylw1mFh9oDCOZiUP
         0xw3F9mDWzBzsbF7eg5rc5jeBEPNwCaccnEWa830NB3ams0dKp8msJwfLc3ftOQRd/TE
         dwUv7QNzKs/zxE/DH98MGBrpf4uFWNOJEJ6R4NwfYPXRw0bzfHIDsjIlbyQjLgHqfLFs
         prvJvPGgulTMPFWXAZ3pFZ/9y1C59/RRqUycoY3MXQ23ca/rC7Kd+K9lC5/oaO3dMegW
         uN6A==
X-Received: by 10.202.200.151 with SMTP id y145mr6989143oif.111.1438411523551;
 Fri, 31 Jul 2015 23:45:23 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 31 Jul 2015 23:44:54 -0700 (PDT)
In-Reply-To: <xmqqy4hy973q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275109>

On Wed, Jul 29, 2015 at 11:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> A handful of "huh?" on the design.
>>>
>>>  - The atom says "if *exists*" and explanation says "has a value".
>>>    How are they related?  Does an atom whose value is an empty
>>>    string has a value?  Or is "ifexists" meant to be used only to
>>>    ignore meaningless atom, e.g. %(*objectname) applied to a ref that
>>>    refers to an object that is not an annotated tag?
>>
>> It's meant to ignore meaningless atom. atom's whose values are empty
>> strings are ignored.
>
> That is a self-contradicting answer.
>
> If you ask for "%(*objectname)" on a commit, that request truly is
> meaningless, as a commit is not an annotated tag that points at another
> object whose objectname is being asked for.
>
> But if a commit has an empty log message (you should be able to
> create such an object with commit-tree), then "%(subject)" would be
> an empty string.  The fact that the commit happens to have an empty
> string as its message is far from meaningless.
>
> Either you ignore an empty string, or you ignore meaningless one.
> Which does "ifexists" mean?

I meant ignore atom values which are empty, sorry for the confusion.

>
>>>  - That %s looks ugly.  Are there cases where a user may want to say
>>>    %(ifexists:[%i]) or something other than 's' after that per-cent?
>>
>> Couldn't think of a better replacer, any suggestions would be welcome :)
>
> See below.
>
>> Its given as example, is that misleading?
>
> Othewise I wouldn't be asking.
>
>>>  - What, if anything, is allowed to come between %(ifexists...) and
>>>    the next atom like %(refname)?  For example, are these valid
>>>    constructs?
>>>
>>>     . %(ifexists...)%(padright:20)%(refname)
>>
>> Doesn't work ...
>> ...
>>>  - This syntax does not seem to allow switching on an attribute to
>>>    show or not to show another, e.g. "if %(*objectname) makes sense,
>>>    then show '%(padright:20)%(refname:short) %(*subject)' for it".
>>
>> Yes this doesn't do that,
>
> One way to do all of the above is to make it
>
>     %(ifexists:atom:expansionString)
>
> That is, for example:
>
>  "%(ifexists:*objectname:tag %(color:blue)%(refname:short)%(color:reset))"
>
> would give you a string "tag v1.0" with "v1.0" painted in blue for
> refs/tags/v1.0 but nothing for refs/heads/master.
>
> Obviously expansionString part needs some escaping mechanism to
> allow it to include an unmatched ")".

I liked your other idea of if and endif better :)

-- 
Regards,
Karthik Nayak
