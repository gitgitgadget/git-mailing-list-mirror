From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be depth-first,
 --parent option to execute command in supermodule as well
Date: Mon, 18 Mar 2013 22:10:43 +0100
Message-ID: <514782D3.5060200@web.de>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com> <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org> <20130305075901.GB4677@sandbox-ub> <7vhakpvnex.fsf@alter.siamese.dyndns.org> <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com> <7vboaxu23y.fsf@alter.siamese.dyndns.org> <51365AB6.2010602@web.de> <CABURp0psgofX=ean+KKooN74pF4Ns-gDGt68vc5Exs6NmDRUyw@mail.gmail.com> <513B7D08.20406@web.de> <CABURp0qBA6myf7_SuaxJSrePJHmh2v-nmtLRzKTtgAJxLkJ-tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Cousineau <eacousineau@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Lars Hjemli <hjemli@gmail.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 22:11:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHhL3-0006JR-LD
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 22:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748Ab3CRVKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 17:10:53 -0400
Received: from mout.web.de ([212.227.15.3]:60605 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756734Ab3CRVKu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 17:10:50 -0400
Received: from [192.168.178.41] ([91.3.185.39]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MF3jD-1UWKad0jAR-00GDff; Mon, 18 Mar 2013 22:10:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CABURp0qBA6myf7_SuaxJSrePJHmh2v-nmtLRzKTtgAJxLkJ-tQ@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:ioMih8k9STBTIF0gbyrjBFww2eoQc5J5jkerOpd9OEx
 RlFyBWdqdUJOM1UucZzGIMgm8aBdQrJCu/l/QtPlC5dMReBd4Y
 fF7rpO2G1IscujWxDFja1y89ivOO/7jzYPIlK/SGdEdeZOEBHn
 CG6MlGjnCZl9Aqc0WM7R8y2GJM0PjmA/zTeLbHoUrbzi922+LH
 pIuzDix9Cv47CbQ6UMuNg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218452>

Am 12.03.2013 17:01, schrieb Phil Hord:
> On Sat, Mar 9, 2013 at 1:18 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 05.03.2013 22:17, schrieb Phil Hord:
>>> On Tue, Mar 5, 2013 at 3:51 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>>> Am 05.03.2013 19:34, schrieb Junio C Hamano:
>>>>> Eric Cousineau <eacousineau@gmail.com> writes:
>>>>>> ...
>>>>> I am not entirely convinced we would want --include-super in the
>>>>> first place, though.  It does not belong to "submodule foreach";
>>>>> it is doing something _outside_ the submoudules.
>>>>
>>>> I totally agree with that. First, adding --include-super does not
>>>> belong into the --post-order patch at all, as that is a different
>>>> topic (even though it belongs to the same use case Eric has). Also
>>>> the reason why we are thinking about adding the --post-order option
>>>> IMO cuts the other way for --include-super: It is so easy to do
>>>> that yourself I'm not convinced we should add an extra option to
>>>> foreach for that, especially as it has nothing to do with submodules.
>>>> So I think we should just drop --include-super.
>>>
>>> I agree it should not be part of this commit, but I've often found
>>> myself in need of an --include-super switch.   To me,
>>> git-submodule-foreach means "visit all my .git repos in this project
>>> and execute $cmd".  It's a pity that the super-project is considered a
>>> second-class citizen in this regard.
>>
>> Hmm, for me the super-project is a very natural second-class citizen
>> to "git *submodule* foreach". But also I understand that sometimes the
>> user wants to apply a command to superproject and submodules alike (I
>> just recently did exactly that with "git gc" on our build server).
>>
>>> I have to do this sometimes:
>>>
>>>    ${cmd} && git submodule foreach --recursive '${cmd}'
>>>
>>> I often forget the first part in scripts, though, and I've seen others
>>> do it too.  I usually create a function for it in git-heavy scripts.
>>>
>>> In a shell, it usually goes like this:
>>>
>>>    git submodule foreach --recursive '${cmd}'
>>>    <up><home><del>{30-ish}<end><backspace><enter>
>>>
>>> It'd be easier if I could just include a switch for this, and maybe
>>> even create an alias for it.  But maybe this is different command
>>> altogether.
>>
>> Are you sure you wouldn't forget to provide such a switch too? ;-)
> 
> No.  However, when I remember to add the switch, my shell history will
> remember it for me.  This does not happen naturally for me in the
> "<up><home><del>{30-ish}..." workflow.

I started to use '&&' in my daily shell work for exactly that reason:
that the bash history remembers groups of two or more commands for me.

> I also hope this switch grows up into a configuration option someday.
> Or maybe a completely different command, like I said before; because I
> actually think it could be dangerous as a configuration option since
> it would have drastic consequences for users executing scripts or
> commands in other users' environments.

I agree on the possible problems a configuration option introduces.

>> I'm still not convinced we should add a new switch, as it can easily
>> be achieved by adding "${cmd} &&" to your scripts. And on the command
>> line you could use an alias like this one to achieve that:
>>
>> [alias]
>>         recurse = !sh -c \"$@ && git submodule foreach --recursive $@\"
> 
> Yes, making the feature itself a 2nd-class citizen.  :-)
> 
> But this alias also denies me the benefit of the --post-order option.
> For 'git recurse git push', for example, I wouldn't want the
> superproject push to occur first; I would want it to occur last after
> the submodules have been successfully pushed.

[alias]
         recurse-post = !sh -c \"git submodule foreach --recursive --post-order $@ && $@\"
;-)

> I agree this should go in some other commit, but I do not think it is
> so trivial it should never be considered as a feature for git.  That's
> all I'm trying to say.

I am not against adding such a functionality to Git, I'm just not
convinced "git submodule foreach" is the right command for that. I
suspect the "git for-each-repo" Lars proposed earlier this year might
be a better choice, as that could also recurse into other repos which
aren't registered as submodules. And a "for-each-repo" to me looks
like a command which could include the superproject too (at least when
told to do so with an option).
