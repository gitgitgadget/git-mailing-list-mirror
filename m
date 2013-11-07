From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH] Add interpret-trailers builtin
Date: Thu, 7 Nov 2013 15:57:38 +0100
Message-ID: <CAP8UFD09PbOL=EPCQifsakZo5s_vhzQRfcp9LhOjq2gAbUcKpw@mail.gmail.com>
References: <20131106.074355.225932577498673677.chriscool@tuxfamily.org>
	<CAP8UFD0STna++2StV1RcT2bB83Lh_hFQU94A0y4ziovs61Z==A@mail.gmail.com>
	<xmqq4n7pa1pn.fsf@gitster.dls.corp.google.com>
	<20131106.211659.1008913569403460043.chriscool@tuxfamily.org>
	<xmqq7gcl8dor.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 15:57:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeR1i-00070v-Vu
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 15:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045Ab3KGO5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 09:57:41 -0500
Received: from mail-ve0-f171.google.com ([209.85.128.171]:41923 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab3KGO5i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 09:57:38 -0500
Received: by mail-ve0-f171.google.com with SMTP id pa12so458273veb.16
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 06:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z0ZteeBDLAP2jhxgO1I+ycVSrfzKw8Nhgubv9HawteM=;
        b=jce4FmGFILMBBYErrVcx+oX79/K4CSF3eNgl33zziMWffVPvQrlTRHrgUpCpEw/i2G
         Qwpltn9fsrlufK1+ekYChwaFXKMhkBsXcA3r3djp+QXkom5XNyFMBuiOnTJQvV4vw1wH
         44k8zr5ie6WUzvmiONdZZhAxuUTk+H6/60LamLx93FE+eqjJ1pEne+VLEDmVASv3ni+9
         Z78U+jPfHI0eSqwuFoW4MVUr4cY3FckPDCg9qusMx4uAXSvMIbfhOBUbcsyY7qWYOm3B
         g/0l55Cy9TdRzxJ6CF1q72MfzeQU73wnNbvPGksoGaQjlWQQdIRwrFotlzCYg33Wu8Dl
         xX/Q==
X-Received: by 10.52.33.69 with SMTP id p5mr5897790vdi.28.1383836258095; Thu,
 07 Nov 2013 06:57:38 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Thu, 7 Nov 2013 06:57:38 -0800 (PST)
In-Reply-To: <xmqq7gcl8dor.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237411>

On Wed, Nov 6, 2013 at 9:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>> From: Junio C Hamano <gitster@pobox.com>
>>
>>> But that is insufficient to emulate what we do, no?  I.e. append
>>> unless the last one is from the same person we are about to add.
>>
>> Yeah, but, with DONT_REPEAT_PREVIOUS, it would be possible using:
>>
>> [trailer "signoff"]
>>          key = "Signed-off-by:"
>>          if_exist = dont_repeat_previous
>>          if_missing = append
>>          command = echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"'
>
> Anything is possible, but "possible" does not justify "it is better
> way than other possible ways".
>
> What are the plausible values for if_missing?  If if_missing needs
> "prepend", for example, in addition to "append", does it mean
> if_exist also needs corresponding "prepend" variant for the value
> "dont_repeat_previous" you would give to if_exist?

Yeah, we could add "prepend" to the possible values for if_missing and
also other values that prepend instead of append to if_exist.
But I am not sure they would be as useful.

If we think they are useful, then maybe we could instead add another
configuration to say if we want to append or prepend or put in the
middle, and change the others to make them clearer.
For example we could have:

where = (after | middle | before)
if_exist = (add_if_different | add_if_neighbor_different | add |
overwrite | do_nothing)
if_missing = (do_nothing | add)

(The default being the first choice.)

> Having two that are seemingly independent configuration does not
> seem to be helping in reducing complexity (by keeping settings that
> can be independently set orthogonal, by saying "if the other rule
> decides to add, do we append, prepend, insert at the middle?", for
> example).

I am not sure I understand what you mean.
In my opinion, if we want to use just one configuration, instead of 2
or 3, it will not reduce complexity.

Maybe we could parse something like:

style = if_exist:add_if_different:after, if_missing:add:before

or like:

style = (append | prepend | insert | append_unless <regexp> |
prepend_unless <regexp> | insert_unless <regexp>)

with <regexp> being a regexp where $KEY is the key and $VALUE is the
value, so you can say: append_unless ^$KEY[:=]$VALUE.*

or like:

style = (append_if <cmd> | prepend_if <cmd> | insert_if <cmd>)

with <cmd> being a shell command that should exit with code 0.

(The command would be passed the existing trailers in stdin.
So you could say things like: "append_if true" or "append_if tail -1 |
grep -v '$KEY: $VALUE'")

But if we want to keep things simple, I think what I suggest first
above is probably best.

And by the way, later we might add "add_if_match <regexp>" or
"add_if_true <cmd>" to "if_exist" and "if_missing", so we could still
be as powerful as the other styles.

> How would one differentiate between "there is a field with that key"
> and "there is a field with that <key, value> combination" with a
> single if_exist?  Add another variable if_exist_exact?

"if_exist = do_nothing" would mean: "do nothing if there is a field
with that key"
"if_exist = overwrite" would mean: "overwrite the existing value of a
field with that key"
"if_exist = add" would mean: "add if there is one or more fields with
that key (whatever the value(s), so the value(s) could be the same)"
"if_exist = add_if_different" would mean: "add only if there is no
field with the same <key, value> pair"
"if_exist = add_if_different_neighbor" would mean: "add only if there
is no field with the same <key, value> pair where we are going to add"

"if_missing = do_nothing" would mean: "do nothing if there is no field
with that key"
"if_missing= add" would mean: "add if there is no field with that key"

"where = after" would mean: "if we decide to add, we will put the
trailer after the other trailers"
"where = middle" would mean: "if we decide to add, we will put the
trailer in the middle of the other trailers"
"where = before" would mean: "if we decide to add, we will put the
trailer before the other trailers"

In my opinion, that should be enough for most use cases.

It is true that some people might want something more complex (like
adding only if there is no value for the same key that match a given
regexp) or something stranger like adding only if there is already a
field with the same <key, value> pair.

But we can take care of these special cases later if they actually happen.
Then we will hopefully have more experience.
And we could add things like "add_if_no_value_match <regexp>" or
"add_if <cmd>" to if_exist and if_missing .

Thanks,
Christian.
