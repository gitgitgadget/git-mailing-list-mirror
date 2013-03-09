From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be depth-first,
 --parent option to execute command in supermodule as well
Date: Sat, 09 Mar 2013 19:18:48 +0100
Message-ID: <513B7D08.20406@web.de>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com> <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org> <20130305075901.GB4677@sandbox-ub> <7vhakpvnex.fsf@alter.siamese.dyndns.org> <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com> <7vboaxu23y.fsf@alter.siamese.dyndns.org> <51365AB6.2010602@web.de> <CABURp0psgofX=ean+KKooN74pF4Ns-gDGt68vc5Exs6NmDRUyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Cousineau <eacousineau@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 19:19:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEOMX-0003bI-Qm
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 19:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880Ab3CISSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 13:18:51 -0500
Received: from mout.web.de ([212.227.17.11]:61567 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794Ab3CISSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 13:18:50 -0500
Received: from [192.168.178.41] ([91.3.183.52]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MKa6N-1UEfCp2NVv-001SvE; Sat, 09 Mar 2013 19:18:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <CABURp0psgofX=ean+KKooN74pF4Ns-gDGt68vc5Exs6NmDRUyw@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:+DU+wAQFq17OPA9eT6a8x1jRTioFF2MQ5yp4h4fpatM
 YIWBBCgXs1IFl4gTvJ7sTRpMLTYG5ZU3IuPzfRUUQdzm3UNWbH
 4ZYOeIMCz7d1erFQp8xL5pz3kE+LreZAoUAskBq3mvTMMgdPZ6
 pL/uFfK5gk3q4ZM225HaFn46JEO05kD4Ee59qto1bngj0fqVRx
 zqUXtVMhPo0eWUoKv5Z8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217733>

Am 05.03.2013 22:17, schrieb Phil Hord:
> On Tue, Mar 5, 2013 at 3:51 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Am 05.03.2013 19:34, schrieb Junio C Hamano:
>>> Eric Cousineau <eacousineau@gmail.com> writes:
>>>> ...
>>> I am not entirely convinced we would want --include-super in the
>>> first place, though.  It does not belong to "submodule foreach";
>>> it is doing something _outside_ the submoudules.
>>
>> I totally agree with that. First, adding --include-super does not
>> belong into the --post-order patch at all, as that is a different
>> topic (even though it belongs to the same use case Eric has). Also
>> the reason why we are thinking about adding the --post-order option
>> IMO cuts the other way for --include-super: It is so easy to do
>> that yourself I'm not convinced we should add an extra option to
>> foreach for that, especially as it has nothing to do with submodules.
>> So I think we should just drop --include-super.
> 
> I agree it should not be part of this commit, but I've often found
> myself in need of an --include-super switch.   To me,
> git-submodule-foreach means "visit all my .git repos in this project
> and execute $cmd".  It's a pity that the super-project is considered a
> second-class citizen in this regard.

Hmm, for me the super-project is a very natural second-class citizen
to "git *submodule* foreach". But also I understand that sometimes the
user wants to apply a command to superproject and submodules alike (I
just recently did exactly that with "git gc" on our build server).

> I have to do this sometimes:
> 
>    ${cmd} && git submodule foreach --recursive '${cmd}'
> 
> I often forget the first part in scripts, though, and I've seen others
> do it too.  I usually create a function for it in git-heavy scripts.
> 
> In a shell, it usually goes like this:
> 
>    git submodule foreach --recursive '${cmd}'
>    <up><home><del>{30-ish}<end><backspace><enter>
> 
> It'd be easier if I could just include a switch for this, and maybe
> even create an alias for it.  But maybe this is different command
> altogether.

Are you sure you wouldn't forget to provide such a switch too? ;-)

I'm still not convinced we should add a new switch, as it can easily
be achieved by adding "${cmd} &&" to your scripts. And on the command
line you could use an alias like this one to achieve that:

[alias]
	recurse = !sh -c \"$@ && git submodule foreach --recursive $@\"
