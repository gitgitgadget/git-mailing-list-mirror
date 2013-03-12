From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be
 depth-first, --parent option to execute command in supermodule as well
Date: Tue, 12 Mar 2013 12:01:43 -0400
Message-ID: <CABURp0qBA6myf7_SuaxJSrePJHmh2v-nmtLRzKTtgAJxLkJ-tQ@mail.gmail.com>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com>
 <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org>
 <20130305075901.GB4677@sandbox-ub> <7vhakpvnex.fsf@alter.siamese.dyndns.org>
 <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com>
 <7vboaxu23y.fsf@alter.siamese.dyndns.org> <51365AB6.2010602@web.de>
 <CABURp0psgofX=ean+KKooN74pF4Ns-gDGt68vc5Exs6NmDRUyw@mail.gmail.com> <513B7D08.20406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Cousineau <eacousineau@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 12 17:02:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFRer-0003zA-Fg
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 17:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610Ab3CLQCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 12:02:06 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:60434 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932390Ab3CLQCE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 12:02:04 -0400
Received: by mail-ve0-f170.google.com with SMTP id 14so3662263vea.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DDWHzMGs4+SN/k1DQKa8EHQsnZZ7v+uF7pt1SndmAGM=;
        b=U+uowPVgk37eN14CVZbIejYtnAl5fP3D/aln9VlCZDQf+VbQs34g/0oEoZ3WQiBuLN
         Rb2ohjUBRKZJ+sgXpz1dKP5kWIQ1elMI42fnLE8aFHwLcvmlU+A+LRRFPD5A6LGRYbci
         LNgjlL0T5HJ4VPPAuumFyhiaVIl61oWcwVH4LCmIl51DGzrSA+RdaRzp2hRZR74LxgMo
         qKBzr4ONVnTzQoinhkqB677vI2YJQlSD2+c9K5ZJqgyA0rrtI3aN78Fk4ixCQMmunRn8
         7qrRbXGSBzuuk6khi7BSyB4UND84fkleKdyK2XWYh5mmP4LVh00DPPW36GYGh54pZ947
         ifRw==
X-Received: by 10.220.228.74 with SMTP id jd10mr5762083vcb.65.1363104123782;
 Tue, 12 Mar 2013 09:02:03 -0700 (PDT)
Received: by 10.58.201.103 with HTTP; Tue, 12 Mar 2013 09:01:43 -0700 (PDT)
In-Reply-To: <513B7D08.20406@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217970>

On Sat, Mar 9, 2013 at 1:18 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 05.03.2013 22:17, schrieb Phil Hord:
>> On Tue, Mar 5, 2013 at 3:51 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> Am 05.03.2013 19:34, schrieb Junio C Hamano:
>>>> Eric Cousineau <eacousineau@gmail.com> writes:
>>>>> ...
>>>> I am not entirely convinced we would want --include-super in the
>>>> first place, though.  It does not belong to "submodule foreach";
>>>> it is doing something _outside_ the submoudules.
>>>
>>> I totally agree with that. First, adding --include-super does not
>>> belong into the --post-order patch at all, as that is a different
>>> topic (even though it belongs to the same use case Eric has). Also
>>> the reason why we are thinking about adding the --post-order option
>>> IMO cuts the other way for --include-super: It is so easy to do
>>> that yourself I'm not convinced we should add an extra option to
>>> foreach for that, especially as it has nothing to do with submodules.
>>> So I think we should just drop --include-super.
>>
>> I agree it should not be part of this commit, but I've often found
>> myself in need of an --include-super switch.   To me,
>> git-submodule-foreach means "visit all my .git repos in this project
>> and execute $cmd".  It's a pity that the super-project is considered a
>> second-class citizen in this regard.
>
> Hmm, for me the super-project is a very natural second-class citizen
> to "git *submodule* foreach". But also I understand that sometimes the
> user wants to apply a command to superproject and submodules alike (I
> just recently did exactly that with "git gc" on our build server).
>
>> I have to do this sometimes:
>>
>>    ${cmd} && git submodule foreach --recursive '${cmd}'
>>
>> I often forget the first part in scripts, though, and I've seen others
>> do it too.  I usually create a function for it in git-heavy scripts.
>>
>> In a shell, it usually goes like this:
>>
>>    git submodule foreach --recursive '${cmd}'
>>    <up><home><del>{30-ish}<end><backspace><enter>
>>
>> It'd be easier if I could just include a switch for this, and maybe
>> even create an alias for it.  But maybe this is different command
>> altogether.
>
> Are you sure you wouldn't forget to provide such a switch too? ;-)

No.  However, when I remember to add the switch, my shell history will
remember it for me.  This does not happen naturally for me in the
"<up><home><del>{30-ish}..." workflow.

I also hope this switch grows up into a configuration option someday.
Or maybe a completely different command, like I said before; because I
actually think it could be dangerous as a configuration option since
it would have drastic consequences for users executing scripts or
commands in other users' environments.


> I'm still not convinced we should add a new switch, as it can easily
> be achieved by adding "${cmd} &&" to your scripts. And on the command
> line you could use an alias like this one to achieve that:
>
> [alias]
>         recurse = !sh -c \"$@ && git submodule foreach --recursive $@\"

Yes, making the feature itself a 2nd-class citizen.  :-)

But this alias also denies me the benefit of the --post-order option.
For 'git recurse git push', for example, I wouldn't want the
superproject push to occur first; I would want it to occur last after
the submodules have been successfully pushed.

I agree this should go in some other commit, but I do not think it is
so trivial it should never be considered as a feature for git.  That's
all I'm trying to say.

Phil
