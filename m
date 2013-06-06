From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 08/15] for-each-ref: get --pretty using format_commit_message
Date: Thu, 6 Jun 2013 07:07:44 +0700
Message-ID: <CACsJy8D9bLijPX7JnUEkJ4e9OU9tDN_vGa=gkkHSm3Sr34fWQQ@mail.gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
 <1370349337-20938-9-git-send-email-artagnon@gmail.com> <CAPig+cRmnc=poOZUxZms_OWdLpBM_q=h+MDYisu8WtuF11PYXA@mail.gmail.com>
 <CACsJy8ABwroExpXQRX8OYAnDum9+sX1+JB9z+WNn+YcZoXi5KA@mail.gmail.com> <7v61xs32n0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 02:08:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkNkZ-0001DL-Pk
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 02:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144Ab3FFAIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 20:08:15 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:53070 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894Ab3FFAIP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 20:08:15 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so1694360oag.18
        for <git@vger.kernel.org>; Wed, 05 Jun 2013 17:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XPSsTcASjRJ98Wu7PEZxcuhuQE02++iHURxY602Fb50=;
        b=vW1klxbpIypNBvXaWSjI0LCRZMz2YlI2heL+7mFi5KENYXLSEIwiqFmhNz1UXU9OXK
         uoEcMQkbHY76W4/XIbPufOItYo1v+66TiX+Qe2gOE3W4UbkyW+4WUe41fzC71jNVpTNq
         VQZ2PcjI7MQihcc6MYRwQ3W+k4n/FPg35bGBU6s/4FCCb2sTDhfXgEMiXgqGmoPcEIOZ
         V4B7Ur7xIO3G/MWWb0vP4Ab1xAfazIxRMABzX8KN2jP+2XtKIA1kyFNEJSkL4oVllSjq
         G+WTdNXp6rhd6YOL7OdGoOcDga0yCAOr83+dxN5YqsAowrhdZpfdyx3KIQz3rw02Mdtl
         ieVQ==
X-Received: by 10.182.81.202 with SMTP id c10mr11702033oby.27.1370477294605;
 Wed, 05 Jun 2013 17:08:14 -0700 (PDT)
Received: by 10.76.76.69 with HTTP; Wed, 5 Jun 2013 17:07:44 -0700 (PDT)
In-Reply-To: <7v61xs32n0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226476>

On Thu, Jun 6, 2013 at 12:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Jun 5, 2013 at 4:12 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> +Caveats:
>>>> +
>>>> +1. Many of the placeholders in "PRETTY FORMATS" are designed to work
>>>> +   specifically on commit objects: when non-commit objects are
>>>> +   supplied, those placeholders won't work.
>>>
>>> Should "won't work" be expanded upon? It's not clear if this means
>>> that git will outright crash, or if it will abort with an appropriate
>>> error message, or if the directive will be displayed as-is or removed
>>> from the output.
>>
>> It will be displayed as-is but that's a bit inconsistent: %(unknown)
>> prints error and aborts while %unknown simply produces %unknown. The
>> latter is how "git log --format" does it. But I think we could make
>> for-each-ref --pretty to do the former for %unknown. It'll be
>> consistent with %(unknown) and we do not need to elaborate much (it's
>> pretty obvious when it does not work).
>
> The Caveat Eric is asking about talks about "what happens to a
> %(field) that only makes sense for a commit when showing a ref
> pointing at a non-commit?", but you are answering "what happend to a
> %(invalidfield) that is not defined", aren't you?

Because %(field) is treated like %(invalidfield) in this case. I'm not
saying this is the best thing to do though.

> IIRC, the reason we show literal from "log --format" is to make it
> easier for the person who misspelt %placeholder to spot it in the
> output, and also make it easier for the person who use %placeholder
> meant for newer versions of Git with an older one.  It would be a
> bit unnice to die for the latter, especially if the format string is
> in a script or something.

That makes more sense for for-each-ref than log because for-each-ref
is a plumbing and should support scripting. But old for-each-ref will
happily reject %(newplacholder) right away. Should we take this
opportunity to change this behavior in for-each-ref too?

> To "log --format", all input objects are expected to be commits, so
> it does not have the "what does %(authordate) give when given a blob"
> issue.
>
> But for "for-each-ref --format", it is perfectly normal that you may
> feed a non-commit; it makes the mechanism unusable if you errored
> out %(authordate) when showing a ref that points at a tag, doesn't
> it?  Substituting an inapplicable placeholder with an empty string
> would be an easies way out, unless it learns a flexible/elaborate
> conditional formatting mechanism, I would think.

There is a blurred line here. %H (or %h) should produce an object name
even for tags or blobs, but right now it produces "%H" instead. The
same applies for %ad and friends, but these are clearly for commits
and should probably behave like %(authordate), i.e. producing empty
string.
--
Duy
